From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata: pass ata_scsi_translate() return value to SCSI midlayer
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <11440531592356-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:36988 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751627AbWDCIct (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:49 -0400
Received: by xproxy.gmail.com with SMTP id t10so764240wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:48 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_scsi_translate() will need to return SCSI_ML_QUEUE_DEVICE_BUSY to
achieve exlusion between NCQ and non-NCQ commands or among non-NCQ
commands.  Pass its return value upward to SCSI midlayer.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

a2a749416f31f6cc1b790f6170a47b79bcbd1d91
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index bfb9a5b..a1a4307 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1251,9 +1251,12 @@ static void ata_scsi_qc_complete(struct 
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY if the command
+ *	needs to be deferred.
  */
-
-static void ata_scsi_translate(struct ata_port *ap, struct ata_device *dev,
+static int ata_scsi_translate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *),
 			      ata_xlat_func_t xlat_func)
@@ -1294,13 +1297,13 @@ static void ata_scsi_translate(struct at
 	ata_qc_issue(qc);
 
 	VPRINTK("EXIT\n");
-	return;
+	return 0;
 
 early_finish:
         ata_qc_free(qc);
 	done(cmd);
 	DPRINTK("EXIT - early finish (good or error)\n");
-	return;
+	return 0;
 
 err_did:
 	ata_qc_free(qc);
@@ -1308,7 +1311,7 @@ err_mem:
 	cmd->result = (DID_ERROR << 16);
 	done(cmd);
 	DPRINTK("EXIT - internal\n");
-	return;
+	return 0;
 }
 
 /**
@@ -2461,19 +2464,23 @@ static inline void ata_scsi_dump_cdb(str
 #endif
 }
 
-static inline void __ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
-				       struct ata_port *ap, struct ata_device *dev)
+static inline int __ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
+				      struct ata_port *ap, struct ata_device *dev)
 {
+	int rc = 0;
+
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
 							      cmd->cmnd[0]);
 
 		if (xlat_func)
-			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
+			rc = ata_scsi_translate(ap, dev, cmd, done, xlat_func);
 		else
 			ata_scsi_simulate(ap, dev, cmd, done);
 	} else
-		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+		rc = ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+
+	return rc;
 }
 
 /**
@@ -2492,15 +2499,16 @@ static inline void __ata_scsi_queuecmd(s
  *	Releases scsi-layer-held lock, and obtains host_set lock.
  *
  *	RETURNS:
- *	Zero.
+ *	Return value from __ata_scsi_queuecmd() if @cmd can be queued,
+ *	0 otherwise.
  */
-
 int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
 {
 	struct ata_port *ap;
 	struct ata_device *dev;
 	struct scsi_device *scsidev = cmd->device;
 	struct Scsi_Host *shost = scsidev->host;
+	int rc = 0;
 
 	ap = (struct ata_port *) &shost->hostdata[0];
 
@@ -2511,7 +2519,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
-		__ata_scsi_queuecmd(cmd, done, ap, dev);
+		rc = __ata_scsi_queuecmd(cmd, done, ap, dev);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
@@ -2519,7 +2527,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	spin_unlock(&ap->host_set->lock);
 	spin_lock(shost->host_lock);
-	return 0;
+	return rc;
 }
 
 /**
-- 
1.2.4


