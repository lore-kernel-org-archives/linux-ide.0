From: Palumbo Daniele <rocco@rimini.no-ip.com>
Subject: HPT370, dma timeout, raid
Date: Thu, 4 Dec 2003 04:07:12 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031204030712.GA14622@rimini.no-ip.com>
Reply-To: Palumbo Daniele <rocco@rimini.no-ip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host71-25.pool8248.interbusiness.it ([82.48.25.71]:26754 "EHLO
	rimini.no-ip.com") by vger.kernel.org with ESMTP id S261681AbTLDDHk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Dec 2003 22:07:40 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi all.
first of all: can you cc: me? i'm not in list...

am getting this problem:

Nov 18 08:57:00 data kernel: hda: dma_timer_expiry: dma status =3D=3D 0x21
Nov 18 08:57:10 data kernel: hda: 0 bytes in FIFO
Nov 18 08:57:10 data kernel: hda: timeout waiting for DMA
Nov 18 08:57:10 data kernel: hda: timeout waiting for DMA
Nov 18 08:57:10 data kernel: hda: 0 bytes in FIFO
Nov 18 08:57:10 data kernel: hda: timeout waiting for DMA
Nov 18 08:57:10 data kernel: hda: (__ide_dma_test_irq) called while not wai=
ting
Nov 18 08:57:10 data kernel: hda: status error: status=3D0x58 { DriveReady =
SeekComplete DataRequest }
Nov 18 08:57:10 data kernel:
Nov 18 08:57:10 data kernel: hda: drive not ready for command

sometimes with 0 bytes in fifo in both fields, sometimes in the first 252, =
in the second 0

this is my hpt370, builtin with in mb:
Dec  3 12:23:33 data kernel: HPT370: IDE controller at PCI slot 00:13.0
Dec  3 12:23:33 data kernel: PCI: Found IRQ 11 for device 00:13.0
Dec  3 12:23:33 data kernel: HPT370: chipset revision 3
Dec  3 12:23:33 data kernel: HPT370: not 100%% native mode: will probe irqs=
 later
Dec  3 12:23:33 data kernel: HPT37X: using 33MHz PCI clock
Dec  3 12:23:33 data kernel:     ide0: BM-DMA at 0xc800-0xc807, BIOS settin=
gs: hda:DMA, hdb:pio
Dec  3 12:23:33 data kernel:     ide1: BM-DMA at 0xc808-0xc80f, BIOS settin=
gs: hdc:pio, hdd:pio

and this is my hd
Nov 21 16:13:46 data kernel: hda: IC35L120AVV207-1, ATA DISK drive
Nov 21 16:13:46 data kernel: blk: queue c03c50c0, I/O limit 4095Mb (mask 0x=
ffffffff)
-snip-
Nov 21 16:13:47 data kernel: hda: attached ide-disk driver.
Nov 21 16:13:47 data kernel: hda: host protected area =3D> 1
Nov 21 16:13:47 data kernel: hda: 241254720 sectors (123522 MB) w/7965KiB C=
ache, CHS=3D15017/255/63, UDMA(100)

and hdparm output
root@data:~# hdparm  /dev/hda

/dev/hda:
 multcount    =3D  0 (off)
 IO_support   =3D  0 (default 16-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D  8 (on)
 geometry     =3D 15017/255/63, sectors =3D 241254720, start =3D 0
root@data:~# hdparm -i /dev/hda

/dev/hda:

 Model=3DIC35L120AVV207-1, FwRev=3DV24OA66A, SerialNo=3DVNVD07G4GVJNAL
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D52
 BuffType=3DDualPortCache, BuffSize=3D7965kB, MaxMultSect=3D16, MultSect=3D=
off
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D241254720
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  2 3 4 5 6

root@data:~#

now:
- i have saw a list of bad udma 100 in hpt366.h... also some ibm. is it up =
to date?
- i have red here http://archives.mandrakelinux.com/discuss/2003-07/msg0006=
5.php
  that my HD could be going to hell... is it true?
- i have not tried yet patch from Marc Bellon: http://lkml.org/lkml/2003/11=
/6/106
  as suggested in this thread http://testing.lkml.org/slashdot.php?mid=3D43=
0607
- a new version of hpt366 (also include support for 370) is in 2.6. is it s=
imple to
  backport? is it useful with hpt370 (i have saw a lot of code for hpt372n)
- i have saw that support for ide in raid was removed on 2.6 branch, and th=
e goal
  is to make the support for normal raid support already present in linux.
  is it usable?
  also, in 2.4 i can read from help of ataraid: "Note, that Linux does not =
use the
  Raid implementation in BIOS, and the main purpose for this feature is to =
retain
  compatibility and data integrity with other OS-es, using the same disk ar=
ray.
  Linux has its own Raid drivers, which you should use if you need better p=
erformance."

  so if i create or not the mirror in hpt370 bios linux don't care at all?
  i have only linux in that pc, what should i do? i suppose that 2.6 is not=
 ready for
  ide yet...
  if possibile i don't want to use driver from highpoint... at least the ra=
id one.
  suggestion?

thanks
Daniele Palumbo

--=20
PGP Key-ID: 0xF482D454
--
To bodly go where no man has gone before.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/zqTg8Tj5mfSC1FQRAihOAJ0aUZfnW0EcSp/y3MYyKthB1n/ecwCfa4Wa
x5xiXVPc7C+BonPbXVfIKno=
=4q6t
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
