From: =?ISO-8859-1?Q?Guillaume_Laur=E8s?=
	<guillaume.laures@club-internet.fr>
Subject: unknown problem with seagate SATA drive
Date: Sat, 9 Jul 2005 23:59:44 +0200
Message-ID: <c051b4e5d0c63fa4c8f7a9109b7ec89a@club-internet.fr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-905264177"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay-bv.club-internet.fr ([194.158.96.102]:59646 "EHLO
	relay-bv.club-internet.fr") by vger.kernel.org with ESMTP
	id S261752AbVGIV7v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jul 2005 17:59:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--Apple-Mail-1-905264177
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hello,

I'm encountering a problem with a seagate drive you seem to know and=20
have adressed in the sata_sil driver. The drive just stops spinning=20
after a random amount of time and is then completely unusable until a=20
power down/power up sequence. The "fix" I'm refering to is limit=20
requests to 15 sectors.
Do you know if this workaround could be used in sata_sis like you did=20
in sata_sil ?
The drive used to work perfectly for 6 monthes on an intel box (don't=20
remember which sata chipset it was) and is unusable on both sata_nv and=20=

now sata_sis.

Thanks you for your answer !!

Guillaume Laur=E8s=

--Apple-Mail-1-905264177
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: =?ISO-8859-1?Q?Ceci_est_une_signature_=E9lectronique_PGP?=
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFC0EjRxnIJde5abSkRAkM/AJ4lM13Bx97fOkNBb/DezVqGLqsxewCcCAis
cJ/Xms8ZiW8nuxlP6kt0K/w=
=NyDk
-----END PGP SIGNATURE-----

--Apple-Mail-1-905264177--

