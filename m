Return-Path: <SRS0=eb51=3D=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A9C33CA9
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jan 2020 04:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65429214AF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jan 2020 04:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uk6cugxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgANEaX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 23:30:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41127 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgANEaX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 23:30:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so4706683plb.8
        for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2020 20:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iVr9yAoZJuPT+wI1kzCXAwKFTOLQvGUMRGn0vgwmpYw=;
        b=uk6cugxOn0gyvgxJ338/RfwMLRVtyKEGffiIZLmHpX1kXOjtW8v9C1lDoB6P1RATQf
         Rf8lnj8xXV8TU5G7AuV9eOO9++qiaDpjLFNCDpaI9BodYB6/h55KgrekPE6r7H8j8fjk
         9ybHWCFAtoLYx8VRzWT83ZX9qTq7fWZ8nglOE8RvcWXTLZ3Pc6Hpy1hwIlVeAfG3iCD0
         TmA1KM5YSve5wyJ0IGU9ldi9kF9lzlYXHqCf9bMjcvpX/GIW4rctveoSyngwcDE7HmL+
         Xo6rA5FdjJg+muFTBKi7TihYTkgl3syhBFFPASeGOsk3bAhww4aLRejvFSOzgfdPgkXe
         vcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVr9yAoZJuPT+wI1kzCXAwKFTOLQvGUMRGn0vgwmpYw=;
        b=WynufGSHwJkkyYhna0xCwumjAJUGhTCW0V0oJrfqktbXXdTeBVqLmtnRK1TXHA8tfy
         e2yr1s5dypoEBu8f2SQjpGpyjAl+CH6y/OgsssGVqCpaquUJxxTMoiM/VOnsD377FqTo
         3INRI8jy3V37jvNEnM6CBXOVEDKQl+rNoZ+HGwpz7q2zLnWxW3fDQ9y6jxWYhHN1mxdI
         GXVo+nZnLpCFcNIaf+LXMtj4gyRoqDr2jKhVLhPUz4Fw05XrkvBNO317Lx+F56EyqBnm
         /Mcza7W7MujD+Zf6WB4unwI657agStbCgE7WoBuCndTdD8vpy1AAA1yQV38KuJR6xn2D
         riKw==
X-Gm-Message-State: APjAAAU/WQq9awfMc9ZXt11aX2h/LM1wauL4M3/hEHviVwjQOlLNgcx+
        ekzkDSh3fKxaA9zmuxV7vF/1JA==
X-Google-Smtp-Source: APXvYqwl+qwYqVRNB1p2rvrTovb/wGz3fEtHSoB4mx14jTJ+/G5hSEPL7yh4AtUL5EnCcwJvgtv7cA==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr18029458plq.244.1578976222640;
        Mon, 13 Jan 2020 20:30:22 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id i4sm15444898pgc.51.2020.01.13.20.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 20:30:22 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:00:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk,
        vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: pata_arasan_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20200114043020.fecmhepuvlvtcknd@vireshk-i7>
References: <20200113142747.15240-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113142747.15240-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 13-01-20, 16:27, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> The dma_request_chan() is the standard API to request slave channel,
> clients should be moved away from the legacy API to allow us to retire
> them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v1:
> - Fixed type in subject
> - Removed reference to deferred probing in commit message
> 
> Regards,
> Peter
> 
>  drivers/ata/pata_arasan_cf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 391dff0f25a2..e9cf31f38450 100644
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
