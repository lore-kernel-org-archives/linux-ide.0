From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: sata_sil24 performance weirdness
Date: Thu, 28 Dec 2006 03:34:46 -0800
Message-ID: <20061228113446.GI28939@curie-int.orbis-terrarum.net>
References: <20061227134503.GD28939@curie-int.orbis-terrarum.net> <45934018.4090005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:33028 "EHLO mail.isohunt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753249AbWL1Ler (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Dec 2006 06:34:47 -0500
Content-Disposition: inline
In-Reply-To: <45934018.4090005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2006 at 12:55:04PM +0900, Tejun Heo wrote:
> Robin H. Johnson wrote:
> > I forward-ported Tejun's PMP patches to libata#upstream (my first attem=
pt at it
> > a few weeks ago failed, but this round works fine, tested at each branch
> > stage), and in using them, I have noticed a bit of oddity.
>=20
> Great, care to share them?
I don't have a machine with sufficient bandwidth to host a git, so it's jus=
t exported patches.

Complete set here:
http://dev.gentoo.org/~robbat2/libata-development/

Naming convention:
$XX_$BRANCH_$YYYY_$PATCHNAME

XX =3D branch sequence number
BRANCH =3D branch name, as used by Tejun in his git repo (hp-poll, vt8251-a=
hci, link, pmp-prep, pmp)
YYYY =3D patch sequence number

There are also 5 tarballs, containing all of the patches for that branch.

00_hp-poll_0000ALL.tar.gz
01-vt8251-ahci_0000ALL.tar.gz
02_link_0000ALL.tar.gz
03_pmp-prep_0000ALL.tar.gz
04-pmp_0000ALL.tar.gz

--=20
Robin Hugh Johnson
Gentoo Linux Developer
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6-ecc01.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFk6vWPpIsIjIzwiwRAsXJAJ9UBnmAp3+1WTAPOsy236IpBAO88wCff8xm
9PZ0A5/i40gYBTImCVaVcTM=
=Tvj9
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
