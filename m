From: Raphael Bossek <raphael.bossek@gmx.de>
Subject: Re: Looking for support of Promise PDC40775 (SATA 300 TX2plus)
Date: Sun, 7 Aug 2005 12:09:51 +0200
Message-ID: <20050807120951.171361d7.raphael.bossek@gmx.de>
References: <20050806231016.7a4f6553.raphael.bossek@gmx.de>
	<1123406115.4303.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__7_Aug_2005_12_09_51_+0200_b.TJ3dm42pUzSBO4"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:22500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751396AbVHGKJ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Aug 2005 06:09:58 -0400
In-Reply-To: <1123406115.4303.0.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

--Signature=_Sun__7_Aug_2005_12_09_51_+0200_b.TJ3dm42pUzSBO4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 07 Aug 2005 11:15:15 +0200 Erik Slagter <erik@slagter.name>
wrote:

> > I'm looking for 2.6 support of this kind of Promise controller.
> > Is there any progress ongoing to support this kind of hardware
> > with SATA and PATA conectors?
> > Promise released GPL source code Linux 2.4 driver for this
> > controllers
> >=20
> > PDC40518        Promise SATAII150 TX4
> > PDC20575        Promise SATAII150 TX2plus
>   ^^^^^^^^
>=20
> I have this one working. It's as simple as adding the PCI id.
If I understand the implementation of sata_promise.c you extended
the pdc_ata_pci_tbl array. Which board do you seletected?
 1. board_2037x
 2. board_20319
 3. board_20619

--=20
Raphael Bossek

--Signature=_Sun__7_Aug_2005_12_09_51_+0200_b.TJ3dm42pUzSBO4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC9d3yN2lBq4Nesv8RAgksAJ9l3Td0cL/eBQ0TVG7kIcs6lRF/IwCcC2Jq
QsptkjQ9U50OhYKVDmaRzzU=
=q0sS
-----END PGP SIGNATURE-----

--Signature=_Sun__7_Aug_2005_12_09_51_+0200_b.TJ3dm42pUzSBO4--
