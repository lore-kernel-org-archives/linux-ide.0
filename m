From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
 platforms
Date: Wed, 21 Sep 2011 09:02:01 +0200
Message-ID: <20110921070201.GB14191@pengutronix.de>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
 <1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
 <20110920203037.GE31404@pengutronix.de>
 <CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38070 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab1IUHCI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2011 03:02:08 -0400
Content-Disposition: inline
In-Reply-To: <CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: eric@eukrea.com, eric.miao@linaro.org, linux-ide@vger.kernel.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, jgarzik@pobox.com, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

On Wed, Sep 21, 2011 at 01:04:09PM +0800, Richard Zhu wrote:
> Hi Sascha:
> Thanks for your comments.
>=20
> Best Regard
> Richard Zhu
>=20
> On 21 September 2011 04:30, Sascha Hauer <s.hauer@pengutronix.de> wro=
te:
> > On Wed, Aug 31, 2011 at 11:50:31AM +0800, Richard Zhu wrote:
> >> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> >> Tested-By: Hector Oron Martinez <hector.oron@gmail.com>
> >> ---
> >> =A0arch/arm/mach-mx5/clock-mx51-mx53.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 19 ++++
> >> =A0arch/arm/mach-mx5/devices-imx53.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A04 +
> >> =A0arch/arm/plat-mxc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A01 +
> >> =A0arch/arm/plat-mxc/ahci_sata.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0104 +++++++++++++++++++++++
> >> =A0arch/arm/plat-mxc/devices/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A04 +
> >> =A0arch/arm/plat-mxc/devices/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A01 +
> >> =A0arch/arm/plat-mxc/devices/platform-ahci-imx.c =A0 | =A0 66 ++++=
++++++++++
> >> =A0arch/arm/plat-mxc/include/mach/ahci_sata.h =A0 =A0 =A0| =A0 33 =
+++++++
> >> =A0arch/arm/plat-mxc/include/mach/devices-common.h | =A0 10 ++
> >> =A09 files changed, 242 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 arch/arm/plat-mxc/ahci_sata.c
> >> =A0create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.=
c
> >> =A0create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
> >>
> >> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-m=
x5/clock-mx51-mx53.c
> >> index 7f20308..e1fadaf 100644
> >> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> @@ -1397,6 +1397,22 @@ static struct clk esdhc4_mx53_clk =3D {
> >> =A0 =A0 =A0 .secondary =3D &esdhc4_ipg_clk,
> >> =A0};
> >>
> >> diff --git a/arch/arm/plat-mxc/ahci_sata.c b/arch/arm/plat-mxc/ahc=
i_sata.c
> >> new file mode 100644
> >> index 0000000..4f54816
> >> --- /dev/null
> >> +++ b/arch/arm/plat-mxc/ahci_sata.c
> >> @@ -0,0 +1,104 @@
> >> +/*
> >> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Re=
served.
> >> + */
> >> +
> >> +/*
> >> + * This program is free software; you can redistribute it and/or =
modify
> >> + * it under the terms of the GNU General Public License as publis=
hed by
> >> + * the Free Software Foundation; either version 2 of the License,=
 or
> >> + * (at your option) any later version.
> >> +
> >> + * This program is distributed in the hope that it will be useful=
,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
> >> + * GNU General Public License for more details.
> >> +
> >> + * You should have received a copy of the GNU General Public Lice=
nse along
> >> + * with this program; if not, write to the Free Software Foundati=
on, Inc.,
> >> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#include <linux/io.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/err.h>
> >> +#include <linux/device.h>
> >> +#include <mach/ahci_sata.h>
> >> +
> >> +static struct clk *sata_clk, *sata_ref_clk;
> >
> > These variables make the driver single instance only.
> [Richard Zhu] In order to handle the clock enable/disable stuff, thes=
e
> two variables are mandatory required.
> Otherwise, new two struct clk members had to be added into
> ahci_platform_data struct. Then the clks can
> be transferred by the platform data.
> The current is preferred, refer to the second choice.
> >
> >> +
> >> +/* AHCI module Initialization, if return 0, initialization is suc=
cessful. */
> >> +int sata_init(struct device *dev, void __iomem *addr)
> >
> > A global function with such a generic name is not a good idea.
> > Also I wonder how we want to convert this to devicetree when we
> > implement this as a platform specific hook. It should be done in th=
e
> > driver.
> >
> [Richard Zhu] The name of these two func can be changed.
> But I don't have a good idea to move out these two platform specific
> hooks (->init, ->exit).
>=20
> Refer to you comments, do you means that the ->init and ->exit should
> be done in ahci_platform.c driver?
> Different platform may have the different ->init and ->exit funcs to
> handle it's own initialization and exit.
> It would be a problem that handle all kinds of init in one driver
> without the hooks.

