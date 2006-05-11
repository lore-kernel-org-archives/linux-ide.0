From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/12] libata-ncq: pass ata_scsi_translate() return value to SCSI midlayer
Date: Thu, 11 May 2006 23:44:42 +0900
Message-ID: <11473586822135-git-send-email-htejun@gmail.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:63075 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751802AbWEKOos (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 10:44:48 -0400
Received: by nz-out-0102.google.com with SMTP id 13so216446nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 07:44:48 -0700 (PDT)
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_scsi_translate() will need to return SCSI_ML_QUEUE_DEVICE_BUSY to
achieve exlusion between NCQ and non-NCQ commands or among non-NCQ
commands.  Pass its return value upward to SCSI midlayer.

---

 drivers/scsi/libata-scsi.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

31df0610cf8d4ea725d9b3be8676a49248d6b1c9
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index e61cc35..96517ca 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1248,11 +1248,14 @@ static void ata_scsi_qc_complete(struct 
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY if the command
+ *	needs to be deferred.
  */
-
-static void ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
-			       void (*done)(struct scsi_cmnd *),
-			       ata_xlat_func_t xlat_func)
+static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *),
+			      ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
 	u8 *scsicmd = cmd->cmnd;
@@ -1290,13 +1293,13 @@ static void ata_scsi_translate(struct at
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
@@ -1304,7 +1307,7 @@ err_mem:
 	cmd->result = (DID_ERROR << 16);
 	done(cmd);
 	DPRINTK("EXIT - internal\n");
-	return;
+	return 0;
 }
 
 /**
@@ -2456,20 +2459,24 @@ static inline void ata_scsi_dump_cdb(str
 #endif
 }
 
-static inline void __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
-				       void (*done)(struct scsi_cmnd *),
-				       struct ata_device *dev)
+static inline int __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
+				      void (*done)(struct scsi_cmnd *),
+				      struct ata_device *dev)
 {
+	int rc = 0;
+
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
 							      cmd->cmnd[0]);
 
 		if (xlat_func)
-			ata_scsi_translate(dev, cmd, done, xlat_func);
+			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
 		else
 			ata_scsi_simulate(dev, cmd, done);
 	} else
-		ata_scsi_translate(dev, cmd, done, atapi_xlat);
+		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+
+	return rc;
 }
 
 /**
@@ -2488,15 +2495,16 @@ static inline void __ata_scsi_queuecmd(s
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
 
 	ap = ata_shost_to_port(shost);
 
@@ -2507,7 +2515,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
-		__ata_scsi_queuecmd(cmd, done, dev);
+		rc = __ata_scsi_queuecmd(cmd, done, dev);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
@@ -2515,7 +2523,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	spin_unlock(&ap->host_set->lock);
 	spin_lock(shost->host_lock);
-	return 0;
+	return rc;
 }
 
 /**
-- 
1.2.4


