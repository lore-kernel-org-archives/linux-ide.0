From: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [PATCH] tiny patch to kill warning in drivers/ide/ide.c
Date: Tue, 8 Jun 2004 20:33:08 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040609023308.GC24042@schnapps.adilger.int>
References: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moraine.clusterfs.com ([66.246.132.190]:62604 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265508AbUFICdN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Jun 2004 22:33:13 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
List-Id: linux-ide@vger.kernel.org
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 09, 2004  03:38 +0200, Jesper Juhl wrote:
> drivers/ide/ide.c: In function `ide_unregister_subdriver':
> drivers/ide/ide.c:2216: warning: implicit declaration of function `pnpide=
_init'
>=20
> I added a simple declaration of pnpide_init to drivers/ide/ide.c
>=20
> Here's a patch against 2.6.7-rc3 - please consider including it (or if
> that's not the way to do it, then don't) :)

Better to add the declaration into a header like linux/ide.h that is
included into both ide.c and ide-pnp.c so that when/if pnpide_init()
ever changes its prototype you will get a warning during compilation.

The only good reason to have declarations within .c files is for forward
declarations of functions only used in the same file.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/goli=
nux/


--m51xatjYGsM+13rf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAxnbkpIg59Q01vtYRAn6OAJ0eCiDJUjHSkzo+idkYA5inQ1k/XACePYbV
Sxtjoht4t2NCEZpmT66naxs=
=NRLz
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
