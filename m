Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF9C3F2D1
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F9E217F4
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lq6jjLvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCBRBI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:01:08 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48452 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBRBI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:01:08 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302170105euoutp01e4809a8833ca6341e7a06865c07a5879~4i1Tr5Xa50860808608euoutp01k
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:01:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302170105euoutp01e4809a8833ca6341e7a06865c07a5879~4i1Tr5Xa50860808608euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583168465;
        bh=XIgE3s+WZNOLz85vavFP1v8zI3xF10HGLdstZK6FEE4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Lq6jjLvYLiBn4An4G+iQfNyTV0G+8BBWonjBjnDCuS0G8Rgatjc8VwMEE/bjWBOnq
         tRqAzKDF/azMJbD3dCzrd3pPJIi8U67zWDIaJNJbStB2YjbOCwTUbxR2yh6v3AIWKE
         8iiuk/Xfv5+yNMftlgXQxTc1eBCHnu089yH9NSaU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302170105eucas1p1adf03b3db2cd4e6b5be525b7cbc83723~4i1Thgabu1742717427eucas1p1u;
        Mon,  2 Mar 2020 17:01:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.76.61286.1DB3D5E5; Mon,  2
        Mar 2020 17:01:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302170105eucas1p206f9e9ce8e4d66ad3b3b6d1d57496acb~4i1S5NYLq1782217822eucas1p2E;
        Mon,  2 Mar 2020 17:01:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302170105eusmtrp2352365faa99a3d58c64c2fcdd153901a~4i1S4q67R1722017220eusmtrp27;
        Mon,  2 Mar 2020 17:01:05 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-9a-5e5d3bd19066
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.08.07950.0DB3D5E5; Mon,  2
        Mar 2020 17:01:04 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302170104eusmtip1b346c428dfb9dfaaf5943edfb24fb54b~4i1SbXzaK0193801938eusmtip18;
        Mon,  2 Mar 2020 17:01:04 +0000 (GMT)
Subject: Re: [PATCH 12/42] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0f57fee3-d3b9-57b7-b405-69264536060b@samsung.com>
Date:   Mon, 2 Mar 2020 18:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-13-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87oXrWPjDE6/UbdYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG5IvvWAoe
        alesOC7dwDhDqYuRk0NCwETiwN5FbF2MXBxCAisYJVqb3jBBOF8YJR6//McO4XxmlLjy8jgb
        TMvjG39ZIRLLGSW+LXrJDOG8ZZTYvvM2E0iVsECYxPb5e1lBbBEBJYmP7YfYQWxmgQiJjRvW
        gtWwCVhJTGxfxQhi8wrYSaye+guohoODRUBFYtOecpCwKFD5pweHWSFKBCVOznzCAmJzChhL
        bG1axgwxUlzi1pP5TBC2vMT2t3PA7pEQ6GeXeD7vEQvE1S4S946sY4WwhSVeHd/CDmHLSPzf
        OZ8JomEdo8TfjhdQ3dsZJZZP/gf1s7XEnXO/2ECuYxbQlFi/Sx/ElBBwlDi9XQjC5JO48VYQ
        4gY+iUnbpjNDhHklOtqEIGaoSWxYtoENZmvXzpXMExiVZiH5bBaSb2Yh+WYWwtoFjCyrGMVT
        S4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxApPK6X/HP+1g/Hop6RCjAAejEg9vAHNsnBBrYllx
        Ze4hRgkOZiURXl/O6Dgh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbB
        ZJk4OKUaGNu/L328jqX3/NTzopaX9DiEO4+cr+IwNZSQbXC78VxB/1/F/jVKuSHCE3d/Nere
        djLmsktG2533V3JP5R77OSOVI/Xx4WOyUxPqNKQ9mc7qnDdSC3Nc++yLu+nJD99rd0ypzAxS
        5pf/YDTLV//ct2fscvyze5J+lx14Nd1a9pBY7aZLHeElwkosxRmJhlrMRcWJABryhrAmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7oXrGPjDH58srBYfbefzWLPoklM
        Fsd2PGKy+LX8KKMDi8fls6Uem1Z1snlsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5IvvWAoealesOC7dwDhDqYuRk0NCwETi
        8Y2/rF2MXBxCAksZJfa/nMfUxcgBlJCROL6+DKJGWOLPtS42iJrXjBJ7Hp1jAkkIC4RJbJ+/
        lxXEFhFQkvjYfogdxGYWiJDofnUGqmEdo8Sv55fYQBJsAlYSE9tXMYLYvAJ2Equn/mIHWcYi
        oCKxaU85SFgUqPfwjllQJYISJ2c+YQGxOQWMJbY2LWOGmK8u8WfeJShbXOLWk/lMELa8xPa3
        c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYRduO/dyy
        g7HrXfAhRgEORiUe3h8MsXFCrIllxZW5hxglOJiVRHh9OaPjhHhTEiurUovy44tKc1KLDzGa
        Av02kVlKNDkfGOF5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY
        i/TNe3IPOpyc1bb2cNIG0yvf9A48zPjruyXzkZPWSs7Cw2vUDM03XuWWS2tbf+H8sdV71h/r
        U3KYKLJMTuWpe9lBIfNMubyLQolFH3a0BC3ildgQqht04PdUW1meZxoXefh1HuqmWPibTy6W
        YuSsfvhz8ZHLv35uvL9bl28C2/k1b2fr79aSVWIpzkg01GIuKk4EALixMBG4AgAA
X-CMS-MailID: 20200302170105eucas1p206f9e9ce8e4d66ad3b3b6d1d57496acb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095434eucas1p10d25ecaa4a82f2d5a0e2a7a68e2a3327
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095434eucas1p10d25ecaa4a82f2d5a0e2a7a68e2a3327
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095434eucas1p10d25ecaa4a82f2d5a0e2a7a68e2a3327@eucas1p1.samsung.com>
        <20200213095412.23773-13-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
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
>  drivers/ata/sata_mv.c | 88 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d7228f8e9297..1eb93976af8d 100644
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
> @@ -1245,42 +1249,43 @@ static int mv_stop_edma(struct ata_port *ap)
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
> @@ -1295,31 +1300,34 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
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
> @@ -2958,9 +2966,11 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
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
