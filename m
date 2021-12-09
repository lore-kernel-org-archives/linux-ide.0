Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E73C433F5
	for <linux-ide@archiver.kernel.org>; Thu,  9 Dec 2021 00:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLIAmA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 19:42:00 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28337 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLIAl7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 19:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639010306; x=1670546306;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z/fxOk9kMUHdGIMymg4DeT3FPuVwDBmGGxdjEE29ECQ=;
  b=QrnETSO/bOIexeMH6hT3NpXOgVDeHwTFxxr0PXMGRRrHJ3EoqULwuCG/
   JoRDRZmQrgqp0VvUpkcWak+rwjBdWFLsynII/DcIky+7g3KdYeTrNPSwr
   vw0ggqismwhWl4uauAmp2oI9zUAQX5a1Ubbtyrh75FNJ4memvII/1QxMb
   Klw15gLKAP+RBQPc8HGrj7qXAf9iN8TrU3j+1ZocwPPOIkn8GHJTUpLOw
   ZXjibAkqjcyoZVUwQnLq49/5CsAYIVF3oqUGNQD+jo6CXZvc2/Jr6uN7T
   LBEfyr3MLe4CBSZr5tJL5/9RSKf+Nf6eI6mGIS8VkSP0DzaVOj24QfrAB
   w==;
X-IronPort-AV: E=Sophos;i="5.88,190,1635177600"; 
   d="scan'208";a="187792957"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 08:38:25 +0800
IronPort-SDR: w/PS/XBWlLpvfhxANcyRZ7Nr0TRZCb6Bgh+639bfwLJgbWZwkOnjxt9E9rjxxlXvg+NCWD3Azq
 7k4JrKCf2l4ImLwC7zb0BfqZKeZ9nTcDdEnAXSIEwn+DL+VMHlhUN5rXjb7Hx3/r1Jl1/PkTwI
 aOoEClu/Q9Xn/9/RlVgY5086rwsqMlE2Mliu5Ukzx5gSEFigjdW27js9KxeU7J9x5KP1YrEo90
 Zomvwg/7jTozaRIosSBxiSepqoVkYgAcNvUTAR5wk0en1/dSWYYdfynLSMMqhclLI70zrk4ppY
 cW4Fb2pZ4E5Yy4gl9ewnK8Mq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:13:00 -0800
IronPort-SDR: u/VlDwQnibN40bZqqX9Haw+GKYXzO3p1o4ud9ERDsoy+NEd4yqAfmKTxXu2N7VJ0r0D+kVO72+
 8KAWoH8MCfIpqk6Q2bs8q0aZXJMAZg93GFbducE42QLarF6n1FmXWEINbq51f/neTEErMrJOo9
 PaafDI/6zSe6CccGEU6Fz5wumXIrc+oXV+n9/rxq077cA9UjdxPVWiAXH01FiGO9Q2FczfLAOm
 O1jEArr0wgn/XovDCDVfO9BiNOIvfXLddsgLgLzmPy7FQ0rEKE+Jd2YMxR6uHU9Iyu/5T+2kaG
 asI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 16:38:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J8Zry2z0mz1RwFN
        for <linux-ide@vger.kernel.org>; Wed,  8 Dec 2021 16:38:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639010305; x=1641602306; bh=z/fxOk9kMUHdGIMymg4DeT3FPuVwDBmGGxd
        jEE29ECQ=; b=mOJdy+t2TBWueayoIBtyt6w4dojPQJ2D3REkv1ohJnKSF99sJWQ
        KSu2wjLpQM+tfv1hRsqX6fuZuqHFcn/ySRlXe7P0lgScCJOQ+0ZUeN1qrzALnLFO
        2C4Iqa+qulYSBquym/bvrFC16csDkRa1F2pbyfy3yMigvsv4UVqfTJZz4N4/CNix
        Zl1qNmPD6o7VkwK/l7JNUruXGghTeN/mcOKzWORYe+ZfJHuV9+EEJCuRlJMoxuLf
        BpbIIMUguccGHJ1jdXBcJyv9HwXvR40sbCjxAMkUbIZwzydJ9kB8oeZod+rY6oC9
        RXld9waeIpjTvg3xmM+VyCmPPha6OuWjWyw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 55ViGhw6oLYb for <linux-ide@vger.kernel.org>;
        Wed,  8 Dec 2021 16:38:25 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J8Zrw6X6Hz1RtVG;
        Wed,  8 Dec 2021 16:38:24 -0800 (PST)
Message-ID: <6fc0936f-d220-69c4-a76b-f68485a078bd@opensource.wdc.com>
Date:   Thu, 9 Dec 2021 09:38:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 05/73] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20211208163255.114660-1-hare@suse.de>
 <20211208163255.114660-6-hare@suse.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211208163255.114660-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/09 1:31, Hannes Reinecke wrote:
