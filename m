From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ali: Lots of problems still showing up with small
 ATAPI DMA
Date: Mon, 19 Nov 2007 14:37:58 +0000
Message-ID: <20071119143758.3c6b85ee@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37822 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752281AbXKSOjv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:39:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

Hopefully there is a better long term solution but for now lets favour
reliability.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_ali.c linux-2.6.24-rc2-mm1/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_ali.c	2007-11-16 17:55:11.000000000 +0000
+++ linux-2.6.24-rc2-mm1/drivers/ata/pata_ali.c	2007-11-16 18:12:21.000000000 +0000
@@ -282,6 +285,21 @@
 	adev->max_sectors = 255;
 }
 
+/**
+ *	ali_check_atapi_dma	-	DMA check for most ALi controllers
+ *	@adev: Device
+ *
+ *	Called to decide whether commands should be sent by DMA or PIO
+ */
+ 
+static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	/* If its not a media command, its not worth it */
+	if (qc->nbytes < 2048)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 static struct scsi_host_template ali_sht = {
 	.module			= THIS_MODULE,
 	.name			= DRV_NAME,
@@ -378,6 +396,7 @@
 	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
+	.check_atapi_dma = ali_check_atapi_dma,
 	.check_status 	= ata_check_status,
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
@@ -415,6 +434,7 @@
 	.mode_filter	= ata_pci_default_filter,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
+	.check_atapi_dma = ali_check_atapi_dma,
 	.check_status 	= ata_check_status,
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
