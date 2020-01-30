Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB37C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977D0206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UK9rlCfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgA3KsP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:48:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42582 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KsP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:48:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104812euoutp0298e9dd8083115c3c03c784c75f364699~upGmSHwS63039230392euoutp02T
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:48:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130104812euoutp0298e9dd8083115c3c03c784c75f364699~upGmSHwS63039230392euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381292;
        bh=Rq0yeW4qOX6nr3TXc8GnSAwbr/Jbl75Qc44UG6dA1vk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UK9rlCfUhq5+U+r8N6Udd4pm28CaXN2Ca7RKE33O06aJGpRv9kRNYEyi0A/rAI/AL
         IfcEGhCl968P+n/nqhQDKd0Um37ZOkZHGEAfrs57lZyGveaye4o1eJZYjz81uR8Thf
         g0kmniaWWg4BY4dWj1TdM0GrDdgHGVt3GFcZ79wE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130104812eucas1p26d3091b0c051c30875846b805eb7747a~upGmKhMVJ0468904689eucas1p25;
        Thu, 30 Jan 2020 10:48:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 54.ED.60679.C64B23E5; Thu, 30
        Jan 2020 10:48:12 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104812eucas1p143eda28eadee77c73373c3686c593fde~upGl1KIXO0442504425eucas1p1o;
        Thu, 30 Jan 2020 10:48:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130104812eusmtrp12cfc038fd766f86fd1457c07059e002d~upGl0fNUf1063710637eusmtrp1a;
        Thu, 30 Jan 2020 10:48:12 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-e8-5e32b46c8406
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.7E.08375.B64B23E5; Thu, 30
        Jan 2020 10:48:11 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104811eusmtip1e773019ef5d9c0f8fc0359bfcb4e6ec6~upGlf7dy_1215212152eusmtip1U;
        Thu, 30 Jan 2020 10:48:11 +0000 (GMT)
Subject: Re: [PATCH 05/24] sata_rcar: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6684a390-c6ef-5999-e7ca-047856419ea7@samsung.com>
Date:   Thu, 30 Jan 2020 11:48:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-17-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7o5W4ziDD4flbJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6M/e8WMxZ8
        EK5ofZTdwDhVoIuRk0NCwETi0uFzrF2MXBxCAisYJc4eescO4XxhlHix8DALhPOZUeLW15VA
        GQ6wln9HNSDiyxkl1r17wQjhvGWUmP/lMRvIXGEBZ4lj06azgtgiAkoSH9sPsYPYzAJxEk1X
        7oLZbAJWEhPbVzGC2LwCdhIzp/0As1kEVCWWn7rHDGKLCkRIfHpwmBWiRlDi5MwnLCA2p4Cx
        xIFLC5kgZopL3HoyH8qWl9j+dg4zyEESApPZJTrmPmWBeNRFYuPjX1C2sMSr41vYIWwZidOT
        e1ggGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879YgP5n1lAU2L9Ln2IsKPEwUknmCHBwidx460g
        xBF8EpO2TYcK80p0tAlBVKtJbFi2gQ1mbdfOlcwTGJVmIXltFpJ3ZiF5ZxbC3gWMLKsYxVNL
        i3PTU4uN8lLL9YoTc4tL89L1kvNzNzEC08rpf8e/7GDc9SfpEKMAB6MSD6/GBqM4IdbEsuLK
        3EOMEhzMSiK8oq6GcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJ
        MnFwSjUwrv86LZVZ7Mj/nm8qX+3X9jU9PL3B/v5n/fn+5xZPLr9nU/qkwOzg/Nbnhaytanab
        qxpiuBsr/9puC2HzNtv7j8d6kXvn+0Vvd7ss2HXI7GF7oBGXnIb6vr4rZbJ87IENrHvufN/R
        rz951tVfkZJPZjctnu1xL+z+1C+3NNvdI25m/Jzs5XRBWImlOCPRUIu5qDgRAMJ8l90nAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7rZW4ziDA7etrFYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M/e8WMxZ8EK5ofZTdwDhVoIuRg0NCwETi
        31GNLkYuDiGBpYwSRxdPZYeIy0gcX1/WxcgJZApL/LnWxQZR85pR4vTnncwgCWEBZ4lj06az
        gtgiAkoSH9sPsYPYzAJxEv/6djNBNKxjlHh+sosJJMEmYCUxsX0VI4jNK2AnMXPaDzCbRUBV
        Yvmpe2BDRQUiJA7vmAVVIyhxcuYTFhCbU8BY4sClhUwQC9Ql/sy7xAxhi0vcejIfKi4vsf3t
        HOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG0bZjPzfv
        YLy0MfgQowAHoxIPr8YGozgh1sSy4srcQ4wSHMxKIryiroZxQrwpiZVVqUX58UWlOanFhxhN
        gZ6byCwlmpwPjPC8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        +dEBJX1nFs/cEzKt+Jge795LL52PM+cdO/XJ5WffT8ftS81zJ2yvEZguZXK8aynvJLGVWpsm
        fLvcf9aX/+GyaV+v5zNVZv298sbWWsRDYdWaZU5JE6/fmu2rsmX+BKXdptN8b+7nv/+x4eyE
        pzMOz8viMC3aEPEgymWJ4U/bnyvn9Cg+YWe/vFiJpTgj0VCLuag4EQAuB/19uAIAAA==
