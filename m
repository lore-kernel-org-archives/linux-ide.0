From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ide: pci: free PCI BARs on initialization failure
Date: Tue, 03 Oct 2017 13:59:07 +0200
Message-ID: <3105781.uZB2mYxEDh@amdc3058>
References: <CGME20171003115909epcas2p21c25b1c67678df6fd6c26386345abf9a@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:10504 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdJCL7M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Oct 2017 07:59:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Recent pci_assign_irq() changes uncovered a problem with missing
freeing of PCI BARs on PCI IDE host initialization failure:

ide0: disabled, no IRQ
ide0: failed to initialize IDE interface
ide0: disabling port
cmd64x 0000:00:02.0: IDE controller (0x1095:0x0646 rev 0x07)
CMD64x_IDE 0000:00:02.0: BAR 0: can't reserve [io  0x8050-0x8057]
cmd64x 0000:00:02.0: can't reserve resources
CMD64x_IDE: probe of 0000:00:02.0 failed with error -16

Fix the problem by adding missing freeing of PCI BARs to
ide_setup_pci_controller() and ide_pci_init_two().

Link: http://lkml.kernel.org/r/32ec730f-c1b0-5584-cd35-f8a809122b96@roeck-us.net
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
This should fix problem with reserving PCI resources on a secondary
PCI device probe attempt (please test when pci_assign_irq() fix is
not present and "[PATCH] ide: add missing hwif->portdev freeing on
hwif_init() failure" is applied).

 drivers/ide/setup-pci.c |   61 +++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c	2017-10-03 13:43:29.567778114 +0200
+++ b/drivers/ide/setup-pci.c	2017-10-03 13:43:54.131778138 +0200
@@ -179,6 +179,7 @@ EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
 /**
  *	ide_pci_enable	-	do PCI enables
  *	@dev: PCI device
+ *	@bars: PCI BARs mask
  *	@d: IDE port info
  *
  *	Enable the IDE PCI device. We attempt to enable the device in full
@@ -189,9 +190,10 @@ EXPORT_SYMBOL_GPL(ide_setup_pci_noise);
  *	Returns zero on success or an error code
  */
 
-static int ide_pci_enable(struct pci_dev *dev, const struct ide_port_info *d)
+static int ide_pci_enable(struct pci_dev *dev, int bars,
+			  const struct ide_port_info *d)
 {
-	int ret, bars;
+	int ret;
 
 	if (pci_enable_device(dev)) {
 		ret = pci_enable_device_io(dev);
@@ -216,18 +218,6 @@ static int ide_pci_enable(struct pci_dev
 		goto out;
 	}
 
-	if (d->host_flags & IDE_HFLAG_SINGLE)
-		bars = (1 << 2) - 1;
-	else
-		bars = (1 << 4) - 1;
-
-	if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0) {
-		if (d->host_flags & IDE_HFLAG_CS5520)
-			bars |= (1 << 2);
-		else
-			bars |= (1 << 4);
-	}
-
 	ret = pci_request_selected_regions(dev, bars, d->name);
 	if (ret < 0)
 		printk(KERN_ERR "%s %s: can't reserve resources\n",
@@ -403,6 +393,7 @@ int ide_hwif_setup_dma(ide_hwif_t *hwif,
 /**
  *	ide_setup_pci_controller	-	set up IDE PCI
  *	@dev: PCI device
+ *	@bars: PCI BARs mask
  *	@d: IDE port info
  *	@noisy: verbose flag
  *
@@ -411,7 +402,7 @@ int ide_hwif_setup_dma(ide_hwif_t *hwif,
  *	and enables it if need be
  */
 
-static int ide_setup_pci_controller(struct pci_dev *dev,
+static int ide_setup_pci_controller(struct pci_dev *dev, int bars,
 				    const struct ide_port_info *d, int noisy)
 {
 	int ret;
@@ -420,7 +411,7 @@ static int ide_setup_pci_controller(stru
 	if (noisy)
 		ide_setup_pci_noise(dev, d);
 
-	ret = ide_pci_enable(dev, d);
+	ret = ide_pci_enable(dev, bars, d);
 	if (ret < 0)
 		goto out;
 
@@ -428,16 +419,18 @@ static int ide_setup_pci_controller(stru
 	if (ret < 0) {
 		printk(KERN_ERR "%s %s: error accessing PCI regs\n",
 			d->name, pci_name(dev));
-		goto out;
+		goto out_free_bars;
 	}
 	if (!(pcicmd & PCI_COMMAND_IO)) {	/* is device disabled? */
 		ret = ide_pci_configure(dev, d);
 		if (ret < 0)
-			goto out;
+			goto out_free_bars;
 		printk(KERN_INFO "%s %s: device enabled (Linux)\n",
 			d->name, pci_name(dev));
 	}
 
+out_free_bars:
+	pci_release_selected_regions(dev, bars);
 out:
 	return ret;
 }
@@ -540,13 +533,28 @@ int ide_pci_init_two(struct pci_dev *dev
 {
 	struct pci_dev *pdev[] = { dev1, dev2 };
 	struct ide_host *host;
-	int ret, i, n_ports = dev2 ? 4 : 2;
+	int ret, i, n_ports = dev2 ? 4 : 2, bars;
 	struct ide_hw hw[4], *hws[] = { NULL, NULL, NULL, NULL };
 
+	if (d->host_flags & IDE_HFLAG_SINGLE)
+		bars = (1 << 2) - 1;
+	else
+		bars = (1 << 4) - 1;
+
+	if ((d->host_flags & IDE_HFLAG_NO_DMA) == 0) {
+		if (d->host_flags & IDE_HFLAG_CS5520)
+			bars |= (1 << 2);
+		else
+			bars |= (1 << 4);
+	}
+
 	for (i = 0; i < n_ports / 2; i++) {
-		ret = ide_setup_pci_controller(pdev[i], d, !i);
-		if (ret < 0)
+		ret = ide_setup_pci_controller(pdev[i], bars, d, !i);
+		if (ret < 0) {
+			if (i == 1)
+				pci_release_selected_regions(pdev[0], bars);
 			goto out;
+		}
 
 		ide_pci_setup_ports(pdev[i], d, &hw[i*2], &hws[i*2]);
 	}
@@ -554,7 +562,7 @@ int ide_pci_init_two(struct pci_dev *dev
 	host = ide_host_alloc(d, hws, n_ports);
 	if (host == NULL) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_free_bars;
 	}
 
 	host->dev[0] = &dev1->dev;
@@ -576,7 +584,7 @@ int ide_pci_init_two(struct pci_dev *dev
 		 * do_ide_setup_pci_device() on the first device!
 		 */
 		if (ret < 0)
-			goto out;
+			goto out_free_bars;
 
 		/* fixup IRQ */
 		if (ide_pci_is_in_compatibility_mode(pdev[i])) {
@@ -589,6 +597,13 @@ int ide_pci_init_two(struct pci_dev *dev
 	ret = ide_host_register(host, d, hws);
 	if (ret)
 		ide_host_free(host);
+	else
+		goto out;
+
+out_free_bars:
+	i = n_ports / 2;
+	while (i--)
+		pci_release_selected_regions(pdev[i], bars);
 out:
 	return ret;
 }

