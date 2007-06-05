From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Wed, 6 Jun 2007 01:04:17 +0200
Message-ID: <200706060104.18055.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764864AbXFEXEj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jun 2007 19:04:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

the PATA-port of SiS180 controller does not support a drive present status
in the pci configspace like the other SiS PATA controllers, check skipped.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/drivers/ata/pata_sis.c	2007-06-05 22:17:10.000000000 +0200
+++ b/drivers/ata/pata_sis.c	2007-06-06 00:06:08.000000000 +0200
@@ -130,6 +130,20 @@
 
 
 /**
+ *	sis_enables_supported - Check if enable_bits are supported
+ *	@pdev: pci device
+ *
+ *	The combined PATA/SATA controller SiS180 does not support
+ *	the enable_bits in the PCI configspace
+ */
+
+static inline int sis_enables_supported(struct pci_dev *pdev)
+{
+	return ((pdev->device != 0x0180) && (pdev->device != 0x0181));
+}
+
+
+/**
  *	sis_pre_reset		-	probe begin
  *	@ap: ATA port
  *	@deadline: deadline jiffies for the operation
@@ -146,7 +160,8 @@
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
+	if (sis_enables_supported(pdev) && 
+	    !pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
 		return -ENOENT;
 
 	return ata_std_prereset(ap, deadline);

