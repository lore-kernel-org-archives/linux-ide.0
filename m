From: Phil Dibowitz <phil@ipom.com>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Mon, 9 Apr 2007 15:02:33 -0700
Message-ID: <20070409220233.GA3088@ipom.com>
References: <200704092133.l39LXtrM022972@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:39085 "EHLO
	uberhacker.sage-inc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbXDIWCh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Apr 2007 18:02:37 -0400
Content-Disposition: inline
In-Reply-To: <200704092133.l39LXtrM022972@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2007 at 11:33:55PM +0200, Mikael Pettersson wrote:
> The error decodes as:
> port_status 0x20200000: Drive Error during Packet Command Cycle
> (the drive signalled an error to the controller)
>=20
> SErr 0x380100: CRC error, Disparity error, 10B-to-8B decoding error,
> non-recoverable transient data integrity error.
>=20
> My conclusion is that the link between the controller and the drive
> is corrupting messages. This is almost certainly a hardware problem,
> and could be a broken motherboard (you wrote that you hadn't used
> the mobo's Promise chip before), bad cables, bad drives, a bad power
> supply, or electrical interference.

Mikael,

Thanks for the quick response. I appreciate your help. I guess I'm buying a
SATA PCI card!

Looks like my choice of reasonably-priced known-brands is Highpoint and
Promise (specifically a Highpoint ROCKETRAID1520 or a Promise SATA300 TX4) -
are one of these brands better from a Linux compatibility or hardware-bug
standpoint?

Thanks again.
--=20
Phil Dibowitz                             phil@ipom.com
Open Source software and tech docs        Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Never write it in C if you can do it in 'awk';
 Never do it in 'awk' if 'sed' can handle it;
 Never use 'sed' when 'tr' can do the job;
 Never invoke 'tr' when 'cat' is sufficient;
 Avoid using 'cat' whenever possible" -- Taylor's Laws of Programming


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGGrf5N5XoxaHnMrsRArrhAJ90UC1QMwIZZLrGaPzyry0JmevcLQCfVF/S
qAHz20qWiY/zq2PZRiiy0wE=
=ZcFu
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
