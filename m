From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] sata: sata_rcar: Reset SATA PHY when Salvator-X board
 resumes
Date: Tue, 16 Jan 2018 19:25:25 +0300
Message-ID: <b9cbfc3d-c1d3-e6c0-8f7d-1291ba04365c@cogentembedded.com>
References: <1516113552-27701-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1516113552-27701-1-git-send-email-ykaneko0929@gmail.com>
Content-Language: en-MW
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 01/16/2018 05:39 PM, Yoshihiro Kaneko wrote:

> From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> 
> Because power of Salvator-X board is cut off in suspend,
> it needs to reset SATA PHY state in resume.
> Otherwise, SATA partition could not be accessed anymore.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@rvc.renesas.com>
> [reinit phy in sata_rcar_resume() function on R-Car Gen3 only]
> [fixed the prefix for the subject]
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the for-next branch of libata tree.
> 
> v2 [Yoshihiro Kaneko]
> * reinit phy on R-Car Gen3 only as suggested by Geert Uytterhoeven
> * use "sata_rcar" prefix for the subject as suggested by Sergei Shtylyov
>   drivers/ata/sata_rcar.c | 38 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 80ee2f2..4adc0d6 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
[...]
> @@ -977,11 +979,43 @@ static int sata_rcar_resume(struct device *dev)
>   	struct sata_rcar_priv *priv = host->private_data;
>   	void __iomem *base = priv->base;
>   	int ret;
> +	u32 val;
>   
>   	ret = clk_prepare_enable(priv->clk);
>   	if (ret)
>   		return ret;
>   
> +	/* reinit phy on R-Car Gen3 only */
> +	switch (priv->type) {
> +	case RCAR_GEN1_SATA:
> +	case RCAR_GEN2_SATA:
> +	case RCAR_R8A7790_ES1_SATA:
> +		break;
> +	case RCAR_GEN3_SATA:
> +		sata_rcar_gen2_phy_init(priv);
> +		break;
> +	default:
> +		dev_warn(host->dev, "SATA phy is not initialized\n");
> +		break;
> +	}
> +
> +	/* SATA-IP reset state */
> +	val = ioread32(base + ATAPI_CONTROL1_REG);
> +	val |= ATAPI_CONTROL1_RESET;
> +	iowrite32(val, base + ATAPI_CONTROL1_REG);
> +
> +	/* ISM mode, PRD mode, DTEND flag at bit 0 */
> +	val = ioread32(base + ATAPI_CONTROL1_REG);
> +	val |= ATAPI_CONTROL1_ISM;
> +	val |= ATAPI_CONTROL1_DESE;
> +	val |= ATAPI_CONTROL1_DTA32M;
> +	iowrite32(val, base + ATAPI_CONTROL1_REG);
> +
> +	/* Release the SATA-IP from the reset state */
> +	val = ioread32(base + ATAPI_CONTROL1_REG);
> +	val &= ~ATAPI_CONTROL1_RESET;
> +	iowrite32(val, base + ATAPI_CONTROL1_REG);
> +

    As it stands, we could surely do the same with a much shorter code:

	if (priv->type == RCAR_GEN3_SATA) {
		sata_rcar_init_controller(host);
		
	} else {
	 	/* ack and mask */
	   	iowrite32(0, base + SATAINTSTAT_REG);
		iowrite32(0x7ff, base + SATAINTMASK_REG);
	}

    But do we really need this reset/init sequence on gen1/2 chips?

MBR, Sergei
