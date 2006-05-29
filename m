From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 14:35:15 +0800
Message-ID: <1148884515.3466.12.camel@forrest26.sh.intel.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>
	 <44779A05.4010209@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41865 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751244AbWE2Gqv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:46:51 -0400
In-Reply-To: <44779A05.4010209@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: htejun@gmail.com, liml@rtr.ca, linux-ide@vger.kernel.org

On Fri, 2006-05-26 at 20:15 -0400, Jeff Garzik wrote:
> I agree with the concept, and agree that the SCSI layer must be notified 
> when the ATA write cache type changes.  However, I NAK the patch for the 
> following reasons:
> 
> 1) Tejun's revalidate should trigger scsi_rescan_device(), as your patch 
> indicates.  But that's pretty much all that needs to be done.
> 
> 2) Thus, a new bit (ATA_FLAG_SCSI_RESCAN) and a new workqueue are 
> unnecessary.

Doing scsi_rescan_device() in SCSI EH thread caused my machine with 1
logical CPU to hang(it stopped responding, user can't login locally or
remotely, and it can only respond to "ping".)
So I think scsi_rescan_device() is prohibited from being invoked in SCSI
EH thread. This is the reason why I introduced another work_queue to do
scsi_rescan_device().

The following patch is again current #upstream and can reproduce the
problem.

After the kernel with this patch boots up, "hdparm -W 0 /dev/sd*" can
trigger the system to hang.

Thanks,
Forrest

diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 71b45ad..d833b36 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1356,6 +1356,8 @@ static int ata_eh_revalidate(struct ata_
 			if (rc)
 				break;
 
+			scsi_rescan_device(&(dev->sdev->sdev_gendev));
+
 			ehc->i.action &= ~ATA_EH_REVALIDATE;
 		}
 	}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 9e5cb9f..0838e9b 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1269,6 +1269,19 @@ static void ata_scsi_qc_complete(struct 
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
 
+	/* We snoop the SET_FEATURES - Write Cache ON/OFF command, and
+	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
+	 * cache
+	 */
+	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
+	    (!(cdb[2] & 0x20)) && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
+	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
+	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
+		qc->ap->eh_info.action = ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(qc->ap);
+	}
+
+
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
 	 * generate because the user forced us to, a check condition
@@ -2744,9 +2757,17 @@ void ata_scsi_scan_host(struct ata_port 
 		return;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct scsi_device *sdev;
 		dev = &ap->device[i];
 
-		if (ata_dev_enabled(dev))
-			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
+		if (!ata_dev_enabled(dev) || dev->sdev)
+			continue;
+		sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
+		if(!IS_ERR(sdev)){
+			dev->sdev = sdev;
+			scsi_device_put(sdev);
+		}
 	}
 }
+
+
diff --git a/include/linux/ata.h b/include/linux/ata.h
index c494e1c..3671af8 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -181,6 +181,9 @@ enum {
 	XFER_PIO_0		= 0x08,
 	XFER_PIO_SLOW		= 0x00,
 
+	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
+	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b0ee1c1..79ea9a5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -402,6 +402,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
+	struct scsi_device	*sdev;
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
