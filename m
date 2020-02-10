Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DDBC352A4
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7BD20708
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ixddi8+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgBJMy0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:54:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47746 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbgBJMy0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:54:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210125424euoutp015cf2ef939d86a570b443423749ecf578~yC66451fI2503925039euoutp01b
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210125424euoutp015cf2ef939d86a570b443423749ecf578~yC66451fI2503925039euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581339264;
        bh=TL/yQBRSIlpabMhdYACpjgvMAOyFl8npQ4yQBcVhuzI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ixddi8+JaCx7Wvvl0wVhRRtiC41X5PoCbicOqX8MsygSm1VVcZ58Aj65iLTabmkEO
         E+2l89ZVuCPP2AbBxSIuDO2OWZsXPSgBrd8cr52CJGUieI9M2wc4r0AYXTgBfWOeL7
         gvwm2BvpON3jnq9IDl8nWwueI6Yv5KufLUMTUTVg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210125424eucas1p1982c429f9ab0bfe255c816ae986beaa2~yC66wRqhh1401514015eucas1p1u;
        Mon, 10 Feb 2020 12:54:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 13.88.60698.F72514E5; Mon, 10
        Feb 2020 12:54:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210125423eucas1p1d84b32159baf830d7cef34634ebf2df6~yC66brGrZ1401514015eucas1p1t;
        Mon, 10 Feb 2020 12:54:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210125423eusmtrp24f1432293655ad7cece0b6f7e4984e7f~yC66bDVHD0146201462eusmtrp2h;
        Mon, 10 Feb 2020 12:54:23 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-ed-5e41527f094d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.B3.07950.F72514E5; Mon, 10
        Feb 2020 12:54:23 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210125422eusmtip2a32bbe7d1df2d550d4cb7ea9377ba081~yC65OC71h0576905769eusmtip2t;
        Mon, 10 Feb 2020 12:54:22 +0000 (GMT)
Subject: Re: [PATCH 10/46] sata_mv: replace DPRINTK with 'pci_dump' module
 parameter
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Message-ID: <d4da568c-b353-ed83-e9ac-b74c558c0712@samsung.com>
Date:   Mon, 10 Feb 2020 13:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9f91e33e-5c5c-a142-2cef-dc2d0df12c75@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7r1QY5xBo9eWVmsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGnb2tzAVb
        9CqWb/vH1MB4XaWLkYNDQsBEYvVizy5GLg4hgRWMEjvWtrFBOF8YJV7c/ssO4XxmlJjw5DJj
        FyMnWMfEeaegqpYzSvxd0coK4bxllDjfsIYFpEpYIEyice8cVhCbTcBKYmL7KrBuEQEliY/t
        h9hBbGaBOImmK3fBbF4BO4mDp/8xg9gsAqoSBy9cYAKxRQUiJD49OMwKUSMocXLmE7D5nAL2
        Er2Ll7FAzBGXuPVkPhOELS+x/e0cZpCDJASms0ucWTqHHeJsF4n39w+yQtjCEq+Ob4GKy0j8
        3wnSDNKwDuidjhdQ3dsZJZZP/scGUWUtcefcLzZQkDELaEqs36UPEXaUmNM/kwkSknwSN94K
        QhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8
        tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCxnP53/OsOxn1/kg4xCnAwKvHwznB0iBNiTSwr
        rsw9xCjBwawkwmsp7RgnxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQi
        mCwTB6dUA6Od5Ro7zf0pHx7mbJx+rrV7w++vOvkXZk+4Efe2Uj5kj2I75/397XdSVhYzv2g8
        mJsnc2qm+2cu50zttxf59TnnbMy9xBiXGcHumvHiG9OipAdnpr1rY7m0eP8u3/C6mFmbL298
        tKr5bUro6/dnLR2PRG1SfLu95V52l/YniR/RDhs4uJYt/6ahxFKckWioxVxUnAgALTRe2igD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7r1QY5xBhsfaVisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gnb2tzAVb9CqWb/vH1MB4XaWLkZNDQsBE
        YuK8U2xdjFwcQgJLGSXmrv7B3sXIAZSQkTi+vgyiRljiz7UuNhBbSOA1o8SzHnUQW1ggTKJx
        7xxWEJtNwEpiYvsqRhBbREBJ4mP7IXYQm1kgTuJf324miPlPGSW+/XgM1sArYCdx8PQ/ZhCb
        RUBV4uCFC0wgtqhAhMThHbMYIWoEJU7OfMICYnMK2Ev0Ll7GAjFUXeLPvEvMELa4xK0n85kg
        bHmJ7W/nME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCO
        th37uWUHY9e74EOMAhyMSjy8DvYOcUKsiWXFlbmHGCU4mJVEeC2lHeOEeFMSK6tSi/Lji0pz
        UosPMZoCPTeRWUo0OR8Y43kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqY
        ODilGhi1++IcM1c9/T9jdoL/z96VixnWdh11vDdbt9bP43ikQ3aEs9pirlg+y+VtZe5W788W
        v05VXcebsyGzVels92cL+bT/55c7HjqcLSXEcHej99OS/bWSPgmbvNiyfjUGdl/R/TxvGaMp
        8/vH2vk/qvkWhZ35xF4jIDsrecKEcu3uFb5Zt1Xy3iqxFGckGmoxFxUnAgAHucZ6uQIAAA==
