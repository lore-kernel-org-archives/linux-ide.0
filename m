From: Phil Dibowitz <phil@ipom.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 9 Apr 2007 13:26:54 -0700
Message-ID: <20070409202654.GA3106@ipom.com>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:38662 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbXDIU1A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 16:27:00 -0400
Content-Disposition: inline
In-Reply-To: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2007 at 12:18:09PM +0200, Mikael Pettersson wrote:
> I've seen reports of issues like these with second-generation
> Promise SATA chips and SATAII (3Gbps) drives, but this is the
> first time I've seen any issues with a first-generation chip.
>=20
> 1. Please try 2.6.21-rc6 plus the following two patches:
>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-sep=
arate-sata-pata-ops-2.6.21-rc6
>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-err=
or_intr-2.6.21-rc6
>=20
>    This probably won't eliminate the errors, but should improve
>    the level of detail in the error messages.

It doesn't appear to have changed much. After a reboot, I have:

ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2 frozen
ata1.00: (port_status 0x20200000)
ata1.00: cmd c8/00:90:f2:fb:a6/00:00:00:00:00/e0 tag 0 cdb 0x0 data 73728 in
         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x14 (ATA bus error)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2 frozen
ata1.00: (port_status 0x20200000)
ata1.00: cmd c8/00:88:1a:f5:a6/00:00:00:00:00/e0 tag 0 cdb 0x0 data 69632 in
         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x14 (ATA bus error)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
ata1.00: limiting speed to UDMA/100:PIO4
ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x380100 action 0x2 frozen
ata1.00: (port_status 0x20200000)
ata1.00: cmd c8/00:80:7a:b8:a9/00:00:00:00:00/e0 tag 0 cdb 0x0 data 65536 in
         res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x14 (ATA bus error)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
DPO or FUA


Any other info I can provide?

--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGGqGON5XoxaHnMrsRAp98AJ9j7AKNYIAJKvFa+hR0Mi5+G7Pl1QCfctCY
uNsHX/qh8xplW11NJfaVcVw=
=MKe1
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
