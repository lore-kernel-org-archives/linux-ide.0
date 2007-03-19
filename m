From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for ATA_16 on ATAPI
Date: Mon, 19 Mar 2007 11:29:49 -0400
Message-ID: <45FEAC6D.2050100@rtr.ca>
References: <45FA8E96.20909@rtr.ca> <45FE11CB.5020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2951 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965885AbXCSP3w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 11:29:52 -0400
In-Reply-To: <45FE11CB.5020500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> (many months and hours of wasted effort later, still resending..)
>>
>> This patch adds support for issuing ATA_16 passthru commands
>> to ATAPI devices managed by libata.  It requires the previous
>> CDB length fix patch.
>>
>> A boot/module parameter, "ata16_passthru=1" can be used to
>> globally disable this feature, if ever desired.
>>
>> Signed-Off-By: Mark Lord <mlord@pobox.com> ---
> 
> It applies with some warnings.
> 
> Adds trailing whitespace.
> .dotest/patch:47: 
> Space in indent is followed by a tab.
> .dotest/patch:49:               DPRINTK("bad CDB len=%u, max=%u\n",
> Space in indent is followed by a tab.
> .dotest/patch:50:                       scmd->cmd_len, max_len);
> 
> Other than that.
> 
> Acked-by: Tejun Heo <htejun@gmail.com>

Here it is again, without the two extraneous spaces.

This patch adds support for issuing ATA_16 passthru commands
to ATAPI devices managed by libata.  It requires the previous
CDB length fix patch.

A boot/module parameter, "ata16_passthru=1" can be used to
globally disable this feature, if ever desired.

Signed-Off-By: Mark Lord <mlord@pobox.com> ---
---

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
