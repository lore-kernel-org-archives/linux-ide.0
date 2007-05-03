From: Mark Lord <liml@rtr.ca>
Subject: [Fwd: Re: PATCH: libata: add support for ATA_16 on ATAPI]
Date: Wed, 02 May 2007 22:37:14 -0400
Message-ID: <46394ADA.1020400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2673 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767336AbXECChQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 May 2007 22:37:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jeff?
This has been pending for a very long time now.

This patch brings libata up to similar standards as Linux IDE
with support for things like hdparm -I (identify) and -C (check power)
among others on ATAPI drives.

Andrew, can you pick this up for -mm ??

???

-------- Original Message --------
Subject: Re: PATCH: libata: add support for ATA_16 on ATAPI
Date: Sun, 29 Apr 2007 16:46:15 +0900
From: Tejun Heo <htejun@gmail.com>
To: Mark Lord <liml@rtr.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>,	IDE/ATA development list <linux-ide@vger.kernel.org>
References: <4633C0E0.60706@rtr.ca> <4633C14B.6030403@rtr.ca>

Mark Lord wrote:
> resending.. again.. with a Subject line this time :)
> 
> This patch adds support for issuing ATA_16 passthru commands
> to ATAPI devices managed by libata.  It requires the previous
> CDB length fix patch.
> 
> A boot/module parameter, "ata16_passthru=1" can be used to
> globally disable this feature, if ever desired.
> 
> Signed-Off-By: Mark Lord <mlord@pobox.com>

Acked-by: Tejun Heo <htejun@gmail.com>

diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/ata/libata-core.c new/drivers/ata/libata-core.c
--- old/drivers/ata/libata-core.c	2007-02-02 12:29:10.000000000 -0500
+++ new/drivers/ata/libata-core.c	2007-02-02 12:29:03.000000000 -0500
@@ -82,6 +82,10 @@
 module_param(atapi_dmadir, int, 0444);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
 
+int ata16_passthru = 0;
+module_param(ata16_passthru, int, 0444);
+MODULE_PARM_DESC(ata16_passthru, "Enable passthru of SCSI opcode 0x85 to ATAPI devices (0=off, 1=on)");
+
 int libata_fua = 0;
 module_param_named(fua, libata_fua, int, 0444);
 MODULE_PARM_DESC(fua, "FUA support (0=off, 1=on)");
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/ata/libata-scsi.c new/drivers/ata/libata-scsi.c
--- old/drivers/ata/libata-scsi.c	2007-02-02 12:29:10.000000000 -0500
+++ new/drivers/ata/libata-scsi.c	2007-02-02 12:29:25.000000000 -0500
@@ -2688,6 +2688,10 @@
 
 static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
+	if (dev->class == ATA_DEV_ATAPI)
+		if (cmd != ATA_16 || ata16_passthru)
+			return atapi_xlat;
+
 	switch (cmd) {
 	case READ_6:
 	case READ_10:
@@ -2746,27 +2750,28 @@
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
-	int rc = 0;
-
-	if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len)) {
-		DPRINTK("bad CDB len=%u, max=%u\n",
-			scmd->cmd_len, dev->cdb_len);
+	ata_xlat_func_t xlat_func;
+	int rc = 0, max_len;
+	u8 scsi_op = scmd->cmnd[0];
+
+	if (scsi_op == ATA_16 && dev->class == ATA_DEV_ATAPI && !ata16_passthru)
+		max_len = 16;
+	else
+		max_len = dev->cdb_len;
+ 
+	if (unlikely(!scmd->cmd_len || scmd->cmd_len > max_len)) {
+		DPRINTK("bad CDB len=%u, max=%u\n",
+			scmd->cmd_len, max_len);
 		scmd->result = DID_ERROR << 16;
 		done(scmd);
 		return 0;
 	}
 
-	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      scmd->cmnd[0]);
-
-		if (xlat_func)
-			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
-		else
-			ata_scsi_simulate(dev, scmd, done);
-	} else
-		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
-
+	xlat_func = ata_get_xlat_func(dev, scsi_op);
+	if (xlat_func)
+		rc = ata_scsi_translate(dev, scmd, done, xlat_func);
+	else
+		ata_scsi_simulate(dev, scmd, done);
 	return rc;
 }
 
diff -u --recursive --new-file --exclude-from=old/Documentation/dontdiff old/drivers/ata/libata.h new/drivers/ata/libata.h
--- old/drivers/ata/libata.h	2007-02-02 12:26:28.000000000 -0500
+++ new/drivers/ata/libata.h	2007-02-02 12:29:03.000000000 -0500
@@ -47,6 +47,7 @@
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
 extern int atapi_dmadir;
+extern int ata16_passthru;
 extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
