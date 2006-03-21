From: Leopold Palomo Avellaneda <lepalom@wol.es>
Subject: Marvell SATA Support ... problem
Date: Tue, 21 Mar 2006 13:14:00 +0100
Message-ID: <200603211314.06315.lepalom@wol.es>
Reply-To: lepalom@wol.es
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart190506366.IdemK8KUm4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from violet.upc.es ([147.83.2.51]:50136 "EHLO violet.upc.es")
	by vger.kernel.org with ESMTP id S1751501AbWCUMPf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 07:15:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

--nextPart190506366.IdemK8KUm4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi people,

I'm trying to install a Debian testing to a Proliant ML150 G2 box. This=20
hardware has a Adaptec HostRaid 8130 SATA Galileo/SATA II PI-X.=20

However, this card has the Marvell Chip, and the lspci give:

0000:03:04.0 SCSI storage controller: Marvell Technology Group Ltd.
MV88SX6041 4-port SATA II PCI-X Controller (rev 07)

I have used the debian-installer from March 18th that comes with the 2.6.15=
=20
version. The installer uses your sata_mv module. The module detects the=20
controller and the hd, however all is very slow and I'm having a lot of of=
=20
timeouts during the access to the hard disk. The device is unusable.

I have not tried yet to test the Marvell driver [1], however, I have found=
=20
that this driver have been moved to a GPLv2 version [2].

Otherwise, talking about the sata_mv, I would like to know what I have to d=
o=20
to help to improve the driver because it doesn't work with my hardware?

Regards,

Leo


Pd. If Marvell have a GPL v2 driver, maybe it could be a good idea to inclu=
de=20
it in the kernel tree?


[1] ftp://ftp.abit.com.tw/pub/download/drivers/linux/marvell/mvsata340.zip
[2] http://www.keffective.com/mvsata/


=2D-=20
Linux User 152692=20
Catalonia

--nextPart190506366.IdemK8KUm4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEH+4OaC7AnPlEgH4RAvxbAJ9ZESR7DGwlfAHXL4aBO2Gb2F4ABgCfZRO5
6T71WhXEJ53Kx1LU3zOCMtU=
=ZxzN
-----END PGP SIGNATURE-----

--nextPart190506366.IdemK8KUm4--
