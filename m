From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: [Patch? 2.6.10-rc3-bk17] ata_pci_remove_one used freed memory
Date: Sat, 25 Dec 2004 16:20:03 +0800
Message-ID: <200412250820.iBP8K3421640@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [61.48.52.95] ([61.48.52.95]:61944 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261435AbULYIYP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Dec 2004 03:24:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

	Attempting to unload a serial ATA driver module gave me a kernel
memory fault.  I think this problem occurs in all configurations, but
I should mention that my configuration may be slightly unusual in that
I configured my BIOS not to do IDE emulation with SATA disks, and I don't
actually have any disks plugged in.

	The problem was that ata_pci_remove_one would call
scsi_host_put(ap->host), which would free the memory used to hold
host_set->ports, but host_set->ports was used later in ata_pci_remove_one.

	So, the following patch reorders some of the steps in
ata_pci_remove_one and seems to eliminate the problem, at least to
the extent that I can unload and reload the module, although I do not
have a SATA disk handy for testing (I'm expecting one to arrive later
today).

	The patch actually makes the code four lines shorter, although
two of those lines come from putting an assignement and variable
declaration in the same line.  Since the patch is a little hard to
read, here is a description of the edit steps.

	1. Moved pci_release_regions() to toward the end of the routine
to facilitate merging the loops before and after it.  Also, I think that
calls that are good candidates for consolidating into the bus-level code
in the future (instead of individual drivers) are best put at the beginning
or end of the driver routines so that it is clearer if there would be
problems doing such consolidation.

	2. Moved the cacluation of ioaddr into the only if-branch that
uses it.

	3. Moved the call to scsi_host_put to after the code that
checks ATA_FLAG_NO_LEGACY.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux/drivers/scsi/libata-core.c.orig	2004-12-25 10:08:16.000000000 +0800
+++ linux/drivers/scsi/libata-core.c	2004-12-25 10:15:45.000000000 +0800
@@ -3701,32 +3701,28 @@
 		iounmap(host_set->mmio_base);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
 
 		ata_scsi_release(ap->host);
-		scsi_host_put(ap->host);
-	}
-
-	pci_release_regions(pdev);
-
-	for (i = 0; i < host_set->n_ports; i++) {
-		struct ata_ioports *ioaddr;
-
-		ap = host_set->ports[i];
-		ioaddr = &ap->ioaddr;
 
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
+			struct ata_ioports *ioaddr = &ap->ioaddr;
+
 			if (ioaddr->cmd_addr == 0x1f0)
 				release_region(0x1f0, 8);
 			else if (ioaddr->cmd_addr == 0x170)
 				release_region(0x170, 8);
 		}
+
+		scsi_host_put(ap->host);
 	}
 
 	kfree(host_set);
+
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
 }
 
 /* move to PCI subsystem */
 int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits)
