From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-acpi: Try and stop all the non PCI devices crashing
Date: Thu, 8 Mar 2007 23:13:50 +0000
Message-ID: <20070308231350.4ecad127@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60602 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030746AbXCHWK0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:10:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, torvalds@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

For 2.6.20 it mostly used to just not work, for 2.6.21-rc it crashes, this
seems to be down to luck (bad or good). The libata-acpi code needs to
avoid doing PCI work on non-PCI devices. This is one hack although it's
not pretty and perhaps there is a "right" way to check if a struct device
* is PCI ?

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c linux-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c	2007-03-08 15:59:20.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-acpi.c	2007-03-08 16:44:25.000000000 +0000
@@ -34,6 +34,16 @@
 	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
 };
 
+/*
+ *	Helper - belongs in the PCI layer somewhere eventually
+ */
+ 
+static int is_pci_dev(struct device *dev)
+{
+	if (dev->bus == &pci_bus_type)
+		return 1;
+	return 0;
+}
 
 /**
  * sata_get_dev_handle - finds acpi_handle and PCI device.function
@@ -52,6 +62,9 @@
 {
 	struct pci_dev	*pci_dev;
 	acpi_integer	addr;
+	
+	if (!is_pci_dev(dev))
+		return -ENODEV;
 
 	pci_dev = to_pci_dev(dev);	/* NOTE: PCI-specific */
 	/* Please refer to the ACPI spec for the syntax of _ADR. */
@@ -84,7 +97,12 @@
 	acpi_status status;
 	struct acpi_device_info	*dinfo = NULL;
 	int ret = -ENODEV;
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev;
+
+	if (!is_pci_dev(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
 
 	bus = pdev->bus->number;
 	devnum = PCI_SLOT(pdev->devfn);
