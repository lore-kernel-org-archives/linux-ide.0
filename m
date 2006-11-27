From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_it821x: Suspend/Resume support
Date: Mon, 27 Nov 2006 16:14:36 +0000
Message-ID: <20061127161436.51e1a8de@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21167 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758350AbWK0QMX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Nov 2006 11:12:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

If you are using the noraid option then after a suspend/resume sequence
we need to reset the card back out of raid mode again.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_it821x.c linux-2.6.19-rc6-mm1/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_it821x.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_it821x.c	2006-11-24 14:23:48.000000000 +0000
@@ -80,7 +80,7 @@
 
 
 #define DRV_NAME "pata_it821x"
-#define DRV_VERSION "0.3.2"
+#define DRV_VERSION "0.3.3"
 
 struct it821x_dev
 {
@@ -676,6 +676,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations it821x_smart_port_ops = {
@@ -808,6 +810,14 @@
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static int it821x_reinit_one(struct pci_dev *pdev)
+{
+	/* Resume - turn raid back off if need be */
+	if (it8212_noraid)
+		it821x_disable_raid(pdev);
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id it821x[] = {
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), },
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8212), },
@@ -819,7 +829,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= it821x,
 	.probe 		= it821x_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= it821x_reinit_one,
 };
 
 static int __init it821x_init(void)
