From: Erik Slagter <erik@slagter.name>
Subject: Re: Problems with DMA enabling
Date: Thu, 18 Aug 2005 11:01:01 +0200
Message-ID: <1124355661.8720.23.camel@localhost.localdomain>
References: <1124293208.3885.10.camel@localhost>
	 <1124294354.5948.18.camel@localhost.localdomain>
	 <1124299885.3851.7.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M1uuyWz0Fa154iW3LYw9"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:15045 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932133AbVHRJBK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 05:01:10 -0400
In-Reply-To: <1124299885.3851.7.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dbueso@linuxchile.cl
Cc: linux-ide@vger.kernel.org


--=-M1uuyWz0Fa154iW3LYw9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-08-17 at 13:31 -0400, Davidlohr Bueso A. wrote:
> On Wed, 2005-08-17 at 17:59 +0200, Erik Slagter wrote:
> > On Wed, 2005-08-17 at 11:40 -0400, Davidlohr Bueso A. wrote:
> > ROFL! Sorry...
>=20
> I didn't mention that I recompiled/rebooted my system after making the
> changes because it is obvious that I did it. I'm also not using my
> debian-precompiled kernel -> I got 2.6.12.3 from kernel.org

Oops, apologies. Please mention you're using a vanilla kernel next time.

> > If you have built the new kernel and booted it, your cd/dvd drive will
> > now be claimed by libata and show up as /dev/scd0 instead of /dev/hdc
> > (or similar). Hdparm -d 1 will not work (either), but DMA will be used
> > anyway.
>=20
> I added the patch you attached, recompiled, rebooted and still can't
> use /dev/scd0 (not a valid block device), here's what I get with dmes|
> grep ata:
>=20
> libata version 1.11 loaded.
> ata_piix version 1.03
> ata: 0x170 IDE port busy
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
> ata1: dev 0 cfg 49:0f00 82:746b 83:7fe9 84:4023 85:f469 86:3e49 87:4023
> 88:203f
> ata1: dev 0 ATA, max UDMA/100, 117210240 sectors: lba48
> ata1: dev 0 configured for UDMA/100
> scsi0 : ata_piix

For this to work, you must disable (legacy) IDE altogether. It looks it
has claimed the second port before libata can do it.

--=-M1uuyWz0Fa154iW3LYw9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDBE5NJgD/6j32wUYRAt58AJ49R0+QYsdgjbxRM9VLLaVTPNtBjgCfYZta
A7X03NNhM8tA63nwo6x2UaU=
=NS2J
-----END PGP SIGNATURE-----

--=-M1uuyWz0Fa154iW3LYw9--
