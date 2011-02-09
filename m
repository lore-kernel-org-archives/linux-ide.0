From: Joerg Dorchain <joerg@dorchain.net>
Subject: [Patch] Enable AHCI on certain ich chipsets
Date: Wed, 9 Feb 2011 12:59:29 +0100
Message-ID: <20110209115929.GS5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:43675 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab1BIMH0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 07:07:26 -0500
Received: from Redstar.dorchain.net (localhost [127.0.0.1])
	by Redstar.dorchain.net (8.14.4/8.14.3) with ESMTP id p19BxTTR007781
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 9 Feb 2011 12:59:29 +0100
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.14.4/8.13.8/Submit) id p19BxT7Y007780
	for linux-ide@vger.kernel.org; Wed, 9 Feb 2011 12:59:29 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

Disclaimer: this patch is based on http://mjg59.livejournal.com/85504.html
It is in works-for-me state.

The patch to ahci.c is required for suspend/resume.

Signed-Off-By: joerg Dorchain <joerg@dorchain.net>

--- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
+++ linux/drivers/pci/quirks.c	2011-02-09 11:16:36.000000000 +0100
@@ -2684,6 +2684,79 @@
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
+static bool ich_force_ahci_mode =3D false;
+static bool ich_ahci_mode_forced =3D false;
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
+        u8 amrval;
+        u8 sclkgc;
+        const int ich89_address_map_reg =3D 0x90;
+        const int ich89_sata_clock_gen_config_reg =3D 0x9c;
+        /* const u32 ich89_func_disable_reg_offset =3D 0x3418; */
+
+	if (!ich_force_ahci_mode)
+		return;
+
+        /* ICH8 datasheet section 12.1.33 */
+        if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->=
devfn), 2),
+                                ich89_address_map_reg, &amrval))
+{
+                if (amrval & (BIT(6) | BIT(7))) {
+                        dev_printk(KERN_DEBUG, &pdev->dev,
+                                        "ICH7/8/9 SATA controller not in I=
DE mode.  Not modifying.\n");
+                        return;
+                }
+                if (amrval & (BIT(0) | BIT(1)))
+                        dev_printk(KERN_DEBUG, &pdev->dev,
+                                        "ICH7/8/9 in SATA/PATA combined mo=
de.  Untested.\n");
+                /* AHCI mode */
+                amrval |=3D BIT(6);
+                amrval &=3D ~BIT(7);
+                pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pde=
v->devfn), 2),=20
+                                ich89_sata_clock_gen_config_reg, &sclkgc);
+                dev_printk(KERN_DEBUG, &pdev->dev, "sclkgc is %#0x\n", scl=
kgc);
+                pci_bus_write_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pd=
ev->devfn), 2),=20
+                                ich89_address_map_reg, amrval);
+                ich_ahci_mode_forced =3D true;
+                dev_printk(KERN_DEBUG, &pdev->dev, "Forced ICH7/8/9 mode P=
IIX->AHCI\n");
+        }
+
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
+
+/*
  * This is a quirk for the Ricoh MMC controller found as a part of
  * some mulifunction chips.
=20
--- linux/drivers/ata/ahci.c.orig	2011-02-04 18:13:33.000000000 +0100
+++ linux/drivers/ata/ahci.c	2011-02-04 18:23:41.000000000 +0100
@@ -640,6 +640,8 @@
 	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
 	int rc;
=20
+	// override check to see if PCI config space is already restored in pci_r=
estore_state
+	pdev->state_saved =3D true;
 	rc =3D ata_pci_device_do_resume(pdev);
 	if (rc)
 		return rc;

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHcEARECADcFAk1SgaEwFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zgxCsAn0EjD943M0mvX7hSuBJtwLIB
vfBHAJ4+Vy4w1QCtrrnjGKCWQPR/s9RXiA==
=r4AO
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
