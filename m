From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] pata_ali: disable ATAPI DMA
Date: Thu, 03 Apr 2008 14:40:55 +0900
Message-ID: <47F46DE7.6090809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.247]:13286 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYDCFlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Apr 2008 01:41:03 -0400
Received: by hs-out-0708.google.com with SMTP id 4so2414041hsl.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 22:41:02 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik l <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

ATAPI DMA just doesn't work reliably on pata_ali.  The IDE driver can
do it but for some mysterious reason, pata_ali can't.  This patch
disables it by default and makes the driver whine during
initialization.  "pata_ali.atapi_dma" parameter is added so that user
can bypass the workaround.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
I just had another run with pata_ali.  I tried various things w/o any
success.  I just can't see what's the difference between alim15x3 and
pata_ali.  I again tried to make the command issue path of pata_ali +
libata behave virtually identical to alim15x3 but it just didn't work.
:-(  :-(  :-(

 drivers/ata/pata_ali.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 8786455..ce830fe 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -36,6 +36,10 @@
 #define DRV_NAME "pata_ali"
 #define DRV_VERSION "0.7.5"
 
+int ali_atapi_dma = 0;
+module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
+MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
+
 /*
  *	Cable special cases
  */
@@ -270,6 +274,27 @@ static void ali_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
+ *	ali_warn_atapi_dma	-	Warn about ATAPI DMA disablement
+ *	@adev: Device
+ *
+ *	Whine about ATAPI DMA disablement if @adev is an ATAPI device.
+ *	Can be used as ->dev_config.
+ */
+
+static void ali_warn_atapi_dma(struct ata_device *adev)
+{
+	struct ata_eh_context *ehc = &adev->link->eh_context;
+	int print_info = ehc->i.flags & ATA_EHI_PRINTINFO;
+
+	if (print_info && adev->class == ATA_DEV_ATAPI && !ali_atapi_dma) {
+		ata_dev_printk(adev, KERN_WARNING,
+			       "WARNING: ATAPI DMA disabled for reliablity issues.  It can be enabled\n");
+		ata_dev_printk(adev, KERN_WARNING,
+			       "WARNING: via pata_ali.atapi_dma modparam or corresponding sysfs node.\n");
+	}
+}
+
+/**
  *	ali_lock_sectors	-	Keep older devices to 255 sector mode
  *	@adev: Device
  *
@@ -283,6 +308,7 @@ static void ali_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 static void ali_lock_sectors(struct ata_device *adev)
 {
 	adev->max_sectors = 255;
+	ali_warn_atapi_dma(adev);
 }
 
 /**
@@ -294,6 +320,18 @@ static void ali_lock_sectors(struct ata_device *adev)
 
 static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
 {
+	if (!ali_atapi_dma) {
+		/* FIXME: pata_ali can't do ATAPI DMA reliably but the
+		 * IDE alim15x3 driver can.  I tried lots of things
+		 * but couldn't find what the actual difference was.
+		 * If you got an idea, please write it to
+		 * linux-ide@vger.kernel.org and cc htejun@gmail.com.
+		 *
+		 * Disable ATAPI DMA for now.
+		 */
+		return -EOPNOTSUPP;
+	}
+
 	/* If its not a media command, its not worth it */
 	if (atapi_cmd_type(qc->cdb[0]) == ATAPI_MISC)
 		return -EOPNOTSUPP;
@@ -359,6 +397,7 @@ static struct ata_port_operations ali_20_port_ops = {
 
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
+	.check_atapi_dma = ali_check_atapi_dma,
 	.check_status 	= ata_check_status,
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
@@ -438,6 +477,7 @@ static struct ata_port_operations ali_c5_port_ops = {
 	.check_status 	= ata_check_status,
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
+	.dev_config	= ali_warn_atapi_dma,
 
 	.freeze		= ata_bmdma_freeze,
 	.thaw		= ata_bmdma_thaw,
