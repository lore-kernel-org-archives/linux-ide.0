From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/15] libata-ncq: pass ata_scsi_translate() return value to SCSI midlayer
Date: Tue, 11 Apr 2006 22:53:36 +0900
Message-ID: <11447636161898-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:43136 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750982AbWDKNxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:41 -0400
Received: by pproxy.gmail.com with SMTP id i49so1388582pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:40 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_scsi_translate() will need to return SCSI_ML_QUEUE_DEVICE_BUSY to
achieve exlusion between NCQ and non-NCQ commands or among non-NCQ
commands.  Pass its return value upward to SCSI midlayer.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

3fd6c2e278004c2fddf09099560b9630a352fba4
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 1c1b510..c978a5d 100644
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
@@ -2459,19 +2462,23 @@ static inline void ata_scsi_dump_cdb(str
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
@@ -2490,15 +2497,16 @@ static inline void __ata_scsi_queuecmd(s
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
 
@@ -2509,7 +2517,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	dev = ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
-		__ata_scsi_queuecmd(cmd, done, ap, dev);
+		rc = __ata_scsi_queuecmd(cmd, done, ap, dev);
 	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
@@ -2517,7 +2525,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 
 	spin_unlock(&ap->host_set->lock);
 	spin_lock(shost->host_lock);
-	return 0;
+	return rc;
 }
 
 /**
-- 
1.2.4


