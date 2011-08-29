From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
 different features
Date: Mon, 29 Aug 2011 13:02:16 +0200
Message-ID: <20110829110216.GI24524@pengutronix.de>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
 <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
 <20110829083649.GB24524@pengutronix.de>
 <CAMPhdO-vuExLKVSmsr_kR1HnHfEBPp_Ae7pgs=XaVYiKGFRo-A@mail.gmail.com>
 <20110829093746.GE24524@pengutronix.de>
 <CAMPhdO8k-boE0p0J_60VrS3LBdNaJRfJ6z_HCHLiRbQtESOJFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43934 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1H2LCY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2011 07:02:24 -0400
Content-Disposition: inline
In-Reply-To: <CAMPhdO8k-boE0p0J_60VrS3LBdNaJRfJ6z_HCHLiRbQtESOJFw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.miao@linaro.org>
Cc: eric@eukrea.com, linux-ide@vger.kernel.org, Richard Zhu <richard.zhu@linaro.org>, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2011 at 05:54:23PM +0800, Eric Miao wrote:
> On Mon, Aug 29, 2011 at 5:37 PM, Wolfram Sang <w.sang@pengutronix.de> wro=
te:
> > On Mon, Aug 29, 2011 at 04:51:46PM +0800, Eric Miao wrote:
> >> On Mon, Aug 29, 2011 at 4:36 PM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
> >> > On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> >> >> On imx53 AHCI, soft reset fails with IPMS set when PMP
> >> >> is enabled but SATA HDD/ODD is connected to SATA port,
> >> >> do soft reset again to port 0.
> >> >> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> >> >> ahci is present.
> >> >>
> >> >> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> >> >> ---
> >> >> =A0drivers/ata/ahci_platform.c | =A0 44 +++++++++++++++++++++++++++=
++++++++++-----
> >> >> =A01 files changed, 38 insertions(+), 6 deletions(-)
> >> >>
> >> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platfor=
m.c
> >> >> index 6fef1fa..f32c91e 100644
> >> >> --- a/drivers/ata/ahci_platform.c
> >> >> +++ b/drivers/ata/ahci_platform.c
> >> >> @@ -23,6 +23,41 @@
> >> >> =A0#include <linux/ahci_platform.h>
> >> >> =A0#include "ahci.h"
> >> >>
> >> >> +enum ahci_type {
> >> >> + =A0 =A0 AHCI, =A0 =A0 =A0 =A0 =A0 /* standard platform ahci */
> >> >> + =A0 =A0 IMX53_AHCI, =A0 =A0 /* ahci on i.mx53 */
> >> >
> >> > How about making all the IMX*-naming more generic because other SoC =
might need
> >> > this somewhen, too?
> >>
> >> From a practical point of view, we can start with what we know already.
> >> As the SATA controller on "other SoC" so far, we don't know yet if they
> >> show the same issue (which we have to use ahci_pmp_retry_srst_ops).
> >>
> >> So Wolfram, how about we consider a generic one once more controllers
> >> are being added?
> >
> > If we do so later, and we then also change the platform_device_id to so=
mething
> > generic, we then also have to change all users, too. Is it so bad to ch=
ange
> > IMX53_AHCI (and imx53-ahci and alike) to something like "ahci-pmp-retry=
-srst"
> > (or similar) now?
>=20
> There are other fields in ata_port_info which might be different between
> boards. Using a SoC specific name as an index to an array of ata_port_info
> will be more flexible, as is adopted in drivers/ata/ahci.c - the PCI driv=
er.

Well, that file also has generic fixups:

       [board_ahci_ign_iferr] =3D
=2E..

which is what I had in mind thinking that the flaw was not too imx53 specif=
ic.
If you think I am wrong, then be it. I mainly wanted to avoid the fixups wh=
ich
might be needed later.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5bcbgACgkQD27XaX1/VRu/7QCfXdDYJEGF2dEKmSntFgP1nZbH
yasAoJWzgrXk6dBqVWtQKnBJ/OmVmxy/
=UY8O
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
