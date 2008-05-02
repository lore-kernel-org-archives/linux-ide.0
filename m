From: akpm@linux-foundation.org
Subject: [patch 1/1] pata_atiixp: Don't disable
Date: Fri, 02 May 2008 15:13:39 -0700
Message-ID: <200805022213.m42MDdCs017574@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44752 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936270AbYEBWOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 18:14:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, davidg@havidave.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

A couple of distributions (Fedora, Ubuntu) were having weird problems with the
ATI IXP series PATA controllers being reported as simplex.  At the heart of
the problem is that both distros ignored the recommendations to load pata_acpi
and ata_generic *AFTER* specific host drivers.

The underlying cause however is that if you D3 and then D0 an ATI IXP it
helpfully throws away some configuration and won't let you rewrite it.

Add checks to ata_generic and pata_acpi to pin ATIIXP devices.  Possibly the
real answer here is to quirk them and pin them, but right now we can't do that
before they've been pcim_enable()'d by a driver.

I'm indebted to David Gero for this.  His bug report not only reported the
problem but identified the cause correctly and he had tested the right values
to prove what was going on

[If you backport this for 2.6.24 you will need to pull in the 2.6.25
removal of the bogus WARN_ON() in pcim_enagle]

Signed-off-by: Alan Cox <alan@redhat.com>
Tested-by: David Gero <davidg@havidave.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/ata_generic.c |    6 ++++++
 drivers/ata/pata_acpi.c   |    6 ++++++
 2 files changed, 12 insertions(+)

diff -puN drivers/ata/ata_generic.c~pata_atiixp-dont-disable drivers/ata/ata_generic.c
--- a/drivers/ata/ata_generic.c~pata_atiixp-dont-disable
+++ a/drivers/ata/ata_generic.c
@@ -152,6 +152,12 @@ static int ata_generic_init_one(struct p
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
 
diff -puN drivers/ata/pata_acpi.c~pata_atiixp-dont-disable drivers/ata/pata_acpi.c
--- a/drivers/ata/pata_acpi.c~pata_atiixp-dont-disable
+++ a/drivers/ata/pata_acpi.c
@@ -259,6 +259,12 @@ static int pacpi_init_one (struct pci_de
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
 
_
