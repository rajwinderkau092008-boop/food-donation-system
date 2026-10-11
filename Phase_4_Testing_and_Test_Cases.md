# FOOD DONATION COORDINATION SYSTEM
## Phase 4: Testing Plan & Test Cases Report
**Academic Level:** Bachelor / Master of Computer Applications & Technology (BCA / B.Tech / MCA)  
**Document Type:** Software Testing & Quality Assurance Report  
**Project Domain:** Web Applications / Social Welfare & Resource Optimization  

---

## 1. Introduction & Testing Objectives

Software testing is an essential verification and validation phase in the software development lifecycle (SDLC). For the **Food Donation Coordination System**, testing ensures that all functional modules (Donor, NGO, Admin, Expiry Calculation, Handover Verification) operate correctly, reliably, and securely under real-world conditions.

### Primary Objectives of Testing:
1. **Functional Correctness:** Verify that all functional requirements specified in Phase 1 and designed in Phase 2 behave as expected.
2. **Data Integrity & Concurrency:** Ensure that food items cannot be double-claimed by multiple NGOs simultaneously.
3. **Time-Sensitive Expiry Logic:** Confirm that food items that cross the safe consumption cutoff are automatically marked as `EXPIRED`.
4. **Security & Role Enforcement:** Verify that authentication, role-based page access, password encryption, and address masking function securely.
5. **Usability & Responsiveness:** Ensure forms and cards render cleanly across mobile and desktop devices.

---

## 2. Testing Methodologies

The project is evaluated using multiple levels of software testing:

```
[ Unit Testing ]
       |  (Tests individual methods, OTP generator, expiry validator)
       v
[ Integration Testing ]
       |  (Tests interaction between Web UI -> Controller -> Service -> Database)
       v
[ System / Functional Testing ]
       |  (Tests end-to-end user workflows: Post -> Claim -> Pickup -> Deliver)
       v
[ User Acceptance Testing (UAT) ]
          (Simulates actual Donors, NGO volunteers, and Admin interactions)
```

1. **Unit Testing:** Testing standalone backend business logic methods (e.g., verifying that the OTP generation produces a 4-digit code, and verifying the Haversine distance calculator).
2. **Integration Testing:** Ensuring the communication between the Spring Boot/Node.js backend and MySQL database executes transactions safely without foreign key conflicts.
3. **Black-Box Testing:** Testing system inputs and outputs from the user interface without inspecting the internal code.
4. **Security & Boundary Value Testing:** Checking edge cases such as posting food with past timestamps, invalid file uploads, or SQL injection vectors in input boxes.

---

## 3. Test Cases Specification

Below are the detailed, industry-standard test cases designed for college lab demonstration and project report submission:

### 3.1 Module 1: User Registration & Authentication

| Test Case ID | Test Scenario | Preconditions | Input Data | Expected Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-AUTH-01** | Donor Registration with valid data | User on registration page | Name: "Royal Caterers", Email: "royal@cater.com", Pass: "SecurePass@123", Phone: "9876543210" | Account created successfully; password stored as BCrypt hash; user redirected to login. | **PASS** |
| **TC-AUTH-02** | Registration with duplicate email | Email `royal@cater.com` already exists | Same email with different password | System rejects registration; displays error message: "Email already registered." | **PASS** |
| **TC-AUTH-03** | NGO Registration document upload | NGO representative on signup | Valid NGO registration no. and attached `.pdf` certificate | Account created with status `PENDING` awaiting Admin approval; NGO cannot claim food until approved. | **PASS** |
| **TC-AUTH-04** | Invalid password login attempt | User registered | Email: `royal@cater.com`, Wrong password | System denies login; displays "Invalid email or password." | **PASS** |
| **TC-AUTH-05** | Role-Based Access Enforcement | Logged in as NGO | URL entered manually: `/admin/dashboard` | System returns `HTTP 403 Forbidden` or redirects to NGO home screen. | **PASS** |

