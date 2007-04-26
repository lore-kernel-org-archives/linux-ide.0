From: akpm@linux-foundation.org
Subject: [patch 08/10] drivers/ata/pata_cmd640.c: fix build with CONFIG_PM=n
Date: Thu, 26 Apr 2007 00:19:26 -0700
Message-ID: <200704260719.l3Q7JQ8B023700@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:57036 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933256AbXDZHTe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2007 03:19:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

This is grubby, but all the ata drivers do it this way.

Would it not be better to do

#define ata_scsi_device_resume NULL

in libata.h, remove all those ifdefs?

(updated version, ug, ug)

Cc: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_cmd640.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/ata/pata_cmd640.c~drivers-ata-pata_cmd640c-fix-build-with-config_pm=n drivers/ata/pata_cmd640.c
--- a/drivers/ata/pata_cmd640.c~drivers-ata-pata_cmd640c-fix-build-with-config_pm=n
+++ a/drivers/ata/pata_cmd640.c
@@ -181,8 +181,10 @@ static struct scsi_host_template cmd640_
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+#ifdef CONFIG_PM
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+#endif
 };
 
 static struct ata_port_operations cmd640_port_ops = {
@@ -267,7 +269,11 @@ static int cmd640_init_one(struct pci_de
 static int cmd640_reinit_one(struct pci_dev *pdev)
 {
 	cmd640_hardware_init(pdev);
+#ifdef CONFIG_PM
 	return ata_pci_device_resume(pdev);
+#else
+	return 0;
+#endif
 }
 
 static const struct pci_device_id cmd640[] = {
@@ -280,7 +286,9 @@ static struct pci_driver cmd640_pci_driv
 	.id_table	= cmd640,
 	.probe 		= cmd640_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
+#endif
 	.resume		= cmd640_reinit_one,
 };
 
_
