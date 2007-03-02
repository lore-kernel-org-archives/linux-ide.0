From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: add missing PM callbacks
Date: Fri, 2 Mar 2007 17:30:01 +0900
Message-ID: <20070302083001.GK20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:45199 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422654AbXCBIaD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 03:30:03 -0500
Received: by nz-out-0506.google.com with SMTP id s1so781111nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 00:30:01 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Some LLDs were missing scsi device PM callbacks while having host/port
suspend support.  Add missing ones.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_jmicron.c |    4 ++++
 drivers/ata/pata_mpc52xx.c |    4 ++++
 drivers/ata/pata_sil680.c  |    4 ++++
 3 files changed, 12 insertions(+)

Index: work/drivers/ata/pata_mpc52xx.c
===================================================================
--- work.orig/drivers/ata/pata_mpc52xx.c
+++ work/drivers/ata/pata_mpc52xx.c
@@ -280,6 +280,10 @@ static struct scsi_host_template mpc52xx
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static struct ata_port_operations mpc52xx_ata_port_ops = {
Index: work/drivers/ata/pata_sil680.c
===================================================================
--- work.orig/drivers/ata/pata_sil680.c
+++ work/drivers/ata/pata_sil680.c
@@ -236,6 +236,10 @@ static struct scsi_host_template sil680_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static struct ata_port_operations sil680_port_ops = {
Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -137,6 +137,10 @@ static struct scsi_host_template jmicron
 	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations jmicron_ops = {
