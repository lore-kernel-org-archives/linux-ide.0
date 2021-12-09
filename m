Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFFC433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhLIWnv (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:43:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4987 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhLIWnu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Dec 2021 17:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639089615; x=1670625615;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=O3dOxUszHYvSVXwxc+CzHbIk3s+3IdjYDMtYRFQtwCg=;
  b=kfQpuCzh6blb62Mfwlg7ZkYWSf3nJQVxDtxOzovDGArVFML+AqKXD+h4
   sJtqbdKpE+AAJPi9uQ8JmFvLSd3u5mzacurEM/Vxr2W2KZ922PTTdn1gP
   dFtIFDCWWquY5VTme+nHgDaPGH3MgJDqRl3v/+XrDph0CahZxId3mXkPJ
   N8jhuzlNju6TTofOh4r9EAlDpF0R+n8D3w2cduhSbtWaaBx4Vwc3/a6H7
   pKmK7g4k0pefFFYiWcq8+vwMrjm/BT5A+7VyR6LW3MaaqCQxd8v9o8KSX
   68HTWX/D+xVlEYxAwdAoblXlEcgAuYuPXpDVPnFUhKIrpL7Nd1LA1qWV9
   A==;
X-IronPort-AV: E=Sophos;i="5.88,193,1635177600"; 
   d="scan'208";a="192666868"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 06:40:15 +0800
IronPort-SDR: zH4J5OivazG98+tdeXNfL3bZH937XRBC73Yusd9dMcMSFTeRpkUowW6ElrXv6HImixlnUksXtx
 vGAz6n36r1zwkzoC78he9y+2ldfeJhWRyLslXNQ0/x+afzjRDVfLooPTJsUROCIFX6XjU3nZrz
 NyQl4eAUANG32a+pnQ3gTg+vpXwalDU0LmHznFcOobN6DN/5arLI7TDnPdp9SOlJpdQ2N3zITT
 YmkM73i1pNXKhPWsE+IWgB/eAKFn3V2piHds5BpqcdEAmA9ZFF0cyKuBOFuSijidslMXZ0Fa03
 Dz+iEoSwD5aic/j7mrn6Qa2u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:13:19 -0800
IronPort-SDR: 3MmNTihef9l0lGIkJm4jTxZg7zRxhq16mroePETW1DiugHO5cl9l7qJbbuUOQj05qbvT989S4C
 b+4HIEqceZv+EiTrTEHeEGeHp2RPHZtQN+A46nXDmF24Q/9Gd5B4L0OGmUkCgmCKFFO2yMO2Wa
 /GMXAUbjtslutTI0v65ltfjrLjhZGbxeJWD2GyOGP2ASIOZY72WeZtIPKsbQUf8AQ004ZAd887
 RZfJ9Le21Pnlb631+DlQx4NBA3ve8yfIg0RmRXmTP9eGHuK6CsyPUEc7Q0iB6uMVlCUttnQWmS
 EiQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 14:40:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J98B80wCvz1Rvlf
        for <linux-ide@vger.kernel.org>; Thu,  9 Dec 2021 14:40:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639089615; x=1641681616; bh=O3dOxUszHYvSVXwxc+CzHbIk3s+3IdjYDMt
        YRFQtwCg=; b=iJyiKW3MxYslm5u31MUluLE0pj5VEy4nLceKCYRG6J9VdnCo6Ac
        D15UAarNcsld0VzgS0yW3bLluKRf14yrFpkFdnyg0GMg3zIv9Q704J+rJzlcr0hG
        2nizh97whclUX2PKF7RlNi02I9XZceGFHkEFYz7Ldjkf0P2SNjvN6UbcfuGk16lN
        Tc6HJI11gNsIDkxNH3fjYW6fcCCofH8UuMkrA8dTOFq66UDj5torWWn8I6q1XWCM
        7nnJvuafv6ru/syDCeJmj54RdQ38SV22anTzY4aANNtC0C9De2LIrABk7WDSccr7
        M4eRPkdSsAB/4UumCsmt3//ZZrVrW3Wk7nA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jbOdxG_jUj3F for <linux-ide@vger.kernel.org>;
        Thu,  9 Dec 2021 14:40:15 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J98B70xFPz1RtVG;
        Thu,  9 Dec 2021 14:40:14 -0800 (PST)
Message-ID: <5d98df66-a1fb-a2cf-f780-963bf26f6d1e@opensource.wdc.com>
Date:   Fri, 10 Dec 2021 07:40:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/3] ata: sata_dwc_460ex: Use temporary variable for
 struct device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209143519.60498-1-andriy.shevchenko@linux.intel.com>
 <20211209143519.60498-2-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211209143519.60498-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 23:35, Andy Shevchenko wrote:
> Use temporary variable for struct device to make code neater.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

What is this based on ? Is this on top of Hannes series ?