X-CMS-MailID: 20200210125423eucas1p1d84b32159baf830d7cef34634ebf2df6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p1b7b8cea23b743a5eb5abb51b4fad21aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p1b7b8cea23b743a5eb5abb51b4fad21aa
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p1b7b8cea23b743a5eb5abb51b4fad21aa@eucas1p1.samsung.com>
        <20200204165547.115220-11-hare@suse.de>
        <9f91e33e-5c5c-a142-2cef-dc2d0df12c75@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/10/20 1:51 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 2/4/20 5:55 PM, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.com>
>>
>> Implement module parameter 'pci_dump' and move the DPRINTK calls
>> over to dev_printk().
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Revoked. ;)

In reply to v1 I've asked for preserving __func__ during
the conversion and it hasn't been done.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> ---
>>  drivers/ata/sata_mv.c | 71 +++++++++++++++++++++++++++------------------------
>>  1 file changed, 38 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index d7228f8e9297..9e570d455acc 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -83,6 +83,10 @@ module_param(irq_coalescing_usecs, int, S_IRUGO);
>>  MODULE_PARM_DESC(irq_coalescing_usecs,
>>  		 "IRQ coalescing time threshold in usecs");
>>  
>> +static int pci_dump;
>> +module_param(pci_dump, int, S_IRUGO);
>> +MODULE_PARM_DESC(pci_dump, "Enable dumping of PCI registers on error");
>> +
>>  enum {
>>  	/* BAR's are enumerated in terms of pci_resource_start() terms */
>>  	MV_PRIMARY_BAR		= 0,	/* offset 0x10: memory space */
>> @@ -1245,47 +1249,49 @@ static int mv_stop_edma(struct ata_port *ap)
>>  	return err;
>>  }
>>  
>> -#ifdef ATA_DEBUG
>> -static void mv_dump_mem(void __iomem *start, unsigned bytes)
>> +static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>>  {
>> -	int b, w;
>> +	int b, w, o;
>> +	unsigned char linebuf[38];
>> +
>>  	for (b = 0; b < bytes; ) {
>> -		DPRINTK("%p: ", start + b);
>> -		for (w = 0; b < bytes && w < 4; w++) {
>> -			printk("%08x ", readl(start + b));
>> +		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>> +			o += snprintf(linebuf + o, 38 - o,
>> +				      "%08x ", readl(start + b));
>>  			b += sizeof(u32);
>>  		}
>> -		printk("\n");
>> +		dev_printk(KERN_DEBUG, dev, "%p: %s\n", start + b, linebuf);
>>  	}
>>  }
>> -#endif
>> -#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
>> +#if defined(CONFIG_PCI)
>>  static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
>>  {
>> -#ifdef ATA_DEBUG
>> -	int b, w;
>> +	int b, w, o;
>>  	u32 dw;
>> +	unsigned char linebuf[38];
>> +
>>  	for (b = 0; b < bytes; ) {
>> -		DPRINTK("%02x: ", b);
>> -		for (w = 0; b < bytes && w < 4; w++) {
>> +		for (w = 0, o = 0; b < bytes && w < 4; w++) {
>>  			(void) pci_read_config_dword(pdev, b, &dw);
>> -			printk("%08x ", dw);
>> +			o += snprintf(linebuf + o, 38 - o,
>> +				      "%08x ", dw);
>>  			b += sizeof(u32);
>>  		}
>> -		printk("\n");
>> +		dev_printk(KERN_DEBUG, &pdev->dev, "%02x: %s\n", b, linebuf);
>>  	}
>> -#endif
>>  }
>>  #endif
>>  static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>>  			     struct pci_dev *pdev)
>>  {
>> -#ifdef ATA_DEBUG
>>  	void __iomem *hc_base = mv_hc_base(mmio_base,
>>  					   port >> MV_PORT_HC_SHIFT);
>>  	void __iomem *port_base;
>>  	int start_port, num_ports, p, start_hc, num_hcs, hc;
>>  
>> +	if (!pci_dump)
>> +		return;
>> +	dev_printk(KERN_DEBUG, &pdev->dev, "All regs @ PCI error\n");
>>  	if (0 > port) {
>>  		start_hc = start_port = 0;
>>  		num_ports = 8;		/* shld be benign for 4 port devs */
>> @@ -1295,31 +1301,31 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>>  		start_port = port;
>>  		num_ports = num_hcs = 1;
>>  	}
>> -	DPRINTK("All registers for port(s) %u-%u:\n", start_port,
>> -		num_ports > 1 ? num_ports - 1 : start_port);
>> +	dev_printk(KERN_DEBUG, &pdev->dev,
>> +		   "All registers for port(s) %u-%u:\n", start_port,
>> +		   num_ports > 1 ? num_ports - 1 : start_port);
>>  
>>  	if (NULL != pdev) {
>> -		DPRINTK("PCI config space regs:\n");
>> +		dev_printk(KERN_DEBUG, &pdev->dev, "PCI config space regs:\n");
>>  		mv_dump_pci_cfg(pdev, 0x68);
>>  	}
>> -	DPRINTK("PCI regs:\n");
>> -	mv_dump_mem(mmio_base+0xc00, 0x3c);
>> -	mv_dump_mem(mmio_base+0xd00, 0x34);
>> -	mv_dump_mem(mmio_base+0xf00, 0x4);
>> -	mv_dump_mem(mmio_base+0x1d00, 0x6c);
>> +	dev_printk(KERN_DEBUG, &pdev->dev, "PCI regs:\n");
>> +	mv_dump_mem(&pdev->dev, mmio_base+0xc00, 0x3c);
>> +	mv_dump_mem(&pdev->dev, mmio_base+0xd00, 0x34);
>> +	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
>> +	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
>>  	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
>>  		hc_base = mv_hc_base(mmio_base, hc);
>> -		DPRINTK("HC regs (HC %i):\n", hc);
>> -		mv_dump_mem(hc_base, 0x1c);
>> +		dev_printk(KERN_DEBUG, &pdev->dev, "HC regs (HC %i):\n", hc);
>> +		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
>>  	}
>>  	for (p = start_port; p < start_port + num_ports; p++) {
>>  		port_base = mv_port_base(mmio_base, p);
>> -		DPRINTK("EDMA regs (port %i):\n", p);
>> -		mv_dump_mem(port_base, 0x54);
>> -		DPRINTK("SATA regs (port %i):\n", p);
>> -		mv_dump_mem(port_base+0x300, 0x60);
>> +		dev_printk(KERN_DEBUG, &pdev->dev, "EDMA regs (port %i):\n", p);
>> +		mv_dump_mem(&pdev->dev, port_base, 0x54);
>> +		dev_printk(KERN_DEBUG, &pdev->dev, "SATA regs (port %i):\n", p);
>> +		mv_dump_mem(&pdev->dev, port_base+0x300, 0x60);
>>  	}
>> -#endif
>>  }
>>  
>>  static unsigned int mv_scr_offset(unsigned int sc_reg_in)
>> @@ -2958,7 +2964,6 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
>>  
>>  	dev_err(host->dev, "PCI ERROR; PCI IRQ cause=0x%08x\n", err_cause);
>>  
>> -	DPRINTK("All regs @ PCI error\n");
>>  	mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
>>  
>>  	writelfl(0, mmio + hpriv->irq_cause_offset);
>>
