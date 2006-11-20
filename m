From: Tom Fredrik Blenning Klaussen <bfg-dev@blenning.no>
Subject: Driver for the Promise sx4000 HW RAID card
Date: Mon, 20 Nov 2006 21:22:45 +0100
Message-ID: <1164054165.5035.40.camel@bfg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7eve7LYztTOqnvP0Aruf"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kunder.interhost.no ([80.239.54.98]:55233 "EHLO
	kunder.interhost.no") by vger.kernel.org with ESMTP id S966637AbWKTUWr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 15:22:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Renan Calliari <renan_calliari@terra.com.br>, Juha Leivo <jmleivo@gmail.com>


--=-7eve7LYztTOqnvP0Aruf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

We are currently trying to start a project with the goal to support the
Promise sx4000 RAID card. There is already one provided, but it is not
working with the current 2.6 kernel.

It seem there are two possible ways to attack this problem.

1. Get the driver provided by promise up to a current state, and do some
disassembling of their binary code. Alternatively use it as is, but
getting a tainted kernel. There is some evidence suggesting that this
driver is a windows version adapted to be used under Linux.

2. The card seems to be an older version of the card already supported
with the module sata_sx4, except it runs PATA and not SATA. It should be
possible to do some backporting on this driver.

I have scrambled a small team consisting of me and Renan Calliari as
developers. In addition to Juha Leivo, who is willing to contribute as a
tester. Neither of us are unfortunately experienced with driver
development, and we would appreciate any help you can give us.

We look forward to hear from you.

Best regards
--=20
Tom Fredrik Klaussen

--=-7eve7LYztTOqnvP0Aruf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFYg6V5VkLJaz9JvgRAnpCAKCV3jG8xrbPYKHnBA7GFwNt0zKWSACeNvGs
9YNGXK5QLY/gE9f4A2b9p44=
=5SNb
-----END PGP SIGNATURE-----

--=-7eve7LYztTOqnvP0Aruf--