X-CMS-MailID: 20200130104812eucas1p143eda28eadee77c73373c3686c593fde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104740epcas3p12db09f60dff38bdae330d6a541fd4656
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104740epcas3p12db09f60dff38bdae330d6a541fd4656
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104740epcas3p12db09f60dff38bdae330d6a541fd4656@epcas3p1.samsung.com>
        <20181213104716.31930-17-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_rcar.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 4b1ff5bc256a..0c60d46eb7ae 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -323,7 +323,7 @@ static int sata_rcar_bus_softreset(struct ata_port *ap, unsigned long deadline)
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> +	ata_port_dbg(ap, "bus reset via SRST\n");

Please preserve __func__ printing in the conversion.

>  	/* software reset.  causes dev0 to be selected */
>  	iowrite32(ap->ctl, ioaddr->ctl_addr);
> @@ -350,7 +350,7 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
>  		devmask |= 1 << 0;
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
> +	ata_link_dbg(link, "about to softreset, devmask=%x\n", devmask);

ditto

>  	rc = sata_rcar_bus_softreset(ap, deadline);
>  	/* if link is occupied, -ENODEV too is an error */
>  	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> @@ -361,7 +361,7 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
>  	/* determine by signature whether we have ATA or ATAPI devices */
>  	classes[0] = ata_sff_dev_classify(&link->device[0], devmask, &err);
>  
> -	DPRINTK("classes[0]=%u\n", classes[0]);
> +	ata_link_dbg(link, "classes[0]=%u\n", classes[0]);

ditto

>  	return 0;
>  }
>  
> @@ -440,7 +440,7 @@ static void sata_rcar_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  static void sata_rcar_exec_command(struct ata_port *ap,
>  				   const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> +	ata_port_dbg(ap, "cmd 0x%X\n", tf->command);

ditto

>  	iowrite32(tf->command, ap->ioaddr.command_addr);
>  	ata_sff_pause(ap);
> @@ -683,7 +683,7 @@ static void sata_rcar_serr_interrupt(struct ata_port *ap)
>  	if (!serror)
>  		return;
>  
> -	DPRINTK("SError @host_intr: 0x%x\n", serror);
> +	ata_port_dbg(ap, "SError @host_intr: 0x%x\n", serror);

ditto

>  	/* first, analyze and record host port events */
>  	ata_ehi_clear_desc(ehi);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
