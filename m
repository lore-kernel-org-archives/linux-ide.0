From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/4] pata: imx: add support of setting timings for PIO
 modes
Date: Wed, 9 Nov 2016 12:39:13 +0300
Message-ID: <23fb0678-db2a-a0ff-65a3-3174720b0ee8@cogentembedded.com>
References: <20161109005638.17691-1-vz@mleia.com>
 <20161109005638.17691-4-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33124 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbcKIJj2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2016 04:39:28 -0500
Received: by mail-lf0-f49.google.com with SMTP id c13so159665937lfg.0
        for <linux-ide@vger.kernel.org>; Wed, 09 Nov 2016 01:39:16 -0800 (PST)
In-Reply-To: <20161109005638.17691-4-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>, Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org

Hello.

On 11/9/2016 3:56 AM, Vladimir Zapolskiy wrote:

> The controller is capable to operate in up to PIO4 mode, however
> before the change the driver relies on timing settings done by
> a bootloader for PIO0 mode only. The change adds more flexibility
> in PIO mode selection at runtime and makes the driver to work even if
                                                         ^^ not needed

> bootloader does not preset ATA timings.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/ata/pata_imx.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
> index 00df18b..8f13c9f 100644
> --- a/drivers/ata/pata_imx.c
> +++ b/drivers/ata/pata_imx.c
[...]
> @@ -31,6 +40,10 @@
>  #define PATA_IMX_DRIVE_DATA		0xA0
>  #define PATA_IMX_DRIVE_CONTROL		0xD8
>
> +static u32 pio_t4[] = { 30,  20,  15,  10,  10 };
> +static u32 pio_t9[] = { 20,  15,  10,  10,  10 };
> +static u32 pio_tA[] = { 35,  35,  35,  35,  35 };

    Perhaps it makes sense to extend the 'struct ata_timing'...

[...]
> @@ -38,11 +51,43 @@ struct pata_imx_priv {
>  	u32 ata_ctl;
>  };
>
> +static void pata_imx_set_timing(struct ata_device *adev,
> +				struct pata_imx_priv *priv)
> +{
> +	struct ata_timing timing;
> +	unsigned long clkrate;
> +	u32 T, mode;
> +
> +	clkrate = clk_get_rate(priv->clk);
> +
> +	if (adev->pio_mode < XFER_PIO_0 || adev->pio_mode > XFER_PIO_4 ||
> +	    !clkrate)
> +		return;
> +
> +	T = 1000000000 / clkrate;
> +	ata_timing_compute(adev, adev->pio_mode, &timing, T * 1000, 0);
> +
> +	mode = adev->pio_mode - XFER_PIO_0;
> +
> +	writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_OFF);
> +	writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_ON);

    What do those registers mean?

> +	writeb(timing.setup, priv->host_regs + PATA_IMX_ATA_TIME_1);
> +	writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2W);
> +	writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2R);
> +	writeb(1, priv->host_regs + PATA_IMX_ATA_TIME_PIO_RDX);

    And this one?

> +
> +	writeb(pio_t4[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_4);
> +	writeb(pio_t9[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_9);
> +	writeb(pio_tA[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_AX);

    DIV_ROUND_UP(x, T)?

[...]

MBR, Sergei

