# FOOD DONATION COORDINATION SYSTEM
## Phase 1: Requirement Analysis Document
**Academic Level:** Bachelor / Master of Computer Applications & Technology (BCA / B.Tech / MCA)  
**Document Type:** Software Requirement Specification (SRS) - Phase 1  
**Project Domain:** Web Applications / Social Welfare & Resource Optimization  

---

## 1. Introduction

Food waste and malnutrition represent two of the most pressing socio-economic challenges today. Every day, vast quantities of fresh, edible food from restaurants, banquet halls, hotels, corporate cafeterias, and family events are discarded into landfills, while millions of underprivileged individuals across communities suffer from hunger and malnutrition.

The **Food Donation Coordination System** is a centralized, web-based platform developed to bridge the communication and logistical gap between surplus food providers (donors) and charitable institutions (NGOs, orphanages, old-age homes, and shelter houses). The system provides a digital medium for real-time notification, verification, claiming, and tracking of surplus food before it spoils.

By automating the identification of nearby surplus food, validating requests, and tracking pickup and delivery statuses, this platform eliminates manual delays and ensures that surplus food reaches hungry people safely, quickly, and transparently.

---

## 2. Problem Statement

In the conventional food distribution and donation ecosystem, the process of sharing excess food suffers from critical bottlenecks:

1. **Unorganized and Manual Communication:** Donors must physically call multiple NGOs or volunteers. By the time an NGO is found, hours have passed, and the food may no longer be fresh.
2. **Time Sensitivity of Cooked Food:** Cooked food has a limited shelf life (typically 4–6 hours at room temperature). Without immediate coordination, edible food turns into waste.
3. **Geographical Mismatch:** Donors often lack awareness of local orphanages or shelter homes located within their immediate vicinity that could collect the food immediately.
4. **Lack of Transparency & Status Tracking:** Donors are unaware of whether their posted food was accepted, collected, or distributed, discouraging repeat donations.
5. **Absence of Centralized Records:** Neither donors nor NGOs have verifiable records of total food donated, recipients served, or wastage prevented for compliance, tax incentives, or CSR (Corporate Social Responsibility) reporting.

---

## 3. Existing System and Its Limitations

### Existing System Workflow
Presently, surplus food donation relies heavily on informal, manual methods:
* Direct phone calls to known charitable trusts.
* Unstructured posts on social media platforms (WhatsApp, Facebook groups, Instagram stories).
* Ad-hoc visits by volunteers to collect leftover food from major event halls.

### Limitations of the Existing System
* **No Real-Time Availability Updates:** Social media posts often remain visible long after food has already been collected or spoiled, leading to confusion and wasted trips.
* **Lack of Expiry and Shelf-Life Tracking:** Traditional methods do not track the precise preparation time, consumption deadline, or storage condition of the food.
* **No Verification Mechanism:** Anyone can claim food, creating risks of food misuse, resale, or safety hazards without institutional verification.
* **High Coordination Overhead:** Multiple phone calls back and forth between donor, driver, and NGO coordinator cause delays that exceed the food's shelf life.
* **Zero Analytical Insights:** No historical records exist to measure the impact, understand food waste patterns, or recognize consistent donors.

---

## 4. Proposed System

The proposed **Food Donation Coordination System** is a responsive web application that streamlines the entire food rescue lifecycle into a unified digital pipeline:

```
[ Food Donor ] ---> [ Creates Food Listing (Qty, Type, Expiry, Location) ]
                              |
                              v
[ Admin / System ] ---> [ Instant Verification & Notification Dispatch ]
                              |
                              v
[ Verified NGOs ] ---> [ Views Real-Time Feed -> Requests / Claims Food ]
                              |
                              v
[ Logistics / Pickup ] -> [ Shared Contact, Map Location & Verification OTP ]
                              |
                              v
[ Status Tracking ] ---> [ Posted -> Claimed -> Picked Up -> Distributed ]
                              |
                              v
[ Analytics & Reports ] -> [ Automatic Record Log & Impact Dashboard ]
```

### Key Advantages of the Proposed System:
* **Immediate Availability Broadcast:** As soon as a donor posts surplus food, nearby verified NGOs receive notifications instantly.
* **Perishable Food Timer (Expiry Tracking):** Every listing features a live countdown timer based on estimated shelf life to prevent distribution of stale food.
* **Location-Aware Discovery:** NGOs can filter available donations by radius/distance to ensure rapid pickup.
* **Role-Based Access Control:** Separate, secure interfaces for Donors, NGOs, and Administrators ensure data privacy and operational integrity.
* **End-to-End Status Tracking:** Both donor and NGO can monitor each step from initial posting to final distribution confirmation.

