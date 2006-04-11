From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/13] libata-hp: add ata_hotplug_wq
Date: Tue, 11 Apr 2006 23:06:22 +0900
Message-ID: <11447643821791-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:34748 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751013AbWDKOG3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:29 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100709nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:28 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

It's best to run ATA hotplug from EH but attaching SCSI devices needs
working EH.  ata_hotplug_wq is used to give SCSI hotplug operations a
separate context.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

1438492c4408fc908d3fb5865fd56231360a2fcd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0206791..610f963 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -72,6 +72,8 @@ static void ata_dev_xfermask(struct ata_
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
 
+struct workqueue_struct *ata_hotplug_wq;
+
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
@@ -5300,6 +5302,12 @@ static int __init ata_init(void)
 	if (!ata_wq)
 		return -ENOMEM;
 
+	ata_hotplug_wq = create_workqueue("ata_hotplug");
+	if (!ata_hotplug_wq) {
+		destroy_workqueue(ata_wq);
+		return -ENOMEM;
+	}
+
 	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
 	return 0;
 }
@@ -5307,6 +5315,7 @@ static int __init ata_init(void)
 static void __exit ata_exit(void)
 {
 	destroy_workqueue(ata_wq);
+	destroy_workqueue(ata_hotplug_wq);
 }
 
 module_init(ata_init);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 659badb..09fddf6 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -40,6 +40,7 @@ struct ata_scsi_args {
 };
 
 /* libata-core.c */
+extern struct workqueue_struct *ata_hotplug_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
-- 
1.2.4


