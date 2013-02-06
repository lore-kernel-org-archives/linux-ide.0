From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH 2/2] driver: ata: add new Exynos5250 SATA PHY controller driver
Date: Wed, 6 Feb 2013 14:21:42 +0530
Message-ID: <CAK1UHiwW2VG5oWPfm1xFS-vrdvQXt0HWYuiMBNhVXB6U9bQSxw@mail.gmail.com>
References: <1359472758-31350-1-git-send-email-vasanthananthan@gmail.com>
	<1359472758-31350-3-git-send-email-vasanthananthan@gmail.com>
	<1577526.Waac87eVZb@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:36128 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300Ab3BFIvn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2013 03:51:43 -0500
In-Reply-To: <1577526.Waac87eVZb@amdc1227>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>

Hi Tomasz,

On Tue, Feb 5, 2013 at 7:53 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>
> Hi Vasanth,
>
> Please see my comments inline. They are basically related to the same
> issues as I pointed in previous version of this patch.
>
> On Tuesday 29 of January 2013 20:49:18 Vasanth Ananthan wrote:
> > Adding platform driver and I2C client driver for SATA PHY controller
> > for Samsung Exynos5250.
> >
> > The PHY controller in Exynos5250 has both the APB interface
> > and I2C client interface, hence it requires both a platform driver
> > and an I2C client driver. The PHY controller's primary charecteristics
> > are handled through the APB interface, facilitated by the platform
> > driver and the 40 bit interface should be enabled through the I2C
> > interface, facilitated by the I2C client driver.
> >
> > Further, this PHY controller driver uses PHY framework introduced by
> > this patchset. The driver registers its initialization/shutdown call
> > back to the framework and corresponding port this PHY controller is
> > assciated with gets this PHY and initializes it.
> >
> > Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> > ---
> >  arch/arm/mach-exynos/include/mach/regs-pmu.h  |    3 +
> >  arch/arm/mach-exynos/include/mach/regs-sata.h |   29 +++
> >  drivers/ata/Makefile                          |    2 +-
> >  drivers/ata/sata_exynos_phy.c                 |  265
> > +++++++++++++++++++++++++ 4 files changed, 298 insertions(+), 1
> > deletion(-)
> >  create mode 100644 arch/arm/mach-exynos/include/mach/regs-sata.h
> >  create mode 100644 drivers/ata/sata_exynos_phy.c
> >
> > diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> > b/arch/arm/mach-exynos/include/mach/regs-pmu.h index 3f30aa1..fd813d9
> > 100644
> > --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> > +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> > @@ -369,4 +369,7 @@
> >
> >  #define EXYNOS5_OPTION_USE_RETENTION                         (1 << 4)
> >
> > +/* Only for EXYNOS5250 */
> > +#define EXYNOS5_SATA_PHY_CONTROL
> S5P_PMUREG(0x0724)
> > +
> >  #endif /* __ASM_ARCH_REGS_PMU_H */
> > diff --git a/arch/arm/mach-exynos/include/mach/regs-sata.h
> > b/arch/arm/mach-exynos/include/mach/regs-sata.h new file mode 100644
> > index 0000000..80dd564
> > --- /dev/null
> > +++ b/arch/arm/mach-exynos/include/mach/regs-sata.h
> > @@ -0,0 +1,29 @@
> > +/*
> > + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> > + *              http://www.samsung.com
> > + *
> > + * EXYNOS - SATA PHY controller definition
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as +
> > * published by the Free Software Foundation.
> > +*/
> > +
> > +#define EXYNOS5_SATA_RESET           0x4
> > +#define RESET_CMN_RST_N                      (1 << 1)
> > +#define LINK_RESET                   0xF0000
> > +
> > +#define EXYNOS5_SATA_MODE0           0x10
> > +
> > +#define EXYNOS5_SATA_CTRL0           0x14
> > +#define CTRL0_P0_PHY_CALIBRATED_SEL  (1 << 9)
> > +#define CTRL0_P0_PHY_CALIBRATED              (1 << 8)
> > +
> > +#define EXYNOS5_SATA_PHSATA_CTRLM    0xE0
> > +#define PHCTRLM_REF_RATE             (1 << 1)
> > +#define PHCTRLM_HIGH_SPEED           (1 << 0)
> > +
> > +#define EXYNOS5_SATA_PHSATA_STATM    0xF0
> > +#define PHSTATM_PLL_LOCKED           (1 << 0)
> > +
> > +#define SATA_PHY_CON_RESET              0xF003F
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index 3d2d128..7add682 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -10,7 +10,7 @@ obj-$(CONFIG_SATA_INIC162X) += sata_inic162x.o
> >  obj-$(CONFIG_SATA_SIL24)     += sata_sil24.o
> >  obj-$(CONFIG_SATA_DWC)               += sata_dwc_460ex.o
> >  obj-$(CONFIG_SATA_HIGHBANK)  += sata_highbank.o libahci.o
> > -obj-$(CONFIG_SATA_PHY)               += sata_phy.o
> > +obj-$(CONFIG_SATA_PHY)               += sata_phy.o sata_exynos_phy.o
> >
> >  # SFF w/ custom DMA
> >  obj-$(CONFIG_PDC_ADMA)               += pdc_adma.o
> > diff --git a/drivers/ata/sata_exynos_phy.c
> > b/drivers/ata/sata_exynos_phy.c new file mode 100644
> > index 0000000..f48fd2f
> > --- /dev/null
> > +++ b/drivers/ata/sata_exynos_phy.c
> > @@ -0,0 +1,265 @@
> > +/*
> > + * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
> > + *              http://www.samsung.com
> > + *
> > + * EXYNOS - SATA PHY controller driver
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as +
> > * published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/ahci_platform.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/list.h>
> > +#include <linux/io.h>
> > +#include <linux/of_address.h>
> > +
> > +#include <plat/cpu.h>
> > +
> > +#include <mach/irqs.h>
> > +#include <mach/map.h>
> > +#include <mach/regs-pmu.h>
> > +#include <mach/regs-sata.h>
> > +
> > +#include "sata_phy.h"
> > +
> > +#define      SATA_TIME_LIMIT         1000
> > +
> > +static struct i2c_client *i2c_client;
> > +
> > +static struct i2c_driver sataphy_i2c_driver;
> > +
> > +struct exynos_sata_phy {
> > +     void __iomem *mmio;
> > +     struct resource *mem;
> > +     struct clk *clk;
> > +     struct sata_phy phy;
> > +};
> > +
> > +static bool sata_is_reg(void __iomem *base, u32 reg, u32 checkbit, u32
> > status) +{
> > +     if ((readl(base + reg) & checkbit) == status)
> > +             return true;
> > +     else
> > +             return false;
> > +}
> > +
> > +static bool wait_for_reg_status(void __iomem *base, u32 reg, u32
> > checkbit, +                           u32 status)
> > +{
> > +     unsigned long timeout = jiffies + usecs_to_jiffies(1000);
> > +
> > +     while (time_before(jiffies, timeout)) {
> > +             if (sata_is_reg(base, reg, checkbit, status))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static int sataphy_init(struct sata_phy *phy)
> > +{
> > +     int ret;
> > +     u32 val;
> > +
> > +     /* Values to be written to enable 40 bits interface */
> > +     u8 buf[] = { 0x3A, 0x0B };
> > +
> > +     struct exynos_sata_phy *sata_phy;
> > +
> > +     if (!i2c_client)
> > +             return -EPROBE_DEFER;
>
> What probe are you deferring here? SATA PHY has been already probed if
> something can call this function.

