From: Joerg Dorchain <joerg@dorchain.net>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Mon, 14 Feb 2011 08:41:36 +0100
Message-ID: <20110214074136.GH5778@Redstar.dorchain.net>
References: <20110209115929.GS5778@Redstar.dorchain.net>
 <4D528F00.1090000@ru.mvista.com>
 <20110210192321.GB5778@Redstar.dorchain.net>
 <4D552B18.8030808@ru.mvista.com>
 <20110211173620.GF5778@Redstar.dorchain.net>
 <4D55A0FE.30505@ru.mvista.com>
 <20110212062701.GG5778@Redstar.dorchain.net>
 <AANLkTimb3+yk2O2gFVi5_FB-rmf78h-ZRE6a7_KR_dkc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pa4xkLBhPDIhDLv1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:46155 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab1BNHlt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2011 02:41:49 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimb3+yk2O2gFVi5_FB-rmf78h-ZRE6a7_KR_dkc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org


--Pa4xkLBhPDIhDLv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 12, 2011 at 01:09:37PM +0100, Bartlomiej Zolnierkiewicz wrote:
>=20
> > The second part just makes sure that the config space change is
> > kept after a resume. Otherwise it comes up as a different PCI
> > id, the AHCI driver finds nothing to work with, the harddisk is
> > gone after resume, not good.
>=20
> Shouldn't therefore the quirk be applied also during resume (by
> additional use of DECLARE_PCI_FIXUP_RESUME_EARLY in addition to
> existing DECLARE_PCI_FIXUP_EARLY one)?

I have considered that, but just not touching the config space
for having the desired effect seems easier to me.

Actually this is a reason why I am looking for feedback from
other people with the chipsets listed in the patch. Is it only my
system for keeps pci config during suspend/resume or does it work
for others, too?
On the other hand, if I understand Sergei correctly, it could be
a more general effect with it, which is why I'd also appreciated
some review from an architectural perspective.

If not, DECLARE_PCI_FIXUP_RESUME_EARLY is fine with me. My main
objective is to use the ahci driver, and I hope others like to do
so as well.

Bye,

Joerg

--Pa4xkLBhPDIhDLv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHcEARECADcFAk1Y3LAwFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zg6YoAnRKCVcmSJWeNuKW1PGoYAJ52
+48qAJwJpdyzCP16M7z2VgL0zVUIAgfvfQ==
=CHYb
-----END PGP SIGNATURE-----

--Pa4xkLBhPDIhDLv1--
