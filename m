Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FBEC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4AF20733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NIn5OZVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJQqW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:46:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43088 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJQqW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:46:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210164621euoutp02e0a124979f65900ac1bf08a8af90428c~yGFcEYcnc2964829648euoutp02D
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:46:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210164621euoutp02e0a124979f65900ac1bf08a8af90428c~yGFcEYcnc2964829648euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353181;
        bh=nrsdJEUnd85JvSIK1gWGu+UrdYS15b0vMDz8BsaBWCQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NIn5OZVqJFKvCWOfCLcrlkjuyT7Xlux/pBX+nzLFUCEgI1WaBQgNEL3ocXYwM72AU
         JrX6v3Z/Taorl666KAoKU7Gck5aZF4okbVcek1RR/E62MpS7DChdlSZAQ1djKIsrRL
         +U/+Tf1kjPFYKh/42BFevp//sVOS8WpMjaEeqlso=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210164621eucas1p2527d4a3c822ab5794ad2ffacde2587ec~yGFb_qD7M1852718527eucas1p2v;
        Mon, 10 Feb 2020 16:46:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E7.3C.60698.CD8814E5; Mon, 10
        Feb 2020 16:46:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210164620eucas1p10b9c13ecb2d5abca74cfe7a5f375176a~yGFbkQgoI1357613576eucas1p1R;
        Mon, 10 Feb 2020 16:46:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210164620eusmtrp2d3b4bcab5dc48bd453746e88e2cd9289~yGFbjuJHw3080330803eusmtrp2f;
        Mon, 10 Feb 2020 16:46:20 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-35-5e4188dc6d77
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.E8.08375.CD8814E5; Mon, 10
        Feb 2020 16:46:20 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210164620eusmtip2765b1c31c0575e232e7ca777b68ffcb2~yGFbXTDEZ0548605486eusmtip2r;
        Mon, 10 Feb 2020 16:46:20 +0000 (GMT)
Subject: Re: [PATCH 40/46] libata-eh: remove DPRINTK() calls for request
 sense
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <1bdc0ed1-832b-2d9e-e0b3-90ed4b91825c@samsung.com>
Date:   Mon, 10 Feb 2020 17:46:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-41-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned27HY5xBrttLVbf7Wez2LNoEpPF
        sR2PmByYPS6fLfXYfLra4/MmuQDmKC6blNSczLLUIn27BK6MVweOMRac5KxY2XmWtYHxBXsX
        IyeHhICJxIYZE9m6GLk4hARWMEo0fP3PAuF8YZR4eOQ8M4TzmVHi7IwHzDAtXzefZ4RILGeU
        ODBpCxOE85ZRYmfjdUaQKmGBAInTJ3+wgNgiAkoSH9sPgS1kFrCWmL14PROIzSZgJTGxfRVY
        Pa+AncT2i//B6lkEVCWOnvgItk1UIELi04PDrBA1ghInZz4Bq+EEumLy4guMEDPFJW49mc8E
        YctLbH87B+xsCYFmdomvl9uZIM52kWg6cAnKFpZ4dXwLNARkJP7vnM8E0bCOUeJvxwuo7u2M
        Essn/2ODqLKWuHPuF5DNAbRCU2L9Ln2IsKPEgsu/2UHCEgJ8EjfeCkIcwScxadt0Zogwr0RH
        mxBEtZrEhmUb2GDWdu1cyTyBUWkWktdmIXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgx
        t7g0L10vOT93EyMwiZz+d/zrDsZ9f5IOMQpwMCrx8F4IdowTYk0sK67MPcQowcGsJMJrKQ0U
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgXETs+0V0xav
        HaUHLjGmB0z/G//s37eNUQ5/L0quv72Rke3pqkKr1IvdjT0fTRoC9Dqf/Q18d+wqv8KJyfkS
        xW4FX2aypH9O6U1pbgq8ruoTUj7JJO4sS+uG6rPqHb++Se2VdpkttnBqxvY5d2M0hUu59gds
        WXRVNuTRspMvsvkfuJ/b+W7ltWAlluKMREMt5qLiRAA6gZZHHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7p3OhzjDP69VrFYfbefzWLPoklM
        Fsd2PGJyYPa4fLbUY/Ppao/Pm+QCmKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0Ml4dOMZYcJKzYmXnWdYGxhfsXYycHBICJhJfN59n7GLk4hAS
        WMoo8X3mPZYuRg6ghIzE8fVlEDXCEn+udbFB1LxmlLi49i8rSEJYwE9i9fsJLCC2iICSxMf2
        Q2BDmQWsJWYvXs8EYgsJbGCUWNukCWKzCVhJTGxfxQhi8wrYSWy/+B+sl0VAVeLoiY/MILao
        QITE4R2zoGoEJU7OfAJWwwl06OTFFxgh5qtL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYxCs5C0
        z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExsy2Yz8372C8tDH4EKMA
        B6MSD29FoGOcEGtiWXFl7iFGCQ5mJRFeS2mgEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucD
        4zmvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOje/bU99cXLQj8
        cs3xXXdo7cLZ9nJ69+5MkdTPv94qfn/z+gvGd8p1hF/dye8Nz3CvnN2S43vipfgGCVWpVMVv
        K2YtbTP9lnNGf+2aKflvT88UUN60z6t0YZ2BW/DnqZ1NxdK2r5Z7Tn2zKuXX6459l29k5+1Z
        f8/a5XioZ07BdOufLe3x6XvdlViKMxINtZiLihMBKg0Fma8CAAA=
X-CMS-MailID: 20200210164620eucas1p10b9c13ecb2d5abca74cfe7a5f375176a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165618eucas1p23667d051b5db649feafa41ec5c56eec4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165618eucas1p23667d051b5db649feafa41ec5c56eec4
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165618eucas1p23667d051b5db649feafa41ec5c56eec4@eucas1p2.samsung.com>
        <20200204165547.115220-41-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> The information will printed during ata_qc_issue() anyway, so
> this messages can be dropped.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-eh.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index f37dad5f9c17..388f8ed46eab 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1538,8 +1538,6 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc,
>  		return;
>  	}
>  
> -	DPRINTK("ATA request sense\n");
> -
>  	ata_tf_init(dev, &tf);
>  	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>  	tf.flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
> @@ -1580,8 +1578,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
>  	struct ata_port *ap = dev->link->ap;
>  	struct ata_taskfile tf;
>  
> -	DPRINTK("ATAPI request sense\n");
> -
>  	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
>  
>  	/* initialize sense_buf with the error register,
> 
