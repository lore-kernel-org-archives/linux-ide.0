From: Phil Dibowitz <phil@ipom.com>
Subject: sata_promise ata exceptions (2.6.20.6)
Date: Sat, 07 Apr 2007 16:41:04 -0700
Message-ID: <46182C10.7010703@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig036760AB48FC9F276A273186"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:56903 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966010AbXDHANg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Apr 2007 20:13:36 -0400
Received: from [10.1.1.2] (cpe-24-24-210-243.socal.res.rr.com [24.24.210.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uberhacker.sage-inc.com (Postfix) with ESMTP id 592D51BBB9
	for <linux-ide@vger.kernel.org>; Sat,  7 Apr 2007 18:41:34 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig036760AB48FC9F276A273186
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I've recently moved to a Promise Sata controller with two SATA drives in =
a
RAID1 mirror. But I get lots of ata exceptions and the kernel eventually
slows down my drive to UDMA/33.

It usually happens on ata1 (sda), but sometimes it'll kick in on ata2 (sd=
b).
I can definitely cause this to happen more by increasing load on the disk=
s.
But even low load (checking email) causes this. Full hardware and softwar=
e
specs are below, but first, the errors:

ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x180100 action 0x2
ata1.00: cmd c8/00:d0:8a:31:ae/00:00:00:00:00/e0 tag 0 cdb 0x0 data 10649=
6 in
         res 51/0c:0f:4b:32:ae/00:00:00:00:00/e0 Emask 0x10 (ATA bus erro=
r)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't suppo=
rt
DPO or FUA
ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2
ata1.00: cmd c8/00:a0:12:fa:bc/00:00:00:00:00/e0 tag 0 cdb 0x0 data 81920=
 in
         res 51/0c:1f:93:fa:bc/00:00:00:00:00/e0 Emask 0x10 (ATA bus erro=
r)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't suppo=
rt
DPO or FUA
ata1.00: limiting speed to UDMA/100
ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2
ata1.00: cmd c8/00:48:2a:27:ac/00:00:00:00:00/e0 tag 0 cdb 0x0 data 36864=
 in
         res 51/0c:27:4b:27:ac/00:00:00:00:00/e0 Emask 0x10 (ATA bus erro=
r)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't suppo=
rt
DPO or FUA
ata1.00: limiting speed to UDMA/66
ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x180100 action 0x2
ata1.00: cmd c8/00:f8:6a:7a:ae/00:00:00:00:00/e0 tag 0 cdb 0x0 data 12697=
6 in
         res 51/0c:97:cb:7a:ae/00:00:00:00:00/e0 Emask 0x10 (ATA bus erro=
r)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/66
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't suppo=
rt
DPO or FUA


Kernel: 2.6.20.6 (PREEMT & SMP)
SATA Controller:
  02:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTra=
k
  378/SATA 378) (rev 02)
        Subsystem: ASUSTeK Computer Inc. K8V Deluxe/PC-DL Deluxe motherbo=
ard
        Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 16
        I/O ports at df00 [size=3D64]
        I/O ports at dfa0 [size=3D16]
        I/O ports at dc00 [size=3D128]
        Memory at feafe000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at feac0000 (32-bit, non-prefetchable) [size=3D128K]
        Capabilities: [60] Power Management version 2
Drives:
  2 x Western Digital WD1600JS-00N

Other Setup Details:
  3 software RAID1 mirrors (md0, 1, 2 made up of sd{a,b}1 - 3 respectivel=
y)
  md3 is an LVM physical group with 2 volumes in it. In other words:
    /dev/md0 =3D /boot
    /dev/md1 =3D swap
    /dev/md2 =3D LVM:
            /dev/vg00/root =3D /
            /dev/vg00/home =3D /home

The sata controller isn't brand new, but it's never been used and is
relatively new. The sata drives and cables are fresh out of the box. Any
help would be greatly appreciated.

--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming



--------------enig036760AB48FC9F276A273186
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGGCwVN5XoxaHnMrsRAgLpAJ9TxtQ07PWfGiURniziLYOp6SIbsQCcDAGb
TkJAFj+Zil5lnsamzHYQQbg=
=ira8
-----END PGP SIGNATURE-----

--------------enig036760AB48FC9F276A273186--