> Implement module parameter 'pci_dump' and move the DPRINTK calls
> over to dev_printk().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/ata/sata_mv.c | 88 ++++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index cae4c1eab102..f0257685495f 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -83,6 +83,10 @@ module_param(irq_coalescing_usecs, int, S_IRUGO);
>  MODULE_PARM_DESC(irq_coalescing_usecs,
>  		 "IRQ coalescing time threshold in usecs");
>  
> +static int pci_dump;
> +module_param(pci_dump, int, S_IRUGO);
> +MODULE_PARM_DESC(pci_dump, "Enable dumping of PCI registers on error");
> +
>  enum {
>  	/* BAR's are enumerated in terms of pci_resource_start() terms */
>  	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
> @@ -1248,42 +1252,43 @@ static int mv_stop_edma(struct ata_port *ap)
>  	return err;
>  }
>  
> -#ifdef ATA_DEBUG
> -static void mv_dump_mem(void __iomem *start, unsigned bytes)
> +static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>  {
> -	int b, w;
> +	int b, w, o;
> +	unsigned char linebuf[38];
> +
>  	for (b = 0; b < bytes; ) {
> -		DPRINTK("%p: ", start + b);
> -		for (w = 0; b < bytes && w < 4; w++) {
> -			printk("%08x ", readl(start + b));
> +		for (w = 0, o = 0; b < bytes && w < 4; w++) {
> +			o += snprintf(linebuf + o, 38 - o,
> +				      "%08x ", readl(start + b));
>  			b += sizeof(u32);
>  		}
> -		printk("\n");
> +		dev_printk(KERN_DEBUG, dev, "%s: %p: %s\n",
> +			   __func__, start + b, linebuf);

Why not dev_dbg() ? Same comment for all the prints below.

>  	}
>  }
> -#endif
> -#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
> +
>  static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
>  {
> -#ifdef ATA_DEBUG
> -	int b, w;
> +	int b, w, o;
>  	u32 dw;
> +	unsigned char linebuf[38];
> +
>  	for (b = 0; b < bytes; ) {
> -		DPRINTK("%02x: ", b);
> -		for (w = 0; b < bytes && w < 4; w++) {
> +		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>  			(void) pci_read_config_dword(pdev, b, &dw);
> -			printk("%08x ", dw);
> +			o += snprintf(linebuf + o, 38 - o,
> +				      "%08x ", dw);
>  			b += sizeof(u32);
>  		}
> -		printk("\n");
> +		dev_printk(KERN_DEBUG, &pdev->dev, "%s: %02x: %s\n",
> +			   __func__, b, linebuf);
>  	}
> -#endif
>  }
> -#endif
> +
>  static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  			     struct pci_dev *pdev)
>  {
> -#ifdef ATA_DEBUG
>  	void __iomem *hc_base = mv_hc_base(mmio_base,
>  					   port >> MV_PORT_HC_SHIFT);
>  	void __iomem *port_base;
> @@ -1298,31 +1303,34 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  		start_port = port;
>  		num_ports = num_hcs = 1;
>  	}
> -	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
> -		num_ports > 1 ? num_ports - 1 : start_port);
> +	dev_printk(KERN_DEBUG, &pdev->dev,
> +		   "%s: All registers for port(s) %u-%u:\n", __func__,
> +		   start_port, num_ports > 1 ? num_ports - 1 : start_port);
>  
> -	if (NULL != pdev) {
> -		DPRINTK("PCI config space regs:\n");
> -		mv_dump_pci_cfg(pdev, 0x68);
> -	}
> -	DPRINTK("PCI regs:\n");
> -	mv_dump_mem(mmio_base+0xc00, 0x3c);
> -	mv_dump_mem(mmio_base+0xd00, 0x34);
> -	mv_dump_mem(mmio_base+0xf00, 0x4);
> -	mv_dump_mem(mmio_base+0x1d00, 0x6c);
> +	dev_printk(KERN_DEBUG, &pdev->dev,
> +		   "%s: PCI config space regs:\n", __func__);
> +	mv_dump_pci_cfg(pdev, 0x68);
> +
> +	dev_printk(KERN_DEBUG, &pdev->dev, "%s: PCI regs:\n", __func__);
> +	mv_dump_mem(&pdev->dev, mmio_base+0xc00, 0x3c);
> +	mv_dump_mem(&pdev->dev, mmio_base+0xd00, 0x34);
> +	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
> +	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
>  	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
>  		hc_base = mv_hc_base(mmio_base, hc);
> -		DPRINTK("HC regs (HC %i):\n", hc);
> -		mv_dump_mem(hc_base, 0x1c);
> +		dev_printk(KERN_DEBUG, &pdev->dev, "%s: HC regs (HC %i):\n",
> +			   __func__, hc);
> +		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
>  	}
>  	for (p = start_port; p < start_port + num_ports; p++) {
>  		port_base = mv_port_base(mmio_base, p);
> -		DPRINTK("EDMA regs (port %i):\n", p);
> -		mv_dump_mem(port_base, 0x54);
> -		DPRINTK("SATA regs (port %i):\n", p);
> -		mv_dump_mem(port_base+0x300, 0x60);
> +		dev_printk(KERN_DEBUG, &pdev->dev, "%s: EDMA regs (port %i):\n",
> +			   __func__, p);
> +		mv_dump_mem(&pdev->dev, port_base, 0x54);
> +		dev_printk(KERN_DEBUG, &pdev->dev, "%s: SATA regs (port %i):\n",
> +			   __func__, p);
> +		mv_dump_mem(&pdev->dev, port_base+0x300, 0x60);
>  	}
> -#endif
>  }
>  
>  static unsigned int mv_scr_offset(unsigned int sc_reg_in)
> @@ -2962,9 +2970,11 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
>  
>  	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
>  
> -	DPRINTK("All regs @ PCI error\n");
> -	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
> -
> +	if (pci_dump) {
> +		dev_printk(KERN_DEBUG, host->dev, "%s: All regs @ PCI error\n",
> +			   __func__);
> +		mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
> +	}
>  	writelfl(0, mmio + hpriv->irq_cause_offset);
>  
>  	for (i = 0; i < host->n_ports; i++) {
> 


-- 
Damien Le Moal
Western Digital Research
