From: Joerg Dorchain <joerg@dorchain.net>
Subject: [Patch] enable AHCI mode on certain ich chipsets
Date: Wed, 16 Feb 2011 10:05:48 +0100
Message-ID: <20110216090548.GQ5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0p3EEgCnBt7M6rub"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:42187 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab1BPJFv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 04:05:51 -0500
Received: from Redstar.dorchain.net (localhost [127.0.0.1])
	by Redstar.dorchain.net (8.14.4/8.14.3) with ESMTP id p1G95mYu019751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2011 10:05:48 +0100
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.14.4/8.13.8/Submit) id p1G95mNN019749
	for linux-ide@vger.kernel.org; Wed, 16 Feb 2011 10:05:48 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--0p3EEgCnBt7M6rub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

this patch allows to force ICH7/8/9 into AHCI mode.  This is needed
because some BIOSes do not make AHCI-mode operation available to the
user.
As the Intel documentation states that the OS should not carry
out the operation - the user must force this on the kernel
commandline using quirk_ich_force_ahci

As this quirk gets called whilst the PCI subsystem is
walking the PCI bus, we declare this quirk against the LPC
(device 00:1f.0), so that we can frob 00:1f.2 before the PCI
code has scanned it.
Note: the pci id might change due to this (e.g. from 27c4 to 27c5)

For working suspend/resume, the next patch is required, too.

Bye,

Joerg


Signed-Off-By: joerg Dorchain <joerg@dorchain.net>

--- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
+++ linux/drivers/pci/quirks.c	2011-02-12 07:07:57.000000000 +0100
@@ -2684,6 +2684,74 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
=20
 /*
+ * Force ICH7/8/9 into AHCI mode.  This is needed because some
+ * BIOSes do not make AHCI-mode operation available to the user.
+ * As the Intel documentation states that the OS should not carry
+ * out the operation - the user must force this on the kernel
+ * commandline using quirk_ich_force_ahci
+ *
+ * As this quirk gets called whilst the PCI subsystem is
+ * walking the PCI bus, we declare this quirk against the LPC
+ * (device 00:1f.0), so that we can frob 00:1f.2 before the PCI
+ * code has scanned it.
+ * Note: the pci id might change due to this (e.g. from 27c4 to 27c5)
+ *
+ */
+
+static bool ich_force_ahci_mode; /* defaults to false */
+
+static int __init ich789_force_ahci_mode_setup(char *str)
+{
+	ich_force_ahci_mode =3D true;
+	return 0;
+}
+early_param("quirk_ich_force_ahci", ich789_force_ahci_mode_setup);
+
+static void ich789_force_ahci_mode(struct pci_dev *pdev)
+{
+	u8 amrval;
+	u8 sclkgc;
+	const int ich89_address_map_reg =3D 0x90;
+	const int ich89_sata_clock_gen_config_reg =3D 0x9c;
+
+	if (!ich_force_ahci_mode)
+		return;
+
+	/* ICH8 datasheet section 12.1.33 */
+	if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn),=
 2),
+		ich89_address_map_reg, &amrval)) {
+
+		if (amrval & (BIT(6) | BIT(7))) {
+			dev_printk(KERN_DEBUG, &pdev->dev,
+				"ICH7/8/9 SATA controller not in IDE mode.  Not modifying.\n");
+			return;
+		}
+		if (amrval & (BIT(0) | BIT(1)))
+			dev_printk(KERN_DEBUG, &pdev->dev,
+				"ICH7/8/9 in SATA/PATA combined mode.  Untested.\n");
+		/* AHCI mode */
+		amrval |=3D BIT(6);
+		amrval &=3D ~BIT(7);
+		pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
+			ich89_sata_clock_gen_config_reg, &sclkgc);
+		dev_printk(KERN_DEBUG, &pdev->dev, "sclkgc is %#0x\n", sclkgc);
+		pci_bus_write_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 2),
+			ich89_address_map_reg, amrval);
+		dev_printk(KERN_DEBUG, &pdev->dev, "Forced ICH7/8/9 mode PIIX->AHCI\n");
+	}
+}
+/* ICH7 */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x27b9, ich789_force_ahci_mod=
e);
+/* ICH8 */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_0, i=
ch789_force_ahci_mode);
+/* ICH9R LPC */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2916, ich789_force_ahci_mod=
e);
+/* ICH9M LPC */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2917, ich789_force_ahci_mod=
e);
+/* ICH9M-E LPC */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2919, ich789_force_ahci_mod=
e);
+
+/*
  * This is a quirk for the Ricoh MMC controller found as a part of
  * some mulifunction chips.
=20

--0p3EEgCnBt7M6rub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHcEARECADcFAk1bk2wwFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zgf7MAnjOPVijvxU9Krnp5n4Mq46A4
qxxGAJ9oCLSlBQ17Vb0gOg/qugdSUlLnOg==
=9ABw
-----END PGP SIGNATURE-----

--0p3EEgCnBt7M6rub--