---

## 5. Objectives of the System

### Primary Objectives:
1. **Minimize Food Wastage:** Provide a fast, accessible platform to connect surplus food producers with charitable organizations before food perishes.
2. **Mitigate Hunger:** Channel safe, nutritious meals directly to vulnerable populations (slum dwellers, orphanages, old-age shelters).
3. **Automate Coordination:** Replace manual phone calls with an automated workflow for posting, requesting, and confirming pickups.

### Secondary Objectives:
1. **Ensure Food Safety & Quality Standards:** Mandate donor disclosures regarding preparation time, food type (veg/non-veg), storage conditions, and expiry timelines.
2. **Promote Accountability & Transparency:** Maintain digital audit logs for every donation transaction, including pickup timestamps and distribution proofs.
3. **Generate Impact Metrics:** Provide donors and NGOs with printable reports and statistical dashboards reflecting total kilograms of food salvaged and meals served.

---

## 6. Scope of the Project

### In-Scope (Functional Boundaries):
* User registration and authentication with role-based profiles (Donor, NGO, Admin).
* Verification and approval of NGOs and commercial food donors by administrators.
* Listing of surplus food with comprehensive metadata (quantity in servings/kg, food category, preparation time, expiry time, pickup address, and images).
* Search, filter, and map-based listing view for verified NGOs.
* One-click claim/request mechanism with automated confirmation codes.
* Real-time donation tracking across predefined statuses.
* Automated notification alerts for urgent donations, claim status, and approaching expiry.
* Comprehensive administrative dashboard for monitoring community metrics, resolving conflicts, and managing user access.

### Out-of-Scope (Future Enhancements):
* In-house dedicated transportation or delivery fleet (logistics will rely on NGO volunteers or donor self-drop).
* Laboratory/chemical food safety testing (system relies on donor self-declarations and basic physical checks upon pickup).
* Monetary transactions or online payment gateways for buying/selling food.

---

## 7. Stakeholders and User Roles

| Stakeholder / Role | Description | Key Responsibilities |
| :--- | :--- | :--- |
| **1. Food Donor** | Restaurants, hotels, caterers, banquet hall managers, supermarkets, corporate cafeterias, and private individuals with edible surplus food. | • Register and maintain profile.<br>• Accurately post surplus food details.<br>• Package food safely for transit.<br>• Hand over food to the authorized NGO representative upon verification code check. |
| **2. NGO / Recipient** | Registered charitable trusts, orphanages, old-age homes, disaster relief agencies, and community food volunteers. | • Register with valid identification/registration documents.<br>• Browse and claim food matching their capacity.<br>• Arrange timely pickup prior to expiry.<br>• Distribute food to beneficiaries and mark delivery status. |
| **3. Admin / Coordinator** | System administrators and volunteer network managers overseeing the platform. | • Verify legitimacy of newly registered NGOs and commercial donors.<br>• Monitor active listings and flag improper posts.<br>• Intervene in dispute resolution or unfulfilled claims.<br>• Generate system-wide impact reports. |

---

## 8. Functional Requirements

Functional requirements define the core operations and behavioral capabilities that the system must perform.

### 8.1 Module 1: User Registration, Authentication & Profile Management
* **FR-1.1 Donor Registration & Login:** The system shall allow donors (individuals and commercial entities) to register using their name, organization name, email, phone number, and physical address, secured by password authentication.
* **FR-1.2 NGO Registration & Document Submission:** The system shall require NGOs to submit their registration number, authorized representative contact details, operating area, and NGO certificate for credibility checks.
* **FR-1.3 Profile Management:** Users shall be able to view and edit their profiles, update contact numbers, reset passwords, and set default pickup/delivery addresses.
* **FR-1.4 Role-Based Authorization:** The system shall restrict page access based on user role (e.g., donors cannot request food; NGOs cannot approve registrations).

### 8.2 Module 2: Surplus Food Listing & Expiry Management
* **FR-2.1 Detailed Food Entry:** Donors shall be able to post food listings by filling in:
  * Food Item Name and Category (e.g., Cooked Meals, Bakery, Raw Grains, Packed Food).
  * Food Classification (Vegetarian / Non-Vegetarian / Vegan).
  * Quantity (specified in number of portions/servings or weight in kg).
  * Preparation Timestamp (when the food was cooked/packed).
  * Expiry/Safe Consumption Window (exact cutoff time after which food must not be consumed).
  * Storage and Packaging Information (e.g., Hot container, Refrigerated, Sealed boxes).
  * Pickup Address with Landmark and Contact Person.
