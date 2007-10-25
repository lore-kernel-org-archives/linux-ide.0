From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: backport ATA_FLAG_NO_SRST and
	ATA_FLAG_ASSUME_ATA
Date: Thu, 25 Oct 2007 15:51:57 +0900
Message-ID: <20071025065157.GH11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:48514 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbXJYGwL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 02:52:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so519810wah
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 23:52:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stable@kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Backport ATA_FLAG_NO_SRST and ATA_FLAG_ASSUME_ATA.  These are
originally link flags (ATA_LFLAG_*) but link abstraction doesn't exist
on 2.6.23, so make it port flags.

This is for the following workaround for ASUS P5W DH Deluxe.

These new flags don't introduce any behavior change unless set and
nobody sets them yet.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This and the next patch are a bit large for -stable but they don't
change anything for machines other than P5W DH and P5W DH users have
been suffering long enough, so I think it'll be nice to include these
patches in the next -stable release.  However, feel free to NACK if
you can see some danger in these patches.

Jeff, what do you think?

 drivers/ata/libata-eh.c |   32 ++++++++++++++++++++++++--------
 include/linux/libata.h  |    2 ++
 2 files changed, 26 insertions(+), 8 deletions(-)

Index: tree0/drivers/ata/libata-eh.c
===================================================================
--- tree0.orig/drivers/ata/libata-eh.c
+++ tree0/drivers/ata/libata-eh.c
@@ -1759,9 +1759,11 @@ static int ata_do_reset(struct ata_port 
 	return 0;
 }
 
-static int ata_eh_followup_srst_needed(int rc, int classify,
-				       const unsigned int *classes)
+static int ata_eh_followup_srst_needed(struct ata_port *ap, int rc,
+				int classify, const unsigned int *classes)
 {
+	if (ap->flags & ATA_FLAG_NO_SRST)
+		return 0;
 	if (rc == -EAGAIN)
 		return 1;
 	if (rc != 0)
@@ -1792,7 +1794,8 @@ static int ata_eh_reset(struct ata_port 
 	 */
 	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
-	if (softreset && (!hardreset || (!sata_set_spd_needed(ap) &&
+	if (softreset && (!hardreset || (!(ap->flags & ATA_FLAG_NO_SRST) &&
+					 !sata_set_spd_needed(ap) &&
 					 !(action & ATA_EH_HARDRESET))))
 		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
@@ -1855,7 +1858,7 @@ static int ata_eh_reset(struct ata_port 
 	rc = ata_do_reset(ap, reset, classes, deadline);
 
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(ap, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		reset = softreset;
 
@@ -1870,8 +1873,8 @@ static int ata_eh_reset(struct ata_port 
 		ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
 		rc = ata_do_reset(ap, reset, classes, deadline);
 
-		if (rc == 0 && classify &&
-		    classes[0] == ATA_DEV_UNKNOWN) {
+		if (rc == 0 && classify && classes[0] == ATA_DEV_UNKNOWN &&
+		    !(ap->flags & ATA_FLAG_ASSUME_ATA)) {
 			ata_port_printk(ap, KERN_ERR,
 					"classification failed\n");
 			rc = -EINVAL;
@@ -1879,6 +1882,10 @@ static int ata_eh_reset(struct ata_port 
 		}
 	}
 
+	/* if we skipped follow-up srst, clear rc */
+	if (rc == -EAGAIN)
+		rc = 0;
+
 	if (rc && try < ARRAY_SIZE(ata_eh_reset_timeouts)) {
 		unsigned long now = jiffies;
 
@@ -1906,8 +1913,17 @@ static int ata_eh_reset(struct ata_port 
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Record the mode.
 		 */
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ap->device[i].pio_mode = XFER_PIO_0;
+		for (i = 0; i < ata_port_max_devices(ap); i++) {
+			struct ata_device *dev = &ap->device[i];
+
+			dev->pio_mode = XFER_PIO_0;
+
+			if (ata_port_offline(ap))
+				continue;
+
+			if (ap->flags & ATA_FLAG_ASSUME_ATA)
+				classes[dev->devno] = ATA_DEV_ATA;
+		}
 
 		/* record current link speed */
 		if (sata_scr_read(ap, SCR_STATUS, &sstatus) == 0)
Index: tree0/include/linux/libata.h
===================================================================
--- tree0.orig/include/linux/libata.h
+++ tree0/include/linux/libata.h
@@ -177,6 +177,8 @@ enum {
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
+	ATA_FLAG_NO_SRST	= (1 << 18),
+	ATA_FLAG_ASSUME_ATA	= (1 << 19),
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
