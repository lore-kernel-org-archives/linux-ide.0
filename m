From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] libata: fix sparse warnings
Date: Sun, 25 Dec 2005 19:34:27 -0800
Message-ID: <20051225193427.0962fdea.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:33497 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750987AbVLZDdw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Dec 2005 22:33:52 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 25 Dec 2005 19:33:50 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik <jgarzik@pobox.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Question:  in patch block 2, what are the semantics of the user <arg>?
Does it point to an input u8 args[4] which must be immediately followed
by an output u8 args[4]?  That's what it seems to be.  Just checking.


Fix sparse warnings:
drivers/scsi/libata-scsi.c:154:15: warning: cast removes address space of expression
drivers/scsi/libata-scsi.c:204:20: warning: cast removes address space of expression
drivers/scsi/libata-scsi.c:204:20: warning: incorrect type in argument 1 (different address spaces)
drivers/scsi/libata-scsi.c:204:20:    expected void [noderef] *to<asn:1>
drivers/scsi/libata-scsi.c:204:20:    got void *<noident>
drivers/scsi/libata-scsi.c:231:15: warning: cast removes address space of expression

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/libata-scsi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2615-rc7.orig/drivers/scsi/libata-scsi.c
+++ linux-2615-rc7/drivers/scsi/libata-scsi.c
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
