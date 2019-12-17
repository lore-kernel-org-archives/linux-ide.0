Return-Path: <SRS0=9Eh1=2H=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DAFC2D0CD
	for <linux-ide@archiver.kernel.org>; Tue, 17 Dec 2019 11:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E144A20733
	for <linux-ide@archiver.kernel.org>; Tue, 17 Dec 2019 11:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLR1VOQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLQLTy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:19:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41260 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfLQLTy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Dec 2019 06:19:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so4436425pjb.8
        for <linux-ide@vger.kernel.org>; Tue, 17 Dec 2019 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StuVP0ZBIouB1KOtrgMy9y/jalCgg++uQ38qlkw46go=;
        b=QLR1VOQ++vE+Qz44q+jn1va7nnY8ffJhae00URWMzxxO1pUdlQ0qNbwEpuNVpFgGVH
         VPFLFHsD8valnT0JOX1tF3f3UPY0mIUF6K1YsrylkNxaLAlnWrRFo7rtHitUagXncs1N
         +nXh6MLIEaXHbmzQ8eMrqjHpdEF2kFH+SMjocTWst/2i1nfaA74n/K39V9gJF9VwHZ9i
         ksYWLsk6w8FLCh+ZQvBMs6JYnWACzECNIagVZ7y9RHE9wqcm0OnCVJR197nFltPRY3rT
         5gLgMkAySUt2ktyPIx2Skxpt+PlSbiF+cZtOWn+SPcNFur7tnYzUuaiXYHWU5nmhHGFS
         eWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=StuVP0ZBIouB1KOtrgMy9y/jalCgg++uQ38qlkw46go=;
        b=FwuHerLbHd0UQQtUfXLPIdiV1jlXSXBrlZV/rlbjwYAkFLcuayIVeKQ9qYIZSBb4rk
         ttvhtjgndC9Oy1+k84tYeogESxDWlykk0qR6AfkF8W71ZBt9ZJ1z8Tzqa3suZvBqvIZs
         stBayKxPPvPcdZMto0k/oIYbhO43vXKOXC9bQsgiY3eep1Eut8FEjIdVhP/DaSvyF4Bn
         gXO4J5E34E1CRG2ugSiW0eZZc6Z6qgT8Ci1drK2jQt+ndCB1xNNvkHybNIG4/wxzqjDj
         5xYZrUZM7S9TWdfOUIbYASgGmqEI9TwXqKKUjzbjN30m/MDLw9LcuBQOHEAcSTZZlZav
         bmNA==
X-Gm-Message-State: APjAAAXkpYPv4NKBzNzX8k6RJUYG1ENW86ntg4UTbOmmUvGZn2o6hOmq
        w850M82zC68S4sROoq1wYnauVQ==
X-Google-Smtp-Source: APXvYqx5xfK0/s9Ru/ZE4AeeQAoahh8g/WaVYmAIike6weLBOZzRcuiHWrLBeuR9IBG/qvZH6xD9Fg==
X-Received: by 2002:a17:902:fe10:: with SMTP id g16mr21654536plj.66.1576581593510;
        Tue, 17 Dec 2019 03:19:53 -0800 (PST)
Received: from localhost ([122.171.234.168])
        by smtp.gmail.com with ESMTPSA id k88sm3134508pjb.15.2019.12.17.03.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 03:19:52 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:49:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk,
        vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_arasam_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20191217111950.vzuww3ov4ub45ros@vireshk-i7>
References: <20191217105048.25327-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217105048.25327-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 17-12-19, 12:50, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/ata/pata_arasan_cf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 135173c8d138..69b555d83f68 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
>  
>  	/* request dma channels */
>  	/* dma_request_channel may sleep, so calling from process context */
> -	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
> -	if (!acdev->dma_chan) {
> +	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
> +	if (IS_ERR(acdev->dma_chan)) {
>  		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}
>  
> @@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
>  	}
>  
>  	dma_release_channel(acdev->dma_chan);
> +	acdev->dma_chan = NULL;
>  
>  	/* data xferred successfully */
>  	if (!ret) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
