From: =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@dsg.to>
Subject: HighPoint RocketRAID 2320
Date: Mon, 3 Aug 2009 20:18:36 +0000
Message-ID: <20090803201836.GD13863@dsg.to>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dsg.to ([79.171.98.146]:43387 "EHLO gozer.dsg.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbZHCU2b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 16:28:31 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm throwing this out here in the hopes that someone smarter than me has
a simple solution - never hurts to be optimistic. :)

I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA fakeraid).=
 It is only supported by an ugly binary blob deceptively labeled as an "ope=
n source driver" from HighPoint (rr232x). Looking at the wrapper around the=
 blob, it seems this driver claims only the 2320 and 2322 controllers:

static const struct pci_device_id hpt_pci_tbl[] =3D {
        {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
        {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
        {}
};

I've found that this controller contains a marvell 88SX6081 chip, which
should be supported by the sata_mv driver. That driver claims device IDs
2300 and 2310:
        { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
        { PCI_VDEVICE(TTI, 0x2310), chip_7042 },

So, ever hopeful, I tried adding the 2320 into the table:
        { PCI_VDEVICE(TTI, 0x2320), chip_608x },

When I do this, the kernel successfully probes the attached disks and
their capacity, but immediately errors out and starts resetting the
ports repeatedly.

I've attached a dmesg output. I can provide any further debugging info
or try different things.

I've tried defining the controller with chip_6042, chip_604x and
chip_7042 with no success.

PS: Please CC me on replies, as I'm not subscribed to linux-ide.

Kind regards,

--=20
Dav=ED=F0 Steinn Geirsson
david@dsg.to

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKd0Yc1zX4pjkhuygRAnwLAKCNQthz8gCI8tU8EqkzKxjiJQgL5gCfWIDK
1kHVhZ/pqXTmp41ZVtaeDeY=
=rpBP
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
