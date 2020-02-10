Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A1C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F209F20656
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XZSoQKKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBJNyg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:54:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45814 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBJNyg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:54:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210135433euoutp01fbf15e29bd678fcdc8fa16d608979db0~yDvcniNsm1412014120euoutp01W
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:54:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210135433euoutp01fbf15e29bd678fcdc8fa16d608979db0~yDvcniNsm1412014120euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342873;
        bh=7bGz9Pa04Z2RH7gMIdFZqx5r/4tNDuex6fWxMRIU8ZM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XZSoQKKIjHYwVfqveWG7cSUTc4M74RwuvFF+AcCv+S7LfiQXVGgY5JNYMNBDbMNAS
         Sbhv2fScUqkGyjZeRGwXxSPtuuoHUDAbCrJFR9PvWF971e7UyPnezXBNA3kWadW/Tz
         hpaMFoQsL+kamucpLyDDH+CYlS6xOHSf5W+5OQWs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210135433eucas1p2a802e61e4e01aad2d900080daf2bb98d~yDvcaVvUa2162121621eucas1p2j;
        Mon, 10 Feb 2020 13:54:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CD.4F.61286.990614E5; Mon, 10
        Feb 2020 13:54:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210135433eucas1p1395b4e6b29168c1c35f8fc07cb61fc3d~yDvcF14ne2259322593eucas1p1V;
        Mon, 10 Feb 2020 13:54:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210135433eusmtrp28f564ccdcf29326e62b33cb145ba61dd~yDvcFVsVR0226102261eusmtrp2G;
        Mon, 10 Feb 2020 13:54:33 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-9f-5e416099dd13
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.4D.07950.990614E5; Mon, 10
        Feb 2020 13:54:33 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210135431eusmtip255790f104375746027d335ccb819a9b2~yDvaqboyC0424204242eusmtip2x;
        Mon, 10 Feb 2020 13:54:31 +0000 (GMT)
Subject: Re: [PATCH 23/46] libata-sff: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <958a329c-844d-c716-ccf9-d2a3f374896a@samsung.com>
Date:   Mon, 10 Feb 2020 14:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-24-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOd2ZCY5xBrNXqVisvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFFcNimpOZllqUX6dglcGXMvfGQreC5Y0dI7m6WBcSVf
        FyMHh4SAicSZNbZdjFwcQgIrGCUmznnMBOF8YZS4tW4mlPOZUWLJ4ZUsXYycYB3H2rpZIBLL
        GSXmzHvPCuG8ZZR4Pm81O0iVsICLxJEDU8BsEQEliY/th8BsZgFridmL1zOB2GwCVhIT21cx
        gtzBK2Ansb47HyTMIqAqseB3LyOILSoQIfHpwWFWEJtXQFDi5MwnYEdwghyxcRYrxEhxiVtP
        5jNB2PIS29/OYQa5R0LgP5vEl41bmSGudpHY/3kKG4QtLPHq+BZ2CFtG4v/O+UwQDesYJf52
        vIDq3s4osXzyP6gOa4k7536xgVzKLKApsX6XPkTYUWLe7i5WSEDySdx4KwhxBJ/EpG3TmSHC
        vBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz01GLDvNRy
        veLE3OLSvHS95PzcTYzAFHL63/FPOxi/Xko6xCjAwajEw1sR6BgnxJpYVlyZe4hRgoNZSYTX
        UhooxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA6PN97oK
        Q+93LcX3/92s5pi1NXKd43TJfZeLM4785lPfx3t9fsarrII7l9yOfc1t2bcqe/bN9zuuzfC3
        8J3KsfzI5Y85DbfUC7ZuWxks9V0rfofDik8mz2y5c5i+3Fjq8OiNz+40q+t3J9/oNlXfUaGs
        pl93Jyz6FWe+/tbPwelxXolhl34zS7xWYinOSDTUYi4qTgQAxkgmLx0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7ozExzjDGY94rJYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0MuZe+MhW8FywoqV3NksD40q+LkZODgkBE4ljbd0sILaQwFJG
        iVmNPF2MHEBxGYnj68sgSoQl/lzrYuti5AIqec0osWP6LFaQhLCAi8SRA1PYQWwRASWJj+2H
        wGxmAWuJ2YvXM0HM3MAo0dMYD2KzCVhJTGxfxQgyn1fATmJ9dz5ImEVAVWLB715GEFtUIELi
        8I5ZYDavgKDEyZlPwE7jBDlzI8RaZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwHjZduznlh2MXe+CDzEKcDAq
        8fBeCHaME2JNLCuuzD3EKMHBrCTCaykNFOJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YCzn
        lcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpglODetD5Bb66z2gGZ
        VxpnF/NlFsfsmdJX7iTz7uUP5zjlE57TV9etFpt1vVn2y8Zbwu1PTp81yfA9ZWHf8tRA81Db
        nqVlu7+lsF3P+7P4OO/dH2/llkoXTP+ZxPuf5Wbh5eZix187dGbvvH5QJrjjz66m1OeqTQ5/
        oje8VVOruT09QNS9M+GzghJLcUaioRZzUXEiAO8NVHWtAgAA
X-CMS-MailID: 20200210135433eucas1p1395b4e6b29168c1c35f8fc07cb61fc3d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p164b2ae5896322571a498f9dd1b9aba1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p164b2ae5896322571a498f9dd1b9aba1e
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p164b2ae5896322571a498f9dd1b9aba1e@eucas1p1.samsung.com>
        <20200204165547.115220-24-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Reset is now logged with tracepoints, so the DPRINTK() calls can
> be dropped.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Also you may consider merging patches #15-23 together.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-sff.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 60509997137f..f1799291b4a6 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1946,8 +1946,6 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> -
>  	if (ap->ioaddr.ctl_addr) {
>  		/* software reset.  causes dev0 to be selected */
>  		iowrite8(ap->ctl, ioaddr->ctl_addr);
> @@ -1985,8 +1983,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  	int rc;
>  	u8 err;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* determine if device 0/1 are present */
>  	if (ata_devchk(ap, 0))
>  		devmask |= (1 << 0);
> @@ -1997,7 +1993,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  	ap->ops->sff_dev_select(ap, 0);
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
>  	rc = ata_bus_softreset(ap, devmask, deadline);
>  	/* if link is occupied, -ENODEV too is an error */
>  	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> @@ -2012,7 +2007,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
>  		classes[1] = ata_sff_dev_classify(&link->device[1],
>  						  devmask & (1 << 1), &err);
>  
> -	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ata_sff_softreset);
> @@ -2045,7 +2039,6 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ata_sff_dev_classify(link->device, 1, NULL);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(sata_sff_hardreset);
> 
