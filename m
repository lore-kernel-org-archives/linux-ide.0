From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_atiixp: Don't disable
Date: Wed, 30 Apr 2008 18:26:45 +0100
Message-ID: <20080430182645.47e66c47@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50748 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758877AbYD3RfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 13:35:02 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

A couple of distributions (Fedora, Ubuntu) were having weird problems
with the ATI IXP series PATA controllers being reported as simplex. At the
heart of the problem is that both distros ignored the recommendations to
load pata_acpi and ata_generic *AFTER* specific host drivers.

The underlying cause however is that if you D3 and then D0 an ATI IXP it
helpfully throws away some configuration and won't let you rewrite it.

Add checks to ata_generic and pata_acpi to pin ATIIXP devices. Possibly
the real answer here is to quirk them and pin them, but right now we
can't do that before they've been pcim_enable()'d by a driver.

I'm indebted to David Gero for this. His bug report not only reported the
problem but identified the cause correctly and he had tested the right
values to prove what was going on

[If you backport this for 2.6.24 you will need to pull in the 2.6.25
removal of the bogus WARN_ON() in pcim_enagle]

Signed-off-by: Alan Cox <alan@redhat.com>
Tested-by: David Gero <davidg@havidave.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-mm1/drivers/ata/ata_generic.c linux-2.6.25-mm1/drivers/ata/ata_generic.c
--- linux.vanilla-2.6.25-mm1/drivers/ata/ata_generic.c	2008-04-28 11:36:48.000000000 +0100
+++ linux-2.6.25-mm1/drivers/ata/ata_generic.c	2008-04-29 20:18:47.000000000 +0100
@@ -152,6 +152,12 @@
 	if (dev->vendor == PCI_VENDOR_ID_AL)
 		ata_pci_bmdma_clear_simplex(dev);
 
+	if (dev->vendor == PCI_VENDOR_ID_ATI) {
+		int rc = pcim_enable_device(pdev);
+		if (rc < 0)
+			return rc;
+		pcim_pin_device(pdev);
+	}
 	return ata_pci_sff_init_one(dev, ppi, &generic_sht, NULL);
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-mm1/drivers/ata/pata_acpi.c linux-2.6.25-mm1/drivers/ata/pata_acpi.c
--- linux.vanilla-2.6.25-mm1/drivers/ata/pata_acpi.c	2008-04-28 11:36:48.000000000 +0100
+++ linux-2.6.25-mm1/drivers/ata/pata_acpi.c	2008-04-29 20:20:04.000000000 +0100
@@ -259,6 +259,12 @@
 		.port_ops	= &pacpi_ops,
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
+	if (pdev->vendor == PCI_VENDOR_ID_ATI) {
+		int rc = pcim_enable_device(pdev);
+		if (rc < 0)
+			return rc;
+		pcim_pin_device(pdev);
+	}
 	return ata_pci_sff_init_one(pdev, ppi, &pacpi_sht, NULL);
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-mm1/drivers/ata/pata_atiixp.c linux-2.6.25-mm1/drivers/ata/pata_atiixp.c
--- linux.vanilla-2.6.25-mm1/drivers/ata/pata_atiixp.c	2008-04-28 11:36:48.000000000 +0100
+++ linux-2.6.25-mm1/drivers/ata/pata_atiixp.c	2008-04-29 20:14:01.000000000 +0100
@@ -243,9 +243,6 @@
 		.port_ops = &atiixp_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-	/* Some of the quirk reconfiguration messes up the simplex flag, so
-	   clear it again */
-	ata_pci_bmdma_clear_simplex(dev);
 	return ata_pci_sff_init_one(dev, ppi, &atiixp_sht, NULL);
 }
 
