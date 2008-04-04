From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: libata/avr32 build failure
Date: Fri, 4 Apr 2008 21:35:59 +1100
Message-ID: <20080404213559.17f44a12.sfr@canb.auug.org.au>
References: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>
	<47F5E1A0.4060905@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__4_Apr_2008_21_35_59_+1100_+T+1_0/giAwS1_R7"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:48055 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbYDDKgI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 06:36:08 -0400
In-Reply-To: <47F5E1A0.4060905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-next@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org

--Signature=_Fri__4_Apr_2008_21_35_59_+1100_+T+1_0/giAwS1_R7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Apr 2008 04:06:56 -0400 Jeff Garzik <jeff@garzik.org> wrote:
>
> Stephen Rothwell wrote:
> >=20
> > For a while the linux-next build for avr32 defconfig (and others) has
> > been failing like this:
> >=20
> > drivers/ata/libata-core.c:127: error: 'ata_pci_default_filter' undeclar=
ed here (not in a function)
> >=20
> > It seems to be because the declaration of ata_pci_default_filter is
> > protected by CONFIG_PCI but the usage above is protected by CONFIG_ATA
> > only.
> >=20
> > Also reported by Randy Dunlap (on March 26) and Haavard Skinnemoen (on
> > March 29).
>=20
> fixed being pushed right now (patch from Tejun fixed it)

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__4_Apr_2008_21_35_59_+1100_+T+1_0/giAwS1_R7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH9gSWTgG2atn1QN8RAsldAJ9T0/jgvQrBRz+ufEib7dFFtwb3nACeLvdI
YbpxoDxibFuczgzLfPrWUyg=
=jxDk
-----END PGP SIGNATURE-----

--Signature=_Fri__4_Apr_2008_21_35_59_+1100_+T+1_0/giAwS1_R7--
