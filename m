From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 11:37:46 +0200
Message-ID: <20110829093746.GE24524@pengutronix.de>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
 <20110829083649.GB24524@pengutronix.de>
 <CAMPhdO-vuExLKVSmsr_kR1HnHfEBPp_Ae7pgs=XaVYiKGFRo-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60276 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1H2Jhz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 05:37:55 -0400
Content-Disposition: inline
In-Reply-To: <CAMPhdO-vuExLKVSmsr_kR1HnHfEBPp_Ae7pgs=XaVYiKGFRo-A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.miao@linaro.org>
Cc: Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2011 at 04:51:46PM +0800, Eric Miao wrote:
> On Mon, Aug 29, 2011 at 4:36 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> > On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> >> On imx53 AHCI, soft reset fails with IPMS set when PMP
> >> is enabled but SATA HDD/ODD is connected to SATA port,
> >> do soft reset again to port 0.
> >> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> >> ahci is present.
> >>
> >> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> >> ---
> >> =A0drivers/ata/ahci_platform.c | =A0 44 ++++++++++++++++++++++++++++++=
+++++++-----
> >> =A01 files changed, 38 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >> index 6fef1fa..f32c91e 100644
> >> --- a/drivers/ata/ahci_platform.c
> >> +++ b/drivers/ata/ahci_platform.c
> >> @@ -23,6 +23,41 @@
> >> =A0#include <linux/ahci_platform.h>
> >> =A0#include "ahci.h"
> >>
> >> +enum ahci_type {
> >> + =A0 =A0 AHCI, =A0 =A0 =A0 =A0 =A0 /* standard platform ahci */
> >> + =A0 =A0 IMX53_AHCI, =A0 =A0 /* ahci on i.mx53 */
> >
> > How about making all the IMX*-naming more generic because other SoC mig=
ht need
> > this somewhen, too?
>=20
> From a practical point of view, we can start with what we know already.
> As the SATA controller on "other SoC" so far, we don't know yet if they
> show the same issue (which we have to use ahci_pmp_retry_srst_ops).
>=20
> So Wolfram, how about we consider a generic one once more controllers
> are being added?

If we do so later, and we then also change the platform_device_id to someth=
ing
generic, we then also have to change all users, too. Is it so bad to change
IMX53_AHCI (and imx53-ahci and alike) to something like "ahci-pmp-retry-srs=
t"
(or similar) now?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5bXeoACgkQD27XaX1/VRu3mwCfdzgsLmWnQ2SKbkarK7mU4Kpc
4GAAnR7Lkvafv4x/TGk9jQTfMnWkOnd2
=uy4x
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
