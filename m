From: Willy Gardiol <willy@gardiol.org>
Subject: Re: IDE-RAID Drive Performance
Date: Wed, 31 Dec 2003 10:28:22 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312311028.36222.willy@gardiol.org>
References: <S265929AbTL3X0Z/20031230232625Z+4252@vger.kernel.org>
Reply-To: willy@gardiol.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.140.2.58] ([213.140.2.58]:45499 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S263653AbTLaJ2m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2003 04:28:42 -0500
In-Reply-To: <S265929AbTL3X0Z/20031230232625Z+4252@vger.kernel.org>
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Nicklas Bondesson <nicke@nicke.nu>, 'Mark Hahn' <hahn@physics.mcmaster.ca>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Now it sounds good!
If you are trying a raid0 please send bonnie's results for it... i am=20
interested!

bye

Alle Wednesday 31 December 2003 00:26, Nicklas Bondesson ha scritto:
> It was the PCI latency value that was wrong. It was set to 0 in the B=
IOS so
> I have changed it now to 64. I now get the following figures! :)
>
> hdparm:
>
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.12 seconds =3D114.29 MB/se=
c
>  Timing buffered disk reads:  64 MB in  1.53 seconds =3D 41.83 MB/sec
>
> bonnie:
>
> Version 1.02b       ------Sequential Output------ --Sequential Input-
> --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
> --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP=
  /sec
> %CP
> gollum         800M  4681  98 37827  76 17590  30  4888  95 39400  26=
 310.4
> 3
>                     ------Sequential Create------ --------Random
> Create--------
>                     -Create-- --Read--- -Delete-- -Create-- --Read---
> -Delete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP=
  /sec
> %CP
>                  16   310  99 +++++ +++ 21319 100   329  99 +++++ +++=
  1766
> 96
> gollum,800M,4681,98,37827,76,17590,30,4888,95,39400,26,310.4,3,16,310=
,99,++
>+ ++,+++,21319,100,329,99,+++++,+++,1766,96
>
> Thanks for the help!
>
> /Nicke
>
> -----Original Message-----
> From: Mark Hahn [mailto:hahn@physics.mcmaster.ca]
> Sent: den 30 december 2003 19:14
> To: Nicklas Bondesson
> Subject: Re: IDE-RAID Drive Performance
>
> > The disks are setup with hdparm at boot time:
>
> not normally necessary or desirable.
>
> > /dev/hda:
> >  Timing buffer-cache reads:   128 MB in  1.13 seconds =3D113.27 MB/=
sec
> >  Timing buffered disk reads:  64 MB in  2.46 seconds =3D 26.02 MB/s=
ec
>
> the 113 indicates that you're running on a fairly old/slow host.
> as such, you cannot expect to achive the full disk bandwidth, though =
you
> can probably do better than this by tweaking w/blockdev.
> it's also worth checking your bios settings (pci latency too low?)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- --=20

!=20
 Willy Gardiol - willy@gardiol.org
 www.gardiol.org
 Use linux for your freedom.

   "Cari fratelli dell'altra sponda
    cantammo in coro gi=F9 sulla terra
    amammo in cento l'identica donna
    partimmo in mille per la stessa guerra.

    Questo ricordo non vi consoli
    quando si muore si muore soli."

	(Il Testamento, Fabrizio De Andr=E8)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8pbDQ9qolN/zUk4RAj8VAJ4sI1Urzrl7BVdP939M7waBcDoXGQCcCHQp
ehyNRhY/XP4kjG9l0vtBl7g=3D
=3DyGM2
-----END PGP SIGNATURE-----

