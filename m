Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1177C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2620708
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="docIQbnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgBJMvf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:51:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35534 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgBJMvd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:51:33 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210125131euoutp02c063426e4e916c58686330ac08358d9b~yC4Z20wb60234102341euoutp028
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:51:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210125131euoutp02c063426e4e916c58686330ac08358d9b~yC4Z20wb60234102341euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581339091;
        bh=Yl79W3gG6KaXlwB++Nm3pVK/FBOuBDMowBIrPDlvCRA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=docIQbnWA1FyIYsdn6tnbG4dzQeWqpjLJpJTUgbauLnK1BkOQkoRt5xaoZ/tgUFz0
         TymYeS9/nDwiWGnC/B0e8W9V+2O0LT7bQuOuNe0CRsA/U0y6X5cKQMJX+IESiQM1fr
         ui5E/4tBI71lm/HF7FrFUOkUdnFv+63Ec6O1QGyw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210125131eucas1p106916f07a4a94f58aa7f693fd259a71f~yC4ZlswKy1824318243eucas1p1U;
        Mon, 10 Feb 2020 12:51:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.CF.60679.2D1514E5; Mon, 10
        Feb 2020 12:51:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210125130eucas1p1900949794dc3844fbdc8fa36c3435f3b~yC4ZRAzpN1824318243eucas1p1T;
        Mon, 10 Feb 2020 12:51:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210125130eusmtrp1a63987eda19de8fb496dc7dd78eabc71~yC4ZQa4g51938919389eusmtrp1N;
        Mon, 10 Feb 2020 12:51:30 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-64-5e4151d24d7b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.43.07950.2D1514E5; Mon, 10
        Feb 2020 12:51:30 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210125130eusmtip1149a6222a96f4320f865af2c7fa7b147~yC4ZCgnpg0160201602eusmtip1x;
        Mon, 10 Feb 2020 12:51:30 +0000 (GMT)
Subject: Re: [PATCH 10/46] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <9f91e33e-5c5c-a142-2cef-dc2d0df12c75@samsung.com>
Date:   Mon, 10 Feb 2020 13:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-11-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87qXAh3jDO4cs7BYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6MKYfeshU0
        aldM3/KctYHxgWIXIweHhICJxIn74iCmkMAKRoltbF2MXEDmF0aJSUuWs0A4nxklFi9cx97F
        yAlWv+jpG6iq5YwSd7f3MEM4bxkleqZeB6sSFgiTaNw7hxXEFhFQkvjYfggsziwQJ9F05S6Y
        zSZgJTGxfRUjiM0rYCexaNkTsHoWAVWJWzcvg9miAhESnx4cZoWoEZQ4OfMJC4jNCXTFhQOP
        mSBmikvcejIfypaX2P52DthBEgL97BJrJ59hhDjbRWLP2pVQtrDEq+NboN6RkTg9uYcFomEd
        o8TfjhdQ3dsZJZZP/scGUWUtcefcLzZQKDELaEqs36UPEXaUmNM/kwkSjnwSN94KQhzBJzFp
        23RmiDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8tbQ4Nz21
        2CgvtVyvODG3uDQvXS85P3cTIzCpnP53/MsOxl1/kg4xCnAwKvHwOtg7xAmxJpYVV+YeYpTg
        YFYS4bWUdowT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1Oq
        gVE/yXPBeY60GBeXG9pcl57Y5nzPPzDpg+JalmvPHHrK1djEljZqb09yrNCWnMZx2feTVtQ7
        m6dfGL9ZVGgWhb5nFNFhc9298u0q72MvV/KvPPBB0+3GWbMjPyfd9TE++XPDi327TRssthw+
        f0AuasbRmxaxx8UnM68+0ryU4fR9qROhCp77tWYosRRnJBpqMRcVJwIAN0G9tCYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qXAh3jDLbuUrdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MKYfeshU0aldM3/KctYHxgWIXIyeHhICJ
        xKKnb9i6GLk4hASWMkrcmtfL3sXIAZSQkTi+vgyiRljiz7UuqJrXjBJ33zxkBUkIC4RJNO6d
        A2aLCChJfGw/xA5iMwvESfzr280EYgsJbGCU+NxtCmKzCVhJTGxfxQhi8wrYSSxa9gSsl0VA
        VeLWzctgtqhAhMThHbOgagQlTs58wgJicwIdeuHAYyaI+eoSf+ZdYoawxSVuPZkPFZeX2P52
        DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjaNuxn1t2
        MHa9Cz7EKMDBqMTD62DvECfEmlhWXJl7iFGCg1lJhNdS2jFOiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OBMZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFx
        wrbd5l/sHzw4cLEz2OjOqoVZKSecX97w/6XAyJC3TecBh731xKQTZ72CX5ptWrhu6ddFV4//
        nP+G47dESqxK75Hvc7XfnZt1582EwsfXjr5r5vye37Y8oyw+OK7j3/dd3asWFmq0bH7K83BH
        JQtLW1o4e7+a993nu6/v+Kl8hcPozRGDsyYmWUosxRmJhlrMRcWJAFKPK965AgAA
