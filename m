From: uaca@alumni.uv.es
Subject: Re: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 14:18:54 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031230131854.GB15816@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pusa.informat.uv.es ([147.156.10.98]:63874 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S265788AbTL3NSz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2003 08:18:55 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, Dec 30, 2003 at 11:41:47AM +0100, Nicklas Bondesson wrote:
> Hi!
>=20
> I think i'm getting really bad values from my disks. It's two Western
> Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected t=
o a
> Promise TX2000 (PDC20271) card (RAID1 using ataraid).

I think I have the same/similar drive, my results

(after trying to flush disk cache by doing a find /)

root@agapito:~# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  124 MB in  3.03 seconds =3D  40.92 MB/sec

(without pause)
root@agapito:~# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  132 MB in  3.01 seconds =3D  43.86 MB/sec
root@agapito:~# hdparm -i /dev/hda

/dev/hda:

 Model=3DWDC WD800JB-00CRA1, FwRev=3D17.07W17, SerialNo=3DWD-WMA8E45198=
60
 Config=3D{ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGa=
pReq }
 RawCHS=3D16383/16/63, TrkSize=3D57600, SectSize=3D600, ECCbytes=3D40
 BuffType=3DDualPortCache, BuffSize=3D8192kB, MaxMultSect=3D16, MultSec=
t=3D16
 CurCHS=3D4047/16/255, CurSects=3D16511760, LBA=3Dyes, LBAsects=3D15630=
1488
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive conforms to: device does not report version:

 * signifies the current active mode


my kernel: 2.6.0-test11
my chipset: sis-735

looking at your test results I believe hdparm is reading to few data to=
 make
the benchmark

	Ulisses

>=20
> The disks are setup with hdparm at boot time:
>=20
> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda
> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hdc
>=20
> When running hdparm -tT I get the following:
>=20
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =3D113.27 MB/se=
c
>  Timing buffered disk reads:  64 MB in  2.46 seconds =3D 26.02 MB/sec
>=20
> /dev/hdc:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =3D113.27 MB/se=
c
>  Timing buffered disk reads:  64 MB in  2.47 seconds =3D 25.91 MB/sec
>=20
> Are these normal values? I don't think so. Please advise.
>=20
> /Nicke
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------=
------
"Computers are useless. They can only give answers."            Pablo P=
icasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociaci=F3n Valenciana de Usuarios de Linux		<---
