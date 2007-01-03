From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata: add atapi_passthru=1 parameter
Date: Wed, 3 Jan 2007 01:01:09 -0500
Message-ID: <200701030101.09838.liml@rtr.ca>
References: <200701021939.10496.liml@rtr.ca> <459AFDC2.6060900@garzik.org> <459B438A.8070601@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4920 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbXACGBN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jan 2007 01:01:13 -0500
In-Reply-To: <459B438A.8070601@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On Wednesday 03 January 2007 00:47, Mark Lord wrote:
> Jeff Garzik wrote:
> > As I said, provide some avenue for the user to choose.

This patch isn't really needed, but it might provide an "out"
just in case somebody has some really non-compliant hardware
out there someday.

Add a boot/module parameter for libata to force the ATA_16
SCSI opcode to not be interpreted as a standards-compliant
ATA passthrough mechanism when used on an ATAPI device
 -- instead, it gets passed directly to the ATAPI device.

Signed-off-by:  Mark Lord <mlord@pobox.com>
--- old/drivers/ata/libata.h	2007-01-02 19:06:56.000000000 -0500
+++ linux/drivers/ata/libata.h	2007-01-03 00:55:01.000000000 -0500
@@ -46,6 +46,7 @@
 
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
+extern int atapi_passthru;
 extern int atapi_dmadir;
 extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
--- old/drivers/ata/libata-core.c	2007-01-02 19:09:06.000000000 -0500
+++ linux/drivers/ata/libata-core.c	2007-01-03 00:52:51.000000000 -0500
@@ -78,6 +78,10 @@
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int atapi_passthru = 0;
+module_param(atapi_passthru, int, 0444);
+MODULE_PARM_DESC(atapi_passthru, "Enable passthru of SCSI opcode 0x85 to ATAPI devices");
+
 int atapi_dmadir = 0;
 module_param(atapi_dmadir, int, 0444);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
--- old/drivers/ata/libata-scsi.c	2007-01-02 19:20:49.000000000 -0500
+++ linux/drivers/ata/libata-scsi.c	2007-01-03 00:55:08.000000000 -0500
@@ -2650,7 +2650,7 @@
 
 static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
-	if (cmd == ATA_16)
+	if (cmd == ATA_16 && !atapi_passthru)
 		return ata_scsi_pass_thru;
 
 	if (dev->class == ATA_DEV_ATAPI)
