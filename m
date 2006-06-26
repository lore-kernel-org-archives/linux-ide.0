From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: SC1200 debug printk
Date: Mon, 26 Jun 2006 14:51:45 +0100
Message-ID: <1151329905.27147.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964847AbWFZNft@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Kill a pair of long escaped debug printk calls

Signed-off-by: Alan Cox <alan@redhat.com>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/sc1200.c linux-2.6.17/drivers/ide/pci/sc1200.c
--- linux.vanilla-2.6.17/drivers/ide/pci/sc1200.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/sc1200.c	2006-06-26 13:27:45.671877280 +0100
@@ -395,7 +395,6 @@
 {
 	ide_hwif_t	*hwif = NULL;
 
-printk("SC1200: resume\n");
 	pci_set_power_state(dev, PCI_D0);	// bring chip back from sleep state
 	dev->current_state = PM_EVENT_ON;
 	pci_enable_device(dev);
@@ -405,7 +404,6 @@
 	while ((hwif = lookup_pci_dev(hwif, dev)) != NULL) {
 		unsigned int		basereg, r, d, format;
 		sc1200_saved_state_t	*ss = (sc1200_saved_state_t *)hwif->config_data;
-printk("%s: SC1200: resume\n", hwif->name);
 
 		//
 		// Restore timing registers:  this may be unnecessary if BIOS also does it
@@ -493,7 +491,7 @@
 }
 
 static struct pci_device_id sc1200_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE), 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
