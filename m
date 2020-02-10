Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B2C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FB220733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B93JbRw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgBJPs4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:48:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53108 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJPs4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:48:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210154855euoutp023c4f03fdd7168f1a11e7850ea6db6b01~yFTSq4Hzc2687526875euoutp02Q
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:48:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210154855euoutp023c4f03fdd7168f1a11e7850ea6db6b01~yFTSq4Hzc2687526875euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349735;
        bh=GdUVdr8YwgDF4ghjMgPInfJVwLld81mO/Kvk/+SSvXM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B93JbRw2uGWVPmhbPhOX1EI0Ok1sdmSs34IJ2ugaxnVAwGN1Cz0BknjIyAPBtjfGh
         H864G92LZ+SYieybQ0cglXSnjTrBYgc+oM7T4WmhkvSUyQtj/RyNBxdqw106wm2Eiw
         mPOc5FEdPHT3ho69+2seLEVapaPKJ9ibc1f5+GvE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210154854eucas1p22d3fec1658bcde5c7bef09a1bc2a3c6d~yFTSgaDNx1637116371eucas1p2Y;
        Mon, 10 Feb 2020 15:48:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4E.8D.60679.66B714E5; Mon, 10
        Feb 2020 15:48:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154854eucas1p26d63e48ac0c1cf7457ffcb562ce67705~yFTSMgAnq1622916229eucas1p2c;
        Mon, 10 Feb 2020 15:48:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210154854eusmtrp25e8fe832eea629d975ded1e84c16bb2c~yFTSL0yf_3213032130eusmtrp2r;
        Mon, 10 Feb 2020 15:48:54 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-51-5e417b661140
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 86.52.08375.66B714E5; Mon, 10
        Feb 2020 15:48:54 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154854eusmtip26e6457ea3316f7cc52c384457a9e2dbd~yFTRqOwAC3238932389eusmtip2T;
        Mon, 10 Feb 2020 15:48:53 +0000 (GMT)
Subject: Re: [PATCH 31/46] pata_octeon_cf: move DPRINTK to VPRINTK
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <66e99ce6-721d-a9d0-a941-791de2dbc69e@samsung.com>
Date:   Mon, 10 Feb 2020 16:48:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-32-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7pp1Y5xBveaLSxW3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlissmJTUnsyy1SN8ugSuj4+w7xoIm
        ropXn1uYGxhncHQxcnJICJhIdDQcZ+9i5OIQEljBKHFk+0w2COcLo8SJBWtZIJzPjBItE7qZ
        YFoezVwBVbWcUWL684dQ/W8ZJZbN6gKrEhZwkmi/fYgRxBYRUJL42H6IHcRmFoiTaLpyF8xm
        E7CSmNi+CqyGV8BO4vy2Z0BxDg4WAVWJFaeSQcKiAhESnx4cZoUoEZQ4OfMJC4jNCXRE56KJ
        LBAjxSVuPZnPBGHLS2x/O4cZ5B4JgX52iVnrJ7BCXO0icfTSMUYIW1ji1fEt7BC2jMT/nSDN
        IA3rGCX+dryA6t7OKLF88j82iCpriTvnfrGBXMcsoCmxfpc+iCkh4ChxsZEHwuSTuPFWEOIG
        PolJ26YzQ4R5JTrahCBmqElsWLaBDWZr186VzBMYlWYh+WwWkm9mIflmFsLaBYwsqxjFU0uL
        c9NTi43yUsv1ihNzi0vz0vWS83M3MQLTyul/x7/sYNz1J+kQowAHoxIPb0WgY5wQa2JZcWXu
        IUYJDmYlEV5LaaAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwc
        nFINjJO8v05S1fhTr8zhHDypaNbladssPuypuTTn6eIfi5f6CVbUfk2c7fOgSCw/XX0f666G
        Wb1nAh6w7XSNcJXV2GB7fErFNL6GZ6xzVrw+OKFj4Vm2qBks/7Z76BYrTzlx8Mj3XqZnlZWG
        3S8yPu1/cFDhkPz7ujI/108zFe7E2ZdMWhwQlWv3454SS3FGoqEWc1FxIgB5eKncJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7pp1Y5xBnv2yFqsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5Gx9l3jAVNXBWvPrcwNzDO4Ohi5OSQEDCR
        eDRzBVsXIxeHkMBSRomeFfMZuxg5gBIyEsfXl0HUCEv8udYFVfOaUeLwgkXsIAlhASeJ9tuH
        GEFsEQEliY/th8DizAJxEv/6djNBNGxglJjS/p0NJMEmYCUxsX0VWAOvgJ3E+W3P2EGWsQio
        Sqw4lQwSFhWIkDi8YxZUiaDEyZlPWEBsTqBDOxdNZIGYry7xZ94lZghbXOLWk/lMELa8xPa3
        c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREYR9uO/dy8
        g/HSxuBDjAIcjEo8vBWBjnFCrIllxZW5hxglOJiVRHgtpYFCvCmJlVWpRfnxRaU5qcWHGE2B
        fpvILCWanA+M8bySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxe
        dz6eM7bkZlO6vql87lvtrb8veWz5cSRd0qhw48svgckLUm5wnu89t7BV5ONU1bYZ7qc2lXfX
        NTzhN/jOuzd6PoPTtJztAtlGgXraHdOzfzNd3reY8dZZr0X7eH/amftEnvzAvWXv9fBtcVlK
        B2uUpbY5LbCZusAvtEcsRu+KSalbqvIbTR0lluKMREMt5qLiRAAeZi1buQIAAA==
X-CMS-MailID: 20200210154854eucas1p26d63e48ac0c1cf7457ffcb562ce67705
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204171350eucas1p26b31b997117e7e3b728aa33419c251ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204171350eucas1p26b31b997117e7e3b728aa33419c251ce
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204171350eucas1p26b31b997117e7e3b728aa33419c251ce@eucas1p2.samsung.com>
        <20200204165547.115220-32-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Move the remaining DPRINTK statement in the interrupt handler to
> VPRINTK. It'll be converted later with the remaining VPRINTK
> calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_octeon_cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index 9527216e59b9..f262120f4615 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -671,7 +671,7 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  
> -	DPRINTK("ENTER\n");
> +	VPRINTK("ENTER\n");
>  	for (i = 0; i < host->n_ports; i++) {
>  		u8 status;
>  		struct ata_port *ap;
> @@ -725,7 +725,7 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
>  		}
>  	}
>  	spin_unlock_irqrestore(&host->lock, flags);
> -	DPRINTK("EXIT\n");
> +	VPRINTK("EXIT\n");
>  	return IRQ_RETVAL(handled);
>  }
>  
