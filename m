From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] RESPIN: libata: add atapi_passthru=1 parameter
Date: Thu, 25 Jan 2007 21:39:02 -0500
Message-ID: <200701252139.04383.liml@rtr.ca>
References: <200701021939.10496.liml@rtr.ca> <200701030124.19568.liml@rtr.ca> <45B15D65.1060203@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1620 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030710AbXAZCjH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 21:39:07 -0500
In-Reply-To: <45B15D65.1060203@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>..
>> I believe Tejun and I were in agreement that proper
>> ATA16 support for ATAPI was the better way to go.
> 
> I like both approaches.  I think direct support of HDIO_GET_IDENTITY can 
> reduce the number of failure points, while making old tools work a bit 
> better.

Okay.  It just seemed like a bit of cruft from my old drivers
that we could leave behind at this point.  But that's fine,
it'll keep more folks off my back regarding hdparm.  :)

Jeff:  I just did this here from scratch:

   git clone rsync://rsync2.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git libata-dev
   cd libata-dev
   git-checkout upstream

And then applied my patches for ATAPI-ATA16 support to them.
They appear to have applied 100% cleanly as-is.

Do I have the correct "upstream" repo ?

Here is the unified patch.
This adds ATA16 command support to libata for ATAPI drives,
permitting issuing of ATA (not ATAPI packet) commands to
ATAPI devices (eg. "hdparm -I" and "hdparm -C").

 libata-core.c |    4 ++++
 libata-scsi.c |   23 ++++++++++++-----------
 libata.h      |    1 +
 3 files changed, 17 insertions(+), 11 deletions(-)

Signed-off-by:  Mark Lord <mlord@pobox.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5117577..509d04a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -78,6 +78,10 @@ int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on)");
 
+int atapi_passthru = 0;
+module_param(atapi_passthru, int, 0444);
+MODULE_PARM_DESC(atapi_passthru, "Enable passthru of SCSI opcode 0x85 to ATAPI devices");
+
 int atapi_dmadir = 0;
 module_param(atapi_dmadir, int, 0444);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off, 1=on)");
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a39d100..4c60d16 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2690,6 +2690,12 @@ static unsigned int ata_scsi_pass_thru(s
 
 static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 {
+	if (cmd == ATA_16 && !atapi_passthru)
+		return ata_scsi_pass_thru;
+
+	if (dev->class == ATA_DEV_ATAPI)
+		return atapi_xlat;
+
 	switch (cmd) {
 	case READ_6:
 	case READ_10:
@@ -2748,6 +2754,7 @@ static inline int __ata_scsi_queuecmd(st
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
+	ata_xlat_func_t xlat_func;
 	int rc = 0;
 
 	if (unlikely(!scmd->cmd_len)) {
@@ -2757,17 +2764,11 @@ static inline int __ata_scsi_queuecmd(st
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
+	xlat_func = ata_get_xlat_func(dev, scmd->cmnd[0]);
+	if (xlat_func)
+		rc = ata_scsi_translate(dev, scmd, done, xlat_func);
+	else
+		ata_scsi_simulate(dev, scmd, done);
 	return rc;
 }
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 81ae41d..89981b4 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -46,6 +46,7 @@ enum {
 
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
+extern int atapi_passthru;
 extern int atapi_dmadir;
 extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
