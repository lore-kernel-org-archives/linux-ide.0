From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v4 4/7] ata: ahci_platform: add the Marvell Berlin AHCI
 compatible
Date: Tue, 20 May 2014 11:23:07 +0200
Message-ID: <20140520092307.GA26491@kwain>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-5-git-send-email-antoine.tenart@free-electrons.com>
 <537B1DD3.2040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <537B1DD3.2040104@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, tj@kernel.org, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, May 20, 2014 at 11:18:11AM +0200, Sebastian Hesselbarth wrote:
> On 05/20/2014 11:04 AM, Antoine T=E9nart wrote:
> >The Marvell Berlin AHCI has all his specific in the PHY driver. It t=
hen
> >only need to use the libahci functions to work properly.
>=20
> If it is that generic, ..
>=20
> >Add its compatible into the libahci_platform driver.
> >
> >Signed-off-by: Antoine T=E9nart <antoine.tenart@free-electrons.com>
> >---
> >  drivers/ata/ahci_platform.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform=
=2Ec
> >index ef67e79944f9..bc050aabf206 100644
> >--- a/drivers/ata/ahci_platform.c
> >+++ b/drivers/ata/ahci_platform.c
> >@@ -76,6 +76,7 @@ static const struct of_device_id ahci_of_match[] =3D=
 {
> >  	{ .compatible =3D "snps,exynos5440-ahci", },
> >  	{ .compatible =3D "ibm,476gtr-ahci", },
> >  	{ .compatible =3D "snps,dwc-ahci", },
> >+	{ .compatible =3D "marvell,berlin-ahci", },
>=20
> .. why have a Marvell-specific compatible?

Well, the 3 other compatibles seemed as generic as the marvell one. Jus=
t
following what was done before here.

> How about "generic-ahci" instead, like we have for other fooHCIs
> already?

That would avoid an endless list of compatibles :)

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
