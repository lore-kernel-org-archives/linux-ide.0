From: Andre <nandre@riseup.net>
Subject: Device unreadable, no SMART errors found
Date: Thu, 11 Jun 2015 21:26:54 -0300
Message-ID: <20150612002654.GB13708@tagesuhu-pc.ookami>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.riseup.net ([198.252.153.129]:38466 "EHLO mx1.riseup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbbFLA1H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jun 2015 20:27:07 -0400
Received: from plantcutter.riseup.net (plantcutter-pn.riseup.net [10.0.1.121])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id AACF240E08
	for <linux-ide@vger.kernel.org>; Fri, 12 Jun 2015 00:27:06 +0000 (UTC)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've got a SATA 2.5 inch disk which is currently unreadable, though not
password locked nor presenting any errors during a SMART selftest.

I've tried to access it both using a SATA USB Bridge and a SATA cable
and couldn't do it with neither of them.

I've also tried to reset it using hdparm, blocking DMA and using PIO
(libata.dma=3D0), blocking ncq (libata.force=3Dnoncq), and I still cannot f=
ind
out what is happening with this device.

The most meaningful error logs are:

[  126.156761] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  126.156770] ata1.00: irq_stat 0x40000001
[  126.156777] ata1.00: failed command: READ DMA
[  126.156788] ata1.00: cmd c8/00:08:08:00:00/00:00:00:00:00/e0 tag 17
dma 4096 in
[  126.156788]          res 51/04:08:08:00:00/00:00:00:00:00/00 Emask
0x1 (device error)
[  126.156794] ata1.00: status: { DRDY ERR }
[  126.156798] ata1.00: error: { ABRT }
[  126.159279] ata1.00: configured for UDMA/133
[  126.167330] sd 0:0:0:0: [sda]=20
[  126.167335] Result: hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
[  126.167339] sd 0:0:0:0: [sda] =20
[  126.167342] Sense Key : Aborted Command [current] [descriptor]

You can read the full logs of dmesg, hdparm and smartctl at
http://paste.ubuntu.com/11699099/

With udev running the log messages go berserk as it keeps trying to
read the device without success.

I'm running Debian kernel 3.16.7-ckt11-1 and hope someone here will be
able to help me sort this out.

Thanks

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIiBAEBCgAMBQJVeidOBYMJZgGAAAoJENfnm1LRPpKL9vMP/RvyCCUktUfChDq2
MtC3+2s1+E8esDDmqndpfCPLQt2fAUD1BiO9VHnGSBTcAm8rp/6jLx37fj2lf07u
yXbDFgOz9o7z+RRKYJwf2yjt/DYmy7XAxgFRnzL3zaXWSls4KPX0skeE0J5kjLZ0
4IpDvumbQ5QUiGd/+e3j9WnN3OzJbYKzdCkFNeEbBtOA/YSlS4AioshKz0XWCi2n
OuyPR9mBC6lO0f9Kohcwz7mU043nmq4yH6nZ89pfiEp8sT0ms6BOUphMo0FZjgsZ
4GdGTA2dyEMW5TLlg9MD+yUInScfl4PkgfFHYa2PQWdcneL83AkuQcp8ZFTyT6fF
9HVbS6qLd5CrW4XO3yx43j7m0AUuSgt16uXZCNgTlmaSXb5QJQBM9wHrRTb+1Z7N
hf12nDrxZf3ZRnKyDXH0YihTgkyzqOE1oBKSqvRm9KxVMzlMnJjWMYCZMUhPZyBH
dRG3H2Q3warjc48Qf+n9xMYHtmZuOnMZ0DN5uIzyPzzPq/V2E3mOXcpJBglTphjC
7ARiAbO6TL+QX+kLjezH7MXfabXMwtiUyRBgoikhrw6QA7RJbrD15fIMs1Pr56iE
0aGMujshziwil/chOqqhbnuAyh6chOHtI73JnrWjt60HB4FK5JIPa4pHwC5wMW7v
gayfFAcUQrYeKOrjRmOsOCjT4GME
=lxC0
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
