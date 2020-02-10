Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E8BC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4D420715
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PIz7yjJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBJNpd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:45:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59408 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgBJNpc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:45:32 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134531euoutp02fa5339932bda7789530a8cd0fa0b99c3~yDnjYveEe0840908409euoutp02c
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:45:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210134531euoutp02fa5339932bda7789530a8cd0fa0b99c3~yDnjYveEe0840908409euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342331;
        bh=5Xk4m0vm/iJgkw08b+Z1M9LVY2nLpodEAvkI6pjbDOc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PIz7yjJFnFDLn2dQhO3nevnpNM3AjXVQju/M4Q1B7vKDFcR0HoQo5BwK1vCVNMeul
         ZXmbrTsPsHueSPiWfAoR1n0ka/2dm6oWhCr6bRhIA+YQgOXdhEGtcSyN1EJAyEBbck
         KFvxDi8QNKZafgv2GVOX5nKTfM1/o4GuqjYbXyp4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210134531eucas1p104509bdf02ec6f380b8302d4eb883782~yDnjPt2GO2684526845eucas1p1J;
        Mon, 10 Feb 2020 13:45:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 87.ED.61286.B7E514E5; Mon, 10
        Feb 2020 13:45:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134530eucas1p1ffec24e712350a29fbca2f3c8f833df8~yDni-R4I31405814058eucas1p11;
        Mon, 10 Feb 2020 13:45:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210134530eusmtrp1cfa600690797515b8ce355e656baa49c~yDni_tBNn1856718567eusmtrp1H;
        Mon, 10 Feb 2020 13:45:30 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-7f-5e415e7bfd51
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 34.EB.07950.A7E514E5; Mon, 10
        Feb 2020 13:45:30 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134530eusmtip1085dc8ccd0d60382c38559e8978bbb25~yDnimb-Nd0335703357eusmtip1W;
        Mon, 10 Feb 2020 13:45:30 +0000 (GMT)
Subject: Re: [PATCH 16/46] ahci_qorig: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <9c1fc46e-b578-be85-ea33-5f5fb37c2fcc@samsung.com>
Date:   Mon, 10 Feb 2020 14:45:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-17-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned3qOMc4gwMXOS1W3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5igum5TUnMyy1CJ9uwSujO8LbrMUXOOo+L79G1sDYyN7
        FyMnh4SAicTd4ytYuxi5OIQEVjBK/NlzAMr5wijx4Px1KOczo8TKOS+BWjjAWh626UDElzNK
        3Dy/mQ3CecsocWndFhaQucICLhIruqcygdgiAkoSH9sPge1jFrCWmL14PVicTcBKYmL7KkYQ
        m1fATmLCxJ1gNSwCqhLHmp+DxUUFIiQ+PTjMClEjKHFy5hOw+ZxARzQs+sMCMVNc4taT+UwQ
        trzE9rdzmEEOkhD4zyZxb+NKNohHXSSWn9vLCGELS7w6vgUaADISpyf3sEA0rGOU+NvxAqp7
        O6PE8sn/oLqtJe6c+8UG8j+zgKbE+l36EGFHidaTq5ggwcInceOtIMQRfBKTtk1nhgjzSnS0
        CUFUq0lsWLaBDWZt186VzBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTiw3zUsv1ihNz
        i0vz0vWS83M3MQKTyOl/xz/tYPx6KekQowAHoxIPb0WgY5wQa2JZcWXuIUYJDmYlEV5LaaAQ
        b0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjEWx8UIX1KMj
        hA8Us0yN9rm+zqBMP3zrT59/kWGlob8sbzO9bDKWfLfXNvWY9wNLzUcpzZX+d1QPON72exjP
        yjuxQrbvrOMUeSOFc3oz/02cwP+9vSlSpO+ToZCRXItE+af+K8+tTiVFFt85HsYTHTRtw5Vm
        G5mFlbWeJ8/1T1DpzeuvzZVRYinOSDTUYi4qTgQAsDMyiB4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7pVcY5xBju/m1qsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6Gd8X3GYpuMZR8X37N7YGxkb2LkYODgkBE4mHbTpdjFwcQgJL
        GSWeLrrJAhGXkTi+vqyLkRPIFJb4c62LDaLmNaNEf+NTRpCEsICLxIruqUwgtoiAksTH9kPs
        IDazgLXE7MXrmSAaNjBK/Pnykg0kwSZgJTGxfRVYM6+AncSEiTvBGlgEVCWONT8Hi4sKREgc
        3jELqkZQ4uTMJywgNifQoQ2L/rBALFCX+DPvEjOELS5x68l8JghbXmL72znMExiFZiFpn4Wk
        ZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJltx35u2cHY9S74EKMAB6MS
        D++FYMc4IdbEsuLK3EOMEhzMSiK8ltJAId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HxnNe
        SbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbGFSVf7qy7PiXjya6I
        TXOEuTbVXWwVc5aJiVqdtHXBEi9Gh66D0SH7M6bNC3y1gtnoqaOBz/uvTe/Fm4vfl8yc/7mS
        IXvZnSgFi9regO0SX5TefO5jP9h3xNfm35xbISx1k1IU/Y/+2NOafrtKY73bYW95wzUGdwxW
        XL0/+WvNQmW+kw8Tu2x3KLEUZyQaajEXFScCAMgp4ZCvAgAA
X-CMS-MailID: 20200210134530eucas1p1ffec24e712350a29fbca2f3c8f833df8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p2d84d7efea0f7203259b93cd21eaa2ca1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p2d84d7efea0f7203259b93cd21eaa2ca1
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p2d84d7efea0f7203259b93cd21eaa2ca1@eucas1p2.samsung.com>
        <20200204165547.115220-17-hare@suse.de>
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

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/ahci_qoriq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> index a330307d3201..711cf94c3d08 100644
> --- a/drivers/ata/ahci_qoriq.c
> +++ b/drivers/ata/ahci_qoriq.c
> @@ -96,8 +96,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>  	int rc;
>  	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	/*
> @@ -139,8 +137,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
>  
>  	if (online)
>  		*class = ahci_dev_classify(ap);
> -
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
>  }
>  
