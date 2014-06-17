From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 1/2] phy: qcom: Add driver for QCOM IPQ806x SATA PHY
Date: Tue, 17 Jun 2014 14:39:14 +0200
Message-ID: <25056551.7rd4nhvM6K@amdc1032>
References: <1402948477-12347-1-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1402948477-12347-1-git-send-email-galak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, sboyd@codeaurora.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Monday, June 16, 2014 02:54:37 PM Kumar Gala wrote:
> 
> Add a PHY driver for uses with AHCI based SATA controller driver on the
> IPQ806x family of SoCs.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v3:
> * Added Kconfig HAS_IOMEM dep
> * re-ordered probe function so phy_provider_register is last
>  
> v2:
> * dropped unused dev pointer in struct qcom_ipq806x_sata_phy
> * remove unnecessary reg initializaiton
> * Removed unneeded error message
> * Added remove function to disable the clock
> 
>  drivers/phy/Kconfig                 |   7 ++
>  drivers/phy/Makefile                |   1 +
>  drivers/phy/phy-qcom-ipq806x-sata.c | 211 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 219 insertions(+)
>  create mode 100644 drivers/phy/phy-qcom-ipq806x-sata.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 16a2f06..b7b6bce 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -178,4 +178,11 @@ config PHY_XGENE
>  	help
>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>  
> +config PHY_QCOM_IPQ806X_SATA
> +	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
> +	depends on ARCH_QCOM
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index b4f1d57..d950317 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -20,3 +20,4 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4X12_USB2)	+= phy-exynos4x12-usb2.o
>  phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2)	+= phy-exynos5250-usb2.o
>  obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
> +obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> diff --git a/drivers/phy/phy-qcom-ipq806x-sata.c b/drivers/phy/phy-qcom-ipq806x-sata.c
> new file mode 100644
> index 0000000..e931aee
> --- /dev/null
> +++ b/drivers/phy/phy-qcom-ipq806x-sata.c

[...]

> +static inline void qcom_ipq806x_sata_delay_us(unsigned int delay)
> +{
> +	/* sleep for max. 50us more to combine processor wakeups */
> +	usleep_range(delay, delay + 50);
> +}

This is used only once in the driver so there is no need to make it
into static inline helper.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
