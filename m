From: Uwe koziolek <uwe.koziolek@gmx.net>
Subject: [PATCH 2.6.22-rc7-git1] sis5513: adding  PCI-ID
Date: Wed, 4 Jul 2007 22:45:34 +0200
Message-ID: <200707042245.35118.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:35821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754284AbXGDUss (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 16:48:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

The SiS966 has one additional PCI-ID 1180.
If the chipset is using this PCI-ID, the primary channel is connected to the first
PATA-port. The secondary channel is connected to SATA-ports in IDE emulation mode.
The legacy IO-ports are used.

the including of the PCI-ID into pata_sis is not sufficient, because the legacy driver
in drivers/ide is initialized before pata_sis.

Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

--- a/include/linux/pci_ids.h	2007-07-03 19:17:44.000000000 +0200
+++ b/include/linux/pci_ids.h	2007-07-04 21:42:16.000000000 +0200
@@ -661,6 +661,7 @@
 #define PCI_DEVICE_ID_SI_965		0x0965
 #define PCI_DEVICE_ID_SI_966		0x0966
 #define PCI_DEVICE_ID_SI_968		0x0968
+#define PCI_DEVICE_ID_SI_1180		0x1180
 #define PCI_DEVICE_ID_SI_5511		0x5511
 #define PCI_DEVICE_ID_SI_5513		0x5513
 #define PCI_DEVICE_ID_SI_5517		0x5517
--- a/drivers/ide/pci/sis5513.c	2007-07-03 19:17:02.000000000 +0200
+++ b/drivers/ide/pci/sis5513.c	2007-07-04 21:34:56.000000000 +0200
@@ -872,6 +872,7 @@
 static struct pci_device_id sis5513_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);

