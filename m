From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: PMP patches for more recent kernel?
Date: Fri, 23 Feb 2007 17:45:36 -0800
Message-ID: <20070224014536.GN17741@curie-int.orbis-terrarum.net>
References: <45DF92B1.6040001@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:42726 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932738AbXBXBpY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 20:45:24 -0500
Content-Disposition: inline
In-Reply-To: <45DF92B1.6040001@drzeus.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2007 at 02:19:45AM +0100, Pierre Ossman wrote:
> I'm eager to test out your PMP patches as I'm currently sitting on a SATA=
 disk
> rack that requires a PMP to be used. Your current set is from october tho=
ugh and
> seems to require some work to get to apply on the current kernel. Do you =
have
> something newer I can play with?
I'm going to answer this question, because I'm getting 3-4 emails a week
now since I did the previous port of the PMP patches to 2.6.20rc2.

This was my previous instructional email.
http://www.mail-archive.com/linux-ide@vger.kernel.org/msg02533.html

That set of patches is intended for applying against the Linus GIT tree
as of approximately 2.6.20rc2, combined with the libata#upstream tree of
the same vintage.

They do NOT apply to anything newer, and definite work is needed in
porting them. I don't have time for such porting at present, so unless
somebody else ports them, I don't see them moving very fast at all.

Things would probably go much smooth if the hp_poll and ata_link stuff
got into jgarzik's tree, but I don't know when he will accept them.

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFF35jAPpIsIjIzwiwRAnGMAKDTEb0l1tbZcJEJVJHjmqWjsLLz9QCg2Oxb
qC4TYKbaQNzeu4Bsib4yyIM=
=uZ0T
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--
