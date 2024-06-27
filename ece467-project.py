# -*- coding: utf-8 -*-
"""
Created on Thu May  9 17:21:42 2024

@author: nikee
"""

import mysql.connector
import datetime



def displayMenu():
    print("\nLibrary Loan Record Tracking System")
    print("***********************************")
    print("1 - List the number of copies of a particular library item")
    print("2 - List the details of the patrons who have at least one overdue library item today")
    print("3 - Identify the total fines owed by a patron (by his/her library card number)")
    print("4 - List the details (e.g., damage, loss, amount, etc.) of the payments made by a patron")
    print("5 - List the copies of library items that are grossly overdue")
    print("6 - List the details of the current pending requests in the system")
    print("7 - Identify the total fines revenue to the library between April 1, 2014 to October 1, 2014")
    print("8 - List the details of the checkout periods and the numbers of renewals for all the categories of library items")
    print("9 - List the total number and the details of library items that are checked out and renewed by a patron")
    print("10 - Insert a new pending request made by a patron")
    print("11 - Quit")
    print()

def getChoice():
    choice = input(">> ")
    while not choice.isdigit() or int(choice) < 1 or int(choice) > 11:
        print("Invalid choice...")
        displayMenu()
        choice = input(">> ")
    return int(choice)

def main():
    cnx = mysql.connector.connect(host='localhost', user='Nikeem', password='dunkelly04', database='library')
    cursor = cnx.cursor()

    choice = 0
    while choice != 11:
        displayMenu()
        choice = getChoice()

        if choice == 1:
            itemID = input("Enter the Item ID to check number of copies: ")
            query = "SELECT title, quantity FROM libraryitem WHERE itemID = %s"
            cursor.execute(query, (itemID,))
            result = cursor.fetchone()
            if result:
                print("Title: {}, Number of Copies: {}".format(result[0], result[1]))
            else:
                print("No such item found.")

        elif choice == 2:
            today = input("Enter today's date (YYYY-MM-DD): ")
            query = """
            SELECT p.patronName, p.address, p.phoneNumber FROM patron p
            JOIN loanrecord l ON p.libraryCardNumber = l.libraryCardNumber
            WHERE l.dueDate < %s AND (l.returnDate IS NULL OR l.returnDate > l.dueDate)
            """
            cursor.execute(query, (today,))
            results = cursor.fetchall()
            if results:
                print("{:<20} {:<30} {:<15}".format("Patron Name", "Address", "Phone Number"))
                print("="*65)
                for row in results:
                    print("{:<20} {:<30} {:<15}".format(row[0], row[1], row[2]))
            else:
                print("No overdue items today.")

        elif choice == 3:
            libraryCardNumber = input("Enter the Library Card Number to check total fines: ")
            query = "SELECT SUM(fine) FROM loanrecord WHERE libraryCardNumber = %s"
            cursor.execute(query, (libraryCardNumber,))
            result = cursor.fetchone()
            print("Total fines owed: ${:.2f}".format(result[0] if result[0] else 0.00))
            
        
        elif choice == 4:
            libraryCardNumber = input("Enter the Library Card Number to view payment details: ")
            query = "SELECT itemID, fineDate, paymentDate, fineAmount, reason FROM fees WHERE libraryCardNumber = %s"
            cursor.execute(query, (libraryCardNumber,))
            results = cursor.fetchall()
            if results:
                print("{:<10} {:<15} {:<15} {:<10} {:<30}".format("Item ID", "Fine Date", "Payment Date", "Amount", "Reason"))
                print("="*80)
                for row in results:
                    item_id = row[0]
                    fine_date = row[1].strftime('%Y-%m-%d') if row[1] else 'N/A'  # Formatting date or showing 'N/A'
                    payment_date = row[2].strftime('%Y-%m-%d') if row[2] else 'N/A'  # Formatting date or showing 'N/A'
                    fine_amount = f"${row[3]:.2f}" if row[3] is not None else "N/A"  # Formatting as currency
                    reason = row[4] if row[4] else 'N/A'
                    print("{:<10} {:<15} {:<15} {:<10} {:<30}".format(item_id, fine_date, payment_date, fine_amount, reason))
            else:
                print("No payments found for this patron.")

        


        elif choice == 5:
            days_overdue = input("Enter the number of days to check for grossly overdue items: ")
            query = """
            SELECT l.itemID, li.title, DATEDIFF(CURDATE(), l.dueDate) AS OverdueDays FROM loanrecord l
            JOIN libraryitem li ON l.itemID = li.itemID
            WHERE l.returnDate IS NULL AND DATEDIFF(CURDATE(), l.dueDate) > %s
            """
            cursor.execute(query, (days_overdue,))
            results = cursor.fetchall()
            if results:
                print("{:<10} {:<30} {:<15}".format("Item ID", "Title", "Days Overdue"))
                print("="*55)
                for row in results:
                    print("{:<10} {:<30} {:<15}".format(row[0], row[1], row[2]))
            else:
                print("No grossly overdue items found.")

        elif choice == 6:
            query = "SELECT * FROM itemrequests WHERE status = 'Pending'"
            cursor.execute(query)
            results = cursor.fetchall()
            if results:
                print("{:<10} {:<10} {:<15} {:<10}".format("Request ID", "Item ID", "Library Card Number", "Request Date"))
                print("="*45)
                for row in results:
                    request_date = row[3].strftime('%Y-%m-%d') if row[3] else 'N/A'  # Formatting date or showing 'N/A'
                    print("{:<10} {:<10} {:<15} {:<10}".format(row[0], row[1], row[2], request_date))
            else:
                print("No pending requests.")

        elif choice == 7:
            query = "SELECT SUM(fineAmount) AS TotalFinesRevenue FROM fees WHERE fineDate BETWEEN '2014-04-01' AND '2014-10-01' AND paymentDate IS NOT NULL"
            cursor.execute(query)
            result = cursor.fetchone()
            print("Total fines revenue between April 1, 2014, and October 1, 2014: ${:.2f}".format(result[0] if result[0] else 0.00))

        elif choice == 8:
            query = "SELECT itemType, AVG(DATEDIFF(dueDate, checkoutDate)) AS AvgCheckoutPeriod, AVG(renewalStatus) AS AvgRenewals FROM loanrecord JOIN libraryitem ON loanrecord.itemID = libraryitem.itemID GROUP BY itemType"
            cursor.execute(query)
            results = cursor.fetchall()
            if results:
                print("{:<20} {:<20} {:<15}".format("Item Type", "Avg Checkout Period", "Avg Renewals"))
                print("="*55)
                for row in results:
                    print("{:<20} {:<20} {:<15}".format(row[0], row[1], row[2]))
            else:
                print("No data available.")

        elif choice == 9:
            libraryCardNumber = input("Enter the Library Card Number to check checked out and renewed items: ")
            query = "SELECT li.title, l.itemID, COUNT(*) AS TimesRenewed FROM loanrecord l JOIN libraryitem li ON l.itemID = li.itemID WHERE l.libraryCardNumber = %s AND l.renewalStatus = 1 GROUP BY l.itemID, li.title"
            cursor.execute(query, (libraryCardNumber,))
            results = cursor.fetchall()
            if results:
                print("{:<30} {:<10} {:<15}".format("Title", "Item ID", "Times Renewed"))
                print("="*55)
                for row in results:
                    print("{:<30} {:<10} {:<15}".format(row[0], row[1], row[2]))
            else:
                print("No items found.")

        elif choice == 10:
            itemID = input("Enter the Item ID to request: ")
            libraryCardNumber = input("Enter your Library Card Number: ")
            today = input("Enter today's date (YYYY-MM-DD): ")
            status = 'Pending'
            query = "INSERT INTO itemrequests (itemID, libraryCardNumber, requestDate, status) VALUES (%s, %s, %s, %s)"
            cursor.execute(query, (itemID, libraryCardNumber, today, status))
            cnx.commit()
            print("Request added successfully.")

    cursor.close()
    cnx.close()

if __name__ == "__main__":
    main()
