From: Mickael Marchand <marchand@kde.org>
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Fri, 12 Dec 2003 01:07:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200312120107.55031.marchand@kde.org>
References: <20031203204445.GA26987@gtf.org> <200312091954.28224.marchand@kde.org> <200312092114.47241.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200312092114.47241.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

if anyone is able to tell me how to find the io address of the SATA por=
ts I=20
could make this patch support the 4 drives of Sil3114 (only the 2 first=
 are=20
working atm).
As I really don't know how to find this, I prefer ask to the kernel exp=
erts ;)
Once I have this info, making the patch is a matter of a few minutes I =
think

I tried looking at lspci/scanpci outputs but could not really find any =
usefull=20
informations recording io ports.

Cheers,
Mik

Le Tuesday 09 December 2003 21:14, Bartlomiej Zolnierkiewicz a =E9crit =
:
> On Tuesday 09 of December 2003 19:54, Mickael Marchand wrote:
> > the attached patch makes _both_ drivers work (whereas the previous =
one
> > made only the libata one working)
>
> Great!  Now I know it is really working.
>
> I've already corrected your previous patch and included it in -bart1 =
patch:
> http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1=
/broke
>n-out/ide-siimage-sil3114.patch
>
> Yes, I forgot to send you corrected patch, sorry. :-)
>
> --bart
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2QbVyOYzc4nQ8j0RAhO/AJ9bm0gJ7uwGlKquhXaIYm1GMRBVWQCdGPwn
wbQskwDqvS7PI54zTefPquM=3D
=3Dp1UV
-----END PGP SIGNATURE-----
