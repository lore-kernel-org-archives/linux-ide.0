From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata-scsi: fix sparse warnings
Date: Tue, 17 Jan 2006 21:33:41 -0800
Message-ID: <20060117213341.7fbae10c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:35773 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030256AbWARFdr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 00:33:47 -0500
Received: from zx64.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2006 21:33:44 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix sparse warnings:
drivers/scsi/libata-scsi.c:154:15: warning: cast removes address space of expression
drivers/scsi/libata-scsi.c:204:20: warning: cast removes address space of expression
drivers/scsi/libata-scsi.c:231:15: warning: cast removes address space of expression

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/libata-scsi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2616-rc1.orig/drivers/scsi/libata-scsi.c
+++ linux-2616-rc1/drivers/scsi/libata-scsi.c
@@ -151,7 +151,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	struct scsi_sense_hdr sshdr;
 	enum dma_data_direction data_dir;
 
-	if (NULL == (void *)arg)
+	if (arg == NULL)
 		return -EINVAL;
 
 	if (copy_from_user(args, arg, sizeof(args)))
@@ -201,7 +201,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	/* Need code to retrieve data from check condition? */
 
 	if ((argbuf)
-	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
+	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
 		rc = -EFAULT;
 error:
 	if (argbuf)
@@ -228,7 +228,7 @@ int ata_task_ioctl(struct scsi_device *s
 	u8 args[7];
 	struct scsi_sense_hdr sshdr;
 
-	if (NULL == (void *)arg)
+	if (arg == NULL)
 		return -EINVAL;
 
 	if (copy_from_user(args, arg, sizeof(args)))


---
