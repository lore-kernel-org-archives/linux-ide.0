From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] ahci: qoriq: added a condition to enable dma
 coherence
Date: Wed, 16 Nov 2016 16:02:35 +0000
Message-ID: <aa049243-0a42-34d8-172b-ab2df88e2313@arm.com>
References: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932458AbcKPQCi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 16 Nov 2016 11:02:38 -0500
In-Reply-To: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yuantian.tang@nxp.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 16/11/16 03:11, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Enable DMA coherence in SATA controller on condition that
> dma-coherent property exists in sata node in DTS.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  drivers/ata/ahci_qoriq.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index 9884c8c..45c88de 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -59,6 +59,7 @@ struct ahci_qoriq_priv {
>  	struct ccsr_ahci *reg_base;
>  	enum ahci_qoriq_type type;
>  	void __iomem *ecc_addr;
> +	bool is_dmacoherent;
>  };
>  
>  static const struct of_device_id ahci_qoriq_of_match[] = {
> @@ -164,26 +165,31 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  		writel(LS1021A_PORT_PHY4, reg_base + PORT_PHY4);
>  		writel(LS1021A_PORT_PHY5, reg_base + PORT_PHY5);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		writel(AHCI_PORT_AXICC_CFG, reg_base + LS1021A_AXICC_ADDR);
> +		if (qpriv->is_dmacoherent)
> +			writel(AHCI_PORT_AXICC_CFG,
> +					reg_base + LS1021A_AXICC_ADDR);
>  		break;
>  
>  	case AHCI_LS1043A:
>  		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
> +		if (qpriv->is_dmacoherent)
> +			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
>  		break;
>  
>  	case AHCI_LS2080A:
>  		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
> +		if (qpriv->is_dmacoherent)
> +			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
>  		break;
>  
>  	case AHCI_LS1046A:
>  		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
>  		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
> +		if (qpriv->is_dmacoherent)
> +			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
>  		break;
>  	}
>  
> @@ -221,6 +227,7 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
>  		if (IS_ERR(qoriq_priv->ecc_addr))
>  			return PTR_ERR(qoriq_priv->ecc_addr);
>  	}
> +	qoriq_priv->is_dmacoherent = of_property_read_bool(np, "dma-coherent");

Better to use of_dma_is_coherent(np) rather than open-coding it.

Robin.

>  
>  	rc = ahci_platform_enable_resources(hpriv);
>  	if (rc)
> 

