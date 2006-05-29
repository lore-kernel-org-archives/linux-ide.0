From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata-hp-prep: add ata_scsi_wq
Date: Mon, 29 May 2006 15:25:58 +0900
Message-ID: <1148883958977-git-send-email-htejun@gmail.com>
References: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.202]:59921 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751253AbWE2G03 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:29 -0400
Received: by wx-out-0102.google.com with SMTP id h27so298162wxd
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:29 -0700 (PDT)
In-Reply-To: <11488839571850-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

It's best to run ATA hotplug from EH but attaching SCSI devices needs
working EH.  ata_scsi_wq is used to give SCSI hotplug operations a
separate context.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

84fc45de6b3fc32e8310a27dd54fa455a1038e9b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 83fb9dd..aa1e0a1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,6 +69,8 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+struct workqueue_struct *ata_scsi_wq;
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
@@ -5622,6 +5624,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_scsi_wq = create_singlethread_workqueue("ata_scsi");
+	if (!ata_scsi_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -5629,6 +5637,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_scsi_wq);
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index d46c552..d4bb2e4 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,6 +39,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern struct workqueue_struct *ata_scsi_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
-- 
1.3.2


