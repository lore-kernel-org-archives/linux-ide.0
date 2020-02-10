Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A039C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4282082F
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ddOTaoLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBJPvm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:51:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54034 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgBJPvl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:51:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210155140euoutp02dd1880c503a7ea4bb91d1af5d2bb07d7~yFVsy3VB02860428604euoutp02P
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:51:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210155140euoutp02dd1880c503a7ea4bb91d1af5d2bb07d7~yFVsy3VB02860428604euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349900;
        bh=Q/kGw0zNpkq5CWH00yESIsQyvs3MHGzlwt3K4+vYU0Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ddOTaoLS2ko5GscHg8BZ3PLaK3qwtQzJ+5sfhRpSYbGmBk8X/kF1MnLp3BOK2UXpQ
         +YpUgRn3Bq6HpLjNE5cZBgXE9KBoE9GwH6HRAGUkWli+MkWS+znHxEEKTQZexoyfJQ
         RJmbofHhdplhaKfKd6KeOrY2bPH4/elYWwe6qu6w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210155140eucas1p11515fa420598316290ef2d46578c4f80~yFVspVymK1472514725eucas1p1D;
        Mon, 10 Feb 2020 15:51:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C9.ED.60679.C0C714E5; Mon, 10
        Feb 2020 15:51:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210155140eucas1p26f4588a50b829370acb470d847a6f399~yFVsRMYV_0106401064eucas1p2k;
        Mon, 10 Feb 2020 15:51:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210155140eusmtrp200558f92060149ac608ed3119bbbc043~yFVsQoopf0113001130eusmtrp2r;
        Mon, 10 Feb 2020 15:51:40 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-43-5e417c0cfa0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.BE.07950.B0C714E5; Mon, 10
        Feb 2020 15:51:39 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210155139eusmtip172ead91f27a8747cc7b82ecc118980d4~yFVr1suLY1020310203eusmtip11;
        Mon, 10 Feb 2020 15:51:39 +0000 (GMT)
Subject: Re: [PATCH 33/46] pata_sil680: Drop DPRINTK in
 sil_sff_exec_command()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e47925c1-7af6-3e5b-e626-6d07e77a5aca@samsung.com>
Date:   Mon, 10 Feb 2020 16:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-34-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzneV2eGsc4g1O9ohar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxu9T71gKGjgqHk+cytjAeIGt
        i5GTQ0LAROLdroOMXYxcHEICKxglNn65wgzhfGGUeLvtEBOE85lR4tOkBriWGw+62SASyxkl
        vpw8wg7hvGWU6D+wgh2kSlggQOLexo1gHSICShIf2w+BxZkFrCVmL17PBGKzCVhJTGxfxQhi
        8wrYSew41MkKYrMIqEqs2/0frF5UIELi04PDrBA1ghInZz5hAbE5ga648/ECC8RMcYlbT+Yz
        QdjyEtvfzgH7QULgN5tE58kOdoizXSSWXvwIZQtLvDq+BcqWkfi/cz4TRMM6Rom/HS+gurcz
        Siyf/A/qaWuJO+d+AdkcQCs0Jdbv0ocIO0pcXHIGLCwhwCdx460gxBF8EpO2TWeGCPNKdLQJ
        QVSrSWxYtoENZm3XzpXMExiVZiF5bRaSd2YheWcWwt4FjCyrGMVTS4tz01OLjfJSy/WKE3OL
        S/PS9ZLzczcxAtPI6X/Hv+xg3PUn6RCjAAejEg9vRaBjnBBrYllxZe4hRgkOZiURXktpoBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MLqVfv506uXcO
        s3plzjJzsb4r4fby1l1z5mtYTvvF6L57/qdE9UMfb5fzX501w0HupYqisrqGn9SqfBf1bonp
        VwvM83/P6nr+o1Kvf+0Ctes29geds42PbWRxV4zJ7Sr/tjYpICMoZ76DbEpea00d06IfS578
        szzu/Dah6POOC89eOP0RYuJUYinOSDTUYi4qTgQA9EgPFR8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7rcNY5xBgfeWlusvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6Gb9PvWMpaOCoeDxxKmMD4wW2LkZODgkBE4kbD7qBbC4OIYGl
        jBInly5h7mLkAErISBxfXwZRIyzx51oXVM1rRon1F0+BNQsL+El8/HOZHcQWEVCS+Nh+CMxm
        FrCWmL14PRNEwwZGif/PmhhBEmwCVhIT21eB2bwCdhI7DnWygtgsAqoS63b/B2sWFYiQOLxj
        FlSNoMTJmU9YQGxOoEvvfLzAArFAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0WkpZZ
        SFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBqth37uWUHY9e74EOMAhyMSjy8
        F4Id44RYE8uKK3MPMUpwMCuJ8FpKA4V4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5HxjReSXx
        hqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGNc9Xt+RkLFfS7c/YSIP
        b7/7fq+UpYGyxly/s+f/U3x6dm2QuEjjlMsONoHZrIZyW6TObffYGCJhltxrGLhk+sHqbTMO
        Zq/wW3Pc6fmfmZxvc/7Vznr14sAKdheGpNc35gao+HidbnfQruGVMjj4Vcxa6GCbw86w7798
        /2j94YwV28F8/0a6nRJLcUaioRZzUXEiAEkbwuOwAgAA
X-CMS-MailID: 20200210155140eucas1p26f4588a50b829370acb470d847a6f399
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165618eucas1p1ba10ecabc4af00ce84b88b2d11998430
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165618eucas1p1ba10ecabc4af00ce84b88b2d11998430
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165618eucas1p1ba10ecabc4af00ce84b88b2d11998430@eucas1p1.samsung.com>
        <20200204165547.115220-34-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Now covered with a generic tracepoint.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Also you may consider merging patches #32-33 with patch #24.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_sil680.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index 7ab9aea3b630..42ea13dd4ace 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -211,7 +211,6 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  static void sil680_sff_exec_command(struct ata_port *ap,
>  				    const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
>  }
> 

