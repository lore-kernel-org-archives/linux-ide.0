From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH V5 1/2] PHY: Exynos: Add Exynos5250 SATA PHY driver
Date: Fri, 10 Jan 2014 10:16:30 +0900
Message-ID: <002901cf0da1$98335370$c899fa50$%han@samsung.com>
References: <1389262005-30399-1-git-send-email-yuvaraj.cd@samsung.com>
 <1389262005-30399-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1389262005-30399-2-git-send-email-yuvaraj.cd@samsung.com>
Content-language: ko
Sender: linux-doc-owner@vger.kernel.org
To: 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, kishon@ti.com
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, joshi@samsung.com, t.figa@samsung.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, grant.likely@linaro.org, christoffer.dall@linaro.org, linux-ide@vger.kernel.org, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>, 'Girish K S' <ks.giri@samsung.com>, 'Vasanth Ananthan' <vasanth.a@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-ide@vger.kernel.org

On Thursday, January 09, 2014 7:07 PM, Yuvaraj Kumar C D wrote:
> 
> This patch adds the SATA PHY driver for Exynos5250.Exynos5250 SATA
> PHY comprises of CMU and TRSV blocks which are of I2C register Map.
> So this patch also adds a i2c client driver, which is used configure
> the CMU and TRSV block of exynos5250 SATA PHY.
> 
> This patch incorporates the generic PHY framework to deal with SATA
> PHY.
> 
> This patch depends on the below patches
> 	[1].drivers: phy: add generic PHY framework
> 		by Kishon Vijay Abraham I<kishon@ti.com>
> 	[2].ata: ahci_platform: Manage SATA PHY
> 		by Roger Quadros <rogerq@ti.com>
> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> Signed-off-by: Girish K S <ks.giri@samsung.com>
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>

Hi Yuvaraj Kumar,

It looks good.
However, I added some minor comments. :-)

Also, you need to base against the following Kishon's PHY git tree,
next branch. Then, Kishon will apply your patch more easily.

T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git


> ---
> Changes from V4:
> 	1.Made Exynos5250 SATA PHY driver by default selects
> 	CONFIG_I2C and CONFIG_I2C_S3C2410, as SATA PHY driver
> 	depends on I2C.
> 	2.struct i2c_driver sataphy_i2c_driver made static which
> 	was earlier global type.
> 	3.Renamed the files to phy-exynos5250-sata.c and
> 	phy-exynos5250-sata-i2c.c and CONFIG_EXYNOS5250_SATA_PHY
> 	to CONFIG_PHY_EXYNOS5250_SATA.
> 
> Changes from V3:
> 	1.Moved devm_phy_create before to devm_phy_provider_register.
> 
> Changes from V2:
> 	1.Removed of_match_table
> 	2.Moved to syscon interface for PMU handling.
> 
> Changes from V1:
> 	1.Adapted to latest version of Generic PHY framework
> 	2.Removed exynos_sata_i2c_remove function.
> 
>  drivers/phy/Kconfig                   |   13 ++
>  drivers/phy/Makefile                  |    1 +
>  drivers/phy/phy-exynos5250-sata-i2c.c |   40 ++++++
>  drivers/phy/phy-exynos5250-sata.c     |  238 +++++++++++++++++++++++++++++++++
>  4 files changed, 292 insertions(+)
>  create mode 100644 drivers/phy/phy-exynos5250-sata-i2c.c
>  create mode 100644 drivers/phy/phy-exynos5250-sata.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index d0611b8..de1c165 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -57,4 +57,17 @@ config PHY_EXYNOS_DP_VIDEO
>  	help
>  	  Support for Display Port PHY found on Samsung EXYNOS SoCs.
> 
> +config PHY_EXYNOS5250_SATA
> +	tristate "Exynos5250 Sata SerDes/PHY driver"
> +	depends on SOC_EXYNOS5250
> +	select GENERIC_PHY
> +	select I2C
> +	select I2C_S3C2410
> +	select MFD_SYSCON
> +	help
> +	  Enable this to support SATA SerDes/Phy found on Samsung's
> +	  Exynos5250 based SoCs.This SerDes/Phy supports SATA 1.5 Gb/s,
> +	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds.It supports one SATA host
                                                          ^
One space between 'speeds.' and 'It' is needed as below.

+	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds. It supports one SATA host

> +	  port to accept one SATA device.
> +
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 4e4adc9..8ccf8c3 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
>  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> +obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o phy-exynos5250-sata-i2c.o
> diff --git a/drivers/phy/phy-exynos5250-sata-i2c.c b/drivers/phy/phy-exynos5250-sata-i2c.c
> new file mode 100644
> index 0000000..83bd6ee
> --- /dev/null
> +++ b/drivers/phy/phy-exynos5250-sata-i2c.c
> @@ -0,0 +1,40 @@

[.....]

> +static struct i2c_driver sataphy_i2c_driver = {
> +	.probe		= exynos_sata_i2c_probe,
> +	.id_table	= sataphy_i2c_device_match,
> +	.driver   = {
> +		.name = "exynos-sataphy-i2c",
> +		.owner = THIS_MODULE,
> +		},

There is an indent coding style issue.
The following is right.

+	},


[.....]

> +
> +MODULE_DESCRIPTION("Samsung SerDes PHY driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("ks.giri <ks.giri@samsung.com>");

The following is more preferable.
+MODULE_AUTHOR("Girish K S <ks.giri@samsung.com>");

Best regards,
Jingoo Han

> +MODULE_AUTHOR("Yuvaraj C D <yuvaraj.cd@samsung.com>");
> --
> 1.7.9.5

