From: akpm@linux-foundation.org
Subject: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Thu, 10 May 2007 22:48:49 -0700
Message-ID: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60219 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754783AbXEKFtD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, pchen@nvidia.com, htejun@gmail.com

From: "Peer Chen" <pchen@nvidia.com>

Because nvidia SATA controllers onward base on AHCI, so wildcard in sata_nv
driver is unnecessary.  Also the wildcard sometimes cause sata_nv driver to
be loaded for AHCI controllers,which is not as expected.

Signed-off-by: Peer Chen <pchen@nvidia.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_nv.c |    6 ------
 1 file changed, 6 deletions(-)

diff -puN drivers/ata/sata_nv.c~drivers-ata-remove-the-wildcard-from-sata_nv-driver drivers/ata/sata_nv.c
--- a/drivers/ata/sata_nv.c~drivers-ata-remove-the-wildcard-from-sata_nv-driver
+++ a/drivers/ata/sata_nv.c
@@ -288,12 +288,6 @@ static const struct pci_device_id nv_pci
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), GENERIC },
 	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-		PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
 
 	{ } /* terminate list */
 };
_
