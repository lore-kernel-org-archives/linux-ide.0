From: Martin =?ISO-8859-1?Q?Ammerm=FCller?= <tenco@gmx.de>
Subject: Re: [sata_sil] kernel 2.6.17(-mm2) test - timeout issue
Date: Mon, 24 Jul 2006 10:21:10 +0200
Message-ID: <1153729271.3860.14.camel@localhost>
References: <1151182247.5566.18.camel@localhost>
	 <449DFDC4.5050207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3bsmk53shdGA50EhufTu"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:15046 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750719AbWGXIVK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jul 2006 04:21:10 -0400
In-Reply-To: <449DFDC4.5050207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com


--=-3bsmk53shdGA50EhufTu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 25.06.2006, 12:06 +0900 schrieb Tejun Heo:
> Failed commands are retried several times, so no data was lost in your=20
> case.  If data gets lost, you'll see more error messages from higher=20
> layers (SCSI, FS).

With high disk I/O and a 2.6.18-rc1 kernel i get these errors (depending
upon the work i do, up to several times a day):

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x400000 action 0x2 frozen
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xc8 Emask 0x2 stat 0x58 err 0x0 (HSM violation)
ata1: soft resetting port
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ATA: abnormal status 0xD8 on port 0xDCA18087
ATA: abnormal status 0xD8 on port 0xDCA18087
ATA: abnormal status 0xD8 on port 0xDCA18087
ATA: abnormal status 0xD8 on port 0xDCA18087
ATA: abnormal status 0xD8 on port 0xDCA18087
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata1.00: revalidation failed (errno=3D-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

> Anyways, if your harddisk is doing this regularly,=20
> your hardware is faulty.  Maybe the connection between the controller=20
> and the disk is the problem or the disk itself.

I did not get those errors with Windows XP and i am not the only one who
has problems running this particular laptop model with a linux kernel.
Ok, to be honest, there's actually only one person i know of which
bothered enough about exactly the same errors to send me an e-mail (he
discovered at least one of my messages to this list). But in my
experience there are almost always others getting the same error, but
which remain silent.

Anyway, i will try to probe the device with smartmontools.

Regards,
Martin Ammerm=C3=BCller

--=-3bsmk53shdGA50EhufTu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBExIL2FjFZ/qjkvZARAnVKAJ9dFMOaRDXsWl27GNmC2BIFYoT3qACfRC4X
iJTdkL5j5vmySdhUx0Nc52U=
=8IQp
-----END PGP SIGNATURE-----

--=-3bsmk53shdGA50EhufTu--

