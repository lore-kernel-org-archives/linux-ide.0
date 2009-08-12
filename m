From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 2.6.32 v3] Conditional MSI support for sata_nv
Date: Wed, 12 Aug 2009 18:15:14 +0100
Message-ID: <1250097314.3879.0.camel@localhost>
References: <20090805235009.88C091007F@gold.linx.net>
	 <c384c5ea0908121003x2f3eef3ejd8bc4a5aaa120793@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-c6fiQCB8R9r/7pHbNPTd"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754558AbZHLROk@vger.kernel.org>
In-Reply-To: <c384c5ea0908121003x2f3eef3ejd8bc4a5aaa120793@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Philip Langdale <philipl@overt.org>, Robert Hancock <hancockrwd@gmail.com>
List-Id: linux-ide@vger.kernel.org


--=-c6fiQCB8R9r/7pHbNPTd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-12 at 19:03 +0200, Leon Woestenberg wrote:
> Shouldn't there be a matching "if (msi_enabled)
> pci_disabling_msi(pdev);" somewhere else?

Hello there Leon,

Actually that is taken care of through other means. Please see Tejun
Heo's confirmation of this in the "v2" thread for this patch.

> Regards,
> Leon.

Regards,
Tony V.

--=-c6fiQCB8R9r/7pHbNPTd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkqC+KIACgkQp5vW4rUFj5rAxgCgnwiK+47bbEl/MZST+AIlCrJy
ZK0An34Hve+abB8h57/Cl9DqDRIfhJx4
=hf5e
-----END PGP SIGNATURE-----

--=-c6fiQCB8R9r/7pHbNPTd--
