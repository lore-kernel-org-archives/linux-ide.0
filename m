From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command(v5)
Date: Mon, 12 Jun 2006 12:01:34 +0800
Message-ID: <1150084894.5721.32.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:547 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750848AbWFLENn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 00:13:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

This patch makes libata "Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE
command" and clean the things up(e.g. revalidate and rescan).

Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>


---
It's against #upstream

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |    3 +++
 drivers/scsi/libata-scsi.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    1 +
 include/linux/ata.h        |    3 +++
 5 files changed, 44 insertions(+), 0 deletions(-)

f36bb7625e283ba15b02af220bae0682f33d883f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 40d1612..aaed5e5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5185,6 +5185,7 @@ static void ata_host_init(struct ata_por
 
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_WORK(&ap->hotplug_task, ata_scsi_hotplug, ap);
+	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 6285257..f82799e 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1554,6 +1554,9 @@ static int ata_eh_revalidate_and_attach(
 			if (rc)
 				break;
 
+			/* schedule the scsi_rescan_device() here */
+			queue_work(ata_aux_wq, &(ap->scsi_rescan_task));
+
 			ehc->i.action &= ~ATA_EH_REVALIDATE;
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
 			   ehc->tries[dev->devno] &&
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 5f90d8e..45a49be 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1306,6 +1306,17 @@ static void ata_scsi_qc_complete(struct 
 	u8 *cdb = cmd->cmnd;
  	int need_sense = (qc->err_mask != 0);
 
+	/* We snoop the SET_FEATURES - Write Cache ON/OFF command, and
+	 * schedule EH_REVALIDATE operation to update the IDENTIFY DEVICE
+	 * cache
+	 */
+	if (!need_sense && (qc->tf.command == ATA_CMD_SET_FEATURES) &&
+	    ((qc->tf.feature == SETFEATURES_WC_ON) ||
+	     (qc->tf.feature == SETFEATURES_WC_OFF))) {
+		qc->ap->eh_info.action |= ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(qc->ap);
+	}
+
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
 	 * generate because the user forced us to, a check condition
@@ -2992,3 +3003,28 @@ static int ata_scsi_user_scan(struct Scs
 
 	return rc;
 }
+
+/**
+ *      ata_scsi_dev_rescan - initiate scsi_rescan_device()
+ *      @data: Pointer to ATA port to perform scsi_rescan_device()
+ *
+ *      After ATA pass thru (SAT) commands are executed successfully,
+ *      libata need to propagate the changes to SCSI layer.
+ *
+ *      LOCKING:
+ *      Kernel thread context (may sleep).
+ */
+void ata_scsi_dev_rescan(void *data)
+{
+	struct ata_port *ap = data;
+	struct ata_device *dev;
+	unsigned int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (ata_dev_enabled(dev))
+			scsi_rescan_device(&(dev->sdev->sdev_gendev));
+	}
+}
+
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 1dd496f..bdd4888 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -104,6 +104,7 @@ extern void ata_scsi_rbuf_fill(struct at
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
+extern void ata_scsi_dev_rescan(void *data);
 
 /* libata-eh.c */
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
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
-- 
1.2.6
