From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata-hp-prep: add ata_aux_wq
Date: Wed, 31 May 2006 20:05:42 +0900
Message-ID: <1149073542956-git-send-email-htejun@gmail.com>
References: <1149073540186-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:49050 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964975AbWEaLF4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:05:56 -0400
Received: by nz-out-0102.google.com with SMTP id s18so5533nze
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:05:56 -0700 (PDT)
In-Reply-To: <1149073540186-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

It's best to run ATA hotplug from EH but attaching SCSI devices needs
working EH.  ata_aux_wq is used to give SCSI hotplug operations a
separate context.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

453b07accb47c5b54aa2f156ebffac63c543027b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b1a02fd..04921cf 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,6 +69,8 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+struct workqueue_struct *ata_aux_wq;
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
@@ -5623,6 +5625,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_aux_wq = create_singlethread_workqueue("ata_aux");
+	if (!ata_aux_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -5630,6 +5638,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_aux_wq);
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c2b1c91..4458fd9 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,6 +39,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
-- 
1.3.2


