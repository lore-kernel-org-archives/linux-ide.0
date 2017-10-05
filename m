From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] ahci: Convert timers to use timer_setup()
Date: Wed, 4 Oct 2017 17:54:17 -0700
Message-ID: <20171005005417.GA23922@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-ide@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Adds a pointer back to link
structure.

Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 drivers/ata/ahci.h    |  1 +
 drivers/ata/libahci.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 8b61123d2c3c..749fd94441b0 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -303,6 +303,7 @@ struct ahci_em_priv {
 	unsigned long saved_activity;
 	unsigned long activity;
 	unsigned long led_state;
+	struct ata_link *link;
 };
 
 struct ahci_port_priv {
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3e286d86ab42..a0de7a38430c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -968,12 +968,12 @@ static void ahci_sw_activity(struct ata_link *link)
 		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(10));
 }
 
-static void ahci_sw_activity_blink(unsigned long arg)
+static void ahci_sw_activity_blink(struct timer_list *t)
 {
-	struct ata_link *link = (struct ata_link *)arg;
+	struct ahci_em_priv *emp = from_timer(emp, t, timer);
+	struct ata_link *link = emp->link;
 	struct ata_port *ap = link->ap;
-	struct ahci_port_priv *pp = ap->private_data;
-	struct ahci_em_priv *emp = &pp->em_priv[link->pmp];
+
 	unsigned long led_message = emp->led_state;
 	u32 activity_led_state;
 	unsigned long flags;
@@ -1020,7 +1020,8 @@ static void ahci_init_sw_activity(struct ata_link *link)
 
 	/* init activity stats, setup timer */
 	emp->saved_activity = emp->activity = 0;
-	setup_timer(&emp->timer, ahci_sw_activity_blink, (unsigned long)link);
+	emp->link = link;
+	timer_setup(&emp->timer, ahci_sw_activity_blink, 0);
 
 	/* check our blink policy and set flag for link if it's enabled */
 	if (emp->blink_policy)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
