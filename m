Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56050C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EB2206D5
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ihd03/p2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgA3Lgh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:36:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40437 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3Lgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 06:36:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130113635euoutp015c908bf2b2baeb3b34505d6b538a160d~upw2KuaL70517505175euoutp01U
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 11:36:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130113635euoutp015c908bf2b2baeb3b34505d6b538a160d~upw2KuaL70517505175euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580384195;
        bh=UqmnG46cRkpb3z0GyA8wRALzorUDLwmgHNtz1/MPT90=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ihd03/p2mPF35cpPvJy4/ibniIBHmgoHGT40iPmYq6xSY+yrvbfi6a4OumjW/SxSL
         0LNmVgMZ3hhX3pnTfOlV9VOeRu7FMIr2S3HviaVvav0mkfDjzuEhBV6Uq8yNqkfe9m
         uUSTU94PiTqrYUjozM/XeHygkhAVV54/nHyjYgl4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130113635eucas1p1142f738e4cc915df5320d95dda4d5d24~upw1_UtOS3263732637eucas1p1C;
        Thu, 30 Jan 2020 11:36:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2A.C0.60698.3CFB23E5; Thu, 30
        Jan 2020 11:36:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130113635eucas1p1a909d72365103e0e77d28a1ddfddf3eb~upw1oi0RD3266232662eucas1p1C;
        Thu, 30 Jan 2020 11:36:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130113635eusmtrp2c2ac0e224f5f2ddd085d554089706581~upw1hP8DL1887618876eusmtrp2H;
        Thu, 30 Jan 2020 11:36:35 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-94-5e32bfc341f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.95.08375.3CFB23E5; Thu, 30
        Jan 2020 11:36:35 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130113634eusmtip17d05c128e6a292e6b2d96459bafd8238~upw1J_xGV1265612656eusmtip1f;
        Thu, 30 Jan 2020 11:36:34 +0000 (GMT)
Subject: Re: [PATCH 17/24] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d9fdb2e6-e361-e070-92e5-e2ab01c8f3aa@samsung.com>
Date:   Thu, 30 Jan 2020 12:36:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-29-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87qH9xvFGfR8U7FYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mu5ucC45r
        Vcz7vomlgXG9YhcjJ4eEgInEj7WdLF2MXBxCAisYJW7eucUI4XxhlJj+diKU85lR4uO8bUww
        Lb0b/jFBJJYzSmxZ+5wZwnnLKLH+03Qgh4NDWCBMYm9bKEiDiICSxMf2Q+wgNrNAnETTlbtg
        NpuAlcTE9lWMIDavgJ3ElFVTweIsAqoSX14vZwWxRQUiJD49OMwKUSMocXLmExYQm1PAWOLq
        geuMEDPFJW49mc8EYctLbH87B+weCYF+dokZj6+wQVztIvHq1R4oW1ji1fEt7BC2jMT/nfOZ
        IBrWMUr87XgB1b2dUWL55H9QHdYSd879YgP5jFlAU2L9Ln2IsKNEy/R5TCBhCQE+iRtvBSGO
        4JOYtA0SDhICvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS
        4tz01GLjvNRyveLE3OLSvHS95PzcTYzAtHL63/GvOxj3/Uk6xCjAwajEw6uxwShOiDWxrLgy
        9xCjBAezkgivqKthnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2Cy
        TBycUg2MPnd477B3ml2R/Pc9rDwn68fb5VcO3J3675LzngVP5q01Ws/Wofs17+NbtuwHWi+j
        VO02Ga39f7Wp9uzZRVPWc6jsrX08V/Fh38stRQ8W/ltpyv81fP373O5b+t05nVInpFqKJZTe
        HtH7leA10euxfr8qg2/gZfOXp1v3dwectC75tkkxIUG6T4mlOCPRUIu5qDgRAActKqknAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7qH9xvFGTxp4LBYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mu5ucC45rVcz7vomlgXG9YhcjJ4eEgIlE
        74Z/TF2MXBxCAksZJU7f/cHWxcgBlJCROL6+DKJGWOLPtS42iJrXjBIb9x5kB6kRFgiT2NsW
        ClIjIqAk8bH9EDuIzSwQJ/GvbzfUzHWMEh9/nGUFSbAJWElMbF/FCGLzCthJTFk1FayBRUBV
        4svr5WA1ogIREod3zIKqEZQ4OfMJC4jNKWAscfXAdUaIBeoSf+ZdYoawxSVuPZnPBGHLS2x/
        O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBUbTt2M/N
        OxgvbQw+xCjAwajEw6uxwShOiDWxrLgy9xCjBAezkgivqKthnBBvSmJlVWpRfnxRaU5q8SFG
        U6DnJjJLiSbnAyM8ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD
        o4H2hmX85parNjlKT/wbwNRVf7Os/NJawXTD1EhrgV3XlxbI7Q/Nt3+VdNch+9D7GUuS8/fJ
        6a78XuJle2lZud+0GZWWJU/ihaSZF3T/si/8K9Ix9Z73142+ETr+CTMbnX7Pn39i++XFoqt0
        Kkv/Xmf/yudWKXJVLs3v8sHUQAbn3VWH9utIKLEUZyQaajEXFScCAMSs02m4AgAA
X-CMS-MailID: 20200130113635eucas1p1a909d72365103e0e77d28a1ddfddf3eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104810epcas2p3bdc448513b7a8a9fb65966bed4e4c9d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104810epcas2p3bdc448513b7a8a9fb65966bed4e4c9d8
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104810epcas2p3bdc448513b7a8a9fb65966bed4e4c9d8@epcas2p3.samsung.com>
        <20181213104716.31930-29-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Implement module parameter 'pci_dump' and move the DPRINTK calls
> over to dev_printk().

Please preserve __func__ printing in the conversion.

> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_mv.c | 71 +++++++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 73ba8e134ca9..2ede635e4023 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -96,6 +96,10 @@ module_param(irq_coalescing_usecs, int, S_IRUGO);
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
> @@ -1258,47 +1262,49 @@ static int mv_stop_edma(struct ata_port *ap)
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
> @@ -1308,31 +1314,31 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
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
> @@ -2969,7 +2975,6 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
>  
>  	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
>  
> -	DPRINTK("All regs @ PCI error\n");
>  	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
>  
>  	writelfl(0, mmio + hpriv->irq_cause_offset);
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