* **FR-2.2 Expiry Validation:** The system shall automatically reject any food listing where the stated expiry time has already passed or is within an unfeasible collection window (e.g., less than 30 minutes).
* **FR-2.3 Image Upload:** Donors shall be able to upload photographs of the prepared food to give recipients a clear visual indication of quality and packaging.

### 8.3 Module 3: Food Browsing & Search
* **FR-3.1 Available Donations Feed:** Registered NGOs shall have access to a live feed displaying all currently available, unexpired, and unclaimed food donations.
* **FR-3.2 Filtering & Search:** The system shall enable NGOs to filter listings by:
  * Location / Distance (nearest first).
  * Dietary Type (Vegetarian / Non-Vegetarian).
  * Quantity range (to match the number of residents in their shelter).
  * Urgency / Time remaining before expiry.

### 8.4 Module 4: Food Request & Claim Workflow
* **FR-4.1 Claim Mechanism:** A verified NGO shall be able to submit a claim request for an available food listing.
* **FR-4.2 Single Allocation Lock:** To avoid multiple NGOs arriving for the same batch of food, the system shall instantly change the listing status to **"Claimed"** upon request, removing it from the public open feed.
* **FR-4.3 Verification Token / OTP:** Upon claim approval, the system shall generate a secure, unique alphanumeric pickup code (or OTP) shared between the donor and claiming NGO.

### 8.5 Module 5: Admin Verification & Moderation
* **FR-5.1 NGO Account Verification:** Administrators shall have a verification portal to review submitted registration certificates and either approve or reject NGO applications.
* **FR-5.2 Content Moderation:** Admins shall have the authority to edit, remove, or flag suspicious, unhygienic, or inappropriate food listings.
* **FR-5.3 User Deactivation:** Admins shall be able to suspend accounts that violate safety guidelines or repeatedly fail to collect claimed donations.

### 8.6 Module 6: Pickup & Delivery Coordination
* **FR-6.1 Contact Exchange:** Once a claim is finalized, the system shall reveal direct contact numbers and Google Maps / navigation location links between the donor and the NGO driver/volunteer.
* **FR-6.2 Handover Verification:** The donor shall confirm food handover only after verifying the NGO representative's verification token/OTP in the portal.

### 8.7 Module 7: Real-Time Donation Status Tracking
* **FR-7.1 Lifecycle Statuses:** The system shall maintain and update the lifecycle of each donation through explicit state transitions:
  1. `POSTED / AVAILABLE`: Food published by donor; awaiting claim.
  2. `CLAIMED`: Food reserved by a verified NGO; pickup scheduled.
  3. `PICKED UP / IN TRANSIT`: Volunteer has collected the food from donor premises.
  4. `DISTRIBUTED / COMPLETED`: Food safely distributed to beneficiaries; transaction closed.
  5. `EXPIRED / CANCELLED`: Time expired without claim, or cancelled due to unavoidable circumstances.
* **FR-7.2 Visual Progress Indicator:** The interface shall display a visual step-by-step progress bar showing the live status to both the donor and the recipient.

### 8.8 Module 8: Notifications & Alerts
* **FR-8.1 New Donation Alerts:** The system shall trigger alerts (email/in-app notification) to registered NGOs located within the donor's district whenever a new donation is posted.
* **FR-8.2 Expiry Warnings:** Automated alerts shall notify the donor and nearby NGOs when an unclaimed listing is within 1 hour of its safe consumption deadline.
* **FR-8.3 Status Notifications:** Donors shall receive immediate notifications when their food is claimed, picked up, and successfully distributed.

### 8.9 Module 9: Records, Audit Trail & History
* **FR-9.1 Donation History:** Donors shall have access to their historical ledger of all past donations, dates, items provided, and which NGO received them.
* **FR-9.2 Distribution Records:** NGOs shall have an immutable record of all meals collected and distributed for reporting to donors, trustees, and regulatory bodies.

### 8.10 Module 10: Reports & Dashboard Generation
* **FR-10.1 Role-Specific Dashboards:**
  * **Donor Dashboard:** Shows total donations made, total meals equivalent provided, and current active listings.
  * **NGO Dashboard:** Shows active pickups, daily meals secured, and distribution history.
  * **Admin Dashboard:** Displays system-wide key performance indicators (total registered donors, total verified NGOs, kilograms of food saved, total meals distributed, wastage prevented).
