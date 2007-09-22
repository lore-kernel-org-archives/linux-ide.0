From: Carsten Otto <c-otto@gmx.de>
Subject: Re: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Sat, 22 Sep 2007 15:11:04 +0200
Message-ID: <20070922131104.GG32509@server.c-otto.de>
Reply-To: Carsten Otto <c-otto@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:54636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751530AbXIVNLI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Sep 2007 09:11:08 -0400
Received: from carsten-otto.halifax.rwth-aachen.de ([137.226.108.169] helo=server.c-otto.de)
	by server.c-otto.de with smtp (Exim 4.67)
	(envelope-from <c-otto@gmx.de>)
	id 1IZ4lE-0007kR-Os
	for linux-ide@vger.kernel.org; Sat, 22 Sep 2007 15:11:05 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

(I am referring to the thread at
http://marc.info/?l=3Dlinux-ide&m=3D118703097726277&w=3D2)

I also experience a lot of NCQ errors which look like these:

Sep 22 10:11:53 server kernel: ata1.00: exception Emask 0x2 SAct 0x7 SErr 0=
x0 action 0x2 frozen
Sep 22 10:11:53 server kernel: ata1.00: (spurious completions during NCQ is=
sue=3D0x0 SAct=3D0x7 FIS=3D004040a1:00000010)
Sep 22 10:11:53 server kernel: ata1.00: cmd 60/38:00:bd:ee:01/00:00:13:00:0=
0/40 tag 0 cdb 0x0 data 28672 in
Sep 22 10:11:53 server kernel:          res 40/00:20:5d:1d:eb/00:00:13:00:0=
0/40 Emask 0x2 (HSM violation)
Sep 22 10:11:53 server kernel: ata1.00: cmd 60/40:08:f5:ee:01/00:00:13:00:0=
0/40 tag 1 cdb 0x0 data 32768 in
Sep 22 10:11:53 server kernel:          res 40/00:20:5d:1d:eb/00:00:13:00:0=
0/40 Emask 0x2 (HSM violation)
Sep 22 10:11:53 server kernel: ata1.00: cmd 60/08:10:35:ef:01/00:00:13:00:0=
0/40 tag 2 cdb 0x0 data 4096 in
Sep 22 10:11:53 server kernel:          res 40/00:20:5d:1d:eb/00:00:13:00:0=
0/40 Emask 0x2 (HSM violation)
Sep 22 10:11:53 server kernel: ata1: soft resetting port
Sep 22 10:11:53 server kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SCo=
ntrol 300)
Sep 22 10:11:53 server kernel: ata1.00: configured for UDMA/133
Sep 22 10:11:53 server kernel: ata1: EH complete
Sep 22 10:11:53 server kernel: sd 0:0:0:0: [sda] 586114704 512-byte hardwar=
e sectors (300091 MB)
Sep 22 10:11:53 server kernel: sd 0:0:0:0: [sda] Write Protect is off
Sep 22 10:11:53 server kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Sep 22 10:11:53 server kernel: sd 0:0:0:0: [sda] Write cache: disabled, rea=
d cache: enabled, doesn't support DPO or FUA

In total I have 355 such entries regarding my SATA disks starting on
September 15 when I installed kernel 2.6.22.6 (before I had
2.6.18-rc4-mm1 or so).

In addition I also see messages like this one:

kern.log:Sep 20 00:42:23 server kernel: ata2.00: NCQ disabled due to excess=
ive errors

Please tell me how I can help resolving the issue (if it is a bug) or,
if possible, tell me how to fix it myself.

Information about my system:
- 4x Maxtor 7V300F0 (MaxLine III, 300GB, 7200rpm, 16MB cache, SATA2),
  firmware VA111900
- 1x Samsung 2SP2014N (SpinPoint P, 200GB, 7200rpm, 8MB cache, PATA),
  firmware VC100-33
- 4 software RAIDs on the SATA disks, 1x RAID1, 3x RAID5
- heavy usage of the RAIDs
- ICH7R
- 2.6.22.6
- Pentium D 805, 2GB RAM

Thanks a lot,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG9RRojUF4jpCSQBQRAotNAJ9UQ3FuTRiZqLn+NRZukW/e+rHpkQCfdQ29
FJ5Dk4Wdh03GH+MGCizv0o8=
=T3p+
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