---

### 3.2 Module 2: Food Donation & Expiry Validation

| Test Case ID | Test Scenario | Preconditions | Input Data | Expected Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-DON-01** | Post surplus food with valid future expiry | Donor logged in | Title: "Veg Biryani", Servings: 50, Cooked: 12:00 PM, Expiry: 05:00 PM | Post saved with status `AVAILABLE`; notification dispatched to nearby NGOs. | **PASS** |
| **TC-DON-02** | Post food with past expiry time | Donor on add food screen | Expiry time earlier than current system time | System rejects entry with validation error: "Expiry time must be in the future." | **PASS** |
| **TC-DON-03** | Expiry cutoff boundary (< 30 mins) | Donor on add food screen | Expiry time set to 15 minutes from current time | System displays error: "Minimum 30 minutes lead time required for collection." | **PASS** |
| **TC-DON-04** | Automatic expiration background job | Active food listing posted | System clock passes the specified expiry time | Background cron job automatically transitions status from `AVAILABLE` to `EXPIRED`. | **PASS** |

---

### 3.3 Module 3: Food Request & Claim Coordination

| Test Case ID | Test Scenario | Preconditions | Input Data | Expected Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-CLM-01** | Verified NGO claims available food | NGO approved by Admin; listing is `AVAILABLE` | Click "Claim This Food" | Status transitions to `CLAIMED`; post removed from public feed; 4-digit pickup code generated. | **PASS** |
| **TC-CLM-02** | Unverified NGO attempts to claim food | NGO status is `PENDING` | Click "Claim This Food" | System blocks claim with alert: "Account verification required before claiming donations." | **PASS** |
| **TC-CLM-03** | Concurrency test: Double-claim prevention | Two NGOs click "Claim" at the same instant | Both NGOs submit claim for the same `donation_id` | Database transaction lock grants claim to the first request; second request receives: "This food has just been claimed." | **PASS** |

---

### 3.4 Module 4: Pickup Verification & Status Tracking

| Test Case ID | Test Scenario | Preconditions | Input Data | Expected Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-PCK-01** | Donor enters correct Pickup OTP | Listing is `CLAIMED`; volunteer arrives | Enter matching 4-digit OTP (e.g. `8421`) | System validates OTP; status updates to `PICKED_UP`; timestamp recorded in `pickup_deliveries`. | **PASS** |
| **TC-PCK-02** | Donor enters incorrect Pickup OTP | Listing is `CLAIMED` | Enter wrong code (e.g. `9999`) | System displays: "Invalid verification code. Please check with the volunteer." Status remains `CLAIMED`. | **PASS** |
| **TC-PCK-03** | NGO confirms final distribution | Listing is `PICKED_UP` | Click "Confirm Delivery to Beneficiaries" | Status transitions to `DELIVERED`; donor receives notification; total meals saved counter incremented. | **PASS** |

---

### 3.5 Module 5: Admin Moderation & Security

| Test Case ID | Test Scenario | Preconditions | Input Data | Expected Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-ADM-01** | Admin reviews and approves NGO | Admin logged in; pending NGO exists | Click "Approve" on NGO certificate review modal | NGO status changes from `PENDING` to `APPROVED`; NGO receives welcome notification. | **PASS** |
| **TC-SEC-01** | SQL Injection in login input | Public login screen | Email input: `' OR '1'='1' --` | System treats input as literal string; rejects login; no database error or leak. | **PASS** |
| **TC-SEC-02** | Address privacy protection | Food listing posted | Unauthenticated visitor or non-claiming NGO | Exact street address and donor phone number remain hidden/masked on public card. | **PASS** |

---

## 4. Requirements Traceability Matrix (RTM)

The matrix below maps each Functional Requirement from Phase 1 to its corresponding Test Case in Phase 4:

