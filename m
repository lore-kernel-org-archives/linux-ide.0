From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/14] libata-hp-prep: add ata_hotplug_wq
Date: Fri, 19 May 2006 06:06:40 -0700 (PDT)
Message-ID: <11480439893127-git-send-email-htejun@gmail.com>
References: <11480439892010-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:30921 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751285AbWESNGl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:06:41 -0400
Received: by py-out-1112.google.com with SMTP id z59so917410pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:06:41 -0700 (PDT)
In-Reply-To: <11480439892010-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

It's best to run ATA hotplug from EH but attaching SCSI devices needs
working EH.  ata_hotplug_wq is used to give SCSI hotplug operations a
separate context.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

5b942048c7f14c12bd0807da3cfbb2fa09925e1f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9e10b79..fba5514 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -69,6 +69,8 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+struct workqueue_struct *ata_hotplug_wq;
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
@@ -5588,6 +5590,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_hotplug_wq = create_singlethread_workqueue("ata_hotplug");
+	if (!ata_hotplug_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -5595,6 +5603,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_hotplug_wq);
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index d46c552..4a67675 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -39,6 +39,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern struct workqueue_struct *ata_hotplug_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
-- 
1.3.2

