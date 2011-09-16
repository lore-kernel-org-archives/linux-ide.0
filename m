From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2] pata-generic/of: Make probing via device tree non-powerpc-specific
Date: Fri, 16 Sep 2011 16:34:51 -0500
Message-ID: <4E73C0FB.4030904@gmail.com>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org> <1316190120-17010-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49191 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab1IPVez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2011 17:34:55 -0400
Received: by ywb5 with SMTP id 5so3215687ywb.19
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2011 14:34:54 -0700 (PDT)
In-Reply-To: <1316190120-17010-1-git-send-email-dave.martin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Dave,

On 09/16/2011 11:22 AM, Dave Martin wrote:
> This patch enables device-tree-based probing of the pata-generic
> platform driver across all architectures:
> 
>   * make the pata_of_generic module depend on OF instead of PPC_OF;
>   * supply some missing inclues;
>   * replace endianness-sensitive raw access to device tree data
>     with of_property_read_u32() calls.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> v2: correct sense of the check of_property_read_u32(dn, "pio-mode",
> &pio_mode).  Somehow I posted an old version of this patch, depite
> having already fixed this...
> 
> Tested on ARM Versatile Express, with my soon-to-be-posted device
> tree support patches.
> 
> I'm not in a position to build/test this for powerpc easily --
> if anyone is able to do that, it would be appreciated.
> 
Building just requires getting Codesourcery PPC toolchain...

You also have to be aware that you are enabling this for all OF-enabled
arches which could break with an allyesconfig. So really you need sparc,
x86, mips, and microblaze, but a subset is probably sufficient.

> Grant, does this require similar cleanup to the isp1760 USB hcd driver?
> 
Yes. It really should be merged with pata_platform.c. If you're willing
to combine them, I'll do ppc and sparc builds as I already have those on
my system.

Rob

>  drivers/ata/Kconfig            |    2 +-
>  drivers/ata/pata_of_platform.c |   16 +++++++---------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 5987e0b..c6ef9d0 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -820,7 +820,7 @@ config PATA_PLATFORM
>  
>  config PATA_OF_PLATFORM
>  	tristate "OpenFirmware platform device PATA support"
> -	depends on PATA_PLATFORM && PPC_OF
> +	depends on PATA_PLATFORM && OF
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems with OpenFirmware
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index f305400..e6e9aa9 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -11,6 +11,9 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/ata_platform.h>
>  
> @@ -21,10 +24,9 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
>  	struct resource io_res;
>  	struct resource ctl_res;
>  	struct resource irq_res;
> -	unsigned int reg_shift = 0;
> -	int pio_mode = 0;
> +	u32 reg_shift = 0;
> +	u32 pio_mode = 0;
>  	int pio_mask;
> -	const u32 *prop;
>  
>  	ret = of_address_to_resource(dn, 0, &io_res);
>  	if (ret) {
> @@ -55,13 +57,9 @@ static int __devinit pata_of_platform_probe(struct platform_device *ofdev)
>  	else
>  		irq_res.flags = 0;
>  
> -	prop = of_get_property(dn, "reg-shift", NULL);
> -	if (prop)
> -		reg_shift = *prop;
> +	of_property_read_u32(dn, "reg-shift", &reg_shift);
>  
> -	prop = of_get_property(dn, "pio-mode", NULL);
> -	if (prop) {
> -		pio_mode = *prop;
> +	if (!of_property_read_u32(dn, "pio-mode", &pio_mode)) {
>  		if (pio_mode > 6) {
>  			dev_err(&ofdev->dev, "invalid pio-mode\n");
>  			return -EINVAL;

