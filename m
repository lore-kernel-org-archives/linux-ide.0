From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix incorrect link online check during
 probe
Date: Tue, 06 Oct 2009 17:08:40 +0900
Message-ID: <4ACAFB08.8020501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58371 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbZJFIJi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 04:09:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, stable@kernel.org, Tim Blechmann <tim@klingt.org>

While trying to work around spurious detection retries for
non-existent devices on slave links, commit
816ab89782ac139a8b65147cca990822bb7e8675 incorrectly added link
offline check logic before ata_eh_thaw() was called.  This means that
if an occupied link goes down briefly at the time that offline check
was performed, device class will be cleared to ATA_DEV_NONE and libata
wouldn't retry thus failing detection of the device.

The offline check should be done after the port is thawed together
with online check so that such link glitches can be detected by the
interrupt handler and handled properly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Tim Blechmann <tim@klingt.org>
Cc: stable@kernel.org
--
 drivers/ata/libata-eh.c |   50 ++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a04488f..0a97822 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2667,14 +2667,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		dev->pio_mode = XFER_PIO_0;
 		dev->flags &= ~ATA_DFLAG_SLEEPING;
 
-		if (!ata_phys_link_offline(ata_dev_phys_link(dev))) {
-			/* apply class override */
-			if (lflags & ATA_LFLAG_ASSUME_ATA)
-				classes[dev->devno] = ATA_DEV_ATA;
-			else if (lflags & ATA_LFLAG_ASSUME_SEMB)
-				classes[dev->devno] = ATA_DEV_SEMB_UNSUP;
-		} else
-			classes[dev->devno] = ATA_DEV_NONE;
+		if (ata_phys_link_offline(ata_dev_phys_link(dev)))
+			continue;
+
+		/* apply class override */
+		if (lflags & ATA_LFLAG_ASSUME_ATA)
+			classes[dev->devno] = ATA_DEV_ATA;
+		else if (lflags & ATA_LFLAG_ASSUME_SEMB)
+			classes[dev->devno] = ATA_DEV_SEMB_UNSUP;
 	}
 
 	/* record current link speed */
@@ -2713,34 +2713,48 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
-	/* Make sure onlineness and classification result correspond.
+	/*
+	 * Make sure onlineness and classification result correspond.
 	 * Hotplug could have happened during reset and some
 	 * controllers fail to wait while a drive is spinning up after
 	 * being hotplugged causing misdetection.  By cross checking
-	 * link onlineness and classification result, those conditions
-	 * can be reliably detected and retried.
+	 * link on/offlineness and classification result, those
+	 * conditions can be reliably detected and retried.
 	 */
 	nr_unknown = 0;
 	ata_for_each_dev(dev, link, ALL) {
-		/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
-		if (classes[dev->devno] == ATA_DEV_UNKNOWN) {
-			classes[dev->devno] = ATA_DEV_NONE;
-			if (ata_phys_link_online(ata_dev_phys_link(dev)))
+		if (ata_phys_link_online(ata_dev_phys_link(dev))) {
+			if (classes[dev->devno] == ATA_DEV_UNKNOWN) {
+				ata_dev_printk(dev, KERN_DEBUG, "link online "
+					       "but device misclassifed\n");
+				classes[dev->devno] = ATA_DEV_NONE;
 				nr_unknown++;
+			}
+		} else if (ata_phys_link_offline(ata_dev_phys_link(dev))) {
+			if (ata_class_enabled(classes[dev->devno]))
+				ata_dev_printk(dev, KERN_DEBUG, "link offline, "
+					       "clearing class %d to NONE\n",
+					       classes[dev->devno]);
+			classes[dev->devno] = ATA_DEV_NONE;
+		} else if (classes[dev->devno] == ATA_DEV_UNKNOWN) {
+			ata_dev_printk(dev, KERN_DEBUG, "link status unknown, "
+				       "clearing UNKNOWN to NONE\n");
+			classes[dev->devno] = ATA_DEV_NONE;
 		}
 	}
 
 	if (classify && nr_unknown) {
 		if (try < max_tries) {
 			ata_link_printk(link, KERN_WARNING, "link online but "
-				       "device misclassified, retrying\n");
+					"%d devices misclassified, retrying\n",
+					nr_unknown);
 			failed_link = link;
 			rc = -EAGAIN;
 			goto fail;
 		}
 		ata_link_printk(link, KERN_WARNING,
-			       "link online but device misclassified, "
-			       "device detection might fail\n");
+				"link online but %d devices misclassified, "
+				"device detection might fail\n", nr_unknown);
 	}
 
 	/* reset successful, schedule revalidation */
