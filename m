From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ahci: imx: fix building without hwmon or thermal
Date: Wed, 11 Jan 2017 15:16:44 +0100
Message-ID: <3181052.yXLkhGQIbt@amdc3058>
References: <CGME20170111133703epcas4p39c0af66a9642a4904fbecbbac2367b7d@epcas4p3.samsung.com>
 <20170111133652.3715437-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50863 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966936AbdAKOQy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jan 2017 09:16:54 -0500
In-reply-to: <20170111133652.3715437-1-arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday, January 11, 2017 02:36:16 PM Arnd Bergmann wrote:
> When CONFIG_HWMON is disabled, we now get a link failure:
> 
> ERROR: "devm_hwmon_device_register_with_groups" [drivers/ata/ahci_imx.ko] undefined!
> drivers/ata/ahci_imx.o: In function `imx_ahci_probe':
> ahci_imx.c:(.text.imx_ahci_probe+0x304): undefined reference to `devm_thermal_zone_of_sensor_register'
> 
> This makes the code calling into the hwmon subsystem compile-time
> conditional, and adds a Kconfig dependency to avoid the corner
> case of having HWMON=m and AHCI_IMX=y, by forcing AHCI_IMX=m in this
> case. The thermal subsystem already has a check in its header, but
> that also doesn't cover the THERMAL=m case, so we need a somewhat
> complex Kconfig expression to handle all cases.
> 
> Fixes: 54643a83b41a ("ahci: imx: Add imx53 SATA temperature sensor support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks fine to me (I see that this is the same solution as for
TOUCHSCREEN_SUN4I from commit 4a6155a46565 but without hard
dependency on HWMON).

Thanks for fixing this.

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/Kconfig    | 1 +
>  drivers/ata/ahci_imx.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 78c002021029..70b57d2229d6 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -129,6 +129,7 @@ config AHCI_ST
>  config AHCI_IMX
>  	tristate "Freescale i.MX AHCI SATA support"
>  	depends on MFD_SYSCON && (ARCH_MXC || COMPILE_TEST)
> +	depends on (HWMON && (THERMAL || !THERMAL_OF)) || !HWMON
>  	help
>  	  This option enables support for the Freescale i.MX SoC's
>  	  onboard AHCI SATA.
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 420f065978dc..787567e840bd 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -774,7 +774,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (imxpriv->type == AHCI_IMX53) {
> +	if (imxpriv->type == AHCI_IMX53 &&
> +	    IS_ENABLED(CONFIG_HWMON)) {
>  		/* Add the temperature monitor */
>  		struct device *hwmon_dev;