X-CMS-MailID: 20200210125130eucas1p1900949794dc3844fbdc8fa36c3435f3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p1b7b8cea23b743a5eb5abb51b4fad21aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p1b7b8cea23b743a5eb5abb51b4fad21aa
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p1b7b8cea23b743a5eb5abb51b4fad21aa@eucas1p1.samsung.com>
        <20200204165547.115220-11-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Implement module parameter 'pci_dump' and move the DPRINTK calls
> over to dev_printk().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_mv.c | 71 +++++++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d7228f8e9297..9e570d455acc 100644
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
> @@ -1245,47 +1249,49 @@ static int mv_stop_edma(struct ata_port *ap)
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
> +		dev_printk(KERN_DEBUG, dev, "%p: %s\n", start + b, linebuf);
>  	}
>  }
> -#endif
> -#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
> +#if defined(CONFIG_PCI)
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
> +		dev_printk(KERN_DEBUG, &pdev->dev, "%02x: %s\n", b, linebuf);
>  	}
> -#endif
>  }
>  #endif
>  static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  			     struct pci_dev *pdev)
>  {
> -#ifdef ATA_DEBUG
>  	void __iomem *hc_base = mv_hc_base(mmio_base,
>  					   port >> MV_PORT_HC_SHIFT);
>  	void __iomem *port_base;
>  	int start_port, num_ports, p, start_hc, num_hcs, hc;
>  
> +	if (!pci_dump)
> +		return;
> +	dev_printk(KERN_DEBUG, &pdev->dev, "All regs @ PCI error\n");
>  	if (0 > port) {
>  		start_hc = start_port = 0;
>  		num_ports = 8;		/* shld be benign for 4 port devs */
> @@ -1295,31 +1301,31 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  		start_port = port;
>  		num_ports = num_hcs = 1;
>  	}
> -	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
> -		num_ports > 1 ? num_ports - 1 : start_port);
> +	dev_printk(KERN_DEBUG, &pdev->dev,
> +		   "All registers for port(s) %u-%u:\n", start_port,
> +		   num_ports > 1 ? num_ports - 1 : start_port);
>  
>  	if (NULL != pdev) {
> -		DPRINTK("PCI config space regs:\n");
> +		dev_printk(KERN_DEBUG, &pdev->dev, "PCI config space regs:\n");
>  		mv_dump_pci_cfg(pdev, 0x68);
>  	}
> -	DPRINTK("PCI regs:\n");
> -	mv_dump_mem(mmio_base+0xc00, 0x3c);
> -	mv_dump_mem(mmio_base+0xd00, 0x34);
> -	mv_dump_mem(mmio_base+0xf00, 0x4);
> -	mv_dump_mem(mmio_base+0x1d00, 0x6c);
> +	dev_printk(KERN_DEBUG, &pdev->dev, "PCI regs:\n");
> +	mv_dump_mem(&pdev->dev, mmio_base+0xc00, 0x3c);
> +	mv_dump_mem(&pdev->dev, mmio_base+0xd00, 0x34);
> +	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
> +	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
>  	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
>  		hc_base = mv_hc_base(mmio_base, hc);
> -		DPRINTK("HC regs (HC %i):\n", hc);
> -		mv_dump_mem(hc_base, 0x1c);
> +		dev_printk(KERN_DEBUG, &pdev->dev, "HC regs (HC %i):\n", hc);
> +		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
>  	}
>  	for (p = start_port; p < start_port + num_ports; p++) {
>  		port_base = mv_port_base(mmio_base, p);
> -		DPRINTK("EDMA regs (port %i):\n", p);
> -		mv_dump_mem(port_base, 0x54);
> -		DPRINTK("SATA regs (port %i):\n", p);
> -		mv_dump_mem(port_base+0x300, 0x60);
> +		dev_printk(KERN_DEBUG, &pdev->dev, "EDMA regs (port %i):\n", p);
> +		mv_dump_mem(&pdev->dev, port_base, 0x54);
> +		dev_printk(KERN_DEBUG, &pdev->dev, "SATA regs (port %i):\n", p);
> +		mv_dump_mem(&pdev->dev, port_base+0x300, 0x60);
>  	}
> -#endif
>  }
>  
>  static unsigned int mv_scr_offset(unsigned int sc_reg_in)
> @@ -2958,7 +2964,6 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
>  
>  	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
>  
> -	DPRINTK("All regs @ PCI error\n");
>  	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
>  
>  	writelfl(0, mmio + hpriv->irq_cause_offset);
> 
