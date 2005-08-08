From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Mon, 08 Aug 2005 12:10:56 +0200
Message-ID: <1123495856.22328.62.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RQRuXigpxlb92O1SDKCA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:15233 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1750800AbVHHKLJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2005 06:11:09 -0400
In-Reply-To: <20050808030239.GA27502@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--=-RQRuXigpxlb92O1SDKCA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-08-07 at 23:02 -0400, Jeff Garzik wrote:
> On Mon, Aug 08, 2005 at 10:43:41AM +0900, Tejun Heo wrote:
> >  I don't know much about PATA support.  All I know is that ICH's seem=20
> > to generate a lot of noise in this mailing list w/ its legacy, combined=
,=20
> > ahci and whatever modes and no one setting seems to satisfy all.  (If=20
> > anyone knows more about it, please fill in here.)
>=20
> Combined mode aggregates the PATA and SATA devices into a single PCI
> device.  The chosen solution was to use the IDE driver for PATA, and
> libata for SATA.

BTW can you tell me why my PATA harddisk shows up as scsi (sd..) disk
using ICH6M, using kernel with both plain ide and libata/piix enabled? I
was under the impression that PATA harddisks should always show up as
hd..

I tried two approaches and both sort of work: include the PCI id in the
ide/piix list (disk/cd show up as hd..) or enable atapi in libata
(disk/cd show up as sd/scd), although the latter tends to lock up hard
every once in while, which is to be expected I assume.

Just puzzled...

Is there a possibility that dell attaches PATA harddisks using a
SATA/PATA converter to the SATA connection of the ICH6M?

--=-RQRuXigpxlb92O1SDKCA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC9y+wJgD/6j32wUYRAodYAJ9MjZjzZ57TLhr5HJ0avjKOfyDvagCfRvJy
tdzgvrMQowphFfeMWUJEzn8=
=+34B
-----END PGP SIGNATURE-----

--=-RQRuXigpxlb92O1SDKCA--
