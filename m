From: Simon Guinot <simon.guinot@sequanux.org>
Subject: Re: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Wed, 15 Jan 2014 00:15:35 +0100
Message-ID: <20140114231535.GA3863@kw.sim.vm.gnt>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114154834.GD32507@kw.sim.vm.gnt>
 <20140114155945.GQ19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140114155945.GQ19878@titan.lakedaemon.net>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 10:59:45AM -0500, Jason Cooper wrote:
> Simon,
>=20
> On Tue, Jan 14, 2014 at 04:48:34PM +0100, Simon Guinot wrote:
> > On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> > > Simon,
> > >=20
> > > On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> > > > Hello,
> > > >=20
> > > > This patch series fixes a SATA disk hotplug issue for the Armada 37=
0/XP
> > > > SoCs: once a disk is removed from a SATA port, then the re-plug eve=
nts
> > > > are not detected by the sata_mv driver.
> > > >=20
> > > > This should be applied to the -stable kernels 3.10 and onwards.=20
> > >=20
> > > Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
> > > tags.  It looks like the sata_mv binding and the Armada 370 DT booting
> > > were both introduced in v3.6, so I would probably use:
> > >=20
> > > Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and =
Armada XP with DT)
> >=20
> > Hi Jason,
> >=20
> > I am not comfortable with this "Fixes: commit_id" notation. It states
> > that the patch fixes a regression introduced by a given commit. This
> > hardly makes sense to me because obviously the hotplug issue has not
> > been introduced by:
> >=20
> > "arm: mach-mvebu: add support for Armada 370 and Armada XP with DT".
> >=20
> > I know that the purpose is purely administrative, but it is kind of
> > weird...
>=20
> True, the wording may not be the best, but the goal is to make it easier
> to do a 'tag --contains' search.  We could call it
>=20
> Repair-Something-Broken-Since-Introduced-by:
>=20
> in this case ;-)
>=20
> > > Is there a specific reason you say v3.10?
> >=20
> > I could have said nothing as well.
> >=20
> > As stable kernel older than 3.10 are no longer maintained, I think
> > we don't need to point out a specific commit as a -stable target.
> > Simply Cc'ing -stable without any extra informations should be good
> > enough.
>=20
> The reason I ask is that I'd like to know if, in debugging this issue,
> you discovered that the fix was not needed before v3.10 (hypothetically,
> say because sata hotplug was added in v3.10).
>=20
> The linux-stable team isn't the only people who find this information
> useful.  Distros maintaining older kernels would find it very helpful
> when going through -stable patches to know easily if a patch should be
> backported further, say to v3.8.

The patches may effectively apply against a 3.6 kernel but who is going
to embed a such kernel on an Armada-based board ?

IMO, stabilize the Armada support for kernels older than 3.10 is a waste
of time, for you, for the -stable maintainers and for me. Some important
features (for Armada SoCs) are missing on this kernels. Then I don't
think that someone is going to use a kernel older than 3.10 with an
Armada-based board.

But anyway, it is not up to me and I have hopefully added all the needed
-stable informations to the v3 patch series.

Simon

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlLVxRcACgkQgtp0PDeOcDpxyACfdL7qkXKSammTvReY8uSv28vH
7lAAoIsVwMImtE5Xz+oCvYN6yxgXwmOw
=v4Hc
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
