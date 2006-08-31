From: Mathias Jeschke <jeschke@informatik.hu-berlin.de>
Subject: AHCI driver with ASUS P5B
Date: Thu, 31 Aug 2006 21:32:25 +0200
Message-ID: <20060831193225.GA10312@mail.majes.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from berlin.zq1.de ([85.25.132.119]:8461 "EHLO mail.majes.de")
	by vger.kernel.org with ESMTP id S932316AbWHaTca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Aug 2006 15:32:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jeff,

first thank you for your great job on the AHCI linux kernel driver.

I have a problem with the detection of 2 of my 4 SATA ports on the
mainboard (a P5B one), since ASUS implemented the last two as port 4 and 5
(started by zero) - so port 2 and 3 are physically unused.

Your driver reads a value of "4" and initializes only the first 4 ports
and so ports 4 and 5 become unusable.

So I have a suggestion to support some boards with "incorrect" ports value
in the controller register:
  Add an extra kernel parameter (e.g. "ahci=3D<nr_of_ports>") and override
  these "autodetection" if such a kernel paramter is given.

I added a patch file, which implements this feature.

Regards,
Mathias

--=20
Mathias Jeschke
home: http://www.informatik.hu-berlin.de/~jeschke/
mail: jeschke@informatik.hu-berlin.de
gpg fingerprint: CF50 E22C 50F4 AF70 9628  7AB9 7E10 3A60 EAE5 4729

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ahci-ports.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.17.11.orig/drivers/scsi/ahci.c	2006-08-31 12:54:06.000000000 =
+0200
+++ linux-2.6.17.11/drivers/scsi/ahci.c	2006-08-31 21:12:40.000000000 +0200
@@ -201,6 +201,7 @@
 static u8 ahci_check_status(struct ata_port *ap);
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cm=
d *qc);
 static void ahci_remove_one (struct pci_dev *pdev);
+static u8 sata_phy_ports;
=20
 static struct scsi_host_template ahci_sht =3D {
 	.module			=3D THIS_MODULE,
@@ -1015,7 +1016,8 @@
=20
 	hpriv->cap =3D readl(mmio + HOST_CAP);
 	hpriv->port_map =3D readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports =3D (hpriv->cap & 0x1f) + 3;
+	probe_ent->n_ports =3D sata_phy_ports ? sata_phy_ports : (hpriv->cap & 0x=
1f) + 1;
+	dev_printk(KERN_INFO, &pdev->dev, "override autodetection, use kernel par=
amter: ports=3D%u\n", sata_phy_ports);
=20
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
 		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
@@ -1347,3 +1349,19 @@
=20
 module_init(ahci_init);
 module_exit(ahci_exit);
+
+#if !defined(MODULE)
+static int __init ahci_setup(char *str)
+{
+    int ints[2];
+   =20
+	get_options(str, ARRAY_SIZE(ints), ints);
+	if (ints[0] =3D=3D 1)
+		sata_phy_ports =3D ints[1];
+
+	return 0;
+}
+
+__setup("ahci=3D", ahci_setup);
+#endif
+

--BXVAT5kNtrzKuDFl--

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE9zlJfhA6YOrlRykRAjuDAKDFbXS8BPKEIdcaPeeliouqkBRzdgCgkUtd
f7J0rl7CFkFpcCeFSWfAxdw=
=DfvE
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