> ---
>  drivers/ata/sata_dwc_460ex.c | 37 ++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 513bee589d12..5421f74c0199 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -215,9 +215,10 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
>  {
>  	struct sata_dwc_device *hsdev = hsdevp->hsdev;
>  	struct dw_dma_slave *dws = &sata_dwc_dma_dws;
> +	struct device *dev = hsdev->dev;
>  	dma_cap_mask_t mask;
>  
> -	dws->dma_dev = hsdev->dev;
> +	dws->dma_dev = dev;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
> @@ -225,8 +226,7 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
>  	/* Acquire DMA channel */
>  	hsdevp->chan = dma_request_channel(mask, sata_dwc_dma_filter, hsdevp);
>  	if (!hsdevp->chan) {
> -		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
> -			 __func__);
> +		dev_err(dev, "%s: dma channel unavailable\n", __func__);
>  		return -EAGAIN;
>  	}
>  
> @@ -236,19 +236,20 @@ static int sata_dwc_dma_get_channel_old(struct sata_dwc_device_port *hsdevp)
>  static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  				 struct sata_dwc_device *hsdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  
> -	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
> +	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
>  	if (!hsdev->dma)
>  		return -ENOMEM;
>  
> -	hsdev->dma->dev = &pdev->dev;
> +	hsdev->dma->dev = dev;
>  	hsdev->dma->id = pdev->id;
>  
>  	/* Get SATA DMA interrupt number */
>  	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
>  	if (hsdev->dma->irq == NO_IRQ) {
> -		dev_err(&pdev->dev, "no SATA DMA irq\n");
> +		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}
>  
> @@ -1205,6 +1206,8 @@ static const struct ata_port_info sata_dwc_port_info[] = {
>  
>  static int sata_dwc_probe(struct platform_device *ofdev)
>  {
> +	struct device *dev = &ofdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct sata_dwc_device *hsdev;
>  	u32 idr, versionr;
>  	char *ver = (char *)&versionr;
> @@ -1214,12 +1217,11 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	struct ata_host *host;
>  	struct ata_port_info pi = sata_dwc_port_info[0];
>  	const struct ata_port_info *ppi[] = { &pi, NULL };
> -	struct device_node *np = ofdev->dev.of_node;
>  	struct resource *res;
>  
>  	/* Allocate DWC SATA device */
> -	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_DWC_MAX_PORTS);
> -	hsdev = devm_kzalloc(&ofdev->dev, sizeof(*hsdev), GFP_KERNEL);
> +	host = ata_host_alloc_pinfo(dev, ppi, SATA_DWC_MAX_PORTS);
> +	hsdev = devm_kzalloc(dev, sizeof(*hsdev), GFP_KERNEL);
>  	if (!host || !hsdev)
>  		return -ENOMEM;
>  
> @@ -1229,7 +1231,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	base = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> -	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
> +	dev_dbg(dev, "ioremap done for SATA register address\n");
>  
>  	/* Synopsys DWC SATA specific Registers */
>  	hsdev->sata_dwc_regs = base + SATA_DWC_REG_OFFSET;
> @@ -1243,11 +1245,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	/* Read the ID and Version Registers */
>  	idr = sata_dwc_readl(&hsdev->sata_dwc_regs->idr);
>  	versionr = sata_dwc_readl(&hsdev->sata_dwc_regs->versionr);
> -	dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c\n",
> -		   idr, ver[0], ver[1], ver[2]);
> +	dev_notice(dev, "id %d, controller version %c.%c%c\n", idr, ver[0], ver[1], ver[2]);
>  
>  	/* Save dev for later use in dev_xxx() routines */
> -	hsdev->dev = &ofdev->dev;
> +	hsdev->dev = dev;
>  
>  	/* Enable SATA Interrupts */
>  	sata_dwc_enable_interrupts(hsdev);
> @@ -1255,7 +1256,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	/* Get SATA interrupt number */
>  	irq = irq_of_parse_and_map(np, 0);
>  	if (irq == NO_IRQ) {
> -		dev_err(&ofdev->dev, "no SATA DMA irq\n");
> +		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}
>  
> @@ -1267,7 +1268,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	}
>  #endif
>  
> -	hsdev->phy = devm_phy_optional_get(hsdev->dev, "sata-phy");
> +	hsdev->phy = devm_phy_optional_get(dev, "sata-phy");
>  	if (IS_ERR(hsdev->phy))
>  		return PTR_ERR(hsdev->phy);
>  
> @@ -1282,7 +1283,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  	 */
>  	err = ata_host_activate(host, irq, sata_dwc_isr, 0, &sata_dwc_sht);
>  	if (err)
> -		dev_err(&ofdev->dev, "failed to activate host");
> +		dev_err(dev, "failed to activate host");
>  
>  	return 0;
>  
> @@ -1306,7 +1307,7 @@ static int sata_dwc_remove(struct platform_device *ofdev)
>  	sata_dwc_dma_exit_old(hsdev);
>  #endif
>  
> -	dev_dbg(&ofdev->dev, "done\n");
> +	dev_dbg(dev, "done\n");
>  	return 0;
>  }
>  


-- 
Damien Le Moal
Western Digital Research
