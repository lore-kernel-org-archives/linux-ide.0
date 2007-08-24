From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH][resend] fix IDE legacy mode resources
Date: Fri, 24 Aug 2007 11:55:59 +0900
Message-ID: <20070824115559.06250ec0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo30.po.2iij.NET ([210.128.50.53]:12821 "EHLO mo30.po.2iij.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933596AbXHXC4Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 22:56:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: yoichi_yuasa@tripeaks.co.jp, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>

Hi,

I got the following error on MIPS Cobalt.

PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1
pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
PCI: Unable to reserve I/O region #3:8@f0000170 for device 0000:00:09.1
pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
pata_via 0000:00:09.1: no available native port

The legacy mode IDE resources set the following order. 

pci_setup_device()
    Legacy mode ATA controllers have fixed addresses.
    IDE resources: 0x1F0-0x1F7, 0x3F6, 0x170-0x177, 0x376
    |
    V
pcibios_fixup_bus()
    MIPS Cobalt PCI bus regions have the -0x10000000 offset from PCI resources.
    pcibios_fixup_bus() fix PCI bus regions.
    0x1F0 - 0x10000000 = 0xF00001F0
    |
    V
ata_pci_init_one()
    PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1

In some architectures, PCI bus regions have the offset from PCI resources.
For this reason, pci_setup_device() should set PCI bus regions to dev->resource[]. 

Yoichi

---

Fix legacy mode IDE resources 

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/pci/probe.c generic/drivers/pci/probe.c
--- generic-orig/drivers/pci/probe.c	2007-07-26 17:07:44.151670750 +0900
+++ generic/drivers/pci/probe.c	2007-07-26 17:25:42.227046250 +0900
@@ -744,22 +744,40 @@ static int pci_setup_device(struct pci_d
 		 */
 		if (class == PCI_CLASS_STORAGE_IDE) {
 			u8 progif;
+			struct pci_bus_region region;
+			struct resource resource;
 			pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
 			if ((progif & 1) == 0) {
-				dev->resource[0].start = 0x1F0;
-				dev->resource[0].end = 0x1F7;
-				dev->resource[0].flags = LEGACY_IO_RESOURCE;
-				dev->resource[1].start = 0x3F6;
-				dev->resource[1].end = 0x3F6;
-				dev->resource[1].flags = LEGACY_IO_RESOURCE;
+				resource.start = 0x1F0;
+				resource.end = 0x1F7;
+				resource.flags = LEGACY_IO_RESOURCE;
+				pcibios_resource_to_bus(dev, &region, &resource);
+				dev->resource[0].start = region.start;
+				dev->resource[0].end = region.end;
+				dev->resource[0].flags = resource.flags;
+				resource.start = 0x3F6;
+				resource.end = 0x3F6;
+				resource.flags = LEGACY_IO_RESOURCE;
+				pcibios_resource_to_bus(dev, &region, &resource);
+				dev->resource[1].start = region.start;
+				dev->resource[1].end = region.end;
+				dev->resource[1].flags = resource.flags;
 			}
 			if ((progif & 4) == 0) {
-				dev->resource[2].start = 0x170;
-				dev->resource[2].end = 0x177;
-				dev->resource[2].flags = LEGACY_IO_RESOURCE;
-				dev->resource[3].start = 0x376;
-				dev->resource[3].end = 0x376;
-				dev->resource[3].flags = LEGACY_IO_RESOURCE;
+				resource.start = 0x170;
+				resource.end = 0x177;
+				resource.flags = LEGACY_IO_RESOURCE;
+				pcibios_resource_to_bus(dev, &region, &resource);
+				dev->resource[2].start = region.start;
+				dev->resource[2].end = region.end;
+				dev->resource[2].flags = resource.flags;
+				resource.start = 0x376;
+				resource.end = 0x376;
+				resource.flags = LEGACY_IO_RESOURCE;
+				pcibios_resource_to_bus(dev, &region, &resource);
+				dev->resource[3].start = region.start;
+				dev->resource[3].end = region.end;
+				dev->resource[3].flags = resource.flags;
 			}
 		}
 		break;
