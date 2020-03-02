Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08AC3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8C24676
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 18:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W+D8/iVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCBSaZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:30:25 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55005 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgCBSaY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 13:30:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302183023euoutp021f6404d2ff340d1090b95c0dbd7d5b7e~4kDRRBrBQ1226512265euoutp02J
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 18:30:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302183023euoutp021f6404d2ff340d1090b95c0dbd7d5b7e~4kDRRBrBQ1226512265euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583173823;
        bh=KnJOX7D75ijtRUDI1ExXjaO55YtxTUzWTUFvHRhWgmY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W+D8/iVWQuSjXh+y4R2oYIfFP7PKIjeHtQ/DzJC/qW2qWKczUIbqDgnoXnhN07roa
         7op+mZgn3oG5BhEcJV0JqjJkvaw6qleL44Ekntqgqz85DSAR435Mdz8S25+6T8j75m
         V531wOO7a/gFZKv7Lau8NxITPILVW4t454rrGM0Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200302183023eucas1p28336956db18434522f36a1f369fae8f4~4kDRJsOdO0634706347eucas1p2z;
        Mon,  2 Mar 2020 18:30:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8E.41.60698.FB05D5E5; Mon,  2
        Mar 2020 18:30:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302183022eucas1p15ac29c46960a1b42c4114b1c0d2403ac~4kDQv1rpf3097830978eucas1p1U;
        Mon,  2 Mar 2020 18:30:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302183022eusmtrp260d7b4caebadc45c9b4bfbe118a44925~4kDQvQrgQ0778607786eusmtrp2R;
        Mon,  2 Mar 2020 18:30:22 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-15-5e5d50bfb0c0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1B.8C.07950.EB05D5E5; Mon,  2
        Mar 2020 18:30:22 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302183022eusmtip2c11e91540f5182622b8af9fb63e17afe~4kDQPvA3s2373923739eusmtip2V;
        Mon,  2 Mar 2020 18:30:22 +0000 (GMT)
Subject: Re: [PATCH 13/42] sata_mv: kill 'port' argument in
 mv_dump_all_regs()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7ef19013-c047-1d45-f4c9-a3cc626a7797@samsung.com>
Date:   Mon, 2 Mar 2020 19:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-14-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87r7A2LjDLq6OS1W3+1ns9izaBKT
        xbEdj5gsfi0/yujA4nH5bKnHplWdbB6bT1d7fN4kF8ASxWWTkpqTWZZapG+XwJWx6fs99oIf
        ohV3b95kbmDcKNjFyMkhIWAicfPrH+YuRi4OIYEVjBJHv7xngnC+MEpM+D0PKvOZUeLFyz2s
        MC2PXn5mhEgsB6q6+JIdwnnLKHGtazkjSJWwQIDE41M/WEBsEQEliY/th9hBbGaBCImNG9Yy
        gdhsAlYSE9tXgdXzCthJ3G1fydbFyMHBIqAisWi+M0hYFKj804PDrBAlghInZz5hASnhFDCW
        aH7BBDFRXOLWk/lQtrzE9rdzwI6WEOhml7h1YTHU0S4S7UfnskPYwhKvjm+BsmUk/u+czwTR
        sI5R4m/HC6ju7YwSyyf/Y4Oospa4c+4X2HHMApoS63fpQ4QdJTb2b2YECUsI8EnceCsIcQSf
        xKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyXzBEalWUg+m4XknVlI3pmFsHcBI8sqRvHU0uLc
        9NRi47zUcr3ixNzi0rx0veT83E2MwLRy+t/xrzsY9/1JOsQowMGoxMMbwBwbJ8SaWFZcmXuI
        UYKDWUmE15czOk6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYO
        TqkGxp3/Zmp6/6uxcL28Upg/UN3C6IeVxfnuxYtiA8vvHl6mNvFPgWHlpI3fdeMjZm/qFuKc
        P3Xt0ooew9C+a+m1vDXJDnGGHgsqZQ5H9Ico/5kWGWT0Mn6l1rMfpivfMbxS3lqw6ZfIbN6J
        /Dkeu+Y8mhv01tSfsYezep7ShOAMUzP7yDlS3vG8SizFGYmGWsxFxYkAs4/1XCcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7r7AmLjDCZ36FmsvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j0/d77AU/RCvu3rzJ3MC4UbCLkZNDQsBE
        4tHLz4wgtpDAUkaJx7Nkuxg5gOIyEsfXl0GUCEv8udbF1sXIBVTymlFi8awmZpCEsICfxKnt
        e8BsEQEliY/th9hBbGaBCInuV2egGtYxSpyd84cVJMEmYCUxsX0V2DJeATuJu+0r2UCWsQio
        SCya7wwSFgXqPbxjFlSJoMTJmU9YQEo4BYwlml8wQYxXl/gz7xIzhC0ucevJfKi4vMT2t3OY
        JzAKzULSPQtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGEPbjv3csoOx
        613wIUYBDkYlHt4fDLFxQqyJZcWVuYcYJTiYlUR4fTmj44R4UxIrq1KL8uOLSnNSiw8xmgK9
        NpFZSjQ5HxjfeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGHt0
        5IMiOsQe3umR/V/3tf/UTRk90fsT3j9973bs9po/ynVt1qems+/Qnc1Tdnlr//b8Kp+MXJ4C
        r+U3py2NSDl8ykLd0CT22IRkGTahdG3HnIKO9c4L0nOUmjXWHnrkl60il/1s+b4rx13EzZmq
        MufeydigHM86fX+ezkStKRHC5o/qVDt+KLEUZyQaajEXFScCABMy3my3AgAA
