From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 10:36:49 +0200
Message-ID: <20110829083649.GB24524@pengutronix.de>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53180 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab1H2IhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 04:37:00 -0400
Content-Disposition: inline
In-Reply-To: <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
>=20
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
>  drivers/ata/ahci_platform.c |   44 +++++++++++++++++++++++++++++++++++++=
-----
>  1 files changed, 38 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 6fef1fa..f32c91e 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -23,6 +23,41 @@
>  #include <linux/ahci_platform.h>
>  #include "ahci.h"
> =20
> +enum ahci_type {
> +	AHCI,		/* standard platform ahci */
> +	IMX53_AHCI,	/* ahci on i.mx53 */

How about making all the IMX*-naming more generic because other SoC might n=
eed
this somewhen, too?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5bT6EACgkQD27XaX1/VRtGTACghBghi8Tbos98osZz2ZOhQQnO
la4AnAhRn4tmxmgfvXUH4173K307hyBo
=42Hw
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
