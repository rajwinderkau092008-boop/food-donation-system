# FOOD DONATION COORDINATION SYSTEM
## Phase 5: Software Testing & Quality Assurance Report
**Academic Level:** Bachelor / Master of Computer Applications & Technology (BCA / B.Tech / MCA)  
**Document Type:** Software Testing & Quality Assurance Specification (Phase 5)  
**Project Domain:** Web Applications / Social Welfare & Resource Optimization  

---

## 1. Introduction to Testing

### 1.1 Purpose of Testing
Software testing is a systematic process of executing a software application with the intent of finding bugs, verifying functional behavior, and ensuring that the implemented software complies with user and system specifications. In the context of software engineering, testing ensures that the system works correctly, securely, reliably, and efficiently before it is released for real-world use.

### 1.2 Importance of Testing for the Food Donation Coordination System
Unlike generic e-commerce or informational websites, the **Food Donation Coordination System** operates under critical real-time and physical constraints:
* **Perishability of Cooked Meals:** Cooked food spoils rapidly (within 4 to 6 hours). A software bug or notification delay could cause edible food to spoil before it can be collected, resulting in hunger and wastage.
* **Health and Safety:** Distributing stale or expired food presents severe health hazards to vulnerable beneficiaries in shelters and orphanages.
* **Coordination Reliability:** If two NGOs receive confirmation for the same batch of food (double-claim bug), one NGO will arrive at the donor's premises only to find the food gone, causing fuel waste, logistical delays, and mistrust.
* **Data Privacy and Security:** The platform stores personal addresses, phone numbers, and NGO registration documents. Flaws in authentication or access control could expose private donor information or allow fraudulent entities to claim food for commercial resale.

Testing ensures that every workflow—from registration to final delivery—functions reliably and predictably without operational failure.

---

## 2. Testing Objectives

The testing phase is driven by specific, measurable goals tailored to the food donation lifecycle:

1. **Finding and Fixing Defects:** Identify, record, and resolve logical, functional, interface, and database bugs before deployment.
2. **Verifying Functional Requirements:** Validate that every feature specified in Phase 1 (donor registration, NGO verification, adding food details, expiry timers, claim requests, OTP handover, and tracking) operates exactly as designed.
3. **Checking Data Accuracy & Consistency:** Ensure that food quantities (servings/kg), calculated shelf life hours, pickup timestamps, and beneficiary statistics remain accurate and synchronized across all views.
4. **Ensuring Secure Access & Role Boundaries:** Guarantee that donors cannot access NGO claim routes, NGOs cannot access administrative verification screens, and passwords remain securely encrypted.
5. **Verifying Real-Time Donation Tracking:** Ensure that state transitions (`AVAILABLE` $\rightarrow$ `CLAIMED` $\rightarrow$ `PICKED UP` $\rightarrow$ `DELIVERED`) occur accurately and trigger appropriate updates for both donor and recipient.
6. **Ensuring Timely Coordination:** Confirm that automated expiry schedulers and alerts trigger on time to prevent distribution delays.

---

## 3. Types of Testing

The system is tested using a multi-tiered testing hierarchy:

```
+-------------------------------------------------------------------------+
|                  7. User Acceptance Testing (UAT)                       |
|           (Real-world validation by Donors, NGOs, and Admins)           |
+-------------------------------------------------------------------------+
                                    |
+-------------------------------------------------------------------------+
|                 6. Usability, Performance & Security                    |
|        (Ease of use, load handling, RBAC, SQLi/XSS protection)          |
+-------------------------------------------------------------------------+
                                    |
+-------------------------------------------------------------------------+
|                    5. System & Functional Testing                       |
|        (Full end-to-end workflow from posting to final distribution)     |
+-------------------------------------------------------------------------+
                                    |
+-------------------------------------------------------------------------+
|                        4. Integration Testing                           |
|       (Module-to-module data handoffs, API-to-database transactions)    |
+-------------------------------------------------------------------------+
                                    |
+-------------------------------------------------------------------------+
|                           3. Unit Testing                               |
|        (Individual methods, OTP generator, expiry validator, forms)     |
+-------------------------------------------------------------------------+
```

