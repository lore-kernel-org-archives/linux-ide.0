From: Joerg Dorchain <joerg@dorchain.net>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Thu, 17 Feb 2011 19:09:39 +0100
Message-ID: <20110217180939.GT5778@Redstar.dorchain.net>
References: <20110216090548.GQ5778@Redstar.dorchain.net>
 <20110217100330.GO19830@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9CzcV6dAFIr7O1Ie"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from RedStar.dorchain.net ([212.88.133.153]:37650 "EHLO
	Redstar.dorchain.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757448Ab1BQSJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 13:09:54 -0500
Content-Disposition: inline
In-Reply-To: <20110217100330.GO19830@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


--9CzcV6dAFIr7O1Ie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2011 at 11:03:30AM +0100, Tejun Heo wrote:
>=20
> I'm not particularly inclined toward including this patch in upstream
> as long as it can't be enabled by default.  It's just gonna be an
> extra piece of code to carry around which only a handful of people use
> and nobody really knows on which hardware it works or not and to what
> extent.

I have a feedback for the chipsets listed in the patch. The
protection via the extra parameter is owned to the fact that
intel recommends against the OS doing this. Quote: "SW shall not
manipulate SMS during runtime operation; that is, the OS will not
do this." I would not see early fixup as runtime, however, better
save than sorry.

Advantages are better performance and lower power consumption.

I don't wanna break anybody's data with that patch, hence the
precaution.

Bye,

Joerg

--9CzcV6dAFIr7O1Ie
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iHcEARECADcFAk1dZGMwFIAAAAAAFQAScGthLWFkZHJlc3NAZ251cGcub3Jnam9l
cmdAZG9yY2hhaW4ubmV0AAoJEI2OPuD3c7zgn0sAn0vDFwX0VYVicOI9Meg3Pl9K
zOoMAJ0XNhuJ/YUNgyVoKXWTvFLDU5XX2g==
=PWCf
-----END PGP SIGNATURE-----

--9CzcV6dAFIr7O1Ie--