This would be called from the SATA controller driver via the
framework, the return value
would propagate to the SATA ctrl driver probe, and defer it, if the
i2c client is not initialized.

>
>
> > +
> > +     sata_phy = container_of(phy, struct exynos_sata_phy, phy);
> > +
> > +     ret = clk_enable(sata_phy->clk);
> > +     if (ret < 0) {
> > +             dev_err(phy->dev, "failed to enable source clk\n");
> > +             return ret;
> > +     }
> > +
> > +     if (sata_is_reg(sata_phy->mmio , EXYNOS5_SATA_CTRL0,
> > +             CTRL0_P0_PHY_CALIBRATED, CTRL0_P0_PHY_CALIBRATED))
> > +             return 0;
> > +
> > +     writel(S5P_PMU_SATA_PHY_CONTROL_EN, EXYNOS5_SATA_PHY_CONTROL);
> > +
> > +     val = 0;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +     val |= 0xFF;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +     val |= LINK_RESET;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +     val |= RESET_CMN_RST_N;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> > +     val &= ~PHCTRLM_REF_RATE;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> > +
> > +     /* High speed enable for Gen3 */
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> > +     val |= PHCTRLM_HIGH_SPEED;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_PHSATA_CTRLM);
> > +
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_CTRL0);
> > +     val |= CTRL0_P0_PHY_CALIBRATED_SEL | CTRL0_P0_PHY_CALIBRATED;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_CTRL0);
> > +
> > +     writel(0x2, sata_phy->mmio + EXYNOS5_SATA_MODE0);
> > +
> > +     ret = i2c_master_send(i2c_client, buf, sizeof(buf));
> > +     if (ret < 0)
> > +             return -ENXIO;
> > +
> > +     /* release cmu reset */
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +     val &= ~RESET_CMN_RST_N;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +
> > +     val = readl(sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +     val |= RESET_CMN_RST_N;
> > +     writel(val, sata_phy->mmio + EXYNOS5_SATA_RESET);
> > +
> > +     if (wait_for_reg_status(sata_phy->mmio, EXYNOS5_SATA_PHSATA_STATM,
> > +                             PHSTATM_PLL_LOCKED, 1)) {
> > +             return 0;
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> > +static int sataphy_shutdown(struct sata_phy *phy)
> > +{
> > +
> > +     struct exynos_sata_phy *sata_phy;
> > +
> > +     sata_phy = container_of(phy, struct exynos_sata_phy, phy);
> > +     clk_disable(sata_phy->clk);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init sata_i2c_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *i2c_id)
> > +{
> > +     i2c_client = client;
> > +     return 0;
> > +}
> > +
> > +static int __init sata_phy_probe(struct platform_device *pdev)
> > +{
> > +     struct exynos_sata_phy *sataphy;
> > +     struct device *dev = &pdev->dev;
> > +     int ret = 0;
> > +
> > +     sataphy = devm_kzalloc(dev, sizeof(struct exynos_sata_phy),
> > GFP_KERNEL); +        if (!sataphy) {
> > +             dev_err(dev, "failed to allocate memory\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     sataphy->mmio = of_iomap(dev->of_node, 0);
> > +     if (!sataphy->mmio) {
> > +             dev_err(dev, "failed to remap IO\n");
> > +             return -EADDRNOTAVAIL;
> > +     }
>
> Wouldn't it be better to use platform_get_resource and
> devm_request_and_ioremap here.

Since this driver is entirely DT based I thought of_iomap would be
more appropriate.Whats your view?

>
> > +
> > +     sataphy->clk = devm_clk_get(dev, "sata-phy");
> > +     if (IS_ERR(sataphy->clk)) {
> > +             dev_err(dev, "failed to get clk for PHY\n");
> > +             ret = PTR_ERR(sataphy->clk);
> > +             goto err_iomap;
> > +     }
> > +
> > +     sataphy->phy.init = sataphy_init;
> > +     sataphy->phy.shutdown = sataphy_shutdown;
> > +     sataphy->phy.dev = dev;
> > +
> > +     ret = sata_add_phy(&sataphy->phy);
> > +     if (ret < 0) {
> > +             dev_err(dev, "PHY not registered with framework\n");
> > +             goto err_iomap;
> > +     }
> > +
> > +     ret = i2c_add_driver(&sataphy_i2c_driver);
> > +     if (ret < 0)
> > +             goto err_phy;
>
> This is obviously incorrect, as I already pointed in previous version of
> this patch.
>
> You are registering a SATA PHY, without making sure that the driver is
> fully initialized.
>
> Some kind of solution would be to register both platform driver and i2c
> driver in module init function and defer probe of platform device until
> i2c device gets registered.
>

Though the driver is not fully initialized, in callback, I am checking
whether the
i2c client is initialized and returning -EPROBEDEFER if otherwise. In
such cases,
the SATA driver probe is deferred and by the time its probed again,
the PHY initialization
would have completed, if not the PHY would never be initialized and
the SATA controller
abandons this PHY.

What do you suggest?


> However this doesn't solve another problem. How can this driver support
> cases when there are multiple SATA PHYs?
>
> > +
> > +     platform_set_drvdata(pdev, sataphy);
>
> This should be done before calling sata_add_phy. Basically calling
> sata_add_phy means that your driver is fully initialized and users can
> instantly call your callbacks safely.
>
> Best regards,
> --
> Tomasz Figa
> Samsung Poland R&D Center
> SW Solution Development, Linux Platform
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--
Regards,

Vasanth K A
