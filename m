From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] pata_jmicron: drop unnecessary device programming in [re]init
Date: Mon, 26 Feb 2007 20:09:02 +0900
Message-ID: <20070226110902.GD20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:58605 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbXBZLJF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 06:09:05 -0500
Received: by py-out-1112.google.com with SMTP id a29so686422pyi
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 03:09:04 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, justin@jmicron.com

Channel redirect and AHCI mode enable programmings are done via PCI
quirk for both probe and resume paths.  Drop duplicate and possibly
unsafe device programming from pata_jmicron().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/pata_jmicron.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -202,43 +202,13 @@ static int jmicron_init_one (struct pci_
 	};
 	struct ata_port_info *port_info[2] = { &info, &info };
 
-	u32 reg;
-
 	/* PATA controller is fn 1, AHCI is fn 0 */
 	if (id->driver_data != 368 && PCI_FUNC(pdev->devfn) != 1)
 		return -ENODEV;
 
-	/* The 365/66 have two PATA channels, redirect the second */
-	if (id->driver_data == 365 || id->driver_data == 366) {
-		pci_read_config_dword(pdev, 0x80, &reg);
-		reg |= (1 << 24);	/* IDE1 to PATA IDE secondary */
-		pci_write_config_dword(pdev, 0x80, reg);
-	}
-
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
-static int jmicron_reinit_one(struct pci_dev *pdev)
-{
-	u32 reg;
-
-	switch(pdev->device) {
-		case PCI_DEVICE_ID_JMICRON_JMB368:
-			break;
-		case PCI_DEVICE_ID_JMICRON_JMB365:
-		case PCI_DEVICE_ID_JMICRON_JMB366:
-			/* Restore mapping or disks swap and boy does it get ugly */
-			pci_read_config_dword(pdev, 0x80, &reg);
-			reg |= (1 << 24);	/* IDE1 to PATA IDE secondary */
-			pci_write_config_dword(pdev, 0x80, reg);
-			/* Fall through */
-		default:
-			/* Make sure AHCI is turned back on */
-			pci_write_config_byte(pdev, 0x41, 0xa1);
-	}
-	return ata_pci_device_resume(pdev);
-}
-
 static const struct pci_device_id jmicron_pci_tbl[] = {
 	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
 	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 363},
@@ -255,7 +225,7 @@ static struct pci_driver jmicron_pci_dri
 	.probe			= jmicron_init_one,
 	.remove			= ata_pci_remove_one,
 	.suspend		= ata_pci_device_suspend,
-	.resume			= jmicron_reinit_one,
+	.resume			= ata_pci_device_resume,
 };
 
 static int __init jmicron_init(void)
