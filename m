Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E22C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbhLIAoI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:44:08 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62989 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbhLIAn6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 19:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639010426; x=1670546426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2GKe5GLlajC3QFergxRDN2hlwaL7v4XD0ZDJk/fL0u0=;
  b=Yg+vBoh93etUf1Z2fDd+nCsovoBn6m44oy0g4AmRj/PGjeYi7nIPK1gb
   Vhp5QeJSneMV+2CE/p+6uT1gs4koViAJpZoVXYd1iRHhi9c6nVxWVKoC7
   gHHDxDSB2X0xpaAgRvSpLO6yTYERRLiPLdXOAylpyNxGW+1CkHRMCxkiw
   ELBn701IOqkA+xHotADZDtpvF+OAzsvZV+OXG0yOBmoF4t7jW/9gNO0b1
   g5ztqfkOhFSjN25SvjAS3E04NMGkUpYptgDfTlFLMhEu41czGyi+EAy/l
   4vNzrqX87/nyoReEHvikky4kvEXpDsz1Xd0P/rZ5BrIIrRWWQOxJt8qzC
   A==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="299635677"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:40:26 +0800
IronPort-SDR: 98I6u0jqpaIst1pRHVHWC21XlHWxBCrbW34yBnzv2ORYJag+3T1GPDa56LBwo6OAgS7rUaBMEF
 +EVICG0gVb12KSpDb6VSnH382yEWla2g1AzJAXd5MCM29o10i1IsqmUHue/6vlSl4CNbjKmgLu
 YgcPqh+FRKDqKkvYAFkGP6oXS6dOpuaZVYul99aJDJTJtr8//JSSxZEZPbDBR3mB59++zC/0ei
 GmJVmmn1mfJ78Ms+p8M4s1qRVX50c6u4tghdFWSqAXJvbaVfZ7OeD44UzFd15UjmR2rBWAkx56
 mczHHSxjQT0dU/kG1VKmDvPP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:15:00 -0800
IronPort-SDR: YoWIFPs8LJe34X++5rrg/JBBgtRhrLG0bDeDw/UBqfBnAaCpAKWGCYFzYoiBIw/aXrl1oOn8Sg
 eTnfZXWzAsrPYNQ/3XaBNPl8PdfAQb5tdjv6zI23I4Rn6HN1knnqoQkAvP4kjpIB0ZpUDeUNJa
 rzWrkLCekzQW2I8hA66Bm3RaWlZaq9heTSKOhh28BxwUhUKyM+AzSj/7uO63FHPMvyI+upVRLo
 yAc/yY9pFAD139YGZnU9Z1G/UFA2LSNPAtYRmjcxkSBhelw35oNHw+XcE1bqjFt6DS7j8ggp2W
 GaQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:40:26 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8ZvF3thwz1RvTh
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:40:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639010425; x=1641602426; bh=2GKe5GLlajC3QFergxRDN2hlwaL7v4XD0ZD
        Jk/fL0u0=; b=eWPo8pcWvGpvGJqllYcGIqQhATuUojJ5OsHh/e6GxR2kfWr6DA6
        yMnjAnoYobDOcUT2CFZaTX1HehHcrAzwc2PAOpaNIaRPXr/RCLQt4bG7k5mqmTeR
        uelejk7lG9Wy2FGkv1GbcXEYXSPkbYKAr27ekYtcsmNOr4mWbitkmTHnGXjK2Qo5
        49MWIou2jjMJMCgCYQ0tZWXdMdAD1iQmcmbcTrEKtL0s8OdOVFMYHdi4dtDg74xS
        oYmP0hw9vk5I2UnBEJkUCIfkvI+gbd3YdYR7zBYZfoQPUaMN1U4pSZEfaLSO8K86
        jioOmNZ/OUW9NyJpgsp1ELDRO5DquAbhedw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mGvEWrdLXIf4 for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:40:25 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8ZvD3XgRz1RtVG;
        Wed,  8 Dec 2021 16:40:24 -0800 (PST)
Message-ID: <df329b28-3c1e-cddd-f9bb-986d14739848@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:40:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 06/73] sata_mv: kill 'port' argument in mv_dump_all_regs()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-7-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:31, Hannes Reinecke wrote:
> Always '-1', so drop it and simplify the function.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/sata_mv.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index f0257685495f..e86eddf83704 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1286,23 +1286,13 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
>  	}
>  }
>  
> -static void mv_dump_all_regs(void __iomem *mmio_base, int port,
> -			     struct pci_dev *pdev)
> +static void mv_dump_all_regs(void __iomem *mmio_base, struct pci_dev *pdev)
>  {
> -	void __iomem *hc_base = mv_hc_base(mmio_base,
> -					   port >> MV_PORT_HC_SHIFT);
> -	void __iomem *port_base;
>  	int start_port, num_ports, p, start_hc, num_hcs, hc;
>  
> -	if (0 > port) {
> -		start_hc = start_port = 0;
> -		num_ports = 8;		/* shld be benign for 4 port devs */
> -		num_hcs = 2;
> -	} else {
> -		start_hc = port >> MV_PORT_HC_SHIFT;
> -		start_port = port;
> -		num_ports = num_hcs = 1;
> -	}
> +	start_hc = start_port = 0;
> +	num_ports = 8;		/* shld be benign for 4 port devs */
> +	num_hcs = 2;
>  	dev_printk(KERN_DEBUG, &pdev->dev,
>  		   "%s: All registers for port(s) %u-%u:\n", __func__,
>  		   start_port, num_ports > 1 ? num_ports - 1 : start_port);
> @@ -1317,13 +1307,13 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
>  	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
>  	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
> -		hc_base = mv_hc_base(mmio_base, hc);
> +		void __iomem *hc_base = mv_hc_base(mmio_base, hc);

please add a blank line after the declaration.

>  		dev_printk(KERN_DEBUG, &pdev->dev, "%s: HC regs (HC %i):\n",
>  			   __func__, hc);

Change this to dev_dbg() while at it ?

>  		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
>  	}
>  	for (p = start_port; p < start_port + num_ports; p++) {
> -		port_base = mv_port_base(mmio_base, p);
> +		void __iomem *port_base = mv_port_base(mmio_base, p);
>  		dev_printk(KERN_DEBUG, &pdev->dev, "%s: EDMA regs (port %i):\n",
>  			   __func__, p);

Same comments.

>  		mv_dump_mem(&pdev->dev, port_base, 0x54);
> @@ -2973,7 +2963,7 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
>  	if (pci_dump) {
>  		dev_printk(KERN_DEBUG, host->dev, "%s: All regs @ PCI error\n",
>  			   __func__);
> -		mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
> +		mv_dump_all_regs(mmio, to_pci_dev(host->dev));
>  	}
>  	writelfl(0, mmio + hpriv->irq_cause_offset);
>  
> 


-- 
Damien Le Moal
Western Digital Research
