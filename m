From: Richard Zhu <richard.zhu@linaro.org>
Subject: Re: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53 platforms
Date: Wed, 21 Sep 2011 13:04:09 +0800
Message-ID: <CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
	<20110920203037.GE31404@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:47807 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1IUFEK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2011 01:04:10 -0400
Received: by yib18 with SMTP id 18so816129yib.19
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2011 22:04:10 -0700 (PDT)
In-Reply-To: <20110920203037.GE31404@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

Hi Sascha:
Thanks for your comments.

Best Regard
Richard Zhu

On 21 September 2011 04:30, Sascha Hauer <s.hauer@pengutronix.de> wrote=
:
> On Wed, Aug 31, 2011 at 11:50:31AM +0800, Richard Zhu wrote:
>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>> Tested-By: Hector Oron Martinez <hector.oron@gmail.com>
>> ---
>> =A0arch/arm/mach-mx5/clock-mx51-mx53.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 19 ++++
>> =A0arch/arm/mach-mx5/devices-imx53.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A04 +
>> =A0arch/arm/plat-mxc/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A01 +
>> =A0arch/arm/plat-mxc/ahci_sata.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0104 +++++++++++++++++++++++
>> =A0arch/arm/plat-mxc/devices/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A04 +
>> =A0arch/arm/plat-mxc/devices/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
>> =A0arch/arm/plat-mxc/devices/platform-ahci-imx.c =A0 | =A0 66 ++++++=
++++++++
>> =A0arch/arm/plat-mxc/include/mach/ahci_sata.h =A0 =A0 =A0| =A0 33 ++=
+++++
>> =A0arch/arm/plat-mxc/include/mach/devices-common.h | =A0 10 ++
>> =A09 files changed, 242 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-mxc/ahci_sata.c
>> =A0create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
>> =A0create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
>>
>> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5=
/clock-mx51-mx53.c
>> index 7f20308..e1fadaf 100644
>> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
>> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
>> @@ -1397,6 +1397,22 @@ static struct clk esdhc4_mx53_clk =3D {
>> =A0 =A0 =A0 .secondary =3D &esdhc4_ipg_clk,
>> =A0};
>>
>> diff --git a/arch/arm/plat-mxc/ahci_sata.c b/arch/arm/plat-mxc/ahci_=
sata.c
>> new file mode 100644
>> index 0000000..4f54816
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/ahci_sata.c
>> @@ -0,0 +1,104 @@
>> +/*
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Rese=
rved.
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> +
>> + * You should have received a copy of the GNU General Public Licens=
e along
>> + * with this program; if not, write to the Free Software Foundation=
, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/device.h>
>> +#include <mach/ahci_sata.h>
>> +
>> +static struct clk *sata_clk, *sata_ref_clk;
>
> These variables make the driver single instance only.
[Richard Zhu] In order to handle the clock enable/disable stuff, these
two variables are mandatory required.
Otherwise, new two struct clk members had to be added into
ahci_platform_data struct. Then the clks can
be transferred by the platform data.
The current is preferred, refer to the second choice.
>
>> +
>> +/* AHCI module Initialization, if return 0, initialization is succe=
ssful. */
>> +int sata_init(struct device *dev, void __iomem *addr)
>
> A global function with such a generic name is not a good idea.
> Also I wonder how we want to convert this to devicetree when we
> implement this as a platform specific hook. It should be done in the
> driver.
>
[Richard Zhu] The name of these two func can be changed.
But I don't have a good idea to move out these two platform specific
hooks (->init, ->exit).

Refer to you comments, do you means that the ->init and ->exit should
be done in ahci_platform.c driver?
Different platform may have the different ->init and ->exit funcs to
handle it's own initialization and exit.
It would be a problem that handle all kinds of init in one driver
without the hooks.

