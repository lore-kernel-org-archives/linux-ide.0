From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Add fixup functionality to the PCI drivers
Date: Fri, 05 Nov 2004 16:40:44 +0000
Message-ID: <1099672842.5564.56.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:13509 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262736AbUKERnh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:43:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Using the ->fixup field that was added we propogate the fixup
functionality into PCI interfaces. The fixup needs to be in the data
structure really as interfaces may be hotplugged/unplugged [plugged only
in base kernel].
The PCI interfaces stay the same so no driver changes are needed except
to use the fixup hook.

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/setup-pci.c linux-2.6.10rc1/drivers/ide/setup-pci.c
--- linux.vanilla-2.6.10rc1/drivers/ide/setup-pci.c	2004-11-05 15:34:46.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/setup-pci.c	2004-11-05 16:27:33.000000000 +0000
@@ -729,14 +729,26 @@
 	return index;
 }
 
+/**
+ *	probe_pci_hwif_init	-	probe the hwif then allow fixups
+ *	@hwif: interface to probe
+ *	@d: PCI device
+ *
+ *	Perform the generic probe and if it is successful invoke any
+ *	remaining post probe fixup logic in the driver itself.
+ */
+static void probe_pci_hwif_init(ide_hwif_t *hwif, ide_pci_device_t *d) {
+	probe_hwif_init_with_fixup(hwif, d->fixup);
+}
+
 void ide_setup_pci_device (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	ata_index_t index_list = do_ide_setup_pci_device(dev, d, 1);
 
 	if ((index_list.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.low]);
+		probe_pci_hwif_init(&ide_hwifs[index_list.b.low], d);
 	if ((index_list.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.high]);
+		probe_pci_hwif_init(&ide_hwifs[index_list.b.high], d);
 
 	create_proc_ide_interfaces();
 }
@@ -749,13 +761,13 @@
 	ata_index_t index_list2 = do_ide_setup_pci_device(dev2, d, 0);
 
 	if ((index_list.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.low]);
+		probe_pci_hwif_init(&ide_hwifs[index_list.b.low], d);
 	if ((index_list.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list.b.high]);
+		probe_pci_hwif_init(&ide_hwifs[index_list.b.high], d);
 	if ((index_list2.b.low & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list2.b.low]);
+		probe_pci_hwif_init(&ide_hwifs[index_list2.b.low], d);
 	if ((index_list2.b.high & 0xf0) != 0xf0)
-		probe_hwif_init(&ide_hwifs[index_list2.b.high]);
+		probe_pci_hwif_init(&ide_hwifs[index_list2.b.high], d);
 
 	create_proc_ide_interfaces();
 }

