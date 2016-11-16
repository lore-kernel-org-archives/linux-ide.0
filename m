From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/2] ahci: qoriq: report warning when ecc register is
 missing
Date: Wed, 16 Nov 2016 08:56:13 -0700
Message-ID: <20161116155613.GA1228@linaro.org>
References: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
 <1479265879-48840-2-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36389 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbcKPP4R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2016 10:56:17 -0500
Received: by mail-it0-f51.google.com with SMTP id l8so71705684iti.1
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2016 07:56:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1479265879-48840-2-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 16, 2016 at 11:11:19AM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> For ls1021a and ls1046a socs, sata ecc must be disabled.
> If ecc register is not found in sata node in dts, report
> a warning.

Hi Yuantian,

What happens if sata ecc is _not_ disaled on those socs?  Can the driver still
work?  If not then it is probably a better idea to return an error code that can
prevent the driver from initialising.

Thanks,
Mathieu

> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  drivers/ata/ahci_qoriq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index 45c88de..66eb4b5 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -158,6 +158,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  
>  	switch (qpriv->type) {
>  	case AHCI_LS1021A:
> +		WARN_ON(!qpriv->ecc_addr);
>  		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
>  		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
>  		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
> @@ -185,6 +186,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
>  		break;
>  
>  	case AHCI_LS1046A:
> +		WARN_ON(!qpriv->ecc_addr);
>  		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
>  		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
>  		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
