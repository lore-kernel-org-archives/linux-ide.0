Return-Path: <SRS0=8bhx=5R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B1EC43331
	for <linux-ide@archiver.kernel.org>; Wed,  1 Apr 2020 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E800A20772
	for <linux-ide@archiver.kernel.org>; Wed,  1 Apr 2020 09:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sUjbTKCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgDAJDu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:03:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46488 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDAJDu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Apr 2020 05:03:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id q5so19756488lfb.13
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2020 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yWgHgk+jLJRzD93cqQsYsHikKuqpSq+ekt3Naao04Oo=;
        b=sUjbTKCUQZ080lknNkmyC6/QcS4P6L6XfgHpUEcDWb73mGAeNLZUm6XP8KOt/FWHqL
         d5QXHHQtYPjLv8S0ufHgEmvDLsvY1hpMSw2NXObmw/8HELgv/WK2duzj5czvfBpb3FAC
         R+narAzrrP9wuJI96XSm54anJzfhOS0S819SrARvwZkk1ZNX1Gbt+kRaLS6e0bFzT/+J
         T6EK+bsGxOWxxNt7X5iLjxvxUm5W+ZTcJ4zoeHJRjDLVo86IlowU2+681GVVDTv1XNi+
         kQOwIT+9+MeZ2jytkxBqKP1f02T9bKzcFOMBRTYplyI+/GWNRAilh3GD//BvPq9+EjJ3
         mnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yWgHgk+jLJRzD93cqQsYsHikKuqpSq+ekt3Naao04Oo=;
        b=cSuMQ1pMjEacuFUbCQ+KcYrSWO2HTxrlEZvSnzyHHUlqDGacDeASE/nzmeBULHwOTK
         Z+d//OEzoOcQtLuLy97nGBVJQuWYvPBbipeVDv/jNd8VyQqGPBkR32rJFSszgZlwtRs8
         8YCj/atwx8YpU8mEDcVcEIt8Kqt4D80vqHKyz4UlS4oWaaMguBxtJR1Fjgz0NX7r/7xH
         y/r6nkgpn+ukOYsna9df9iwEOgSuguRpR/YbNvIER/ya8O4ezMn1zFaEeOoJ803WyUXX
         Ima+sKNfJxkd77eBAGb+MGeiCT+smc3+a7kgXQ2S0SVR3pZAO71mBmfbzaSbZA+abS8w
         bD9w==
X-Gm-Message-State: AGi0PuY3o0FjybZ2Oso3JwgBI0NImIMawLs6q0ivByP1R26nJeNFT7iY
        Uo8aECp9YRQUOIz08ELCp9KPjw==
X-Google-Smtp-Source: APiQypKRtrq5WqtNVqVAopMUXD+lr/bI4FzH75mLC1qIZpHxBGYdPZBrtqlvt+9ukJ/G0J8aZQP0UQ==
X-Received: by 2002:ac2:5f75:: with SMTP id c21mr13824158lfc.194.1585731827671;
        Wed, 01 Apr 2020 02:03:47 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:245:3fc8:782f:cdd9:3f89:e462? ([2a00:1fa0:245:3fc8:782f:cdd9:3f89:e462])
        by smtp.gmail.com with ESMTPSA id k4sm1094999lfo.47.2020.04.01.02.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 02:03:47 -0700 (PDT)
Subject: Re: [PATCH] ata:ahci_xgene:use devm_platform_ioremap_resource() to
 simplify code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200401084952.5828-1-tangbin@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c1cfde01-769d-2904-3be3-a41cc51c1519@cogentembedded.com>
Date:   Wed, 1 Apr 2020 12:03:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401084952.5828-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

On 01.04.2020 11:49, Tang Bin wrote:

> In this function, devm_platform_ioremap_resource() should be suitable
> to simplify code.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>   drivers/ata/ahci_xgene.c | 21 ++++++---------------
>   1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 16246c843..061209275 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
[...]
>   	/* Retrieve the optional IP mux resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
> -	if (res) {
> -		void __iomem *csr = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(csr))
> -			return PTR_ERR(csr);
> -
> -		ctx->csr_mux = csr;
> -	}
> +	ctx->csr_mux = devm_platform_ioremap_resource(pdev, 4);
> +	if (IS_ERR(ctx->csr_mux))
> +		return PTR_ERR(ctx->csr_mux);

    The previous code allowed the memory resource #4 to be absent, the new
code makes it mandatory? Is that intentional?

[...]

MBR, Sergei
