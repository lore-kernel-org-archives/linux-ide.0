From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/10] ide: fix disabled ports reporting for PCI controllers
Date: Tue, 11 Sep 2007 23:36:26 +0200
Message-ID: <200709112336.26656.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:27602 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbXIKVkR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Sep 2007 17:40:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1153nfb
        for <linux-ide@vger.kernel.org>; Tue, 11 Sep 2007 14:40:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Report all disabled ports in ide_pci_setup_ports() (prevents the bogus
warning when ide_hwif_configure()->ide_match_hwif() fails to find free
ide_hwifs[] slots).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -526,7 +526,6 @@ out:
 void ide_pci_setup_ports(struct pci_dev *dev, ide_pci_device_t *d, int pciirq, ata_index_t *index)
 {
 	int channels = (d->host_flags & IDE_HFLAG_SINGLE) ? 1 : 2, port;
-	int at_least_one_hwif_enabled = 0;
 	ide_hwif_t *hwif, *mate = NULL;
 	u8 tmp;
 
@@ -535,13 +534,15 @@ void ide_pci_setup_ports(struct pci_dev 
 	/*
 	 * Set up the IDE ports
 	 */
-	 
+
 	for (port = 0; port < channels; ++port) {
 		ide_pci_enablebit_t *e = &(d->enablebits[port]);
 	
 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
-		    (tmp & e->mask) != e->val))
+		    (tmp & e->mask) != e->val)) {
+			printk(KERN_INFO "%s: IDE port disabled\n", d->name);
 			continue;	/* port not enabled */
+		}
 
 		if ((hwif = ide_hwif_configure(dev, d, mate, port, pciirq)) == NULL)
 			continue;
@@ -587,10 +588,7 @@ void ide_pci_setup_ports(struct pci_dev 
 			d->init_hwif(hwif);
 
 		mate = hwif;
-		at_least_one_hwif_enabled = 1;
 	}
-	if (!at_least_one_hwif_enabled)
-		printk(KERN_INFO "%s: neither IDE port enabled (BIOS)\n", d->name);
 }
 
 EXPORT_SYMBOL_GPL(ide_pci_setup_ports);
