From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V3 1/2] AHCI Add the AHCI SATA feature on MX53 platforms
Date: Mon, 11 Apr 2011 10:17:03 +0200
Message-ID: <20110411081703.GH18601@pengutronix.de>
References: <1302509153-30326-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58686 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab1DKIRO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2011 04:17:14 -0400
Content-Disposition: inline
In-Reply-To: <1302509153-30326-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

Hello Richard,

On Mon, Apr 11, 2011 at 04:05:52PM +0800, Richard Zhu wrote:
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c             |   11 +++++
>  arch/arm/mach-mx5/devices-imx53.h               |    4 ++
>  arch/arm/plat-mxc/Makefile                      |    1 +
>  arch/arm/plat-mxc/ahci_sata.c                   |   43 +++++++++++++=
+++++
>  arch/arm/plat-mxc/devices/Kconfig               |    4 ++
>  arch/arm/plat-mxc/devices/Makefile              |    1 +
>  arch/arm/plat-mxc/devices/platform-ahci-imx.c   |   55 +++++++++++++=
++++++++++
>  arch/arm/plat-mxc/include/mach/ahci_sata.h      |   52 +++++++++++++=
++++++++
>  arch/arm/plat-mxc/include/mach/devices-common.h |   10 ++++
>  9 files changed, 181 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/ahci_sata.c
>  create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
>  create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
>=20
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/=
clock-mx51-mx53.c
> index 652ace4..8bf2bab 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1380,6 +1380,14 @@ static struct clk esdhc4_mx53_clk =3D {
>  	.secondary =3D &esdhc4_ipg_clk,
>  };
> =20
> +static struct clk sata_clk =3D {
> +	.parent =3D &ipg_clk,
> +	.enable =3D _clk_max_enable,
> +	.enable_reg =3D MXC_CCM_CCGR4,
> +	.enable_shift =3D MXC_CCM_CCGRx_CG1_OFFSET,
> +	.disable =3D _clk_max_disable,
> +};
> +
>  DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG5_OFFSE=
T, NULL, NULL, NULL, &pll2_sw_clk);
>  DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG4_OFFS=
ET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
>  DEFINE_CLOCK(mipi_hsc1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG3_OFFS=
ET, NULL, NULL, &mipi_hsc2_clk, &pll2_sw_clk);
> @@ -1468,6 +1476,9 @@ static struct clk_lookup mx53_lookups[] =3D {
>  	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
>  	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
>  	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
> +	_REGISTER_CLOCK("ahci.0", NULL, sata_clk)
> +	_REGISTER_CLOCK(NULL, "usb_phy1", usb_phy1_clk)
> +	_REGISTER_CLOCK(NULL, "ahb", ahb_clk)
>  };
> =20
>  static void clk_tree_init(void)
> diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/de=
vices-imx53.h
> index 9251008..09ebb43 100644
> --- a/arch/arm/mach-mx5/devices-imx53.h
> +++ b/arch/arm/mach-mx5/devices-imx53.h
> @@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_da=
ta[] __initconst;
>  extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initco=
nst;
>  #define imx53_add_imx2_wdt(id, pdata)	\
>  	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
> +
> +extern const struct imx_ahci_imx_data imx53_ahci_imx_data[] __initco=
nst;
> +#define imx53_add_ahci_imx(id, pdata)   \
> +	imx_add_ahci_imx(&imx53_ahci_imx_data[id], pdata)
The platform device name is "ahci", so please use imx(53)?_add_ahci(...=
)
here.

> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index a138787..4f308c6 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) +=3D audmux-v1.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) +=3D audmux-v2.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) +=3D 3ds_debugboard.o
>  obj-$(CONFIG_CPU_FREQ_IMX)    +=3D cpufreq.o
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_SATA_AHCI)	+=3D ahci_sata.o
CONFIG_IMX_HAVE_PLATFORM_AHCI for the same reason.

>  ifdef CONFIG_SND_IMX_SOC
>  obj-y +=3D ssi-fiq.o
>  obj-y +=3D ssi-fiq-ksym.o
> diff --git a/arch/arm/plat-mxc/ahci_sata.c b/arch/arm/plat-mxc/ahci_s=
ata.c
> new file mode 100644
> index 0000000..49cbb68
> --- /dev/null
> +++ b/arch/arm/plat-mxc/ahci_sata.c
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reser=
ved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHA=
NTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public =
License
> + * for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Found=
ation,
> + * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
this address isn't valid anymore.

> + */
> +
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <mach/ahci_sata.h>
> +
> +/* AHCI module Initialization, if return 0, initialization is succes=
sful. */
> +int sata_init(void __iomem *addr, struct clk *clk)
> +{
> +	u32 tmpdata;
> +
> +	tmpdata =3D readl(addr + HOST_CAP);
> +	if (!(tmpdata & HOST_CAP_SSS)) {
> +		tmpdata |=3D HOST_CAP_SSS;
> +		writel(tmpdata, addr + HOST_CAP);
> +	}
> +
> +	if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
> +		writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
> +			addr + HOST_PORTS_IMPL);
> +
> +	tmpdata =3D clk_get_rate(clk) / 1000;
> +	clk_put(clk);
Where is the symmetric clk_get?

> +	writel(tmpdata, addr + HOST_TIMER1MS);
> +
> +	return 0;
> +}
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/de=
vices/Kconfig
> index b9ab1d5..087595a 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -71,3 +71,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> =20
>  config IMX_HAVE_PLATFORM_SPI_IMX
>  	bool
> +
> +config IMX_HAVE_PLATFORM_SATA_AHCI
> +	bool
> +	default y if SOC_IMX53
Can you please keep this file sorted by config name?
Do all i.MX53 have ahci? If so, consider registration as it is done for
mxc_rnga. If not, please let the machines that really use it select
IMX_HAVE_PLATFORM_AHCI.

> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/d=
evices/Makefile
> index 75cd2ec..e0b7fa3 100644
> --- a/arch/arm/plat-mxc/devices/Makefile
> +++ b/arch/arm/plat-mxc/devices/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RNGA) +=3D platf=
orm-mxc_rnga.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) +=3D platform-mxc_w1.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) +=3D platform-sdhci-=
esdhc-imx.o
>  obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=3D  platform-spi_imx.o
> +obj-$(CONFIG_IMX_HAVE_PLATFORM_SATA_AHCI) +=3D  platform-ahci-imx.o
This file is sorted, too.

> diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm=
/plat-mxc/devices/platform-ahci-imx.c
> new file mode 100644
> index 0000000..d6da344
> --- /dev/null
> +++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reser=
ved.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <asm/sizes.h>
> +#include <mach/hardware.h>
> +#include <mach/devices-common.h>
> +
> +#define imx_ahci_data_entry_single(soc)					\
> +	{								\
> +		.iobase =3D soc ## _SATA_BASE_ADDR,			\
> +		.irq =3D soc ## _INT_SATA,				\
> +	}
> +
> +#ifdef CONFIG_SOC_IMX53
> +const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =3D
> +	imx_ahci_data_entry_single(MX53);
> +#endif
arch/arm/mach-mx5/devices-imx53.h declares this to be an array.

> +
> +struct platform_device *__init imx_add_ahci_imx(
> +		const struct imx_ahci_imx_data *data,
> +		const struct ahci_platform_data *pdata)
> +{
> +	struct resource res[] =3D {
> +		{
> +			.start =3D data->iobase,
> +			.end =3D data->iobase + SZ_4K - 1,
> +			.flags =3D IORESOURCE_MEM,
> +		}, {
> +			.start =3D data->irq,
> +			.end =3D data->irq,
> +			.flags =3D IORESOURCE_IRQ,
> +		},
> +	};
> +
> +	return imx_add_platform_device_dmamask("ahci", 0,
> +			res, ARRAY_SIZE(res),
> +			pdata, sizeof(*pdata),  DMA_BIT_MASK(32));
s/  / /

> +}
> diff --git a/arch/arm/plat-mxc/include/mach/ahci_sata.h b/arch/arm/pl=
at-mxc/include/mach/ahci_sata.h
> new file mode 100644
> index 0000000..6adf67a
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/ahci_sata.h
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reser=
ved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHA=
NTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public =
License
> + * for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Found=
ation,
> + * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __PLAT_MXC_AHCI_SATA_H__
> +#define __PLAT_MXC_AHCI_SATA_H__
> +
> +enum {
> +	HOST_CAP =3D 0x00,
> +	HOST_CAP_SSS =3D (1 << 27), /* Staggered Spin-up */
> +	HOST_PORTS_IMPL	=3D 0x0c,
> +	HOST_TIMER1MS =3D 0xe0, /* Timer 1-ms */
> +	/* Offest used to control the MPLL input clk */
> +	PHY_CR_CLOCK_FREQ_OVRD =3D 0x12,
> +	/* Port0 SATA Status */
> +	PORT_SATA_SR =3D 0x128,
> +	/* Port0 PHY Control */
> +	PORT_PHY_CTL =3D 0x178,
> +	/* PORT_PHY_CTL bits */
> +	PORT_PHY_CTL_CAP_ADR_LOC =3D 0x10000,
> +	PORT_PHY_CTL_CAP_DAT_LOC =3D 0x20000,
> +	PORT_PHY_CTL_WRITE_LOC =3D 0x40000,
> +	PORT_PHY_CTL_READ_LOC =3D 0x80000,
> +	/* Port0 PHY Status */
> +	PORT_PHY_SR =3D 0x17c,
> +	/* PORT_PHY_SR */
> +	PORT_PHY_STAT_DATA_LOC =3D 0,
> +	PORT_PHY_STAT_ACK_LOC =3D 18,
> +	/* SATA PHY Register */
> +	SATA_PHY_CR_CLOCK_CRCMP_LT_LIMIT =3D 0x0001,
> +	SATA_PHY_CR_CLOCK_DAC_CTL =3D 0x0008,
> +	SATA_PHY_CR_CLOCK_RTUNE_CTL =3D 0x0009,
> +	SATA_PHY_CR_CLOCK_ADC_OUT =3D 0x000A,
> +	SATA_PHY_CR_CLOCK_MPLL_TST =3D 0x0017,
> +};
> +
> +extern int sata_init(void __iomem *addr, struct clk *clk);
> +#endif /* __PLAT_MXC_AHCI_SATA_H__ */
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/a=
rm/plat-mxc/include/mach/devices-common.h
> index 8658c9c..81baca6 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -264,3 +264,13 @@ struct imx_spi_imx_data {
>  struct platform_device *__init imx_add_spi_imx(
>  		const struct imx_spi_imx_data *data,
>  		const struct spi_imx_master *pdata);
> +
> +#include <linux/ahci_platform.h>
> +struct imx_ahci_imx_data {
> +	int id;
> +	resource_size_t iobase;
> +	resource_size_t irq;
> +};
> +struct platform_device *__init imx_add_ahci_imx(
> +		const struct imx_ahci_imx_data *data,
> +		const struct ahci_platform_data *pdata);
this file is sorted, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