### 3.1 Unit Testing
Tests individual modules, functions, classes, and components in isolation (e.g., testing the OTP generator function, password hashing method, or phone number regex validator) without dependencies on external modules.

### 3.2 Integration Testing
Tests the communication and data exchange between interconnected modules (e.g., verifying that creating a food donation correctly stores records in the database and triggers the notification service).

### 3.3 System Testing
Tests the complete, fully integrated application from start to finish to confirm that the entire end-to-end workflow functions harmoniously.

### 3.4 Functional Testing
Validates system behavior against functional specifications, checking inputs, form validations, button clicks, state transitions, and error prompts.

### 3.5 Usability Testing
Evaluates the user-friendliness, layout simplicity, navigation ease, readability of terms, and responsiveness on mobile and desktop browsers for non-technical users.

### 3.6 Performance Testing
Measures the system's responsiveness, speed, throughput, and stability under simultaneous user access and high data volumes.

### 3.7 Security Testing
Probes the system for vulnerabilities: weak password storage, SQL injection, Cross-Site Scripting (XSS), privilege escalation, and unauthorized access to donor addresses.

### 3.8 User Acceptance Testing (UAT)
Simulates real-world usage by actual stakeholders (restaurant managers, shelter coordinators, and volunteer drivers) to verify that the platform fulfills practical field requirements.

---

## 4. Unit Testing

Unit testing validates individual modules and standalone functions to catch low-level bugs early.

### 4.1 Registration Unit Tests
* **Phone Number Validation:** Validates that inputs with letters (`"9812abc"`) or invalid lengths (`"123"`) fail, while 10-digit formats succeed.
* **Email Format Checker:** Ensures only standard email formats (e.g., `user@domain.com`) are accepted.
* **Role Assignment:** Confirms that selected radio values (`DONOR` vs. `NGO`) correctly populate the role property in the user model.

### 4.2 Login Unit Tests
* **BCrypt Password Verifier:** Confirms that `BCrypt.checkpw(plainPassword, storedHash)` returns `true` for matching passwords and `false` for incorrect passwords.
* **Blank Input Check:** Asserts that submitting empty username/password fields triggers a validation error without invoking the database.

### 4.3 Food Donation Unit Tests
* **Expiry Date Comparison:** Confirms that an expiry datetime set in the past or within 30 minutes of current system time returns a validation error.
* **Quantity Bounds:** Asserts that entering zero or negative numbers for servings (`-5` or `0`) triggers a `"Quantity must be greater than zero"` exception.

### 4.4 Food Request Unit Tests
* **Single Allocation Flag:** Asserts that calling `claimDonation(donationId)` verifies that `status == 'AVAILABLE'` before granting the claim.

### 4.5 Notification Unit Tests
* **Message Formatter:** Verifies that template strings dynamically format alerts correctly (e.g., `"New donation of [80 servings] posted near you"`).

### 4.6 Status Update Unit Tests
* **Valid State Transition Machine:** Ensures that valid transitions (`AVAILABLE` $\rightarrow$ `CLAIMED` $\rightarrow$ `PICKED_UP` $\rightarrow$ `DELIVERED`) are permitted, while invalid transitions (e.g., `AVAILABLE` $\rightarrow$ `DELIVERED`) are blocked.

### 4.7 Dashboard Unit Tests
* **Metric Aggregation Functions:** Verifies that the calculation function `sum(servings)` correctly totals meals for donor and admin summary cards.

---

## 5. Integration Testing

Integration testing verifies data exchange between distinct system modules:

```
[ Donor UI ] ------(1. Post Details)-----> [ Food Donation Module ]
                                                   |
                                            (2. Save Record)
                                                   v
                                          [( Database Tier )]
                                                   |
                                         (3. Notify Event)
                                                   v
[ NGO UI ] <-----(4. Alert Dispatched)---- [ Notification Engine ]
```

### 5.1 Donor $\longrightarrow$ Food Donation $\longrightarrow$ Database
* **Test Interaction:** Donor submits the "Add Surplus Food" form with image upload.
* **Verification:** The business layer validates data, saves the photo file to `/uploads`, writes a row into the `food_donations` table, and returns the generated `donation_id`.

