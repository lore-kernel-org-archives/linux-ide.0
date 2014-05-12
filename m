From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 3/6] ata: ahci: add AHCI support for the Berlin BG2Q
Date: Mon, 12 May 2014 16:12:21 +0200
Message-ID: <20140512141221.GE3378@lunn.ch>
References: <1399886217-20474-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399886217-20474-4-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399886217-20474-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, tj@kernel.org, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alexandre.belloni@free-electrons.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Mon, May 12, 2014 at 11:16:54AM +0200, Antoine T=E9nart wrote:
> Add support for the Berlin BG2Q AHCI SATA controller allowing to
> interface with devices like external hard drives.
>=20
> Signed-off-by: Antoine T=E9nart <antoine.tenart@free-electrons.com>
> ---
>  drivers/ata/Kconfig       |  10 +++
>  drivers/ata/Makefile      |   1 +
>  drivers/ata/ahci_berlin.c | 202 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 drivers/ata/ahci_berlin.c
>=20
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index c2706047337f..37e6817b31f4 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -97,6 +97,16 @@ config SATA_AHCI_PLATFORM
> =20
>  	  If unsure, say N.
> =20
> +config AHCI_BERLIN
> +	tristate "Marvell Berlin AHCI SATA support"
> +	depends on ARCH_BERLIN
> +	select PHY_BERLIN_SATA
> +	help
> +	  This option enables support for the Marvell Berlin SoC's
> +	  onboard AHCI SATA.
> +
> +	  If unsure, say N.
> +
>  config AHCI_DA850
>  	tristate "DaVinci DA850 AHCI SATA support"
>  	depends on ARCH_DAVINCI_DA850
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 44c8016e565c..7fb78d1e0a44 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SATA_INIC162X)	+=3D sata_inic162x.o
>  obj-$(CONFIG_SATA_SIL24)	+=3D sata_sil24.o
>  obj-$(CONFIG_SATA_DWC)		+=3D sata_dwc_460ex.o
>  obj-$(CONFIG_SATA_HIGHBANK)	+=3D sata_highbank.o libahci.o
> +obj-$(CONFIG_AHCI_BERLIN)	+=3D ahci_berlin.o libahci.o libahci_platf=
orm.o
>  obj-$(CONFIG_AHCI_DA850)	+=3D ahci_da850.o libahci.o libahci_platfor=
m.o
>  obj-$(CONFIG_AHCI_IMX)		+=3D ahci_imx.o libahci.o libahci_platform.o
>  obj-$(CONFIG_AHCI_SUNXI)	+=3D ahci_sunxi.o libahci.o libahci_platfor=
m.o
> diff --git a/drivers/ata/ahci_berlin.c b/drivers/ata/ahci_berlin.c
> new file mode 100644
> index 000000000000..973c07e54a6a
> --- /dev/null
> +++ b/drivers/ata/ahci_berlin.c
> @@ -0,0 +1,202 @@
> +/*
> + * Marvell Berlin AHCI SATA platform driver
> + *
> + * Copyright (C) 2014 Marvell Technology Group Ltd.
> + *
> + * Antoine T=E9nart <antoine.tenart@free-electrons.com>
> + * Jisheng Zhang <jszhang@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/ahci_platform.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "ahci.h"
> +
> +#define BERLIN_SATA_NPORTS	2
> +
> +#define PORT_VSR_ADDR		0x78
> +#define PORT_VSR_DATA		0x7c
> +
> +#define PHY_BASE		0x200
> +
> +/* register 0x01 */
> +#define REF_FREF_SEL_25		BIT(0)
> +#define PHY_MODE_SATA		(0x0 << 5)
> +
> +/* register 0x02 */
> +#define USE_MAX_PLL_RATE	BIT(12)
> +
> +/* register 0x23 */
> +#define DATA_BIT_WIDTH_10	(0x0 << 10)
> +#define DATA_BIT_WIDTH_20	(0x1 << 10)
> +#define DATA_BIT_WIDTH_40	(0x2 << 10)
> +
> +/* register 0x25 */
> +#define PHY_GEN_MAX_1_5		(0x0 << 10)
> +#define PHY_GEN_MAX_3_0		(0x1 << 10)
> +#define PHY_GEN_MAX_6_0		(0x2 << 10)
> +
> +struct berlin_ahci_priv {
> +	struct ahci_host_priv	*hpriv;
> +	struct phy		*phys[BERLIN_SATA_NPORTS];
> +};
> +
> +static inline void ahci_berlin_reg_setbits(void __iomem *ctrl_reg, u=
32 reg,
> +					   u32 mask, u32 val)
> +{
> +	u32 regval;
> +
> +	/* select register */
> +	writel(PHY_BASE + reg, ctrl_reg + PORT_VSR_ADDR);
> +
> +	/* set bits */
> +	regval =3D readl(ctrl_reg + PORT_VSR_DATA);
> +	regval &=3D ~mask;
> +	regval |=3D val;
> +	writel(regval, ctrl_reg + PORT_VSR_DATA);
> +}
> +
> +static void ahci_berlin_port_init(struct ahci_host_priv *hpriv,
> +				  unsigned int port)
> +{
> +	struct berlin_ahci_priv *berlin_priv =3D hpriv->plat_data;
> +	void __iomem *ctrl_reg =3D hpriv->mmio + 0x100 + (port * 0x80);
> +
> +	/* power on the PHY */
> +	phy_power_on(berlin_priv->phys[port]);
> +
> +	/* set PHY mode to SATA, ref freq to 25 MHz */
> +	ahci_berlin_reg_setbits(ctrl_reg, 0x1, 0xff, REF_FREF_SEL_25 | PHY_=
MODE_SATA);
> +
> +	/* set PHY up to 6 Gbps */
> +	ahci_berlin_reg_setbits(ctrl_reg, 0x25, 0xc00, PHY_GEN_MAX_6_0);
> +
> +	/* set 40 bits width */
> +	ahci_berlin_reg_setbits(ctrl_reg, 0x23,  0xc00, DATA_BIT_WIDTH_40);
> +
> +	/* use max pll rate */
> +	ahci_berlin_reg_setbits(ctrl_reg, 0x2, 0x0, USE_MAX_PLL_RATE);
> +
> +	/* set the controller speed */
> +	writel(0x31, ctrl_reg + PORT_SCR_CTL);
> +}

Hi Antoine

I've no idea is this is a good or bad idea, but could you put all the
above code in the phy driver? It does seem to be mostly phy
related. Then teach the core ahci code about optional phy nodes in DT.
You can then probably do without a ahci berlin driver.

    Andrew
