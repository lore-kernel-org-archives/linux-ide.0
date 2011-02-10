From: Joerg Dorchain <joerg@dorchain.net>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Thu, 10 Feb 2011 20:23:21 +0100
Message-ID: <20110210192321.GB5778@Redstar.dorchain.net>
References: <20110209115929.GS5778@Redstar.dorchain.net>
 <4D528F00.1090000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:55853 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab1BJTXX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 14:23:23 -0500
Received: from Redstar.dorchain.net (localhost [127.0.0.1])
	by Redstar.dorchain.net (8.14.4/8.14.3) with ESMTP id p1AJNMjZ013470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 20:23:22 +0100
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.14.4/8.13.8/Submit) id p1AJNLS9013469
	for linux-ide@vger.kernel.org; Thu, 10 Feb 2011 20:23:21 +0100
Content-Disposition: inline
In-Reply-To: <4D528F00.1090000@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

On Wed, Feb 09, 2011 at 03:56:32PM +0300, Sergei Shtylyov wrote:
[Several formal corrections]

Should be addressed by this try.

> >The patch to ahci.c is required for suspend/resume.
>=20
>    Need a better description than thatl, I think...

Well, then it is a bit longer story.

During resume from suspend to ram, the kernel pci layer restores
the registers for the SATA controller once, then says okay, and
sets dev->state_saved =3D false. However, since the restore goes
=66rom highest address (the BARs [base address registers]) to
lowest register, some of the higher registers are set as RO
because according to the lower registers controller is in PIIX
mode.  This patch introduces a workaround for
this problem, hacking around the PCI API by setting pdev->state_saved =3D t=
rue
before we do the restore.=20

Admittingly, more testing would be welcome.


Signed-Off-By: joerg Dorchain <joerg@dorchain.net>

--- linux/drivers/pci/quirks.c.orig	2011-02-04 18:29:03.000000000 +0100
+++ linux/drivers/pci/quirks.c	2011-02-09 14:40:15.000000000 +0100
@@ -2684,6 +2684,76 @@
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
+
+	if (!ich_force_ahci_mode)
+		return;
+
+        /* ICH8 datasheet section 12.1.33 */
+        if (!pci_bus_read_config_byte(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->=
devfn), 2),
+        	ich89_address_map_reg, &amrval))
+	{
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
+++ linux/drivers/ata/ahci.c	2011-02-09 14:30:06.000000000 +0100
@@ -640,6 +640,9 @@
 	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
 	int rc;
=20
+	/* override check to see if PCI config space is already
+	 * restored in pci_restore_state */
+	pdev->state_saved =3D true;
 	rc =3D ata_pci_device_do_resume(pdev);
 	if (rc)
 		return rc;

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHcEARECADcFAk1UOykwFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zgdWQAn1VccpMmSRWIsEAzCfMI5joe
kfIsAJ4jg1Sifh8a6bsubQ/WUAAyEeVUXw==
=1ldc
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
