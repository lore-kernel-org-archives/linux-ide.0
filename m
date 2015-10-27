From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [v2 03/10] ata: ahci_brcmstb: add quick for broken phy
Date: Tue, 27 Oct 2015 08:54:17 -0700
Message-ID: <562F9E29.3060806@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33286 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964831AbbJ0Py7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 11:54:59 -0400
In-Reply-To: <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

On 26/10/15 23:48, Jaedon Shin wrote:
> Add quick for broken phy. The ARM-based 28nm chipsets have four phy
> interface control registers and each port has two registers. But, The
> MIPS-based 40nm chipsets have three. and there are no information and
> documentation. The legacy version of broadcom's strict-ahci based
> initial code did not control these registers.

Qualifying this of a broken PHY is a misnomer, this is more about the
fact that the PHY control registers have a different layout and behavior
on 40nm vs 28nm chips, but more importantly, do not require any kind of
configuration.

> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt |  1 +
>  drivers/ata/ahci_brcmstb.c                                  | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> index 488a383ce202..0f0925d58188 100644
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
> @@ -12,6 +12,7 @@ Required properties:
>  
>  Optional properties:
>  - brcm,broken-ncq    : if present, NCQ is unusable
> +- brcm,broken-phy    : if present, to control phy interface is unusable

Same comment as in patch 1, this is something that can be known based on
the compatible string, and the name of the property is misleading.

>  
>  Also see ahci-platform.txt.
>  
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index e53962cb48ee..c61303f7c7dc 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -71,6 +71,7 @@
>  
>  enum brcm_ahci_quicks {
>  	BRCM_AHCI_QUICK_NONCQ		= BIT(0),
> +	BRCM_AHCI_QUICK_NOPHY		= BIT(1),

I would use something like BRCM_AHCI_SKIP_PHY_ENABLE or something like
that to illustrate what this really is about.

>  };
>  
>  struct brcm_ahci_priv {
> @@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  	void __iomem *p;
>  	u32 reg;
>  
> +	if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +		return;
> +
>  	/* clear PHY_DEFAULT_POWER_STATE */
>  	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
>  	reg = brcm_sata_readreg(p);
> @@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>  	void __iomem *p;
>  	u32 reg;
>  
> +	if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +		return;
> +
>  	/* power-off the PHY digital logic */
>  	p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
>  	reg = brcm_sata_readreg(p);
> @@ -297,6 +304,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
>  		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
>  
> +	if (of_property_read_bool(dev->of_node, "brcm,broken-phy"))
> +		priv->quicks |= BRCM_AHCI_QUICK_NOPHY;
> +
>  	brcm_sata_init(priv);
>  	brcm_sata_quick(pdev, priv);
>  
> 


-- 
Florian