### 5.2 NGO $\longrightarrow$ Food Request $\longrightarrow$ Admin / System
* **Test Interaction:** NGO clicks "Claim Donation".
* **Verification:** The request module checks that the NGO's account is verified by Admin (`verification_status == 'APPROVED'`). It creates a row in `food_requests`, updates `food_donations.status` to `CLAIMED`, and locks the record.

### 5.3 Admin $\longrightarrow$ Approval $\longrightarrow$ Notification
* **Test Interaction:** Admin reviews an NGO's uploaded certificate and clicks "Approve".
* **Verification:** The system updates `ngos.verification_status` to `APPROVED`, writes the admin user ID to `verified_by`, and dispatches an account activation alert to the NGO.

### 5.4 Pickup $\longrightarrow$ Delivery $\longrightarrow$ Status Tracking
* **Test Interaction:** Volunteer presents OTP to donor; donor inputs OTP into portal.
* **Verification:** The tracking module validates the OTP against `pickup_deliveries.pickup_code_otp`. Upon matching, it timestamps `pickup_time`, updates status to `PICKED_UP`, and refreshes the live progress stepper.

---

## 6. System Testing (End-to-End Workflow)

System testing validates the entire operational lifecycle from start to finish across all actors:

$$\begin{aligned}
\text{Donor Reg.} &\longrightarrow \text{Login} \longrightarrow \text{Add Food} \longrightarrow \text{Admin Verifies NGO} \longrightarrow \text{NGO Requests Food} \\
&\longrightarrow \text{System Approves \& Locks} \longrightarrow \text{Pickup Scheduled} \longrightarrow \text{OTP Handover} \\
&\longrightarrow \text{Distribution Completed} \longrightarrow \text{Impact Logged}
\end{aligned}$$

### End-to-End Test Scenario:
1. **Donor Registration & Login:** Restaurant "Royal Dine" registers and logs in to the donor portal.
2. **Food Post Creation:** Donor posts 60 servings of cooked vegetable biryani, cooked at 1:00 PM, safe until 7:00 PM.
3. **NGO Verification:** "Shanti Orphanage" registers; Admin reviews the uploaded certificate and approves the charity.
4. **Food Discovery & Request:** "Shanti Orphanage" logs in, browses the feed, spots the biryani 2 km away, and clicks "Claim Food".
5. **Approval & Lock:** System immediately locks the post (status: `CLAIMED`) and generates a 4-digit verification code (`5824`).
6. **Logistics & Handover:** NGO volunteer travels to "Royal Dine", presents code `5824`. Donor inputs `5824` into their screen. Status updates to `PICKED_UP`.
7. **Delivery & Completion:** Volunteer distributes food to 60 children and clicks "Mark as Delivered". Status updates to `DELIVERED`, donor receives completion notification, and the dashboard reflects 60 meals saved.

---

## 7. Comprehensive Test Case Table (26 Realistic Test Cases)

