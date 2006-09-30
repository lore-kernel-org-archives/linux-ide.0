From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] [PATCH] ahci: honor PORTS_IMPL on ICH8s
Date: Sat, 30 Sep 2006 09:13:08 -0700
Message-ID: <20060930161308.GI26289@curie-int.orbis-terrarum.net>
References: <20060930122121.GR25800@htj.dyndns.org> <20060930122259.GS25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:43421 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1751256AbWI3QNP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Sep 2006 12:13:15 -0400
Content-Disposition: inline
In-Reply-To: <20060930122259.GS25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, robbat2@gentoo.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2006 at 09:22:59PM +0900, Tejun Heo wrote:
> Some ICH8s use non-linear port mapping.  ahci driver didn't use to
> honor PORTS_IMPL and this made ports after hole nonfunctional.  This
> patch implements port mapping table and use it to handle non-linear
> port mapping.
>=20
> As it's unknown whether other AHCIs implement PORTS_IMPL register
> properly, new board id board_ahci_pi is added and selectively applied
> to ICH8s.  All other AHCIs continue to use linear mapping regardless
> of PORTS_IMPL value.
>=20
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

Works 100% here, thanks Tejun.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFHpeUPpIsIjIzwiwRAkUEAKD+QmleZ87w7PdhrGQ/shAqbRMA+QCcC9jU
uoCE7FRHHXZQ4I0R2le493M=
=+uHu
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
