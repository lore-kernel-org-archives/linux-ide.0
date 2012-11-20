From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v2 2/6] ARM: EXYNOS5: DT Support for SATA and SATA PHY
Date: Tue, 20 Nov 2012 21:46:46 +0900
Message-ID: <0cb001cdc71d$19e59df0$4db0d9d0$%kim@samsung.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
 <1351612897-14923-3-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Vasanth Ananthan' <vasanthananthan@gmail.com>, jgarzik@pobox.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, 'Vasanth Ananthan' <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Kukjin Kim wrote:
> 
> Vasanth Ananthan wrote:
> >
> > This patch adds Device Nodes for SATA and SATA PHY device.
> >
> 
> [...]
> 
> > @@ -188,6 +188,9 @@
> >  #define EXYNOS4_PA_SATA			0x12560000
> >  #define EXYNOS4_PA_SATAPHY		0x125D0000
> >  #define EXYNOS4_PA_SATAPHY_CTRL		0x126B0000
> > +#define EXYNOS5_PA_SATA_PHY_CTRL	0x12170000
> > +#define EXYNOS5_PA_SATA_PHY_I2C		0x121D0000
> > +#define EXYNOS5_PA_SATA_BASE		0x122F0000
> >
> >  #define EXYNOS4_PA_SROMC		0x12570000
> >  #define EXYNOS5_PA_SROMC		0x12250000
> > diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-
> > exynos/mach-exynos5-dt.c
> > index db1cd8e..7dbd4cc 100644
> > --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> > +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> > @@ -61,6 +61,12 @@ static const struct of_dev_auxdata
> > exynos5250_auxdata_lookup[] __initconst = {
> >  				"exynos4210-spi.1", NULL),
> >  	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS5_PA_SPI2,
> >  				"exynos4210-spi.2", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos5-sata-ahci", EXYNOS5_PA_SATA_BASE,
> > +				"exynos5-sata", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos5-sata-phy", EXYNOS5_PA_SATA_PHY_CTRL,
> > +				"exynos5-sata-phy", NULL),
> > +	OF_DEV_AUXDATA("samsung,exynos5-sata-phy-i2c",
> > EXYNOS5_PA_SATA_PHY_I2C,
> > +				"exynos5-sata-phy-i2c", NULL),
> >  	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
> >  	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
> >  	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
> > --
> > 1.7.4.1
> 
> Just following is enough? Because we don't need the definitions only for
> here...
> 
> 8<-------
> +	OF_DEV_AUXDATA("samsung,exynos5-sata-ahci", 0x122F0000,
> +				"exynos5-sata", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos5-sata-phy", 0x126B0000,
> +				"exynos5-sata-phy", NULL),
> +	OF_DEV_AUXDATA("samsung,exynos5-sata-phy-i2c", 0x121D0000,
> +				"exynos5-sata-phy-i2c", NULL),
> 8<-------
> 

Applied with above changes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