| Test Case ID | Module | Test Scenario | Input Data | Expected Result | Actual Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-01** | Registration | Valid donor registration | Name: "Spice Garden", Email: "spice@gmail.com", Phone: "9876543210", Role: Donor | Account created; password hashed; redirected to login with success message. | As expected | **PASS** |
| **TC-02** | Registration | Registration with missing required field | Email: "spice@gmail.com", Phone: "", Password: "pass" | Form displays validation error: "Phone number is required." Submission blocked. | As expected | **PASS** |
| **TC-03** | Registration | Registration with invalid email format | Email: "spicegarden.com" (missing `@`), Phone: "9876543210" | System alerts: "Please enter a valid email address." | As expected | **PASS** |
| **TC-04** | Authentication| Valid user login | Email: "spice@gmail.com", Password: "CorrectPassword123" | Login successful; session/JWT token initialized; user routed to Donor Dashboard. | As expected | **PASS** |
| **TC-05** | Authentication| Invalid password login | Email: "spice@gmail.com", Password: "WrongPassword" | System denies access; displays: "Invalid email or password." | As expected | **PASS** |
| **TC-06** | Food Donation | Adding valid surplus food | Title: "Veg Pulao", Qty: 50 Servings, Cooked: 12 PM, Expiry: 6 PM (same day) | Listing saved with status `AVAILABLE`; added to active donations table. | As expected | **PASS** |
| **TC-07** | Food Donation | Missing mandatory donation information | Title: "", Qty: 50, Expiry: 6 PM | Form prompts error: "Food title is required." Data not saved. | As expected | **PASS** |
| **TC-08** | Food Donation | Adding food with expired / past time | Expiry time set to 2 hours in the past | System rejects submission: "Expiry time must be in the future." | As expected | **PASS** |
| **TC-09** | Food Donation | Adding invalid food quantity | Quantity: `-10` or `0` servings | Validation error: "Quantity must be at least 1 serving." | As expected | **PASS** |
| **TC-10** | Food Browsing | Viewing available donations feed | Approved NGO logs in and opens "Available Food" tab | Shows all active donations with status `AVAILABLE` and unexpired timestamps. | As expected | **PASS** |
| **TC-11** | Food Request  | Sending food claim request | Approved NGO clicks "Claim Food" on listing #101 | Status updates to `CLAIMED`; post removed from public feed; 4-digit OTP issued. | As expected | **PASS** |
| **TC-12** | Food Request  | Duplicate request race condition | NGO A and NGO B click "Claim" at the same instant | First request accepted; second request returns: "Sorry, this food was just claimed." | As expected | **PASS** |
| **TC-13** | Admin Portal  | Admin approves pending NGO | Admin reviews NGO certificate and clicks "Approve" | NGO `verification_status` updates to `APPROVED`; NGO can now claim donations. | As expected | **PASS** |
| **TC-14** | Admin Portal  | Admin rejects fraudulent NGO | Admin clicks "Reject" and enters reason: "Invalid reg. number" | NGO status set to `REJECTED`; notification sent with reason; claiming disabled. | As expected | **PASS** |
| **TC-15** | Pickup/Delivery| Scheduling pickup time | Claiming NGO selects estimated arrival time: "4:30 PM" | Scheduled time updated in `pickup_deliveries` table; visible on donor tracking card. | As expected | **PASS** |
| **TC-16** | Status Updates| Handover with valid Pickup OTP | Donor enters volunteer's OTP (`5824`) | System verifies code; status transitions to `PICKED_UP`; timestamp recorded. | As expected | **PASS** |
| **TC-17** | Status Updates| Handover with incorrect OTP | Donor enters wrong code (`9999`) | System rejects entry: "Invalid verification code." Status remains `CLAIMED`. | As expected | **PASS** |
| **TC-18** | Notifications | New donation alert triggered | Donor posts 80 servings of food in Zone 2 | All verified NGOs registered in Zone 2 receive in-app alert and notification. | As expected | **PASS** |
| **TC-19** | Cancellation  | Donor cancels unclaimed donation | Donor clicks "Cancel Post" on `AVAILABLE` listing | Status changes to `CANCELLED`; post removed from public view. | As expected | **PASS** |
| **TC-20** | Cancellation  | Donor attempts to cancel claimed food | Donor clicks "Cancel" on a listing marked `CLAIMED` | Blocked with warning: "Food already claimed by NGO. Please contact support." | As expected | **PASS** |
| **TC-21** | Food Expiry   | Automatic expiration background job | Food listing crosses its expiry deadline without claim | Cron job updates status from `AVAILABLE` to `EXPIRED`; listing deactivated. | As expected | **PASS** |
| **TC-22** | Delivery      | Delivery completion confirmation | NGO volunteer clicks "Confirm Delivery to Beneficiaries" | Status updates to `DELIVERED`; donor notified; total meals counter incremented. | As expected | **PASS** |
| **TC-23** | Security      | Unauthorized page access attempt | NGO manually types URL: `/admin/verify-ngos` | Server returns `HTTP 403 Forbidden` and redirects to NGO dashboard. | As expected | **PASS** |
| **TC-24** | Security      | SQL Injection in login input | Email: `' OR '1'='1' --`, Password: `any` | Sanitized through prepared statements; login fails; database remains secure. | As expected | **PASS** |
| **TC-25** | Security      | Session expiry after logout | User clicks "Logout", then presses browser "Back" button | Cached pages refuse sensitive data; redirects to login page immediately. | As expected | **PASS** |
| **TC-26** | Usability     | Mobile responsiveness check | User accesses portal on mobile screen ($375 \times 667$ px) | Navbar collapses into hamburger menu; cards stack vertically without overflow. | As expected | **PASS** |

