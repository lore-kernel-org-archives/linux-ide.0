From: Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: Re: [PATCH RESEND] ahci: qoriq: add lx2160 platforms support
Date: Fri, 1 Feb 2019 15:44:09 +0100
Message-ID: <20190201144409.GA29741@suse.de>
References: <20190131092829.25005-1-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131092829.25005-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: axboe@kernel.dk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, yousaf.kaukab@suse.com, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, Jan 31, 2019 at 05:28:29PM +0800, Peng Ma wrote:
> Lx2160a is a new introduced soc which supports ATA3.0
> Clean up some code
Some more info here can be useful. For example why you are removing LS2088A
support. Otherwise patch looks good.

> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/ata/ahci_qoriq.c |   44 ++++++++++++--------------------------------
>  1 files changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index ce59253..1994bf2 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -57,7 +57,7 @@ enum ahci_qoriq_type {
>  	AHCI_LS2080A,
>  	AHCI_LS1046A,
>  	AHCI_LS1088A,
> -	AHCI_LS2088A,
> +	AHCI_LX2160A,
>  };
>  
>  struct ahci_qoriq_priv {
> @@ -73,7 +73,7 @@ struct ahci_qoriq_priv {
>  	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
>  	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
>  	{ .compatible = "fsl,ls1088a-ahci", .data = (void *)AHCI_LS1088A},
> -	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
> +	{ .compatible = "fsl,lx2160a-ahci", .data = (void *)AHCI_LX2160A},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
> @@ -174,12 +174,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
>  		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		if (qpriv->is_dmacoherent)
> -			writel(AHCI_PORT_AXICC_CFG,
> -					reg_base + LS1021A_AXICC_ADDR);
>  		break;
>  
>  	case AHCI_LS1043A:
> +	case AHCI_LS1046A:
>  		if (!qpriv->ecc_addr)
>  			return -EINVAL;
>  		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
> @@ -188,8 +186,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
>  		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		if (qpriv->is_dmacoherent)
> -			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
>  		break;
>  
>  	case AHCI_LS2080A:
> @@ -197,24 +193,10 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
>  		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		if (qpriv->is_dmacoherent)
> -			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
> -		break;
> -
> -	case AHCI_LS1046A:
> -		if (!qpriv->ecc_addr)
> -			return -EINVAL;
> -		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
> -				qpriv->ecc_addr);
> -		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
> -		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
> -		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
> -		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		if (qpriv->is_dmacoherent)
> -			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
>  		break;
>  
>  	case AHCI_LS1088A:
> +	case AHCI_LX2160A:
>  		if (!qpriv->ecc_addr)
>  			return -EINVAL;
>  		writel(readl(qpriv->ecc_addr) | ECC_DIS_LS1088A,
> @@ -223,18 +205,16 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
>  		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		if (qpriv->is_dmacoherent)
> -			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
>  		break;
> +	}
>  
> -	case AHCI_LS2088A:
> -		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
> -		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
> -		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
> -		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		if (qpriv->is_dmacoherent)
> -			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
> -		break;
> +	if (qpriv->is_dmacoherent) {
> +		if (qpriv->type == AHCI_LS1021A)
> +			writel(AHCI_PORT_AXICC_CFG,
> +			       reg_base + LS1021A_AXICC_ADDR);
> +		else
> +			writel(AHCI_PORT_AXICC_CFG,
> +			       reg_base + PORT_AXICC);
>  	}
>  
>  	return 0;
> -- 
> 1.7.1

BR,
Yousaf
