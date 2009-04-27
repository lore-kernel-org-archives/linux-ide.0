From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] ahci: misc cleanups for EM stuff
Date: Tue, 28 Apr 2009 08:42:52 +0900
Message-ID: <49F642FC.1090602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37917 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378AbZD0XnE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Apr 2009 19:43:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, David Milburn <dmilburn@redhat.com>

Make the following EM related cleanups.

* Use msleep(1) instead of udelay(100) and reduce retry count to 5.
* s/MAX_SLOTS/EM_MAX_SLOTS/
* s/MAX_RETRY/EM_MAX_RETRY/

[ Impact: cleanup, use of longer and fewer msleep() instead of udelay() ]

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3489085..65677b0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -77,8 +77,8 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 			      size_t size);
 static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 					ssize_t size);
-#define MAX_SLOTS 8
-#define MAX_RETRY 15
+#define EM_MAX_SLOTS 8
+#define EM_MAX_RETRY 5
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -281,8 +281,8 @@ struct ahci_port_priv {
 	unsigned int		ncq_saw_dmas:1;
 	unsigned int		ncq_saw_sdb:1;
 	u32 			intr_mask;	/* interrupts to enable */
-	struct ahci_em_priv	em_priv[MAX_SLOTS];/* enclosure management info
-					 	 * per PM slot */
+	/* enclosure management info per PM slot */
+	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
 };
 
 static int ahci_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
@@ -1139,12 +1139,12 @@ static void ahci_start_port(struct ata_port *ap)
 			emp = &pp->em_priv[link->pmp];
 
 			/* EM Transmit bit maybe busy during init */
-			for (i = 0; i < MAX_RETRY; i++) {
+			for (i = 0; i < EM_MAX_RETRY; i++) {
 				rc = ahci_transmit_led_message(ap,
 							       emp->led_state,
 							       4);
 				if (rc == -EBUSY)
-					udelay(100);
+					msleep(1);
 				else
 					break;
 			}
@@ -1338,7 +1338,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 
 	/* get the slot number from the message */
 	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
-	if (pmp < MAX_SLOTS)
+	if (pmp < EM_MAX_SLOTS)
 		emp = &pp->em_priv[pmp];
 	else
 		return -EINVAL;
@@ -1406,7 +1406,7 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 
 	/* get the slot number from the message */
 	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
-	if (pmp < MAX_SLOTS)
+	if (pmp < EM_MAX_SLOTS)
 		emp = &pp->em_priv[pmp];
 	else
 		return -EINVAL;
