From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 16:48:34 +0100
Message-ID: <20140114154834.GD32507@kw.sim.vm.gnt>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140114151404.GN19878@titan.lakedaemon.net>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> Simon,
>=20
> On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> > Hello,
> >=20
> > This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> > SoCs: once a disk is removed from a SATA port, then the re-plug events
> > are not detected by the sata_mv driver.
> >=20
> > This should be applied to the -stable kernels 3.10 and onwards.=20
>=20
> Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
> tags.  It looks like the sata_mv binding and the Armada 370 DT booting
> were both introduced in v3.6, so I would probably use:
>=20
> Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and Arma=
da XP with DT)

Hi Jason,

I am not comfortable with this "Fixes: commit_id" notation. It states
that the patch fixes a regression introduced by a given commit. This
hardly makes sense to me because obviously the hotplug issue has not
been introduced by:

"arm: mach-mvebu: add support for Armada 370 and Armada XP with DT".

I know that the purpose is purely administrative, but it is kind of
weird...

>=20
> Is there a specific reason you say v3.10?

I could have said nothing as well.

As stable kernel older than 3.10 are no longer maintained, I think
we don't need to point out a specific commit as a -stable target.
Simply Cc'ing -stable without any extra informations should be good
enough.

>=20
> Once you've incorporated Gregory's comments,
>=20
> Acked-by: Jason Cooper <jason@lakedaemon.net>

OK.

Thanks,

Simon

>=20
> > Lior Amsalem (1):
> >   ata: sata_mv: fix disk hotplug for Armada 370/XP SoCs
> >=20
> > Simon Guinot (2):
> >   ata: sata_mv: introduce compatible string "marvell,armada-370-xp-sata"
> >   ARM: mvebu: update the SATA compatible string for Armada 370/XP
> >=20
> >  Documentation/devicetree/bindings/ata/marvell.txt |  2 +-
> >  arch/arm/boot/dts/armada-370-xp.dtsi              |  2 +-
> >  drivers/ata/sata_mv.c                             | 25 +++++++++++++++=
++++++++
> >  3 files changed, 27 insertions(+), 2 deletions(-)
>=20
> Tejun,
>=20
> I see no point to breaking up this series only to have both pieces end
> up in stable.  Are you ok with taking the whole thing?
>=20
> thx,
>=20
> Jason.

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlLVXFIACgkQgtp0PDeOcDpyhQCfdDv/glb8+ZmADHTzON0i/Mhp
mzoAoKSuD16sY38xdC7OGluTqxrlQdiq
=Cn2e
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
