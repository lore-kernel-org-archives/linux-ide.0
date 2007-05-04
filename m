From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: add missing PM hooks
Date: Fri, 04 May 2007 11:03:02 +0200
Message-ID: <463AF6C6.1050402@gmail.com>
References: <e34e42440705030542r1574dfdre143e2d43edd44d6@mail.gmail.com>	 <4639F59B.1080009@gmail.com> <e34e42440705040122r2ec59952w2684039868808fcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:53598 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933040AbXEDJDT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 05:03:19 -0400
Received: by py-out-1112.google.com with SMTP id a29so630193pyi
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 02:03:19 -0700 (PDT)
In-Reply-To: <e34e42440705040122r2ec59952w2684039868808fcb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeroen Janssen <jeroen.janssen@gmail.com>
Cc: linux-ide@vger.kernel.org

For some reason, sata_via is missing PM hooks.  Add them.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This patch is against 2.6.21 but you can use it over 2.6.20 too.  Does
this fix your problem?

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