---

## 8. Security Testing

Security testing verifies that the system safeguards user data, prevents malicious tampering, and enforces strict authorization.

```
[ Attack / Vulnerability Vectors Tested ]
 ├── 1. Brute Force Login Attempts ----------> [ Account rate-limiting & error obscuring ]
 ├── 2. Privilege Escalation (RBAC) ---------> [ URL authorization checks on every endpoint ]
 ├── 3. SQL Injection (SQLi) ----------------> [ Parameterized SQL PreparedStatements ]
 ├── 4. Cross-Site Scripting (XSS) ----------> [ HTML tag escaping on titles & descriptions ]
 ├── 5. Password Storage --------------------> [ BCrypt salted hash verification ]
 └── 6. Session Hijacking -------------------> [ HTTP-only cookies, 30-min idle timeout ]
```

1. **Invalid Login & Brute Force Defense:** The system does not reveal whether the email or password was wrong (displays a generic `"Invalid email or password"` message) to prevent user enumeration.
2. **Role-Based Access Control (RBAC):** Tests confirm that URLs such as `/admin/*` are strictly blocked for users with roles `DONOR` or `NGO`.
3. **Password Protection:** Confirms that querying `SELECT password_hash FROM users` returns salted BCrypt strings (starting with `$2a$10$...`), confirming passwords are never stored in plain text.
4. **Input Sanitization (SQLi & XSS):** Tests verify that entering `<script>alert('XSS')</script>` in food titles renders escaped text rather than executing JavaScript in the browser.
5. **Address Masking:** Verifies that exact donor addresses are hidden on public listing feeds and are only visible to the specific NGO that successfully claims the batch.

---

## 9. Performance Testing

Performance testing confirms that the system handles peak traffic without crashing or degrading response times:

| Performance Scenario | Simulated Load Condition | Benchmark Target | Observed Test Result | Evaluation |
| :--- | :--- | :--- | :--- | :--- |
| **Multiple Concurrent Users** | 100 simultaneous users browsing the active food feed | Page load $< 2.0$ seconds | Average response time was 1.15 seconds | **PASS** |
| **High Listing Volume** | Database populated with 5,000 donation and request records | Query response $< 500$ ms | Filter queries executed in 120 ms using indexed columns | **PASS** |
| **Concurrent Claim Submissions**| 10 NGOs attempting to claim the same food item simultaneously | Exact single allocation lock | Exactly 1 claim succeeded; 9 claims rejected gracefully | **PASS** |
| **Admin Bulk Approvals** | Admin viewing 50 pending NGO applications with document links | Dashboard load $< 2.5$ seconds | Dashboard rendered in 1.4 seconds | **PASS** |

---

## 10. Usability Testing

Usability testing was conducted with a focus group of student volunteers representing Donors, NGO staff, and Administrators:

* **Donor Ease of Use:** 5 test donors were asked to list surplus food. All 5 participants successfully completed the food listing form in **under 90 seconds** without requiring guidance.
* **NGO Feed Readability:** The remaining shelf-life countdown timer (e.g., `"Expiring in 2 hours 45 mins"`) was identified by all participants as the most helpful feature for prioritizing pickups.
* **Clarity of Status Tracking:** The 4-step progress stepper (`Available` $\rightarrow$ `Claimed` $\rightarrow$ `Picked Up` $\rightarrow$ `Delivered`) eliminated ambiguity regarding where the food was at any given moment.
* **Error Message Understandability:** When required fields were omitted, inputs were highlighted with clear, descriptive red text (e.g., *"Please provide an approximate number of servings"*).

---

## 11. Bug Identification and Fixing Process

The project followed a structured, 6-step Defect Management Lifecycle:

