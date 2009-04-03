From: David Milburn <dmilburn@redhat.com>
Subject: [PATCH v2] libata: ahci enclosure management bios workaround
Date: Fri, 3 Apr 2009 15:36:41 -0500
Message-ID: <20090403203641.GA16179@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:54169 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368AbZDCUis (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Apr 2009 16:38:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, kristen.c.accardi@intel.com

During driver initialization ahci_start_port may not be able
to turn LEDs off because the hardware may still be transmitting
a message. And since the BIOS may not be setting the LEDs to
off the drive LEDs may end up in a fault state. This has
been seen on ICH9r and ICH10r when configured in AHCI mode
instead of RAID mode, this patch doesn't key off a specific
set of device IDs but will give the EM transmit bit a chance
to clear if busy.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/ata/ahci.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 788bba2..6ca4bc0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -78,6 +78,7 @@ static ssize_t ahci_led_store(struct ata_port *ap, const char *buf,
 static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 					ssize_t size);
 #define MAX_SLOTS 8
+#define MAX_RETRY 15
 
 enum {
 	AHCI_PCI_BAR		= 5,
@@ -1115,6 +1116,8 @@ static void ahci_start_port(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ata_link *link;
 	struct ahci_em_priv *emp;
+	ssize_t rc;
+	int i;
 
 	/* enable FIS reception */
 	ahci_start_fis_rx(ap);
@@ -1126,7 +1129,17 @@ static void ahci_start_port(struct ata_port *ap)
 	if (ap->flags & ATA_FLAG_EM) {
 		ata_for_each_link(link, ap, EDGE) {
 			emp = &pp->em_priv[link->pmp];
-			ahci_transmit_led_message(ap, emp->led_state, 4);
+
+			/* EM Transmit bit maybe busy during init */
+			for (i = 0; i < MAX_RETRY; i++) {
+				rc = ahci_transmit_led_message(ap,
+							       emp->led_state,
+							       4);
+				if (rc == -EBUSY)
+					udelay(100);
+				else
+					break;
+			}
 		}
 	}
 
@@ -1331,7 +1344,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 	em_ctl = readl(mmio + HOST_EM_CTL);
 	if (em_ctl & EM_CTL_TM) {
 		spin_unlock_irqrestore(ap->lock, flags);
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	/*

