Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5483C05051
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jul 2023 04:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGYEW1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jul 2023 00:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjGYEV7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2023 00:21:59 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A541BE8
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2023 21:21:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so5617231276.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2023 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690258885; x=1690863685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0gON7eF0xqfPsqAMih07sB8zK68zYIMS/9LvW8C5ZA=;
        b=XIbOBiYfpwIJCFF7IO7WckeirwYH7QGoJxQ/J6fQhytGuKTfutKgXHmHkXIYOhPytI
         6ZjgVSqgbiiNDh0QkKFets1tQSCT1LVZI/FZ5BG3hQYuwIMqKxpyfM0MRrksmam7nod+
         POnpOYnAnurgOCvduRKL9QJGB67+ZJLFMLN6FgTsLvoqAoGLVa2CUUCM/tbfyOKOPdEL
         hTQWir+5R0XIm4z/gXZCWB90BwSvopLHRnk013rq7s+9XWsF6o/BQJvvOv/vWF1LBG4a
         Yptp3aSIWE9bLhki4Il80NzE+5oqt1CIbNZryYrAWlJRGtgfJSZxHcwQ1fQ3PsLH2qe2
         47MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258885; x=1690863685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0gON7eF0xqfPsqAMih07sB8zK68zYIMS/9LvW8C5ZA=;
        b=MC8bD6v2Gyx6Sxmkm+JGyugemCnRLq9UMtWGAeQdo6mHwJpjA420Q2ZsyimVh1RvK5
         rErREBrqB1Q/aMIY5nkbk/W+zhg8jtjQ0tBq1L23EmqndjSlAKbl3Ok//Z45H1lDtQg+
         KVFmvtSsHBRF6hPpSvIOF6WV2rcg61YDtuBUsbo6o6W/8oCsbaFszQabxmru3eftXSgT
         D6a62XefIrBOFNPm+i/cCl1gUKgbPYAFpoBX8MmruQSlroGgyCZNhsxnaBoH9wJOBiUV
         1RQPLjCuhvL0S2/2c9B38dFAZBvDbhdFDgoBdjv0MNp/SyjNGLVFjRQpR7hE2rfJjCKk
         tbFA==
X-Gm-Message-State: ABy/qLYSCnAXc5MIrsWk+kV1k7KPPjqTCV9LInq1qTBOxzLSvTfia9in
        Pu0vUt7OUKNqaSub8yuRuWrkkg==
X-Google-Smtp-Source: APBJJlH8hbzW9uu86CGIjgRPKjygzRbzBln/SInrZsupWAgw9Cu5sIKJlR1ujz4NeflUCbbDmbb06g==
X-Received: by 2002:a25:643:0:b0:d04:c3ee:feb5 with SMTP id 64-20020a250643000000b00d04c3eefeb5mr8257250ybg.52.1690258884686;
        Mon, 24 Jul 2023 21:21:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902b28300b001b8a897cd26sm9787129plr.195.2023.07.24.21.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:24 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:51:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        "open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v5] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
Message-ID: <20230725042121.qo2kug5ypcfllqbt@vireshk-i7>
References: <20230725030627.1103-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725030627.1103-1-duminjie@vivo.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 25-07-23, 11:06, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> V2 -> V5: Fixed code formatting errors.
> ---
>  drivers/ata/pata_arasan_cf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 6ab294322e79..b32d47112c0a 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
>  	/* dma_request_channel may sleep, so calling from process context */
>  	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>  	if (IS_ERR(acdev->dma_chan)) {
> -		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
> +			      "Unable to get dma_chan\n");
>  		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}

Missed it last time, but the formatting looks okay now I guess.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
