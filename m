From: Vasanth Ananthan <vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/6] DRIVERS:I2C: I2C driver polling mode support
Date: Fri, 23 Nov 2012 14:23:22 +0530
Message-ID: <CAK1UHiymHEddeyuc29cRHbcUyO1pbGOO5MGsLjk1sNDx4iAVKg@mail.gmail.com>
References: <1351612897-14923-1-git-send-email-vasanthananthan@gmail.com>
	<1351612897-14923-5-git-send-email-vasanthananthan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351612897-14923-5-git-send-email-vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Vasanth Ananthan <vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vasanth Ananthan <vasanth.a-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

Missed to include Ben, for I2C patch, including him and copying others.

Thanks,
Vasanth.

On Tue, Oct 30, 2012 at 9:31 PM, Vasanth Ananthan
<vasanthananthan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This patch adds polling mode support for i2c s3c-2410 driver.
> The I2C_SATAPHY controller lacks an interrupt line but the s3c-2410 driver
> is interrupt driven. Hence this support is required for functioning
> of the I2C_SATAPHY controller.
>
> Signed-off-by: Vasanth Ananthan <vasanth.a-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |   79 ++++++++++++++++++++++++++++---------
>  1 files changed, 60 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 3e0335f..5712e40 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -48,6 +48,7 @@
>  #define QUIRK_S3C2440          (1 << 0)
>  #define QUIRK_HDMIPHY          (1 << 1)
>  #define QUIRK_NO_GPIO          (1 << 2)
> +#define QUIRK_SATAPHY          (1 << 3)
>
>  /* i2c controller state */
>  enum s3c24xx_i2c_state {
> @@ -102,10 +103,14 @@ static struct platform_device_id s3c24xx_driver_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, s3c24xx_driver_ids);
>
> +static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat);
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id s3c24xx_i2c_match[] = {
>         { .compatible = "samsung,s3c2410-i2c", .data = (void *)0 },
>         { .compatible = "samsung,s3c2440-i2c", .data = (void *)QUIRK_S3C2440 },
> +       { .compatible = "samsung,exynos5-sata-phy-i2c",
> +         .data = (void *)(QUIRK_S3C2440 | QUIRK_SATAPHY | QUIRK_NO_GPIO) },
>         { .compatible = "samsung,s3c2440-hdmiphy-i2c",
>           .data = (void *)(QUIRK_S3C2440 | QUIRK_HDMIPHY | QUIRK_NO_GPIO) },
>         {},
> @@ -146,7 +151,8 @@ static inline void s3c24xx_i2c_master_complete(struct s3c24xx_i2c *i2c, int ret)
>         if (ret)
>                 i2c->msg_idx = ret;
>
> -       wake_up(&i2c->wait);
> +       if (!(i2c->quirks & QUIRK_SATAPHY))
> +               wake_up(&i2c->wait);
>  }
>
>  static inline void s3c24xx_i2c_disable_ack(struct s3c24xx_i2c *i2c)
> @@ -184,6 +190,23 @@ static inline void s3c24xx_i2c_enable_irq(struct s3c24xx_i2c *i2c)
>  }
>
>
> +static bool is_ack(struct s3c24xx_i2c *i2c)
> +{
> +       u32 time_out = i2c->tx_setup;
> +
> +       while (--time_out) {
> +               if (readl(i2c->regs + S3C2410_IICCON)
> +                       & S3C2410_IICCON_IRQPEND) {
> +                       if (!(readl(i2c->regs + S3C2410_IICSTAT)
> +                               & S3C2410_IICSTAT_LASTBIT))
> +                               return true;
> +               }
> +               udelay(time_out);
> +       }
> +
> +       return false;
> +}
> +
>  /* s3c24xx_i2c_message_start
>   *
>   * put the start of a message onto the bus
> @@ -227,6 +250,15 @@ static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
>
>         stat |= S3C2410_IICSTAT_START;
>         writel(stat, i2c->regs + S3C2410_IICSTAT);
> +
> +       if (i2c->quirks & QUIRK_SATAPHY) {
> +               while ((i2c->msg_num != 0) && is_ack(i2c)) {
> +                       i2c_s3c_irq_nextbyte(i2c, stat);
> +                       stat = readl(i2c->regs + S3C2410_IICSTAT);
> +                       if (stat & S3C2410_IICSTAT_ARBITR)
> +                               dev_err(i2c->dev, "deal with arbitration loss\n");
> +               }
> +       }
>  }
>
>  static inline void s3c24xx_i2c_stop(struct s3c24xx_i2c *i2c, int ret)
> @@ -552,19 +584,23 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
>         s3c24xx_i2c_message_start(i2c, msgs);
>         spin_unlock_irq(&i2c->lock);
>
> -       timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
> -
>         ret = i2c->msg_idx;
>
> -       /* having these next two as dev_err() makes life very
> -        * noisy when doing an i2cdetect */
> +       if (!(i2c->quirks & QUIRK_SATAPHY)) {
>
> -       if (timeout == 0)
> -               dev_dbg(i2c->dev, "timeout\n");
> -       else if (ret != num)
> -               dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
> +               timeout = wait_event_timeout(i2c->wait,
> +                               i2c->msg_num == 0, HZ * 5);
>
> -       /* ensure the stop has been through the bus */
> +               /* having these next two as dev_err() makes life very
> +               * noisy when doing an i2cdetect */
> +
> +               if (timeout == 0)
> +                       dev_dbg(i2c->dev, "timeout\n");
> +               else if (ret != num)
> +                       dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
> +
> +               /* ensure the stop has been through the bus */
> +       }
>
>         dev_dbg(i2c->dev, "waiting for bus idle\n");
>
> @@ -710,6 +746,9 @@ static int s3c24xx_i2c_clockrate(struct s3c24xx_i2c *i2c, unsigned int *got)
>         if (div1 == 512)
>                 iiccon |= S3C2410_IICCON_TXDIV_512;
>
> +       if (i2c->quirks & QUIRK_SATAPHY)
> +               iiccon |= S3C2410_IICCON_SCALE(2);
> +
>         writel(iiccon, i2c->regs + S3C2410_IICCON);
>
>         if (i2c->quirks & QUIRK_S3C2440) {
> @@ -1023,18 +1062,20 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>          * ensure no current IRQs pending
>          */
>
> -       i2c->irq = ret = platform_get_irq(pdev, 0);
> -       if (ret <= 0) {
> -               dev_err(&pdev->dev, "cannot find IRQ\n");
> -               goto err_iomap;
> -       }
> +       if (!(i2c->quirks & QUIRK_SATAPHY)) {
> +               i2c->irq = ret = platform_get_irq(pdev, 0);
> +               if (ret <= 0) {
> +                       dev_err(&pdev->dev, "cannot find IRQ\n");
> +                       goto err_iomap;
> +               }
>
> -       ret = request_irq(i2c->irq, s3c24xx_i2c_irq, 0,
> +               ret = request_irq(i2c->irq, s3c24xx_i2c_irq, 0,
>                           dev_name(&pdev->dev), i2c);
>
> -       if (ret != 0) {
> -               dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
> -               goto err_iomap;
> +               if (ret != 0) {
> +                       dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
> +                       goto err_iomap;
> +               }
>         }
>
>         ret = s3c24xx_i2c_register_cpufreq(i2c);
> --
> 1.7.4.1
>



-- 
Regards,

Vasanth K A
