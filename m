From: Willy Gardiol <gardiol@libero.it>
Subject: Re: [2.6] system is very slow during disk access
Date: Thu, 7 Aug 2003 00:19:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200308070019.17442.gardiol@libero.it>
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062129.26371.frank.vandamme@student.kuleuven.ac.be> <200308062131.46017.fsdeveloper@yahoo.de>
Reply-To: gardiol@libero.it
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200308062131.46017.fsdeveloper@yahoo.de>
Content-Description: clearsigned data
Content-Disposition: inline
To: Michael Buesch <fsdeveloper@yahoo.de>, Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Try to unmask IRQ, this should realy help...=20
hdparm -u1 /dev/hda

I usually do on my disks:
hdparm -c1 -u1 -d1 -X69 /dev/hda
(note: use -X69 only for for an UDMA 100 or 133 drive)

> > Maybe you just didn't enable DMA on them. Use hdparm -v /dev/foo to=
 find
> > out.
>
> DMA is on.
>
> root@lfs:/home/mb> hdparm -v /dev/hda
>
> /dev/hda:
>  multcount    =3D 16 (on)
>  IO_support   =3D  1 (32-bit)
>  unmaskirq    =3D  0 (off)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D 256 (on)
>  geometry     =3D 14244/16/63, sectors =3D 80418240, start =3D 0
>
>
> root@lfs:/home/mb> hdparm -v /dev/hdc
>
> /dev/hdc:
>  multcount    =3D 16 (on)
>  IO_support   =3D  1 (32-bit)
>  unmaskirq    =3D  0 (off)
>  using_dma    =3D  1 (on)
>  keepsettings =3D  0 (off)
>  readonly     =3D  0 (off)
>  readahead    =3D 256 (on)
>  geometry     =3D 14244/16/63, sectors =3D 80418240, start =3D 0

- --=20

!=20
 Willy Gardiol - gardiol@libero.it
 gardiol.eu.org
 Use linux for your freedom.

   "La guerra non far=E0 mai finire=20
    alcuna guerra, nel migliore dei
    casi sar=E0 stata una guerra in pi=F9."

      Gino Strada, Buskash=EC

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MX7kQ9qolN/zUk4RApDfAJ9RG7HO3j1rHI/A7ZpfljJdNtzIsgCcC+PS
hQofsS2lrTLMFh4JwgzAVp4=3D
=3D0g9b
-----END PGP SIGNATURE-----
