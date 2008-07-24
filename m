From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ide: ide-cd.c blocklen is a big-endian value
Date: Fri, 25 Jul 2008 09:52:24 +1000
Message-ID: <20080725095224.f936718a.sfr@canb.auug.org.au>
References: <1216852296.30386.21.camel@brick>
	<200807242048.20087.bzolnier@gmail.com>
	<1216927017.30386.76.camel@brick>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__25_Jul_2008_09_52_24_+1000_KDF8VNT9QDM.H4hB"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1216927017.30386.76.camel@brick>
Sender: linux-next-owner@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-next <linux-next@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Michael Buesch <mb@bu3sch.de>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <petkovbb@googlemail.com>
List-Id: linux-ide@vger.kernel.org

--Signature=_Fri__25_Jul_2008_09_52_24_+1000_KDF8VNT9QDM.H4hB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Harvey,

On Thu, 24 Jul 2008 12:16:57 -0700 Harvey Harrison <harvey.harrison@gmail.c=
om> wrote:
>
> This is precisely why I'm running sparse on each linux-next, so
> no worries.

Thanks Harvey, that is a great addition to the testing.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Jul_2008_09_52_24_+1000_KDF8VNT9QDM.H4hB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiJFbgACgkQjjKRsyhoI8xTjACffbtUFrV++lZCZmJTa3wCevtm
ABAAmQFDkflO6MEDLAYqtaAau1XhnP6w
=3DPB
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Jul_2008_09_52_24_+1000_KDF8VNT9QDM.H4hB--
