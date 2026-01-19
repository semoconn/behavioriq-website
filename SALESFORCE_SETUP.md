# Salesforce Waitlist Automation Setup

Follow these steps to configure your Salesforce Org for the BehaviorIQ waitlist workflow.

## 1. Create 'Waitlist Confirmation' Email Template

This template will be sent to the lead automatically when they sign up.

1.  **Navigate to Setup:** Click the gear icon > Setup.
2.  **Search:** In the Quick Find box, type "Classic Email Templates" (or "Lightning Email Templates" if you prefer using the builder). *Note: Classic is often easier for simple Auto-Response rules.*
3.  **New Template:** Click **New Template**.
4.  **Type:** Select **Text** or **HTML (using Letterhead)**. Text is simplest for now.
5.  **Folder:** Select "Unfiled Public Classic Email Templates" or a custom folder.
6.  **Details:**
    *   **Email Template Name:** `Waitlist Confirmation`
    *   **Unique Name:** `Waitlist_Confirmation`
    *   **Encoding:** Unicode (UTF-8)
    *   **Description:** Sent to new Web-to-Lead submissions.
    *   **Subject:** `Welcome to the BehaviorIQ Waitlist`
7.  **Email Body:**
    ```text
    Hi {!Lead.FirstName},

    Thank you for joining the BehaviorIQ waitlist.

    We have received your request for early access. You are now in the queue to receive updates about our upcoming release.

    Best,
    
    Sean O'Connor Founder & Principal Architect, BehaviorIQ
    ```
8.  **Save.**

*Note: To send as `hello@behavioriq.ai`, ensure this address is set up in **Organization-Wide Email Addresses** and verified.*

## 2. Set Up Lead Auto-Response Rule

This ensures the email is sent immediately upon form submission.

1.  **Search:** In Setup Quick Find, type "Auto-Response Rules".
2.  **Select:** Click **Lead Auto-Response Rules**.
3.  **New:** Click **New**.
    *   **Rule Name:** `Website Waitlist Response`
    *   **Active:** Check this box.
    *   **Save.**
4.  **Add Rule Entry:** Click on the rule name you just created (`Website Waitlist Response`) and scroll to **Rule Entries**. Click **New**.
5.  **Step 1: Sort Order:** `1`
6.  **Step 2: Criteria:**
    *   **Field:** `Lead: Lead Source`
    *   **Operator:** `equals`
    *   **Value:** `Website Waitlist`
7.  **Step 3: Email Settings:**
    *   **Name:** `BehaviorIQ Team`
    *   **Email Address:** `hello@behavioriq.ai` (Must be a verified Org-Wide Address).
    *   **Email Template:** Click the lookup icon and select the `Waitlist Confirmation` template you created in Section 1.
8.  **Save.**

## 3. Create Record-Triggered Flow (Internal Notification)

This notifies you when a new lead comes in.

1.  **Search:** In Setup Quick Find, type "Flows".
2.  **New Flow:** Click **New Flow** > **Record-Triggered Flow** > **Create**.
3.  **Configure Start:**
    *   **Object:** `Lead`
    *   **Trigger the Flow:** `A record is created`
    *   **Condition Requirements:** `All Conditions Are Met (AND)`
    *   **Field:** `LeadSource`
    *   **Operator:** `Equals`
    *   **Value:** `Website Waitlist`
    *   **Optimize the Flow for:** `Actions and Related Records`
4.  **Add Action:**
    *   Click the `+` icon in the path.
    *   Select **Action**.
    *   Search for "Send Email" (specifically the simple "Send Email" core action).
5.  **Configure Action:**
    *   **Label:** `Notify Sean`
    *   **Body:** `A new lead has joined the waitlist: {!$Record.FirstName} {!$Record.LastName} from {!$Record.Company}.`
    *   **Subject:** `New Waitlist Lead: {!$Record.Company}`
    *   **Recipient Email Addresses (comma-separated):** `sean.oconnor@behavioriq.ai`
    *   *Tip: Toggle "Rich-Text-Formatted Body" to True if you want to format the email body.*
6.  **Save & Activate:**
    *   **Flow Label:** `New Waitlist Lead Notification`
    *   **Save**, then click **Activate**.

---

**Verification:**
Your `index.html` form must send `LeadSource = "Website Waitlist"` for these rules to fire.
