From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: sata_rcar: Add DIPM mode disabling workaround
Date: Fri, 10 Oct 2014 14:04:34 +0400
Message-ID: <5437AF32.1080606@cogentembedded.com>
References: <1412930703-24976-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1412930703-24976-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 10/10/2014 12:45 PM, Yoshihiro Kaneko wrote:

> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

> This workaround must be applied to R8A7790(H2) ES1

> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---

> This patch is against for-next branch of Tejun's libata repo.

>   drivers/ata/sata_rcar.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 61eb6d7..0ba5974 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -143,6 +143,11 @@
>   #define RCAR_GEN2_PHY_CTL5_DC		BIT(1)	/* DC connection */
>   #define RCAR_GEN2_PHY_CTL5_TR		BIT(2)	/* Termination Resistor */
>
> +/* Product Register */
> +#define PRODUCT_REGISTER		0xFF000044
> +#define PRODUCT_CUT_MASK		0x00007FF0
> +#define PRODUCT_H2_BIT			(0x45 << 8)

    Why _BIT? And why not 0x00004500?

> @@ -751,18 +756,30 @@ done:
>   	return IRQ_RETVAL(handled);
>   }
>
> -static void sata_rcar_setup_port(struct ata_host *host)
> +static int sata_rcar_setup_port(struct ata_host *host)
>   {
>   	struct ata_port *ap = host->ports[0];
>   	struct ata_ioports *ioaddr = &ap->ioaddr;
>   	struct sata_rcar_priv *priv = host->private_data;
>   	void __iomem *base = priv->base;
> +	void __iomem *product_reg;
>
>   	ap->ops		= &sata_rcar_port_ops;
>   	ap->pio_mask	= ATA_PIO4;
>   	ap->udma_mask	= ATA_UDMA6;
>   	ap->flags	|= ATA_FLAG_SATA;
>
> +	product_reg = ioremap_nocache(PRODUCT_REGISTER, 0x04);

    Don't we need some platform function to read that register instead? It's 
not specific to SATA, AFAICT.

> +	if (!product_reg) {
> +		dev_warn(host->dev, "ioremap fail\n");

    s/fail/failed/.

> +		return -ENOMEM;
> +	}
> +	/* Add the workaround of DIPM mode disabling in R-Car H2 ES1.x.*/

    Please add space before */

[...]

WBR, Sergei