```
[ 1. Identify Bug ]
         |  (Tester uncovers unexpected behavior during test execution)
         v
[ 2. Record Bug ]
         |  (Log Bug ID, Module, Steps to Reproduce, Severity)
         v
[ 3. Find Cause ]
         |  (Analyze code, inspect SQL queries or JavaScript logs)
         v
[ 4. Fix Bug ]
         |  (Modify code, correct logic, add validation checks)
         v
[ 5. Retest ]
         |  (Execute test case again in staging environment)
         v
[ 6. Mark Resolved ]
            (Verify fix; close bug ticket)
```

### Sample Bug Tracking Table:

| Bug ID | Module | Description of Defect | Severity | Root Cause Identified | Remedial Fix Applied | Retest Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **BUG-01** | Food Donation | Donors could enter 0 or negative servings | Medium | Form allowed `<input type="number">` without min attribute | Added `min="1"` in HTML and backend validation `if (servings <= 0) throw error` | **FIXED & VERIFIED** |
| **BUG-02** | Request Module| Two NGOs could claim same food at exact same time | High | Missing transaction lock in database update | Implemented SQL row-level lock (`SELECT ... FOR UPDATE` with conditional update) | **FIXED & VERIFIED** |
| **BUG-03** | Notifications | Expiry alert triggered after food was already picked up | Low | Notification job did not filter by `status == 'AVAILABLE'` | Added `WHERE status = 'AVAILABLE'` to the expiry query | **FIXED & VERIFIED** |
| **BUG-04** | Security | Unverified NGOs could see "Claim Food" button | High | Button visibility was not checking `verification_status` | Added condition to disable Claim button if `status != 'APPROVED'` | **FIXED & VERIFIED** |

---

## 12. User Acceptance Testing (UAT)

User Acceptance Testing was simulated with three sample user groups:

1. **Food Donor Group (Simulated by 3 local restaurant/caterer contacts):**
   * *Feedback:* Appreciated the simplicity of the 1-page donation form and the OTP handover feature, noting that the OTP gives them legal and personal confidence that the food went to the intended charity.
2. **NGO / Shelter Group (Simulated by 3 local orphanage volunteers):**
   * *Feedback:* Requested that distance filters show closest food first and that phone numbers be clickable for instant calling from mobile phones. These recommendations were incorporated.
3. **Admin Group (Simulated by Project Evaluators):**
   * *Feedback:* Verified that certificate inspection tools made it easy to approve or reject NGOs with a single click.

---

## 13. Testing Results Summary

The overall results of all executed test cases across all modules are summarized below:

| Metric Category | Count / Value | Percentage |
| :--- | :--- | :--- |
| **Total Test Cases Executed** | **26** | 100% |
| **Initially Passed** | 22 | 84.6% |
| **Initially Failed (Bugs found)** | 4 | 15.4% |
| **Bugs Successfully Fixed** | 4 | 100% of bugs fixed |
| **Retested & Finally Passed** | **26** | **100% Final Pass Rate** |

```
Test Execution Summary:
[██████████████████████████████] 100% Passed (26/26 Test Cases)
Defects Closed: 4 of 4 (100% Resolved)
```

---

## 14. Final Testing Report & Deployment Readiness

The comprehensive testing of the **Food Donation Coordination System** across Unit, Integration, System, Usability, Security, and Performance dimensions confirms the following:

1. **System Stability:** All critical workflows (Registration, Food Listing, Expiry Tracking, Claim Locking, OTP Handover, and Distribution Logging) execute smoothly without runtime exceptions or data corruption.
2. **Food Safety Compliance:** The automated background expiry scheduler successfully prevents spoiled or stale food from being listed or claimed.
3. **Strong Security Stance:** Role-based access control (RBAC), BCrypt password hashing, address masking, and input sanitization protect the system against unauthorized access and common cyber vulnerabilities (SQLi/XSS).
4. **Conclusion:** The software satisfies all functional and non-functional requirements set forth in **Phase 1 (Requirement Analysis)** and architected in **Phase 2 (System Design)**. The system is verified, robust, and **fully ready for deployment and academic evaluation**.
