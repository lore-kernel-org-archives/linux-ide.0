Return-Path: <SRS0=yb+g=WF=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D433EC31E40
	for <linux-ide@archiver.kernel.org>; Fri,  9 Aug 2019 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB7021743
	for <linux-ide@archiver.kernel.org>; Fri,  9 Aug 2019 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AdaoX5kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436928AbfHIQAy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:00:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34169 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436681AbfHIQAx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2019 12:00:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so45167636plt.1
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2019 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=txjrO/ukHW/V8tkDPdv+tXjuE6UndjIzFZV6EbQgweI=;
        b=AdaoX5kfmRRDO75Blops/TNpQi1Me4FTv/2FQvDgEKKZp73pwIHbiJhj1LBW35UKjN
         0YrzgMVnJfzQJInbm18v3QSJjKnHyqJK8lenJ4EsMt9s+3uHmu8+8dQKGhxtFuQk1oxg
         BmTveXlUtQ0c3pOv88F7TMvBGqZSPK2Ti4pQFZlvUF0nrr77ydJ/hgcmKIPrz6v7YCVY
         vCNJc97r6WNUoDUs4YnuedPG9iO6n3CJyT3G9y1fzStGndf02iKG713R9nfU9klw0YFV
         YsT5ZBo+CCkxSq06baoAd9WG3TWrbB6yN+6b7dJf/PbQABQPU1DrlM5r8Ze3jD02Pq5U
         fP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txjrO/ukHW/V8tkDPdv+tXjuE6UndjIzFZV6EbQgweI=;
        b=Q0vfy10HHwHrKzH5Z+4Zxpg3/8rBWl9/Z9spTUM1Cq3P4oeYWqaxBQAd4M7mIk626/
         9dn/+PlE9HY0BOYanITDqsW9q1doIVTmLIRV1y1gTak/1A+H0aWPi4a92NUi+K2S+zws
         JRwow0JDM5K1GHGJN7F31/VLKJSj8mmoOudL4TTz1O96I5Xyj/s37rTSsZ13dJg+Sg0z
         GEIGuve8tOvCxjK2iKKVtFa5+os4PzNSY9UPV1EOAhEaadnLQWK1ZyPHSLq+xSH1zCrf
         uVBcwRxI0ICHIDaHEUfsWv/8XBGxsm8eVpXyp4m+uUn48M09DgqZbjIXPdUmDH4i93bv
         KkFQ==
X-Gm-Message-State: APjAAAXy3BGlPMFoIrukj+wbuVoiEhV/h/XlCJwUozi3q8j0+YuquszJ
        XkxTWlTqGiHhvO9+GsuGbvZmpA==
X-Google-Smtp-Source: APXvYqymjDUUZeDcn23AB/pb/kVfmj76shSiPkafdWeOx6i3oPDMLrepqSpwPiHzizPqTJzC6CW8VA==
X-Received: by 2002:a17:902:ab96:: with SMTP id f22mr13267254plr.147.1565366453173;
        Fri, 09 Aug 2019 09:00:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:8460:a1eb:bc6a:7081? ([2605:e000:100e:83a1:8460:a1eb:bc6a:7081])
        by smtp.gmail.com with ESMTPSA id p68sm115840887pfb.80.2019.08.09.09.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 09:00:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Lookup PCS offset, and cleanup hex formatting
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190809144827.1609-1-stephend@silicom-usa.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d73ec81d-52d3-816f-0a3b-fa1f493df53a@kernel.dk>
Date:   Fri, 9 Aug 2019 09:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809144827.1609-1-stephend@silicom-usa.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/9/19 7:48 AM, Stephen Douthit wrote:
> v2: Fix case of hex values
> 
> Stephen Douthit (2):
>    ata: ahci: Lookup PCS register offset based on PCI device ID
>    ata: ahci: Cleanup hex values to use lowercase everywhere
> 
>   drivers/ata/ahci.c | 62 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 49 insertions(+), 13 deletions(-)

Thanks, applied.

-- 
Jens Axboe

