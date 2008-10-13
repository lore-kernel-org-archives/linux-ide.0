From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH] libata: ahci enclosure management bit mask
Date: Mon, 13 Oct 2008 14:38:36 -0500
Message-ID: <20081013193836.GA1729@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579AbYJMTqZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 15:46:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

Enclosure management bit mask definitions.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2e1a7cb..21472f4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -49,6 +49,17 @@
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"3.0"
 
+/* Enclosure Management Control */
+#define EM_CTRL_MSG_TYPE              0x000f0000
+
+/* Enclosure Management LED Message Type */
+#define EM_MSG_LED_HBA_PORT           0x0000000f
+#define EM_MSG_LED_PMP_SLOT           0x0000ff00
+#define EM_MSG_LED_VALUE              0xffff0000
+#define EM_MSG_LED_VALUE_ACTIVITY     0x00070000
+#define EM_MSG_LED_VALUE_OFF          0xfff80000
+#define EM_MSG_LED_VALUE_ON           0x00010000
+
 static int ahci_skip_host_reset;
 module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
 MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
@@ -1220,7 +1231,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 	unsigned long led_message = emp->led_state;
 	u32 activity_led_state;
 
-	led_message &= 0xffff0000;
+	led_message &= EM_MSG_LED_VALUE;
 	led_message |= ap->port_no | (link->pmp << 8);
 
 	/* check to see if we've had activity.  If so,
@@ -1230,7 +1241,7 @@ static void ahci_sw_activity_blink(unsigned long arg)
 	if (emp->saved_activity != emp->activity) {
 		emp->saved_activity = emp->activity;
 		/* get the current LED state */
-		activity_led_state = led_message & 0x00010000;
+		activity_led_state = led_message & EM_MSG_LED_VALUE_ON;
 
 		if (activity_led_state)
 			activity_led_state = 0;
@@ -1238,14 +1249,14 @@ static void ahci_sw_activity_blink(unsigned long arg)
 			activity_led_state = 1;
 
 		/* clear old state */
-		led_message &= 0xfff8ffff;
+		led_message &= ~EM_MSG_LED_VALUE_ACTIVITY;
 
 		/* toggle state */
 		led_message |= (activity_led_state << 16);
 		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(100));
 	} else {
 		/* switch to idle */
-		led_message &= 0xfff8ffff;
+		led_message &= ~EM_MSG_LED_VALUE_ACTIVITY;
 		if (emp->blink_policy == BLINK_OFF)
 			led_message |= (1 << 16);
 	}
@@ -1293,7 +1304,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 	struct ahci_em_priv *emp;
 
 	/* get the slot number from the message */
-	pmp = (state & 0x0000ff00) >> 8;
+	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
 	if (pmp < MAX_SLOTS)
 		emp = &pp->em_priv[pmp];
 	else
@@ -1318,7 +1329,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 	message[0] |= (4 << 8);
 
 	/* ignore 0:4 of byte zero, fill in port info yourself */
-	message[1] = ((state & 0xfffffff0) | ap->port_no);
+	message[1] = ((state & ~EM_MSG_LED_HBA_PORT) | ap->port_no);
 
 	/* write message to EM_LOC */
 	writel(message[0], mmio + hpriv->em_loc);
@@ -1361,7 +1372,7 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 	state = simple_strtoul(buf, NULL, 0);
 
 	/* get the slot number from the message */
-	pmp = (state & 0x0000ff00) >> 8;
+	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
 	if (pmp < MAX_SLOTS)
 		emp = &pp->em_priv[pmp];
 	else
@@ -1372,7 +1383,7 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 	 * activity led through em_message
 	 */
 	if (emp->blink_policy)
-		state &= 0xfff8ffff;
+		state &= ~EM_MSG_LED_VALUE_ACTIVITY;
 
 	return ahci_transmit_led_message(ap, state, size);
 }
@@ -1391,16 +1402,16 @@ static ssize_t ahci_activity_store(struct ata_device *dev, enum sw_activity val)
 		link->flags &= ~(ATA_LFLAG_SW_ACTIVITY);
 
 		/* set the LED to OFF */
-		port_led_state &= 0xfff80000;
+		port_led_state &= EM_MSG_LED_VALUE_OFF;
 		port_led_state |= (ap->port_no | (link->pmp << 8));
 		ahci_transmit_led_message(ap, port_led_state, 4);
 	} else {
 		link->flags |= ATA_LFLAG_SW_ACTIVITY;
 		if (val == BLINK_OFF) {
 			/* set LED to ON for idle */
-			port_led_state &= 0xfff80000;
+			port_led_state &= EM_MSG_LED_VALUE_OFF;
 			port_led_state |= (ap->port_no | (link->pmp << 8));
-			port_led_state |= 0x00010000; /* check this */
+			port_led_state |= EM_MSG_LED_VALUE_ON; /* check this */
 			ahci_transmit_led_message(ap, port_led_state, 4);
 		}
 	}
@@ -2611,7 +2622,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		u32 em_loc = readl(mmio + HOST_EM_LOC);
 		u32 em_ctl = readl(mmio + HOST_EM_CTL);
 
-		messages = (em_ctl & 0x000f0000) >> 16;
+		messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
 
 		/* we only support LED message type right now */
 		if ((messages & 0x01) && (ahci_em_messages == 1)) {
