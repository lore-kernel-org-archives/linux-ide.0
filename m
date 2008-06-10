From: Ben Martin <monkeyiq@users.sourceforge.net>
Subject: ata13.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Date: Tue, 10 Jun 2008 23:25:08 +1000
Message-ID: <1213104308.5985.5.camel@sam.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fasAdjY54X9D17xM1ng1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hosted01.westnet.com.au ([203.10.1.211]:41312 "EHLO
	hosted01.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbYFJNn2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jun 2008 09:43:28 -0400
Received: from hosted01.westnet.com.au (hosted01.westnet.com.au [127.0.0.1])
	by hosted01.westnet.com.au (Postfix) with SMTP id B480A2BF17C
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 21:25:11 +0800 (WST)
Received: from ferris.localdomain (unknown [124.148.53.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted01.westnet.com.au (Postfix) with ESMTP id 3DB072BEA14
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 21:25:10 +0800 (WST)
Received: from [192.168.0.200] (sam [192.168.0.200])
	by ferris.localdomain (8.14.1/8.13.8) with ESMTP id m5ADP8xh023644
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2008 23:25:09 +1000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>


--=-fasAdjY54X9D17xM1ng1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFHi,
  I recently constructed a RAID-5 using four 320Gb drives, moved the
system and other data across and everything was working nicely. I awoke
to find a degraded array email one day and on further investigation I
noticed the following in /var/log/messages. The RAID-5 array was running
in degraded mode and had evidently renoticed that /dev/sdm and sdm2 had
reappeared and listed them again as a failed spare in the --detail of
mdadm. I could not however see sdm with fdisk.

  Keeping the story short, do the /var/log/messages give any hints as to
why the machine decided that /dev/sdm should have been inacccessible?
The RAID-5 that had the issues is running off a SIL 3114 controller,
thus no NCQ issues possible.

# uname -a
Linux x 2.6.23.15-80.fc7 #1 SMP Sun Feb 10 17:29:10 EST 2008 i686 athlon
i386 GNU/Linux

/var/log/messages:
Jun  6 04:27:10 x kernel: ata13.00: exception Emask 0x0 SAct 0x0 SErr 0x0 a=
ction 0x2 frozen
Jun  6 04:29:13 x kernel: ata13.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0=
 tag 0 cdb 0x0 data 0=20
Jun  6 04:29:13 x kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 =
Emask 0x4 (timeout)
Jun  6 04:29:13 x kernel: ata13: port is slow to respond, please be patient=
 (Status 0xd0)
Jun  6 04:29:13 x kernel: ata13: device not ready (errno=3D-16), forcing ha=
rdreset
Jun  6 04:29:13 x kernel: ata13: hard resetting port
Jun  6 04:29:13 x kernel: ata13: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 310)
Jun  6 04:29:13 x kernel: ata13.00: qc timeout (cmd 0xec)
Jun  6 04:29:13 x kernel: ata13.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
Jun  6 04:29:13 x kernel: ata13.00: revalidation failed (errno=3D-5)
Jun  6 04:29:13 x kernel: ata13: failed to recover some devices, retrying i=
n 5 secs
Jun  6 04:29:13 x kernel: ata13: hard resetting port
Jun  6 04:29:13 x kernel: ata13: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 310)
Jun  6 04:29:13 x kernel: ata13.00: qc timeout (cmd 0x27)
Jun  6 04:29:13 x kernel: ata13.00: ata_hpa_resize 1: hpa sectors (0) is sm=
aller than sectors (625142448)
Jun  6 04:29:13 x kernel: ata13.00: failed to set xfermode (err_mask=3D0x40=
)
Jun  6 04:29:13 x kernel: ata13.00: limiting speed to UDMA/100:PIO3
Jun  6 04:29:13 x kernel: ata13: failed to recover some devices, retrying i=
n 5 secs
Jun  6 04:29:13 x kernel: ata13: hard resetting port
Jun  6 04:29:13 x kernel: ata13: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 310)
Jun  6 04:29:13 x kernel: ata13.00: qc timeout (cmd 0xec)
Jun  6 04:29:13 x kernel: ata13.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
Jun  6 04:29:13 x kernel: ata13.00: revalidation failed (errno=3D-5)
Jun  6 04:29:13 x kernel: ata13.00: disabled
Jun  6 04:29:13 x kernel: ata13: EH pending after completion, repeating EH =
(cnt=3D4)
Jun  6 04:29:13 x kernel: ata13: port is slow to respond, please be patient=
 (Status 0xd0)
Jun  6 04:29:13 x kernel: ata13: device not ready (errno=3D-16), forcing ha=
rdreset
Jun  6 04:29:13 x kernel: ata13: hard resetting port
Jun  6 04:29:13 x kernel: ata13: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 310)
Jun  6 04:29:13 x kernel: ata13: EH complete
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Result: hostbyte=3DDID_BAD_TAR=
GET driverbyte=3DDRIVER_OK,SUGGEST_OK
Jun  6 04:29:13 x kernel: end_request: I/O error, dev sdm, sector 350365623
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Result: hostbyte=3DDID_BAD_TAR=
GET driverbyte=3DDRIVER_OK,SUGGEST_OK
Jun  6 04:29:13 x kernel: end_request: I/O error, dev sdm, sector 350365879
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] READ CAPACITY failed
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Result: hostbyte=3DDID_BAD_TAR=
GET driverbyte=3DDRIVER_OK,SUGGEST_OK
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Sense not available.
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Write Protect is off
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Asking for cache data failed
Jun  6 04:29:13 x kernel: sd 12:0:0:0: [sdm] Assuming drive cache: write th=
rough
Jun  6 04:29:13 x kernel: md: super_written gets error=3D-5, uptodate=3D0
Jun  6 04:29:13 x kernel: raid5: Disk failure on sdm2, disabling device. Op=
eration continuing on 3 devices
Jun  6 04:29:13 x kernel: RAID5 conf printout:
Jun  6 04:29:13 x kernel:  --- rd:4 wd:3
Jun  6 04:29:13 x kernel:  disk 0, o:1, dev:sdj2
Jun  6 04:29:13 x kernel:  disk 1, o:1, dev:sdl2
Jun  6 04:29:13 x kernel:  disk 2, o:1, dev:sdk2
Jun  6 04:29:13 x kernel:  disk 3, o:0, dev:sdm2
Jun  6 04:29:13 x kernel: RAID5 conf printout:
Jun  6 04:29:13 x kernel:  --- rd:4 wd:3
Jun  6 04:29:13 x kernel:  disk 0, o:1, dev:sdj2
Jun  6 04:29:13 x kernel:  disk 1, o:1, dev:sdl2
Jun  6 04:29:13 x kernel:  disk 2, o:1, dev:sdk2


--=-fasAdjY54X9D17xM1ng1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhOgLQACgkQsIKOrI+5WvMRCQCg8PbDrzD5Lacf+OGujXz/scMc
pt8AnREsZdbb/RfTTSyYsNRJ8cilm5Eb
=/uwa
-----END PGP SIGNATURE-----

--=-fasAdjY54X9D17xM1ng1--

