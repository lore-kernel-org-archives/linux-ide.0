From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ata: sata_rcar: Add DIPM mode disabling workaround
Date: Fri, 24 Oct 2014 13:15:55 +0900
Message-ID: <20141024041555.GB11281@verge.net.au>
References: <1412930703-24976-1-git-send-email-ykaneko0929@gmail.com>
 <5437AF32.1080606@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39879 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbaJXEP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2014 00:15:59 -0400
Content-Disposition: inline
In-Reply-To: <5437AF32.1080606@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Fri, Oct 10, 2014 at 02:04:34PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/10/2014 12:45 PM, Yoshihiro Kaneko wrote:
> 
> >From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> >This workaround must be applied to R8A7790(H2) ES1
> 
> >Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> >Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

For the record, this patch has been superseded by
"ata: sata_rcar: Disable DIPM mode for r8a7790 ES1".

> >---
> 
> >This patch is against for-next branch of Tejun's libata repo.
> 
> >  drivers/ata/sata_rcar.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> >index 61eb6d7..0ba5974 100644
> >--- a/drivers/ata/sata_rcar.c
> >+++ b/drivers/ata/sata_rcar.c
> >@@ -143,6 +143,11 @@
> >  #define RCAR_GEN2_PHY_CTL5_DC		BIT(1)	/* DC connection */
> >  #define RCAR_GEN2_PHY_CTL5_TR		BIT(2)	/* Termination Resistor */
> >
> >+/* Product Register */
> >+#define PRODUCT_REGISTER		0xFF000044
> >+#define PRODUCT_CUT_MASK		0x00007FF0
> >+#define PRODUCT_H2_BIT			(0x45 << 8)
> 
>    Why _BIT? And why not 0x00004500?
> 
> >@@ -751,18 +756,30 @@ done:
> >  	return IRQ_RETVAL(handled);
> >  }
> >
> >-static void sata_rcar_setup_port(struct ata_host *host)
> >+static int sata_rcar_setup_port(struct ata_host *host)
> >  {
> >  	struct ata_port *ap = host->ports[0];
> >  	struct ata_ioports *ioaddr = &ap->ioaddr;
> >  	struct sata_rcar_priv *priv = host->private_data;
> >  	void __iomem *base = priv->base;
> >+	void __iomem *product_reg;
> >
> >  	ap->ops		= &sata_rcar_port_ops;
> >  	ap->pio_mask	= ATA_PIO4;
> >  	ap->udma_mask	= ATA_UDMA6;
> >  	ap->flags	|= ATA_FLAG_SATA;
> >
> >+	product_reg = ioremap_nocache(PRODUCT_REGISTER, 0x04);
> 
>    Don't we need some platform function to read that register instead? It's
> not specific to SATA, AFAICT.
> 
> >+	if (!product_reg) {
> >+		dev_warn(host->dev, "ioremap fail\n");
> 
>    s/fail/failed/.
> 
> >+		return -ENOMEM;
> >+	}
> >+	/* Add the workaround of DIPM mode disabling in R-Car H2 ES1.x.*/
> 
>    Please add space before */
> 
> [...]
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
