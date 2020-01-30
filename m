Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E5C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B134C206F0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fiPYoC+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgA3KwN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:52:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44201 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgA3KwN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:52:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130105211euoutp029cf1b07b6c03cb148eb7f8385e03f5e5~upKFHg_Bx0038000380euoutp02x
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130105211euoutp029cf1b07b6c03cb148eb7f8385e03f5e5~upKFHg_Bx0038000380euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381531;
        bh=0r4WtU1oXmopqXQNBZzqELXiCSJEAdHnT8iAcZu/hgw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fiPYoC+ibdvtZ8PIQohWQCJcYUT5pVAaHJKmFDNbt4m8VNkiYMrRva4pt0sqi4XI+
         QWuIf6M2A2i1n8v97wXMzq2ogF6su2Cd7fFJ19rFsGlE3CTJitxWGjiUEzXrkSLRpW
         vS4/otEv/AYxdMPlHHS2/Da4xw5y7lUgkNRUu2AI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130105211eucas1p1a05138c619062d84756a48e25f6e861f~upKFAalAk1635716357eucas1p1x;
        Thu, 30 Jan 2020 10:52:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.59.61286.B55B23E5; Thu, 30
        Jan 2020 10:52:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105211eucas1p1dfa0f3dff18e9bf0272927019f054a56~upKEr6ILN1153711537eucas1p1x;
        Thu, 30 Jan 2020 10:52:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130105211eusmtrp247e0d2d40704fe748b4eb51445ed6ea0~upKErAO8c2342323423eusmtrp2T;
        Thu, 30 Jan 2020 10:52:11 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-38-5e32b55bc5f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.4E.07950.B55B23E5; Thu, 30
        Jan 2020 10:52:11 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105210eusmtip188af2d5fbaf888716b98285a13775ff5~upKEUyOXt1527615276eusmtip1v;
        Thu, 30 Jan 2020 10:52:10 +0000 (GMT)
Subject: Re: [PATCH 10/24] pata_octeon_cf: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <010977be-19c7-70a4-202c-74a50ecc5a27@samsung.com>
Date:   Thu, 30 Jan 2020 11:52:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-22-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7rRW43iDDZf0bJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6MU5efMBXM
        Fq14d2QNWwPjd4EuRk4OCQETiVuNP9m6GLk4hARWMEo83vcKyvnCKHH+1E9mkCohgc+MEj0L
        xbsYOcA6mhczQtQsZ5Ron36WFcJ5yyixq3stG0iRsICHxJ1v+SC9IgJKEh/bD7GD2MwCcRJN
        V+6C2WwCVhIT21cxgti8AnYSVxaeZQOxWQRUJXa/6gKrERWIkPj04DArRI2gxMmZT1hAbE4B
        Y4nJRy8wQ8wUl7j1ZD4ThC0vsf3tHGaQeyQE+tkl/r36zwrxpovE5W+32SBsYYlXx7ewQ9gy
        Ev93gjSDNKxjlPjb8QKqezujxPLJ/6A6rCXunPsF9hmzgKbE+l36EGFHiX0v1rNAQoVP4sZb
        QYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tosJO/MQvLOLIS9CxhZVjGK
        p5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQmldP/jn/awfj1UtIhRgEORiUeXo0NRnFCrIll
        xZW5hxglOJiVRHhFXQ3jhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBa
        BJNl4uCUamBMauR4X7ihWIPBLKRkpr+qrfUB6fV5N8988/vP+/fIzdg1qisP7HjD9Tf/zGme
        2Es9MgFfZTYGXTnJw1P1ov+9wMKXjn6ijN4L3e9zvIkWadwoxtq20ka5THjXlI35ro4Xs99N
        P/LBcYrcl0fZyjE/Ixwcc7hVew+tfBdwPtLq1/3wY3nBtVZKLMUZiYZazEXFiQCvXA2rJgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7rRW43iDHrWCFqsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GqctPmApmi1a8O7KGrYHxu0AXIweHhICJ
        RPNixi5GLg4hgaWMEu9Wz2OBiMtIHF9f1sXICWQKS/y51sUGYgsJvGaU+LGTH6REWMBD4s63
        fJCwiICSxMf2Q+wgNrNAnMS/vt1MECPXMUp8mvCOBSTBJmAlMbF9FSOIzStgJ3Fl4VmwmSwC
        qhK7X3WBNYsKREgc3jELqkZQ4uTMJ2C9nALGEpOPXmCGWKAu8WfeJShbXOLWk/lMELa8xPa3
        c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYQ9uO/dyy
        g7HrXfAhRgEORiUeXo0NRnFCrIllxZW5hxglOJiVRHhFXQ3jhHhTEiurUovy44tKc1KLDzGa
        Aj03kVlKNDkfGN95JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY
        97KVZf2pSzsg3Wp8XXrLogD3hJtN208+m6Q1UfHPilIxPwYR71qWQ+UsH885Xjow++nCvRX/
        FFaqsr+cJbB15uejC3SSlbMK92VNF+qNszdZdGfbzSdeE94E+rqGLXwV5aQm+iH8dl7UmQvX
        lR/uPL1s8WHzrR+SOiZxLdmVub+oXq8x9pDhPiWW4oxEQy3mouJEAGWJliS3AgAA
