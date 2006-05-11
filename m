From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/14] libata-hp-prep: add ata_hotplug_wq
Date: Fri, 12 May 2006 00:11:59 +0900
Message-ID: <11473603192376-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:39210 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751858AbWEKPMO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:14 -0400
Received: by nz-out-0102.google.com with SMTP id 13so224766nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:14 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

It's best to run ATA hotplug from EH but attaching SCSI devices needs
working EH.  ata_hotplug_wq is used to give SCSI hotplug operations a
separate context.

---

 drivers/scsi/libata-core.c |    9 +++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

60b0f9061e9ce6345e549a38d73f4759daae0339
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6da1005..1f587aa 100644
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
index 134cb4d..ff50442 100644
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
1.2.4


