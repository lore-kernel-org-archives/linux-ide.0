From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Subject: Re: Update on problems creating iteraid driver disk
Date: Sun, 25 Apr 2004 12:49:41 +0200
Sender: fedora-devel-list-bounces@redhat.com
Message-ID: <1082890181.24757.12.camel@m64.net81-64-154.noos.fr>
References: <408B270C.1050201@gear.dyndns.org>
Reply-To: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2096558496=="
Return-path: <fedora-devel-list-bounces@redhat.com>
In-Reply-To: <408B270C.1050201@gear.dyndns.org>
List-Unsubscribe: <http://www.redhat.com/mailman/listinfo/fedora-devel-list>,
	<mailto:fedora-devel-list-request@redhat.com?subject=unsubscribe>
List-Archive: </archives/fedora-devel-list>
List-Post: <mailto:fedora-devel-list@redhat.com>
List-Help: <mailto:fedora-devel-list-request@redhat.com?subject=help>
List-Subscribe: <http://www.redhat.com/mailman/listinfo/fedora-devel-list>,
	<mailto:fedora-devel-list-request@redhat.com?subject=subscribe>
Errors-To: fedora-devel-list-bounces@redhat.com
To: fedora-devel-list@redhat.com
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, fedora-list@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--===============2096558496==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3EbmLpPfBK9QRKJgE0CB"


--=-3EbmLpPfBK9QRKJgE0CB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le dim, 25/04/2004 =C3=A0 12:48 +1000, Paul Gear a =C3=A9crit :
> Hi folks,
>=20
> A while back i posted about trying to create iteraid driver disks for
> FC1.  With the help of David Kewley's instructions
> (http://www.klab.caltech.edu/~kewley/driverdisk/dd.html) on using Doug
> Ledford's driver kit (http://people.redhat.com/dledford/), i managed to
> create a proper driver disk.

Frankly if you really want to bother with ite hardware (the SII680 is
available here for the same price and is perfectly supported under
Linux) you should focus on getting their driver inside the kernel.org
sources.

ie make diffs, submit them to LKM, make the changes people request, etc
(ite is GPLed if  I remember well).

This may seem more difficult but remember the kernel is a moving
target : after six months you'll have spent more energy getting this
out-of-tree driver work than getting it in-tree now.

Cheers,

--=20
Nicolas Mailhot

--=-3EbmLpPfBK9QRKJgE0CB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAi5fFI2bVKDsp8g0RAmKfAJ4iX2VybOQ4g/OKpmx3d2SKqiu9mgCgjK81
Mq6K2eTno5hDGasiMqODJa4=
=TFWx
-----END PGP SIGNATURE-----

--=-3EbmLpPfBK9QRKJgE0CB--



--===============2096558496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
fedora-devel-list mailing list
fedora-devel-list@redhat.com
http://www.redhat.com/mailman/listinfo/fedora-devel-list

--===============2096558496==--
