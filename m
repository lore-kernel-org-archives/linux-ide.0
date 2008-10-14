From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 07:22:54 +0200
Message-ID: <20081014072254.58e9eea9@mjolnir.drzeus.cx>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
	<20081013211202.0328f1e4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-1220-1223961783-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:51062 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750791AbYJNFXD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 01:23:03 -0400
In-Reply-To: <20081013211202.0328f1e4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-1220-1223961783-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Oct 2008 21:12:02 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > five results in 25 MiB/s/disk. In other words, something is limiting
> > things to about 100 MiB/s. Now the question is what that limiting
> > factor is.
>=20
> Whats the PCIe bridge chip and what is the memory bandwidth of the
> system ?
>=20

No idea. The board uses a AMD 690G/SB600 chipset (unsure which part
houses the PCIe bridge), and the memory is two PC6400 modules. The
processor is a Athlon 4050e (did AMD ever put the dual lane capabilty
in the non-opteron models?).

Rgds
--=20
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-1220-1223961783-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkj0LLQACgkQ7b8eESbyJLi3aQCePidGTp65vp2en9aNcMNRwoHt
0jAAoLnEhTKE+wUgxgSwFHl24AlQws/2
=M+E/
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-1220-1223961783-0001-2--
