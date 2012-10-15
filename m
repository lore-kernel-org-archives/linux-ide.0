From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 4/6] ARM: S3C2410: I2C driver polling mode support
Date: Mon, 15 Oct 2012 10:33:20 +0200
Message-ID: <201210151033.20714.heiko@sntech.de>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com> <1349783332-18467-5-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1349783332-18467-5-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Am Dienstag, 9. Oktober 2012, 13:48:50 schrieb Vasanth Ananthan:
> This patch adds polling mode support for i2c s3c-2410 driver.
> The I2C_SATAPHY controller lacks an interrupt line but the s3c-2410 driver
> is interrupt driven. Hence this support is required for functioning
> of the I2C_SATAPHY controller.
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |   84
> +++++++++++++++++++++++++++++--------- 1 files changed, 65 insertions(+),
> 19 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c
> b/drivers/i2c/busses/i2c-s3c2410.c index 5ae3b02..699b530 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c

[...]

> @@ -102,10 +103,14 @@ static struct platform_device_id s3c24xx_driver_ids[]
> = { };
>  MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
> 
> +static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long
> iicstat); +
>  #ifdef CONFIG_OF
>  static const struct of_device_id s3c24xx_i2c_match[] = {
>  	{ .compatible = "samsung,s3c2410-i2c", .data = (void *)0 },
>  	{ .compatible = "samsung,s3c2440-i2c", .data = (void *)QUIRK_S3C2440 },
> +	{ .compatible = "samsung,s3c2440-sataphy-i2c",
> +	  .data = (void *)(QUIRK_S3C2440|QUIRK_SATAPHY|QUIRK_NO_GPIO) },
>  	{ .compatible = "samsung,s3c2440-hdmiphy-i2c",
>  	  .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
>  	{},

Out of curiosity, why is it called s3c2440-sataphy-i2c when it's an exynos 
specific component?


Heiko