X-CMS-MailID: 20200130105211eucas1p1dfa0f3dff18e9bf0272927019f054a56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104816epcas1p2b354b2f30c32d5e7a9d8cc42d2004c0f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104816epcas1p2b354b2f30c32d5e7a9d8cc42d2004c0f
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104816epcas1p2b354b2f30c32d5e7a9d8cc42d2004c0f@epcas1p2.samsung.com>
        <20181213104716.31930-22-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/pata_octeon_cf.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index d3d851b014a3..2e99a11020b0 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -440,7 +440,7 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
>  	int rc;
>  	u8 err;
>  
> -	DPRINTK("about to softreset\n");
> +	ata_link_dbg(link, "about to softreset\n");

Please preserve __func__ printing in the conversion.

>  	__raw_writew(ap->ctl, base + 0xe);
>  	udelay(20);
>  	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
> @@ -455,7 +455,8 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
>  
>  	/* determine by signature whether we have ATA or ATAPI devices */
>  	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
> -	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
> +	ata_link_dbg(link, "EXIT, classes[0]=%u [1]=%u\n",
> +		     classes[0], classes[1]);

ditto

>  	return 0;
>  }
>  
> @@ -525,7 +526,7 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
>  		blob = 0;
>  	}
>  
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> +	ata_port_dbg(ap, "cmd 0x%X\n", tf->command);

ditto

>  	blob |= (tf->command << 8);
>  	__raw_writew(blob, base + 6);
>  
> @@ -543,12 +544,12 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
>  	struct octeon_cf_port *cf_port;
>  
>  	cf_port = ap->private_data;
> -	DPRINTK("ENTER\n");
> +	ata_port_dbg(ap, "ENTER\n");

ditto

>  	/* issue r/w command */
>  	qc->cursg = qc->sg;
>  	cf_port->dma_finished = 0;
>  	ap->ops->sff_exec_command(ap, &qc->tf);
> -	DPRINTK("EXIT\n");
> +	ata_port_dbg(ap, "EXIT\n");

ditto

>  }
>  
>  /**
> @@ -678,7 +679,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> -	DPRINTK("ENTER\n");

Please either keep it or document the removal in the patch description.

>  	for (i = 0; i < host->n_ports; i++) {
>  		u8 status;
>  		struct ata_port *ap;
> @@ -732,7 +732,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
>  		}
>  	}
>  	spin_unlock_irqrestore(&host->lock, flags);
> -	DPRINTK("EXIT\n");

ditto

>  	return IRQ_RETVAL(handled);
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