* **FR-10.2 Report Export:** The system shall allow administrators and donors to export summary reports (monthly/annual) in PDF and CSV/Excel formats for administrative and audit purposes.

---

## 9. Non-Functional Requirements

Non-functional requirements describe the quality attributes, performance benchmarks, and constraints that govern the system's execution.

### 9.1 Performance Requirements
* **Response Time:** Standard web pages and listing feeds shall load within 2 seconds under regular broadband/4G mobile connections.
* **Real-Time Data Refresh:** Food listing status changes (Available $\rightarrow$ Claimed) must reflect across all connected clients within 3 seconds to avoid double-claiming.
* **Concurrent Capacity:** The system shall support a minimum of 200 concurrent active users without degradation of response time.

### 9.2 Usability & Accessibility Requirements
* **Simplicity of Operation:** The food listing creation process for donors shall be completed in under 2 minutes with fewer than 4 input steps.
* **Responsive Design:** The user interface must adapt cleanly to desktop monitors, tablets, and mobile smartphone screens (responsive layout).
* **Clear Terminology:** All labels, prompts, and instructions must be phrased in plain, jargon-free language suitable for diverse users (cooks, NGO drivers, and volunteers).

### 9.3 Reliability & Availability Requirements
* **High Uptime:** The system shall maintain an operational availability of at least 99% during peak service hours (10:00 AM to 11:00 PM), when most event and restaurant surplus occurs.
* **Data Integrity:** Database transactions must adhere strictly to ACID properties, ensuring no donation record or status update is lost or corrupted during system crashes.

### 9.4 Security & Privacy Requirements
* **Secure Authentication:** User passwords must be hashed using strong cryptographic standards (e.g., BCrypt/PBKDF2) before storage.
* **Privacy of Sensitive Contact Data:** Exact donor address and personal phone numbers shall remain hidden from public view and only revealed to the specific NGO that successfully claims the donation.
* **Role-Based Access Control (RBAC):** Every endpoint and page request shall be validated to confirm the requesting user has appropriate permission.

### 9.5 Maintainability & Scalability
* **Modular Code Structure:** The software architecture shall decouple the frontend presentation, backend business logic, and database layer to simplify maintenance and testing.
* **Horizontal Scalability:** The database and application architecture shall be designed to allow easy expansion to support additional cities and districts without architectural redesign.

---

## 10. Hardware Requirements

### 10.1 Server-Side Requirements (Hosting / Deployment Environment)
* **Processor (CPU):** Dual-Core 2.0 GHz or higher (e.g., Intel Xeon / AMD EPYC / Core i5).
* **System Memory (RAM):** Minimum 4 GB RAM (8 GB recommended for concurrent database and application hosting).
* **Storage (Hard Disk / SSD):** 40 GB SSD free space (for operating system, database records, and uploaded donation images).
* **Network Interface:** Stable broadband internet connectivity with at least 10 Mbps dedicated upload/download speed.

### 10.2 Client-Side Requirements (End-User Devices: Donors, NGOs, Admins)
* **Device:** Desktop PC, Laptop, Tablet, or Smartphone (Android / iOS).
* **Processor:** 1.2 GHz multi-core processor or equivalent.
* **RAM:** Minimum 2 GB RAM (4 GB recommended).
* **Display Resolution:** Minimum resolution of $360 \times 640$ pixels for mobile devices; $1366 \times 768$ pixels for desktop computers.
* **Internet Connection:** Basic 3G/4G/5G mobile data or Wi-Fi connection.

---

## 11. Software Requirements

### 11.1 Server-Side Software
* **Operating System:** Windows 10/11, Ubuntu Linux 20.04/22.04 LTS, or macOS.
* **Web Server / Application Server:** Apache Tomcat (for Java), Node.js runtime, or Apache HTTP Server.
* **Database Management System (DBMS):** MySQL 8.0+ or PostgreSQL 13+.
* **Runtime Environment:** Java Development Kit (JDK 17 or higher) / Node.js LTS.

### 11.2 Client-Side Software
* **Web Browser:** Any modern web browser supporting HTML5, CSS3, and JavaScript:
  * Google Chrome (v90+)
  * Mozilla Firefox (v88+)
  * Microsoft Edge (v90+)
  * Apple Safari (v14+)

