From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH RE-UPDATED] libata: add support for ATA_16 on ATAPI
Date: Wed, 8 Aug 2007 01:08:45 +0900
Message-ID: <20070807160845.GR13674@htj.dyndns.org>
References: <20070801075624.GD13674@htj.dyndns.org> <46B091F4.5070704@garzik.org> <46B09494.4080206@gmail.com> <46B1C788.3060201@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:24001 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbXHGQIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 12:08:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1431017rvb
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 09:08:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46B1C788.3060201@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

From: Mark Lord <liml@rtr.ca>

Add support for issuing ATA_16 passthru commands to ATAPI devices
managed by libata.  It requires the previous CDB length fix patch.

A boot/module parameter, "atapi_scmd85=1" can be used to globally
disable this feature, if ever desired.

tj: renamed ata16_passthru module param to atapi_passthru16 and invert
    its meaning to reduce confusion.

tj: restructured __ata_scsi_queuecmd() according to Jeff's suggestion.

Signed-off-by: Mark Lord <liml@rtr.ca>
Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Alright, the winner is atapi_passthru16.

 drivers/ata/libata-core.c |    4 +++
 drivers/ata/libata-scsi.c |   52 +++++++++++++++++++++++++++++++---------------
 drivers/ata/libata.h      |    1 
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 60e78be..0ccac23 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -86,6 +86,10 @@ int atapi_dmadir = 0;
 module_param(atapi_dmadir, int, 0444);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
 
+int atapi_passthru16 = 1;
+module_param(atapi_passthru16, int, 0444);
+MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI devices, on by default (0=off, 1=on)");
+
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e836476..b9a67c1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2746,28 +2746,48 @@ static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
+	u8 scsi_op = scmd->cmnd[0];
+	ata_xlat_func_t xlat_func;
 	int rc = 0;
 
-	if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len)) {
-		DPRINTK("bad CDB len=%u, max=%u\n",
-			scmd->cmd_len, dev->cdb_len);
-		scmd->result = DID_ERROR << 16;
-		done(scmd);
-		return 0;
-	}
-
 	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      scmd->cmnd[0]);
+		if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len))
+			goto bad_cdb_len;
 
-		if (xlat_func)
-			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
-		else
-			ata_scsi_simulate(dev, scmd, done);
-	} else
-		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
+		xlat_func = ata_get_xlat_func(dev, scsi_op);
+	} else {
+		if (unlikely(!scmd->cmd_len))
+			goto bad_cdb_len;
+
+		xlat_func = NULL;
+		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
+			/* relay SCSI command to ATAPI device */
+			if (unlikely(scmd->cmd_len > dev->cdb_len))
+				goto bad_cdb_len;
+
+			xlat_func = atapi_xlat;
+		} else {
+			/* ATA_16 passthru, treat as an ATA command */
+			if (unlikely(scmd->cmd_len > 16))
+				goto bad_cdb_len;
+
+			xlat_func = ata_get_xlat_func(dev, scsi_op);
+		}
+	}
+
+	if (xlat_func)
+		rc = ata_scsi_translate(dev, scmd, done, xlat_func);
+	else
+		ata_scsi_simulate(dev, scmd, done);
 
 	return rc;
+
+ bad_cdb_len:
+	DPRINTK("bad CDB len=%u, scsi_op=0x%02x, max=%u\n",
+		scmd->cmd_len, scsi_op, dev->cdb_len);
+	scmd->result = DID_ERROR << 16;
+	done(scmd);
+	return 0;
 }
 
 /**
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 564cd23..bdee8c2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -56,6 +56,7 @@ extern unsigned int ata_print_id;
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
+extern int atapi_passthru16;
 extern int libata_fua;
 extern int libata_noacpi;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
