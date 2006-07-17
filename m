From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata: make counting functions global
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <11531191522472-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:5519 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932337AbWGQGvU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:20 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398405nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:20 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ata_port_nr_{vacant|enabled}() to libata-core.c and make them
global.  This is in preparation for powersave support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   20 ++++++++++++++++++++
 drivers/scsi/libata-eh.c   |   20 --------------------
 drivers/scsi/libata.h      |    2 ++
 3 files changed, 22 insertions(+), 20 deletions(-)

633b38c08535057d6ad9f91a563758b6641ed0be
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1477d32..8e75899 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -100,6 +100,26 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
+int ata_port_nr_vacant(struct ata_port *ap)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ap->device[i].class == ATA_DEV_UNKNOWN)
+			cnt++;
+	return cnt;
+}
+
+int ata_port_nr_enabled(struct ata_port *ap)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_enabled(&ap->device[i]))
+			cnt++;
+	return cnt;
+}
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 29f5934..7c5217a 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1837,26 +1837,6 @@ static int ata_eh_resume(struct ata_port
 	return 0;
 }
 
-static int ata_port_nr_enabled(struct ata_port *ap)
-{
-	int i, cnt = 0;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_enabled(&ap->device[i]))
-			cnt++;
-	return cnt;
-}
-
-static int ata_port_nr_vacant(struct ata_port *ap)
-{
-	int i, cnt = 0;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ap->device[i].class == ATA_DEV_UNKNOWN)
-			cnt++;
-	return cnt;
-}
-
 static int ata_eh_skip_recovery(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e2fa600..d77b5ff 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -48,6 +48,8 @@ extern struct workqueue_struct *ata_aux_
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+extern int ata_port_nr_vacant(struct ata_port *ap);
+extern int ata_port_nr_enabled(struct ata_port *ap);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
-- 
1.3.2


