From: Erik Slagter <erik@slagter.name>
Subject: Re: Re[4]: TX4000 RAID and sata_promise
Date: Tue, 16 Aug 2005 20:09:46 +0200
Message-ID: <1124215786.29001.2.camel@localhost.localdomain>
References: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
	 <4301E5C5.2030203@dtbb.net>
	 <1124199054.5550.71.camel@localhost.localdomain>
	 <015701c5a267$594284f0$6f0aa8c0@rgkb.local>
	 <1124200207.5550.74.camel@localhost.localdomain>
	 <016a01c5a26a$1745ca50$6f0aa8c0@rgkb.local>
	 <1124200516.5550.77.camel@localhost.localdomain>
	 <017501c5a26a$bb31bfc0$6f0aa8c0@rgkb.local>
	 <1124202300.19419.0.camel@localhost.localdomain>
	 <1721975015.20050621203841@rccb.ru>
	 <1124211467.19419.24.camel@localhost.localdomain>
	 <71290359.20050621214728@rccb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-82UBQoBOK4O+UzIaZxt+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:46829 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1030275AbVHPSKF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 14:10:05 -0400
In-Reply-To: <71290359.20050621214728@rccb.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>
Cc: linux-ide@vger.kernel.org


--=-82UBQoBOK4O+UzIaZxt+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 at 21:47 +0400, Yuri Kirsanov wrote:
> Roger, dmesg (sata_promise doesn't load at boot time for some reason,
> so i start it by 'modprobe sata_promise'):

Hmm, then I guess it would be very interesting to know WHY it doesn't
load at boot time! What are the symptoms?

> sata_promise version 1.01
> PCI: Found IRQ 5 for device 0000:01:09.0
> ata1: PATA max UDMA/133 cmd 0xCCB4A200 ctl 0xCCB4A238 bmdma 0x0 irq 5
> ata2: PATA max UDMA/133 cmd 0xCCB4A280 ctl 0xCCB4A2B8 bmdma 0x0 irq 5
> ata3: PATA max UDMA/133 cmd 0xCCB4A300 ctl 0xCCB4A338 bmdma 0x0 irq 5
> ata4: PATA max UDMA/133 cmd 0xCCB4A380 ctl 0xCCB4A3B8 bmdma 0x0 irq 5
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_promise
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_promise
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_promise
> ata4: no device found (phy stat 00000000)
> scsi3 : sata_promise

It seems to strange to me that sata reports PATA devices... What kind of
harddisks do you connected (brand, type, pata/sata?)

--=-82UBQoBOK4O+UzIaZxt+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAivqJgD/6j32wUYRAt4JAJ4nS9XpKUNIIMuPCyyQnkhqfffUEgCfSdoY
bpmR0oQi9zeRcIte6O0+/p8=
=7R1l
-----END PGP SIGNATURE-----

--=-82UBQoBOK4O+UzIaZxt+--
