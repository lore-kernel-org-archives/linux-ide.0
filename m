From: Erik Mouw <mouw@nl.linux.org>
Subject: Re: Early ATA devices
Date: Wed, 15 Aug 2007 19:19:52 +0200
Message-ID: <20070815171952.GA20237@gateway.home>
References: <20070801014137.4ab39e94@the-village.bc.nu> <46B021FC.20507@gmail.com> <20070802214706.50c3040c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:1429 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761955AbXHORck (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 13:32:40 -0400
Content-Disposition: inline
In-Reply-To: <20070802214706.50c3040c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, jeff@garzik.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2007 at 09:47:06PM +0100, Alan Cox wrote:
> > > So in theory we can persuade libata to drive original MFM/RLL disks w=
ith
> > > relatively few changes
> >=20
> > Does anyone have a working device to test?
>=20
> I'm currently testing a 40MB pre-ATA IDE drive and with the LBA/non-LBA
> fix I sent to Andrew and the 'its ancient, its PIO < 2 who cares if
> SETXFER isn't a known command' patch likewise it is running.
>=20
> That one has a pre-ATA version of identify however. Not yet found one
> without to play with

FWIW, I have a Seagate ST225 (still zero bad blocks) with controller.
If I can persuade the old 386 to do a netboot I can test it.


Erik
(sorry for the late reply, BTW)

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGwzW4/PlVHJtIto0RApRbAJ97RuLG9w9Gih1n87qFuPC7CBGuVQCfYbof
M50jwWaWcNCUoqDnDFHq4Og=
=ZwVb
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
