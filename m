From: Daniel Egger <de@axiros.com>
Subject: Re: Booting from SATA disables IDE? (reproduced)
Date: Sun, 3 Apr 2005 10:42:10 +0200
Message-ID: <d6c2a14544416dae17c80184603baf51@axiros.com>
References: <1921eeb1e202db77fdccb439f85ac532@axiros.com> <424D7F01.1060204@pobox.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-1066544054"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:51673
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S261422AbVDCImj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Apr 2005 04:42:39 -0400
In-Reply-To: <424D7F01.1060204@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--Apple-Mail-1-1066544054
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 01.04.2005, at 19:04, Jeff Garzik wrote:

> Well, sata_via never touches the VIA PATA side of things.  Probably a 
> config or BIOS error, or similar.

FWIW I put both drives into a different system (Asus A7V600) which
is using the same southbridge and the same SATA controller:
exact the same problem. So this does at least not seem to be a
single Board/BIOS combination but to be specific to the
southbridge/SATA chip and/or VIA SATA BIOS (both version 2.3.1,
BTW).

Servus,
       Daniel

--Apple-Mail-1-1066544054
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCT6xochlzsq9KoIYRAt1tAJ9/iWk5DBWC7geZJE8avwfvzb7qQwCgt5RR
otg3lNiDtktrYNR42BpEIkw=
=k7yv
-----END PGP SIGNATURE-----

--Apple-Mail-1-1066544054--

