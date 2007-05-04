From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: add missing PM hooks
Date: Fri, 04 May 2007 15:30:34 +0200
Message-ID: <463B357A.4090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:59308 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbXEDNar (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 09:30:47 -0400
Received: by py-out-1112.google.com with SMTP id a29so676739pyi
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 06:30:46 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org
Cc: Jeroen Janssen <jeroen.janssen@gmail.com>

For some reason, sata_via is missing PM hooks.  Add them.  Spotted by
Jeroen Janssen <jeroen.janssen@gmail.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jeroen Janssen <jeroen.janssen@gmail.com>
---
I have no idea how we missed this.  This is for both libata-dev &&
-stable.  Thanks.

Index: tree0/drivers/ata/sata_via.c
===================================================================
--- tree0.orig/drivers/ata/sata_via.c
+++ tree0/drivers/ata/sata_via.c
@@ -97,6 +97,10 @@ static struct pci_driver svia_pci_driver
 	.name			= DRV_NAME,
 	.id_table		= svia_pci_tbl,
 	.probe			= svia_init_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+#endif
 	.remove			= ata_pci_remove_one,
 };
 
@@ -116,6 +120,10 @@ static struct scsi_host_template svia_sh
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
+#endif
 };
 
 static const struct ata_port_operations vt6420_sata_ops = {
