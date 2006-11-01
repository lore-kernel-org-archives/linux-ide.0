From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3 #upstream] libata: implement ATA_EHI_SETMODE and ATA_EHI_POST_SETMODE
Date: Wed, 1 Nov 2006 18:39:27 +0900
Message-ID: <20061101093927.GT13677@htj.dyndns.org>
References: <20061101093852.GS13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:36307 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946736AbWKAJjf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 04:39:35 -0500
Received: by ug-out-1314.google.com with SMTP id b39so2238026ugd
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 01:39:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061101093852.GS13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

libata EH used to perform ata_set_mode() iff the EH session performed
reset as indicated by ATA_EHI_DID_RESET.  This is incorrect because
->dev_config() called by revalidation is allowed to modify transfer
mode which ata_set_mode() should take care of.  This patch implements
the following two flags.

* ATA_EHI_SETMODE: set during EH to schedule ata_set_mode().  Both new
  device attachment and revalidation set this flag.

* ATA_EHI_POST_SETMODE: set while the device is revalidated after
  ata_set_mode().  Post-setmode revalidation is different from initial
  configuaration and EH revalidation in that ->dev_config() is not
  allowed tune transfer mode.  LLD can use this flag to determine
  whether it's allowed to tune transfer mode.  Note that POST_SETMODE
  ->dev_config() is guaranteed to be preceded by non-POST_SETMODE
  ->dev_config().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +++
 drivers/ata/libata-eh.c   |   13 +++++++++++--
 include/linux/libata.h    |    2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -2158,6 +2158,7 @@ int ata_down_xfermask_limit(struct ata_d
 
 static int ata_dev_set_mode(struct ata_device *dev)
 {
+	struct ata_eh_context *ehc = &dev->ap->eh_context;
 	unsigned int err_mask;
 	int rc;
 
@@ -2172,7 +2173,9 @@ static int ata_dev_set_mode(struct ata_d
 		return -EIO;
 	}
 
+	ehc->i.flags |= ATA_EHI_POST_SETMODE;
 	rc = ata_dev_revalidate(dev, 0);
+	ehc->i.flags &= ~ATA_EHI_POST_SETMODE;
 	if (rc)
 		return rc;
 
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1653,6 +1653,11 @@ static int ata_eh_revalidate_and_attach(
 
 			ata_eh_done(ap, dev, ATA_EH_REVALIDATE);
 
+			/* Configuration may have changed, reconfigure
+			 * transfer mode.
+			 */
+			ehc->i.flags |= ATA_EHI_SETMODE;
+
 			/* schedule the scsi_rescan_device() here */
 			queue_work(ata_aux_wq, &(ap->scsi_rescan_task));
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
@@ -1675,6 +1680,9 @@ static int ata_eh_revalidate_and_attach(
 			spin_lock_irqsave(ap->lock, flags);
 			ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
 			spin_unlock_irqrestore(ap->lock, flags);
+
+			/* new device discovered, configure transfer mode */
+			ehc->i.flags |= ATA_EHI_SETMODE;
 		}
 	}
 
@@ -1990,13 +1998,14 @@ static int ata_eh_recover(struct ata_por
 	if (rc)
 		goto dev_fail;
 
-	/* configure transfer mode if the port has been reset */
-	if (ehc->i.flags & ATA_EHI_DID_RESET) {
+	/* configure transfer mode if necessary */
+	if (ehc->i.flags & ATA_EHI_SETMODE) {
 		rc = ata_set_mode(ap, &dev);
 		if (rc) {
 			down_xfermask = 1;
 			goto dev_fail;
 		}
+		ehc->i.flags &= ~ATA_EHI_SETMODE;
 	}
 
 	/* suspend devices */
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -284,6 +284,8 @@ enum {
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 	ATA_EHI_PRINTINFO	= (1 << 17), /* print configuration info */
+	ATA_EHI_SETMODE		= (1 << 18), /* configure transfer mode */
+	ATA_EHI_POST_SETMODE	= (1 << 19), /* revaildating after setmode */
 
 	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
 