X-CMS-MailID: 20200302183022eucas1p15ac29c46960a1b42c4114b1c0d2403ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095436eucas1p24b6b4f2f68e201be8151c56265f54d46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095436eucas1p24b6b4f2f68e201be8151c56265f54d46
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095436eucas1p24b6b4f2f68e201be8151c56265f54d46@eucas1p2.samsung.com>
        <20200213095412.23773-14-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Always '-1', so drop it and simplify the function.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/sata_mv.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 1eb93976af8d..940b7f2e9105 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1283,23 +1283,13 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
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
> @@ -1314,13 +1304,13 @@ static void mv_dump_all_regs(void __iomem *mmio_base, int port,
>  	mv_dump_mem(&pdev->dev, mmio_base+0xf00, 0x4);
>  	mv_dump_mem(&pdev->dev, mmio_base+0x1d00, 0x6c);
>  	for (hc = start_hc; hc < start_hc + num_hcs; hc++) {
> -		hc_base = mv_hc_base(mmio_base, hc);
> +		void __iomem *hc_base = mv_hc_base(mmio_base, hc);
>  		dev_printk(KERN_DEBUG, &pdev->dev, "%s: HC regs (HC %i):\n",
>  			   __func__, hc);
>  		mv_dump_mem(&pdev->dev, hc_base, 0x1c);
>  	}
>  	for (p = start_port; p < start_port + num_ports; p++) {
> -		port_base = mv_port_base(mmio_base, p);
> +		void __iomem *port_base = mv_port_base(mmio_base, p);
>  		dev_printk(KERN_DEBUG, &pdev->dev, "%s: EDMA regs (port %i):\n",
>  			   __func__, p);
>  		mv_dump_mem(&pdev->dev, port_base, 0x54);
> @@ -2969,7 +2959,7 @@ static int mv_pci_error(struct ata_host *host, void __iomem *mmio)
>  	if (pci_dump) {
>  		dev_printk(KERN_DEBUG, host->dev, "%s: All regs @ PCI error\n",
>  			   __func__);
> -		mv_dump_all_regs(mmio, -1, to_pci_dev(host->dev));
> +		mv_dump_all_regs(mmio, to_pci_dev(host->dev));
>  	}
>  	writelfl(0, mmio + hpriv->irq_cause_offset);
>  
> 
