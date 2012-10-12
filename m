From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 4/6] ARM: S3C2410: I2C driver polling mode support
Date: Sat, 13 Oct 2012 00:36:46 +0200
Message-ID: <3154162.nPBioGgRed@flatron>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com> <1349783332-18467-5-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1349783332-18467-5-git-send-email-vasanthananthan@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasanth Ananthan <vasanthananthan@gmail.com>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Hi,

On Tuesday 09 of October 2012 17:18:50 Vasanth Ananthan wrote:
> This patch adds polling mode support for i2c s3c-2410 driver.
> The I2C_SATAPHY controller lacks an interrupt line but the s3c-2410
> driver is interrupt driven. Hence this support is required for
> functioning of the I2C_SATAPHY controller.
> 
> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |   84
> +++++++++++++++++++++++++++++--------- 1 files changed, 65
> insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c
> b/drivers/i2c/busses/i2c-s3c2410.c index 5ae3b02..699b530 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -48,6 +48,7 @@
>  #define QUIRK_S3C2440		(1 << 0)
>  #define QUIRK_HDMIPHY		(1 << 1)
>  #define QUIRK_NO_GPIO		(1 << 2)
> +#define QUIRK_SATAPHY		(1 << 3)
> 
>  /* i2c controller state */
>  enum s3c24xx_i2c_state {
> @@ -102,10 +103,14 @@ static struct platform_device_id
> s3c24xx_driver_ids[] = { };
>  MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
> 
> +static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long
> iicstat); +
>  #ifdef CONFIG_OF
>  static const struct of_device_id s3c24xx_i2c_match[] = {
>  	{ .compatible = "samsung,s3c2410-i2c", .data = (void *)0 },
>  	{ .compatible = "samsung,s3c2440-i2c", .data = (void *)QUIRK_S3C2440
> }, +	{ .compatible = "samsung,s3c2440-sataphy-i2c",
> +	  .data = (void *)(QUIRK_S3C2440|QUIRK_SATAPHY|QUIRK_NO_GPIO) },

nitpick: Please insert spaces around bitwise OR operators.

>  	{ .compatible = "samsung,s3c2440-hdmiphy-i2c",
>  	  .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
>  	{},
> @@ -146,7 +151,8 @@ static inline void
> s3c24xx_i2c_master_complete(struct s3c24xx_i2c *i2c, int ret) if (ret)
>  		i2c->msg_idx = ret;
> 
> -	wake_up(&i2c->wait);
> +	if (!(i2c->quirks & QUIRK_SATAPHY))
> +		wake_up(&i2c->wait);
>  }
> 
>  static inline void s3c24xx_i2c_disable_ack(struct s3c24xx_i2c *i2c)
> @@ -184,6 +190,21 @@ static inline void s3c24xx_i2c_enable_irq(struct
> s3c24xx_i2c *i2c) }
> 
> 
> +static bool is_ack(struct s3c24xx_i2c *i2c)
> +{
> +	u32 time_out = i2c->tx_setup;

nitpick: Separate local variable declaration from code with a blank line.

> +	while (--time_out) {
> +		if (readl(i2c->regs + S3C2410_IICCON)
> +			& S3C2410_IICCON_IRQPEND) {
> +			if (!(readl(i2c->regs + S3C2410_IICSTAT)
> +				& S3C2410_IICSTAT_LASTBIT))
> +				return true;
> +		}
> +		udelay(time_out);
> +	}

nitpick: Here a blank line would be fine.

> +	return false;
> +}
> +
>  /* s3c24xx_i2c_message_start
>   *
>   * put the start of a message onto the bus
> @@ -227,6 +248,21 @@ static void s3c24xx_i2c_message_start(struct
> s3c24xx_i2c *i2c,
> 
>  	stat |= S3C2410_IICSTAT_START;
>  	writel(stat, i2c->regs + S3C2410_IICSTAT);
> +
> +	if (i2c->quirks & QUIRK_SATAPHY) {
> +

nitpick: Unnecessary blank line.

> +		while ((i2c->msg_num != 0) && is_ack(i2c)) {
> +

Same here.

> +			i2c_s3c_irq_nextbyte(i2c, stat);
> +
> +			stat = readl(i2c->regs + S3C2410_IICSTAT);
> +			if (stat & S3C2410_IICSTAT_ARBITR)
> +				dev_err(i2c->dev, "deal with arbitration loss\n");
> +

Same here.

> +		}
> +
Same here.

> +	}
> +

Same here.

>  }
>

Best regards,
Tomasz Figa
