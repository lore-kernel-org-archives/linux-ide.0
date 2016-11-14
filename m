From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/4] pata: imx: add support of setting timings for PIO modes
Date: Mon, 14 Nov 2016 15:22:16 +0100
Message-ID: <1550314.zPK4oZKyMC@amdc3058>
References: <20161109005638.17691-1-vz@mleia.com>
 <CGME20161109005645epcas5p1aae7d9559edb0b86fcd18405560d91ce@epcas5p1.samsung.com>
 <20161109005638.17691-4-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35286 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbcKNOWa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Nov 2016 09:22:30 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGM02EO5YLBONB0@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 14 Nov 2016 23:22:23 +0900 (KST)
In-reply-to: <20161109005638.17691-4-vz@mleia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


Hi,

On Wednesday, November 09, 2016 02:56:37 AM Vladimir Zapolskiy wrote:
> The controller is capable to operate in up to PIO4 mode, however
> before the change the driver relies on timing settings done by
> a bootloader for PIO0 mode only. The change adds more flexibility
> in PIO mode selection at runtime and makes the driver to work even if
> bootloader does not preset ATA timings.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/ata/pata_imx.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)

[...]

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

No need check for adev->pio_mode < XFER_PIO_0 || adev->pio_mode > XFER_PIO_4
as the libata core code guarantees that these conditions will never happen.

Also you should at least print an error on !clkrate condition. [ IMHO it
is actually better to BUG_ON() on this condition as the further operations
may be risky for the data integrity (wrong PIO timings may be used). ]

> +		return;
> +
> +	T = 1000000000 / clkrate;
> +	ata_timing_compute(adev, adev->pio_mode, &timing, T * 1000, 0);
> +
> +	mode = adev->pio_mode - XFER_PIO_0;
> +
> +	writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_OFF);
> +	writeb(3, priv->host_regs + PATA_IMX_ATA_TIME_ON);
> +	writeb(timing.setup, priv->host_regs + PATA_IMX_ATA_TIME_1);
> +	writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2W);
> +	writeb(timing.act8b, priv->host_regs + PATA_IMX_ATA_TIME_2R);
> +	writeb(1, priv->host_regs + PATA_IMX_ATA_TIME_PIO_RDX);
> +
> +	writeb(pio_t4[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_4);
> +	writeb(pio_t9[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_9);
> +	writeb(pio_tA[mode] / T + 1, priv->host_regs + PATA_IMX_ATA_TIME_AX);
> +}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

