From: Joerg Dorchain <joerg@dorchain.net>
Subject: Re: [Patch] Enable AHCI on certain ich chipsets
Date: Sat, 12 Feb 2011 07:27:01 +0100
Message-ID: <20110212062701.GG5778@Redstar.dorchain.net>
References: <20110209115929.GS5778@Redstar.dorchain.net>
 <4D528F00.1090000@ru.mvista.com>
 <20110210192321.GB5778@Redstar.dorchain.net>
 <4D552B18.8030808@ru.mvista.com>
 <20110211173620.GF5778@Redstar.dorchain.net>
 <4D55A0FE.30505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hnpg0BSo5EvPlUVi"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:56680 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539Ab1BLG1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Feb 2011 01:27:13 -0500
Content-Disposition: inline
In-Reply-To: <4D55A0FE.30505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-ide@vger.kernel.org


--Hnpg0BSo5EvPlUVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2011 at 11:50:06PM +0300, Sergei Shtylyov wrote:
>=20
> >Well, the functionality of the patch to quirks.c is described in
> >the comments on the top of it. Should that be repeated?
>=20
>    Yes, certainly.

Ok, will do so.
>=20
> >>And looks like it
> >>should be in a patch of its own...
>=20
> >I need both parts in order to use the AHCI driver and having
> >suspend/resume work, hence they are together.
>=20
>=20
> They are solving two different issues, as far as I understand, hence
> should be in two different patches. One issue per patch is the basic
> rule.

Here I am not sure. Suspend/resume works fine (for me) without
any of the patches. The first patch fiddles with pci config space
in order to achieve something that  which should be done by the
BIOS, hence it is in quirks, together with other workarounds.

The second part just makes sure that the config space change is
kept after a resume. Otherwise it comes up as a different PCI
id, the AHCI driver finds nothing to work with, the harddisk is
gone after resume, not good.

You could also see it as it triggers a general fault, and
should be fixed anyway indepent of the trigger case.

Whereas I am quite sure about the quirks part, I'd be glad for
some functional review of the ahci part, to avoid undesired side
effects.
>=20
>=20
> scripts/checkpatch.pl -- it notices such style violations.

Thank you for that hint.

Bye,

Joerg

--Hnpg0BSo5EvPlUVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHcEARECADcFAk1WKDUwFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zgt4IAnjjoodQqDg+dvDbHzFOi85RY
gOy4AJsH+oKhdp5FQIxJiBVU/WQPW/R5yA==
=3ElV
-----END PGP SIGNATURE-----

--Hnpg0BSo5EvPlUVi--
