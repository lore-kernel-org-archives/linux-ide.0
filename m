From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Intel DQ965GF booted
Date: Thu, 30 Nov 2006 04:15:38 -0800
Message-ID: <20061130121538.GW22012@curie-int.orbis-terrarum.net>
References: <20061128214326.GA4141@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wNT7VBaN1rUIB9jO"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:61153 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S936287AbWK3MPn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Nov 2006 07:15:43 -0500
Content-Disposition: inline
In-Reply-To: <20061128214326.GA4141@m.safari.iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sami Farin <atafarin@suomi24.fi>
Cc: linux-ide@vger.kernel.org


--wNT7VBaN1rUIB9jO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2006 at 11:43:26PM +0200, Sami Farin wrote:
> OK OK... it seems to work, I noticed after two days
> of hacking(?), when I use
> "all-generic-ide root=3D5841" param for lilo...
> I guess LABEL would have been nice if I were using it
> before mobo crash.
>=20
> And lilo does not know about 5841 so I have to upgrade(?)
> to grub?
[snip your contents of lspci, that look like an old version of lspci
too]

You've gotten bit by the same bug I was, you need the AHCI_PI patch that
Tejun hashed out, and is presently in libata#upstream.

Also, make sure you switch your hardware to AHCI mode in the BIOS!

As for a boot loader, you're on your own there, I just netboot all of my
kernels lately (and use a local root device).

AHCI (remember to put the SCSI disk driver into the kernel, or build a
suitable initrd with everything) would put your root into /dev/sdX
territory, so modify your bootparams accordingly.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--wNT7VBaN1rUIB9jO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFbstqPpIsIjIzwiwRAno/AJ9ciZ1TRYlUoa1EoBpPGZTbXiN2eACg7FFM
DlglQc1n31ROAMw12CJNp0k=
=K9CJ
-----END PGP SIGNATURE-----

--wNT7VBaN1rUIB9jO--