### 11.3 Development & Modeling Tools
* **Integrated Development Environment (IDE):** Eclipse IDE, IntelliJ IDEA, or Visual Studio Code.
* **Database Design & Query Tool:** MySQL Workbench or pgAdmin 4.
* **API Testing Tool:** Postman or Thunder Client.
* **Documentation & Diagramming:** Diagrams.net (draw.io) or StarUML for UML modeling.

---

## 12. User Requirements

User requirements represent the direct needs and expectations of the primary human actors interacting with the system.

### 12.1 Requirements from Food Donors
1. **Frictionless Listing:** Donors need to post surplus food swiftly at the conclusion of an event without navigating complicated forms.
2. **Confidence in Credibility:** Donors require assurance that their food goes to legitimate, registered charities rather than unauthorized third parties.
3. **Prompt Collection:** Donors need prompt confirmation and designated collection windows so premises can be vacated or closed on schedule.
4. **Recognition & Impact Awareness:** Donors want visible proof and acknowledgment of their positive societal contribution.

### 12.2 Requirements from NGOs and Recipients
1. **Accurate Food Descriptions:** NGOs require explicit detail on food freshness, preparation time, and vegetarian/non-vegetarian categorization to distribute safely and appropriately.
2. **Proximity-Based Alerts:** NGOs need alerts for food available close to their shelters to minimize travel expenses and transit delays.
3. **Advance Notice:** NGOs require adequate lead time before food reaches its expiry deadline to mobilize pickup vehicles and distribution volunteers.

### 12.3 Requirements from Administrators
1. **Verification Controls:** Admins require a streamlined dashboard to review NGO credentials and prevent fraudulent exploitation.
2. **Operational Oversight:** Admins need clear visibility over system activity, including open, active, and expired listings, to intervene when disputes or delays occur.

---

## 13. System Constraints

System constraints represent boundaries, restrictions, and regulatory dependencies within which the system must operate:

1. **Perishability Constraint (Strict Time Windows):** Cooked food quality deteriorates rapidly. The system cannot hold a listing indefinitely; automatic state transitions must expire unclaimed items once safety thresholds pass.
2. **Internet Dependency:** All interactions (posting, claiming, OTP verification) require active network access. The system cannot coordinate transactions in fully offline environments.
3. **No In-Platform Logistics Fleet:** The software coordinates communication and scheduling, but actual physical transportation depends entirely on NGO and donor resources.
4. **Regulatory and Food Safety Compliance:** The system must include mandatory donor disclaimer declarations adhering to general Food Safety and Standards (FSSAI / Good Samaritan guidelines), indemnifying the platform against accidental contamination outside of platform control.
5. **Storage Limits for Media:** Image uploads must be compressed and limited in file size (e.g., maximum 2 MB per image) to prevent storage depletion.

---

## 14. Assumptions

1. **User Integrity:** It is assumed that donors provide honest, accurate information regarding food freshness, ingredients, and preparation time.
2. **Logistical Capability of NGOs:** It is assumed that registered NGOs have access to basic transport equipment (motorcycles, vans, insulated containers) and volunteers to execute pickups.
3. **Smart Device Availability:** It is assumed that donors and NGO representatives possess at least one smartphone or internet-enabled computer to access the system during operation.
4. **Non-Commercial Nature:** It is assumed that all transactions through the platform are strictly non-monetary and intended solely for charitable welfare without any resale.
5. **Basic Digital Literacy:** It is assumed that users have rudimentary familiarity with using modern web browsers and submitting web forms.

---

## 15. Expected Outcomes

Upon successful implementation following this requirement analysis, the **Food Donation Coordination System** will achieve the following project outcomes:

1. **Centralized Digital Bridge:** Elimination of unorganized phone calls and scattered social media messages through a single real-time food rescue platform.
2. **Significant Reduction in Food Wastage:** Timely notifications and location-based matching ensure edible surplus food from commercial and domestic donors is saved before spoiling.
3. **Improved Nutritional Access for Beneficiaries:** Orphanages, shelters, and impoverished communities receive regular, wholesome meals through systematized NGO pickups.
4. **Enhanced Trust and Accountability:** Two-factor pickup verification (OTP/Token), NGO background validation, and end-to-end lifecycle tracking build mutual trust between donors and charitable institutions.
5. **Quantifiable Social Impact Data:** Production of reliable, exportable statistics demonstrating the volume of food diverted from landfills, meals served, and greenhouse gas emissions averted.