Maybe Shawn can comment on the device tree topic. I just think that if
we merge this without devicetree support it should at least be
devicetree friendly. For example each platform could provide it's own
platform driver glue code like it's done for the sdhci driver.

> >> diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/=
arm/plat-mxc/devices/platform-ahci-imx.c
> >> new file mode 100644
> >> index 0000000..9e1b460
> >> --- /dev/null
> >> +++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
> >> @@ -0,0 +1,66 @@
> >> +/*
> >> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Re=
served.
> >> + */
> >> +
> >> +/*
> >> + * This program is free software; you can redistribute it and/or =
modify
> >> + * it under the terms of the GNU General Public License as publis=
hed by
> >> + * the Free Software Foundation; either version 2 of the License,=
 or
> >> + * (at your option) any later version.
> >> +
> >> + * This program is distributed in the hope that it will be useful=
,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
> >> + * GNU General Public License for more details.
> >> +
> >> + * You should have received a copy of the GNU General Public Lice=
nse along
> >> + * with this program; if not, write to the Free Software Foundati=
on, Inc.,
> >> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#include <linux/dma-mapping.h>
> >> +#include <asm/sizes.h>
> >> +#include <mach/hardware.h>
> >> +#include <mach/devices-common.h>
> >> +#include <mach/ahci_sata.h>
> >> +
> >> +#define imx_ahci_imx_data_entry_single(soc, _devid) =A0 =A0 =A0 =A0=
 =A0\
> >> + =A0 =A0 { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .devid =3D _devid, =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .iobase =3D soc ## _SATA_BASE_ADDR, =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 .irq =3D soc ## _INT_SATA, =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> >> + =A0 =A0 }
> >> +
> >> +#ifdef CONFIG_SOC_IMX53
> >> +const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =3D
> >> + =A0 =A0 imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
> >> +#endif
> >> +
> >> +static struct ahci_platform_data default_sata_pdata =3D {
> >> + =A0 =A0 .init =3D sata_init,
> >> + =A0 =A0 .exit =3D sata_exit,
> >> +};

If we continue going the way you started, please add the
sata_init/sata_exit functions as static functions to this file, ...

> >> +
> >> +struct platform_device *__init imx_add_ahci_imx(
> >> + =A0 =A0 =A0 =A0 =A0 =A0 const struct imx_ahci_imx_data *data,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 const struct ahci_platform_data *pdata)
> >> +{
> >> + =A0 =A0 struct resource res[] =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D data->iobase,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =3D data->iobase + =
SZ_4K - 1,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_ME=
M,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }, {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D data->irq,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =3D data->irq,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_IR=
Q,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 },
> >> + =A0 =A0 };
> >> +
> >> + =A0 =A0 if (pdata =3D=3D NULL)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &default_sata_pdata;

=2E..remove these two lines, and instead introduce a function like this=
:

struct platform_device *__init imx53_add_ahci_imx(void)
{
	struct ahci_platform_data pdata =3D {
		.init =3D imx53_sata_init,
		.exit =3D imx53_sata_exit,
	};

	return imx_add_ahci_imx(&imx53_ahci_imx_data, &pdata);
}


--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
