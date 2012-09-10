From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH RESEND] ahci: Add JMicron 362 device IDs
Date: Mon, 10 Sep 2012 02:06:03 +0100
Message-ID: <1347239163.5134.40.camel@deadeye.wl.decadent.org.uk>
References: <1347235744.5134.14.camel@deadeye.wl.decadent.org.uk>
	 <20120910003850.GA158@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-XjP5Z4aFDej2/1TSkp7W"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52436 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753300Ab2IJBGQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2012 21:06:16 -0400
In-Reply-To: <20120910003850.GA158@mannheim-rule.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>


--=-XjP5Z4aFDej2/1TSkp7W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2012-09-09 at 17:39 -0700, Jonathan Nieder wrote:
> Hi,
>=20
> Ben Hutchings wrote:
>=20
> > The JMicron JMB362 controller supports AHCI only, but some revisions
> > use the IDE class code.  These need to be matched by device ID.
> [...]
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> [...]
> >  drivers/ata/ahci.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> [...]
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -263,6 +263,9 @@ static const struct pci_device_id ahci_pci_tbl[] =
=3D {
> >  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
> >  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> >  	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
> > +	/* JMicron 362B and 362C have an AHCI function with IDE class code */
> > +	{ PCI_VDEVICE(JMICRON, 0x2362), board_ahci_ign_iferr },
> > +	{ PCI_VDEVICE(JMICRON, 0x236f), board_ahci_ign_iferr },
>=20
> Should this go to stable kernels as well?

I suppose so, yes.

Ben.

--=20
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert=
.

--=-XjP5Z4aFDej2/1TSkp7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUE08++e/yOyVhhEJAQrW6xAAzUzmlQ/tdG0LPWtLX1Czpi9lwhpeEkTT
zAxXSEv+qFRFML81WRZMO/Sw0SOt4aFTNpwP8VjWWiP4zyeGuNdou0k3myOhO1hk
AWV8YUtjJ8HE7PkzS7yJuKJz9SO4FtuqOKfd38oLizQkI8mL94MXYnn2Yql6Dilc
LnYNajC9DBzsc/S34QJZI2q9ZwLLX9pvxWWUs8aEDws+TlzFduQY2q52sbD0GPwv
5QCxo06FeUdd4857wTX0xXVQhMLjsFbAahV7aOj8WLv/QcS2IrPfrP1aVhrCUb3c
tp5oTdj2pDU4tJCxnf/ePWBTBpZJsMFiVyxTZcPEKGiABNekW88TFNw5EvwAt7dC
un11Y6oBo+VnhYcwbviKs8XWVW4oUGNDKRS3ldj/hvA3JCBDpVcPIJeek/K0McIn
Hp2ZB3a1qRTrAOWy9JVeGYgOHskPY6CNf3x4XyGABXng8DoeD3TqPvzxI5Ie0sTO
eg+rbcDfMLcncT7BTamBEFQRBrW3KAtzAbbqDqEKG5JRC0f4aX1kyQh1iICAiI9D
m6NZ1aqvYz6UXSz4xprjHzxByZxsT1y/ap9GQNYccAQavirRA+3H54WoeBbgwoez
m77uhlHjDRLxZLsobYZdvk/xPJZ26xJnaiHrXVrOa+X7hbn5dchhWRAn7GSypQFk
OVUr8Rc4s0Y=
=PNp9
-----END PGP SIGNATURE-----

--=-XjP5Z4aFDej2/1TSkp7W--
