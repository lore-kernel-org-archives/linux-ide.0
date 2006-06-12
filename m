From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix oops caused rescanning NULL sdev
Date: Mon, 12 Jun 2006 22:51:14 +0900
Message-ID: <20060612135114.GC5751@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:9912 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751982AbWFLNvY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 09:51:24 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1635196nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 06:51:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "Zhao, Forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Depending on timing, ata_scsi_dev_rescan() might encounter a device
which is enabled but not yet attached to sdev.  On such cases, the
original code caused oops.  This patch makes ata_scsi_dev_rescan()
rescan only device which are attached to sdevs.

While at it, properly indent leading comment and add description about
how it's synchronized with sdev attach/detach.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 45a49be..32c1df6 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -3005,14 +3005,16 @@ static int ata_scsi_user_scan(struct Scs
 }
 
 /**
- *      ata_scsi_dev_rescan - initiate scsi_rescan_device()
- *      @data: Pointer to ATA port to perform scsi_rescan_device()
+ *	ata_scsi_dev_rescan - initiate scsi_rescan_device()
+ *	@data: Pointer to ATA port to perform scsi_rescan_device()
  *
- *      After ATA pass thru (SAT) commands are executed successfully,
- *      libata need to propagate the changes to SCSI layer.
+ *	After ATA pass thru (SAT) commands are executed successfully,
+ *	libata need to propagate the changes to SCSI layer.  This
+ *	function must be executed from ata_aux_wq such that sdev
+ *	attach/detach don't race with rescan.
  *
- *      LOCKING:
- *      Kernel thread context (may sleep).
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
  */
 void ata_scsi_dev_rescan(void *data)
 {
@@ -3023,8 +3025,7 @@ void ata_scsi_dev_rescan(void *data)
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
-		if (ata_dev_enabled(dev))
+		if (ata_dev_enabled(dev) && dev->sdev)
 			scsi_rescan_device(&(dev->sdev->sdev_gendev));
 	}
 }
-
