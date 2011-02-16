From: Joerg Dorchain <joerg@dorchain.net>
Subject: [Patch] Make suspend/resume work with ich chipset in force AHCI
 mode
Date: Wed, 16 Feb 2011 10:07:09 +0100
Message-ID: <20110216090709.GR5778@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjLo8P/CG6vpADRe"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:50395 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737Ab1BPJHL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2011 04:07:11 -0500
Received: from Redstar.dorchain.net (localhost [127.0.0.1])
	by Redstar.dorchain.net (8.14.4/8.14.3) with ESMTP id p1G9796X019809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 16 Feb 2011 10:07:09 +0100
Received: (from joerg@localhost)
	by Redstar.dorchain.net (8.14.4/8.13.8/Submit) id p1G979TK019808
	for linux-ide@vger.kernel.org; Wed, 16 Feb 2011 10:07:09 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--PjLo8P/CG6vpADRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

this patch in needed in addition to the previous one make
suspend/resume work in the forced ahci mode.

During resume from suspend to ram, the kernel pci layer restores
the registers for the SATA controller once, then says okay, and
sets dev->state_saved =3D false. However, since the restore goes
=66rom highest address (the BARs [base address registers]) to
lowest register, some of the higher registers are set as RO
because according to the lower registers controller is in PIIX
mode.  This patch introduces a workaround for
this problem, hacking around the PCI API by setting
pdev->state_saved =3D true
before we do the restore, basically leaving the pci config space
untouched.

Bye,

Joerg


Signed-off-by: joerg Dorchain<joerg@dorchain.net>

--- linux/drivers/ata/ahci.c.orig	2011-02-04 18:13:33.000000000 +0100
+++ linux/drivers/ata/ahci.c	2011-02-11 13:45:22.000000000 +0100
@@ -640,6 +640,11 @@
 	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
 	int rc;
=20
+	/*
+	 * override check to see if PCI config space is already
+	 * restored in pci_restore_state
+	 */
+	pdev->state_saved =3D true;
 	rc =3D ata_pci_device_do_resume(pdev);
 	if (rc)
 		return rc;

--PjLo8P/CG6vpADRe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHYEARECADcFAk1bk70wFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zgB0kAl0kBTclxVGXod2knhrOrWkxY
AXcAn3ky0cON00UYwRRPgLr/yG9/Kk8r
=G7Pp
-----END PGP SIGNATURE-----

--PjLo8P/CG6vpADRe--
