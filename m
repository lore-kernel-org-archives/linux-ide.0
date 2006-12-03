From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: always use polling IDENTIFY
Date: Sun, 3 Dec 2006 19:30:32 +0900
Message-ID: <20061203103032.GE11250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:47938 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758642AbWLCKar (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 05:30:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4060952nfa
        for <linux-ide@vger.kernel.org>; Sun, 03 Dec 2006 02:30:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

libata switched to IRQ-driven IDENTIFY when IRQ-driven PIO was
introduced.  This has caused a lot of problems including device
misdetection and phantom device.

ATA_FLAG_DETECT_POLLING was added recently to selectively use polling
IDENTIFY on problemetic drivers but many controllers and devices are
affected by this problem and trying to adding ATA_FLAG_DETECT_POLLING
for each such case is diffcult and not very rewarding.

This patch makes libata always use polling IDENTIFY.  This is
consistent with libata's original behavior and drivers/ide's behavior.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 788a269..a2d84f7 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -105,9 +105,8 @@ enum {
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
-	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_DETECT_POLLING,
-	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_DETECT_POLLING,
+	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
+	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3fd7c79..cc0bb59 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1314,16 +1314,12 @@ int ata_dev_read_id(struct ata_device *d
 	}
 
 	tf.protocol = ATA_PROT_PIO;
-
-	/* presence detection using polling IDENTIFY? */
-	if (flags & ATA_READID_DETECT)
-		tf.flags |= ATA_TFLAG_POLLING;
+	tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
 	if (err_mask) {
-		if ((flags & ATA_READID_DETECT) &&
-		    (err_mask & AC_ERR_NODEV_HINT)) {
+		if (err_mask & AC_ERR_NODEV_HINT) {
 			DPRINTK("ata%u.%d: NODEV after polling detection\n",
 				ap->id, dev->devno);
 			return -ENOENT;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5aa7f09..d84bb65 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1690,9 +1690,6 @@ static int ata_eh_revalidate_and_attach(
 			   ata_class_enabled(ehc->classes[dev->devno])) {
 			dev->class = ehc->classes[dev->devno];
 
-			if (ap->flags & ATA_FLAG_DETECT_POLLING)
-				readid_flags |= ATA_READID_DETECT;
-
 			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
 					     dev->id);
 			if (rc == 0) {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2d532da..a367317 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -42,8 +42,6 @@ struct ata_scsi_args {
 enum {
 	/* flags for ata_dev_read_id() */
 	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
-	ATA_READID_DETECT	= (1 << 1), /* perform presence detection
-					     * using polling IDENTIFY */
 };
 
 extern struct workqueue_struct *ata_aux_wq;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9080789..26abd6a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -176,8 +176,6 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_DETECT_POLLING	= (1 << 14), /* detect device presence by
-					      * polling IDENTIFY */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
