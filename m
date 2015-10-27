From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [v2 03/10] ata: ahci_brcmstb: add quick for broken phy
Date: Tue, 27 Oct 2015 03:17:40 -0500
Message-ID: <CAL_Jsq+GngRS80_T2joPZwOB3gGnHZuuaTzXn6Tc07exAq_Fag@mail.gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57219 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbbJ0ISC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Oct 2015 04:18:02 -0400
In-Reply-To: <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Oct 27, 2015 at 1:48 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Add quick for broken phy. The ARM-based 28nm chipsets have four phy

I believe you mean "quirk".

> interface control registers and each port has two registers. But, The

registers, but the...

> MIPS-based 40nm chipsets have three. and there are no information and

s/and there/There/

> documentation. The legacy version of broadcom's strict-ahci based
> initial code did not control these registers.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt |  1 +

Other than the commit message:

Acked-by: Rob Herring <robh@kernel.org>

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
>         BRCM_AHCI_QUICK_NONCQ           = BIT(0),
> +       BRCM_AHCI_QUICK_NOPHY           = BIT(1),
>  };
>
>  struct brcm_ahci_priv {
> @@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>         void __iomem *p;
>         u32 reg;
>
> +       if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +               return;
> +
>         /* clear PHY_DEFAULT_POWER_STATE */
>         p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
>         reg = brcm_sata_readreg(p);
> @@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>         void __iomem *p;
>         u32 reg;
>
> +       if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
> +               return;
> +
>         /* power-off the PHY digital logic */
>         p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
>         reg = brcm_sata_readreg(p);
> @@ -297,6 +304,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>         if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
>                 priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
>
> +       if (of_property_read_bool(dev->of_node, "brcm,broken-phy"))
> +               priv->quicks |= BRCM_AHCI_QUICK_NOPHY;
> +
>         brcm_sata_init(priv);
>         brcm_sata_quick(pdev, priv);
>
> --
> 2.6.2
>
