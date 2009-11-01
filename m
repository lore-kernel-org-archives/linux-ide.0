From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 6/7] S3C6410: Add platform data for S3C IDE controller driver
Date: Sun, 1 Nov 2009 13:07:08 +0000
Message-ID: <20091101130707.GJ8096@trinity.fluff.org>
References: <1257051536-8170-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:34563 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbZKANHD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2009 08:07:03 -0500
Content-Disposition: inline
In-Reply-To: <1257051536-8170-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: ben-linux@fluff.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Nov 01, 2009 at 01:58:56PM +0900, Thomas Abraham wrote:
> This patch adds platform data for S3C IDE controller driver in
> S3C6410 platform.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/mach-s3c6410/mach-smdk6410.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
> index ea51dbe..81b435e 100644
> --- a/arch/arm/mach-s3c6410/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
> @@ -50,6 +50,7 @@
>  #include <plat/regs-sys.h>
>  #include <plat/iic.h>
>  #include <plat/fb.h>
> +#include <plat/ide.h>
>  #include <plat/gpio-cfg.h>
>  
>  #include <plat/s3c6410.h>
> @@ -153,6 +154,12 @@ static struct s3c_fb_platdata smdk6410_lcd_pdata __initdata = {
>  	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
>  };
>  
> +#ifdef CONFIG_BLK_DEV_IDE_S3C
> +static struct s3c_ide_platdata smdk6410_ide_pdata __initdata = {
> +	.setup_gpio	= s3c64xx_ide_setup_gpio,
> +};
> +#endif
> +
>  static struct resource smdk6410_smsc911x_resources[] = {
>  	[0] = {
>  		.start = 0x18000000,
> @@ -199,7 +204,9 @@ static struct platform_device *smdk6410_devices[] __initdata = {
>  	&s3c_device_usb,
>  	&s3c_device_usb_hsotg,
>  	&smdk6410_lcd_powerdev,
> -
> +#ifdef CONFIG_BLK_DEV_IDE_S3C
> +	&s3c_device_cfcon,
> +#endif
>  	&smdk6410_smsc911x,
>  };

Firstly, doing stuff if the driver is enabled or not is not a good idea,
as it means re-installing the kernel if you then go and build the driver
as a module at a later date.

Two, since I guess that the IDE gpio setup should be the same across all
s3c6410 based systems, then you should look at supplying a standard
platform data that the board can use instead of having to duplicate this
across all the boards.

> @@ -377,6 +382,9 @@ static void __init smdk6410_machine_init(void)
>  	s3c_i2c0_set_platdata(NULL);
>  	s3c_i2c1_set_platdata(NULL);
>  	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
> +#ifdef CONFIG_BLK_DEV_IDE_S3C
> +	s3c_ide_set_platdata(&smdk6410_ide_pdata);
> +#endif
>  
>  	gpio_request(S3C64XX_GPN(5), "LCD power");
>  	gpio_request(S3C64XX_GPF(13), "LCD power");

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

