From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: piix vs ata_piix device ID tables
Date: Mon, 04 Oct 2010 21:09:10 +0100
Message-ID: <1286222950.3916.327.camel@localhost>
References: <1286164252.3916.312.camel@localhost>
	 <20101004102145.2f34cc62@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-aC7rwZfpyruF5xw4tN8o"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55547 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753945Ab0JDUJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Oct 2010 16:09:24 -0400
In-Reply-To: <20101004102145.2f34cc62@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: David Miller <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


--=-aC7rwZfpyruF5xw4tN8o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-10-04 at 10:21 +0100, Alan Cox wrote:
> On Mon, 04 Oct 2010 04:50:52 +0100
> Ben Hutchings <ben@decadent.org.uk> wrote:
[...]
> > PCI_DEVICE_ID_INTEL_82801DB_1 =3D=3D 0x24c1 (ICH4 device 31 function 1)
> >=20
> > piix seems to treat this the same as most other ICH PATA interfaces,
> > which are handled by ata_piix.
> >=20
> > Does anyone know why these aren't handled by the libata-based drivers?
>=20
> I don't know about 0x24C1 however it isn't listed in the Intel ICH
> programming manual so given we've also had no reports about it I
> suspect it's an error in the PIIX driver ?

Correction, this is a function of the ICH4-L not the ordinary ICH4.  It
is documented in
<http://www.intel.com/assets/pdf/specupdate/290745.pdf>.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-aC7rwZfpyruF5xw4tN8o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATKo0YOe/yOyVhhEJAQI+VQ/9HwKH20V0MMqNonl5hxab6ueBCzcLRYxt
KQoz48IuKxNbFX9C3+ZoYqu5dW3Ui+IpReNtriZSWCtvfYW9t2qhe4R1s2gZDchM
F0Z/w6PlN7DunBmJScXj7O1GbyFRLQi+6Q8RiFqS17qm6Of+rPbgDUaMK4ojNErQ
AthWsa4cZEOUriUZcJ7E7CpWrJ4C7QRlo7FcbVFWeXkYcbq0xMBvBwI6NtGlQBI8
Emoiao2cDTN2bYugNgdRfstE1mL5siRd3w8m/aGQA7e3pjP8ifETNDK04SD1cGVg
kb8tMny7mODnG6tQVNKEIkkC2v848z4WzgIloHvFhrkhqTFyMeckgl+5bZOWixRU
3MLuSULTORbJPHe3uXAvEX5AB9AIt1Q3LJxgtzuXUPvm0JTsvnChAWr73XajRiG+
G6rEy92BBjSFqqasGfsWKyNERkgmiv1olpWG0A9UCSaO69zR5RJlQ7yZil/8zLpc
W5TRg6ARueaAARUgfDimrRWj8NHIpnXaez5jxz04TB1/+BY6Gy2rzukMf7pV4m/i
B/mvEY1sSJQcRXGoOfRROTQgeGajTBVsRO953bpY4muWP2YF00lNImPlnfSXcCQn
2Gq90L7ffDTMn3jUYlKMvkAIehbn8jwDN7cn+5VTshzgqDBKaSDOZRUbJmXo+PR0
8MNogWwx9uY=
=KzY8
-----END PGP SIGNATURE-----

--=-aC7rwZfpyruF5xw4tN8o--