>> +{
>> + =A0 =A0 u32 tmpdata;
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 struct clk *clk;
>> +
>> + =A0 =A0 sata_clk =3D clk_get(dev, "ahci");
>> + =A0 =A0 if (IS_ERR(sata_clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no sata clock.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(sata_clk);
>> + =A0 =A0 }
>> + =A0 =A0 ret =3D clk_enable(sata_clk);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "can't enable sata clock.\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto put_sata_clk;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* FSL IMX AHCI SATA uses the internal usb phy1 clk on loc=
o */
>
> So this function is loco specific or is the comment wrong?
[Richard Zhu] Comments wrong, they're common codes and should't be
specified by the exact
 board, would be changed later.
>
>> + =A0 =A0 sata_ref_clk =3D clk_get(dev, "ahci_phy");
>> + =A0 =A0 if (IS_ERR(sata_ref_clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no sata ref clock.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(sata_ref_clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto release_sata_clk;
>> + =A0 =A0 }
>> + =A0 =A0 ret =3D clk_enable(sata_ref_clk);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "can't enable sata ref clock.=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto put_sata_ref_clk;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Get the AHB clock rate, and configure the TIMER1MS reg =
later */
>> + =A0 =A0 clk =3D clk_get(dev, "ahci_dma");
>> + =A0 =A0 if (IS_ERR(clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "no dma clock.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto release_sata_ref_clk;
>> + =A0 =A0 }
>> + =A0 =A0 tmpdata =3D clk_get_rate(clk) / 1000;
>> + =A0 =A0 clk_put(clk);
>> +
>> + =A0 =A0 writel(tmpdata, addr + HOST_TIMER1MS);
>> +
>> + =A0 =A0 tmpdata =3D readl(addr + HOST_CAP);
>> + =A0 =A0 if (!(tmpdata & HOST_CAP_SSS)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tmpdata |=3D HOST_CAP_SSS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel(tmpdata, addr + HOST_CAP);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
>> + =A0 =A0 =A0 =A0 =A0 =A0 writel((readl(addr + HOST_PORTS_IMPL) | 0x=
1),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr + HOST_PORTS_IMPL);
>> +
>> + =A0 =A0 return 0;
>> +
>> +release_sata_ref_clk:
>> + =A0 =A0 clk_disable(sata_ref_clk);
>> +put_sata_ref_clk:
>> + =A0 =A0 clk_put(sata_ref_clk);
>> +release_sata_clk:
>> + =A0 =A0 clk_disable(sata_clk);
>> +put_sata_clk:
>> + =A0 =A0 clk_put(sata_clk);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +void sata_exit(struct device *dev)
>> +{
>> + =A0 =A0 clk_disable(sata_ref_clk);
>> + =A0 =A0 clk_put(sata_ref_clk);
>> +
>> + =A0 =A0 clk_disable(sata_clk);
>> + =A0 =A0 clk_put(sata_clk);
>> +
>> +}
>> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/d=
evices/Kconfig
>> index bd294ad..f63887b 100644
>> --- a/arch/arm/plat-mxc/devices/Kconfig
>> +++ b/arch/arm/plat-mxc/devices/Kconfig
>> @@ -76,3 +76,7 @@ config IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
>>
>> =A0config IMX_HAVE_PLATFORM_SPI_IMX
>> =A0 =A0 =A0 bool
>> +
>> +config IMX_HAVE_PLATFORM_AHCI
>> + =A0 =A0 bool
>> + =A0 =A0 default y if ARCH_MX53
>> diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/=
devices/Makefile
>> index b41bf97..e858ad9 100644
>> --- a/arch/arm/plat-mxc/devices/Makefile
>> +++ b/arch/arm/plat-mxc/devices/Makefile
>> @@ -25,3 +25,4 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_RTC) +=3D platf=
orm-mxc_rtc.o
>> =A0obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_W1) +=3D platform-mxc_w1.o
>> =A0obj-$(CONFIG_IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX) +=3D platform-sdh=
ci-esdhc-imx.o
>> =A0obj-$(CONFIG_IMX_HAVE_PLATFORM_SPI_IMX) +=3D =A0platform-spi_imx.=
o
>> +obj-$(CONFIG_IMX_HAVE_PLATFORM_AHCI) +=3D =A0platform-ahci-imx.o
>> diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/ar=
m/plat-mxc/devices/platform-ahci-imx.c
>> new file mode 100644
>> index 0000000..9e1b460
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
>> @@ -0,0 +1,66 @@
>> +/*
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Rese=
rved.
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> +
>> + * You should have received a copy of the GNU General Public Licens=
e along
>> + * with this program; if not, write to the Free Software Foundation=
, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <asm/sizes.h>
>> +#include <mach/hardware.h>
>> +#include <mach/devices-common.h>
>> +#include <mach/ahci_sata.h>
>> +
>> +#define imx_ahci_imx_data_entry_single(soc, _devid) =A0 =A0 =A0 =A0=
 =A0\
>> + =A0 =A0 { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devid =3D _devid, =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 .iobase =3D soc ## _SATA_BASE_ADDR, =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 .irq =3D soc ## _INT_SATA, =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 }
>> +
>> +#ifdef CONFIG_SOC_IMX53
>> +const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =3D
>> + =A0 =A0 imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
>> +#endif
>> +
>> +static struct ahci_platform_data default_sata_pdata =3D {
>> + =A0 =A0 .init =3D sata_init,
>> + =A0 =A0 .exit =3D sata_exit,
>> +};
>> +
>> +struct platform_device *__init imx_add_ahci_imx(
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct imx_ahci_imx_data *data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct ahci_platform_data *pdata)
>> +{
>> + =A0 =A0 struct resource res[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D data->iobase,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =3D data->iobase + SZ=
_4K - 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_MEM,
>> + =A0 =A0 =A0 =A0 =A0 =A0 }, {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =3D data->irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =3D data->irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_IRQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 };
>> +
>> + =A0 =A0 if (pdata =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &default_sata_pdata;
>> +
>> + =A0 =A0 return imx_add_platform_device_dmamask(data->devid, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res, ARRAY_SIZE(res),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata, sizeof(*pdata), =A0=
DMA_BIT_MASK(32));
>> +}
>> diff --git a/arch/arm/plat-mxc/include/mach/ahci_sata.h b/arch/arm/p=
lat-mxc/include/mach/ahci_sata.h
>> new file mode 100644
>> index 0000000..ba297e1
>> --- /dev/null
>> +++ b/arch/arm/plat-mxc/include/mach/ahci_sata.h
>> @@ -0,0 +1,33 @@
>> +/*
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Rese=
rved.
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> +
>> + * You should have received a copy of the GNU General Public Licens=
e along
>> + * with this program; if not, write to the Free Software Foundation=
, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#ifndef __PLAT_MXC_AHCI_SATA_H__
>> +#define __PLAT_MXC_AHCI_SATA_H__
>> +
>> +enum {
>> + =A0 =A0 HOST_CAP =3D 0x00,
>> + =A0 =A0 HOST_CAP_SSS =3D (1 << 27), /* Staggered Spin-up */
>> + =A0 =A0 HOST_PORTS_IMPL =3D 0x0c,
>> + =A0 =A0 HOST_TIMER1MS =3D 0xe0, /* Timer 1-ms */
>> +};
>> +
>> +extern int sata_init(struct device *dev, void __iomem *addr);
>> +extern void sata_exit(struct device *dev);
>> +#endif /* __PLAT_MXC_AHCI_SATA_H__ */
>> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/=
arm/plat-mxc/include/mach/devices-common.h
>> index 524538a..f04e063 100644
>> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
>> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
>> @@ -301,3 +301,13 @@ struct platform_device *__init imx_add_spi_imx(
>> =A0struct platform_device *imx_add_imx_dma(void);
>> =A0struct platform_device *imx_add_imx_sdma(char *name,
>> =A0 =A0 =A0 resource_size_t iobase, int irq, struct sdma_platform_da=
ta *pdata);
>> +
>> +#include <linux/ahci_platform.h>
>> +struct imx_ahci_imx_data {
>> + =A0 =A0 const char *devid;
>> + =A0 =A0 resource_size_t iobase;
>> + =A0 =A0 resource_size_t irq;
>> +};
>> +struct platform_device *__init imx_add_ahci_imx(
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct imx_ahci_imx_data *data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct ahci_platform_data *pdata);
>> --
>> 1.7.1
>>
>>
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0=
 =A0 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5=
121-206917-5555 |
>