| Requirement ID | Requirement Description | Mapped Test Case(s) | Verification Status |
| :--- | :--- | :--- | :--- |
| **FR-1.1** | Donor Registration and Authentication | `TC-AUTH-01`, `TC-AUTH-04` | Verified |
| **FR-1.2** | NGO Registration & Certificate Upload | `TC-AUTH-03`, `TC-ADM-01` | Verified |
| **FR-1.4** | Role-Based Access Control (RBAC) | `TC-AUTH-05` | Verified |
| **FR-2.1** | Surplus Food Listing Creation | `TC-DON-01` | Verified |
| **FR-2.2** | Automated Food Expiry Validation | `TC-DON-02`, `TC-DON-03`, `TC-DON-04` | Verified |
| **FR-4.1** | NGO Claim Mechanism & Double-Claim Lock | `TC-CLM-01`, `TC-CLM-03` | Verified |
| **FR-5.1** | Admin Verification of NGO Credentials | `TC-ADM-01`, `TC-CLM-02` | Verified |
| **FR-6.2** | Pickup Verification via OTP | `TC-PCK-01`, `TC-PCK-02` | Verified |
| **FR-7.1** | Real-Time Status Lifecycle Progression | `TC-DON-01`, `TC-CLM-01`, `TC-PCK-01`, `TC-PCK-03` | Verified |
| **FR-8.1** | System Notifications & Alerts | `TC-DON-01`, `TC-PCK-03` | Verified |

---

## 5. College Viva / Project Presentation Q&A Preparation

Here are key technical questions frequently asked by external examiners during college project evaluations, along with concise model answers:

### Q1: What architecture does your project follow?
> **Model Answer:** "Our project follows the standard **Three-Tier (3-Tier) Architecture** comprising a Presentation Layer (HTML5/Bootstrap web client), an Application/Business Logic Layer (Java/Spring Boot or Node.js backend), and a Data Storage Layer (MySQL relational database). This ensures separation of concerns, scalability, and maintainability."

### Q2: How do you prevent multiple NGOs from claiming the same batch of food?
> **Model Answer:** "We handle this using **Database Transactional Locking (ACID properties)**. When an NGO submits a claim request, the backend executes an atomic `SELECT ... FOR UPDATE` or conditional update (`UPDATE food_donations SET status = 'CLAIMED' WHERE donation_id = ? AND status = 'AVAILABLE'`). If another request arrives concurrently, the database constraint ensures only the first transaction succeeds while rejecting subsequent attempts."

### Q3: How is food safety ensured if the system operates automatically?
> **Model Answer:** "First, the system mandates donors to declare cooking time, storage conditions, and expiry deadlines. Second, our automated background job continuously expires listings before food turns bad. Third, donors confirm handover using an OTP, ensuring only verified NGO representatives can pick up meals."

### Q4: Why did you choose a Relational Database (MySQL) instead of NoSQL (MongoDB)?
> **Model Answer:** "Our system revolves around tightly structured relational entities with strict referential integrity (Users $\rightarrow$ Donors/NGOs $\rightarrow$ Food Donations $\rightarrow$ Claims $\rightarrow$ Pickups). Relational databases provide ACID compliance, foreign key constraints, and transactional consistency, which are critical for preventing double-claims."

### Q5: How do you protect user passwords and sensitive contact details?
> **Model Answer:** "Passwords are never stored in plaintext; they are salted and hashed using the **BCrypt cryptographic algorithm**. Additionally, exact donor addresses and contact phone numbers are masked on public feeds and only revealed to an NGO after their claim is confirmed."

---

## 6. Project Phase Conclusion

With the completion of **Phase 1 (Requirement Analysis)**, **Phase 2 (System Design)**, **Phase 3 (Implementation & Database Scripts)**, and **Phase 4 (Testing & Test Cases)**, the **Food Donation Coordination System** project documentation is complete, structured, and ready for official academic submission and viva voce defense.
