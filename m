Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF290C433DB
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 01:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CB564F39
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 01:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbhCDBMA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451794AbhCDAiJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2021 19:38:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0BAC0613E9
        for <linux-ide@vger.kernel.org>; Wed,  3 Mar 2021 16:35:49 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a188so126663pfb.4
        for <linux-ide@vger.kernel.org>; Wed, 03 Mar 2021 16:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rlj4D0v5bpekL9ZaI7FDQkL4vH4D+M9HhI76IRu/Vd8=;
        b=vcidAvXUFJ5S3F/YYqF0IMaBhef7A9GhmSY50pMOvgDEDXJXVBEmw3Ag1eeyPR/Dh7
         q3PK4MSEMxFsioI/cj5bI8w+OiqvsfnZ+47+p1/ymzKZXgZkM4x9K9Q3ijtr8STi20dS
         48GpjPHezERblpAiwrVycGBbRDTlLUXSXn+Prkw1V6L1Q99DioRlHA5X7yfL441LVK4+
         4NTrVzEG0eiRxOYMszBuNV2+7KsvBv+f2iCHeSSbKCw2+XKfwfL/lJwIpg1CYc46Qkph
         7IHrkeXwpLU8TF/lnXGiA55aUitUBPA86uq7vOA2lpcFdl47RIjNS1EQRYg6t/4ylBo1
         2mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rlj4D0v5bpekL9ZaI7FDQkL4vH4D+M9HhI76IRu/Vd8=;
        b=AM3pxyMhxhNUr7WJ6TjSpC8W9dOikOpGLXrKKEnj5sJVud7eBxviwr4CZGbxrXwEpO
         zYKS2IohlD3QVxZOhEwGleqzuAugI6Q5qPkgHqyD3slwsHsoOGG9xOQMlkib7Qj1FOkc
         uYIm+sOly0FKzexlvHGC8EbVdHWtdohcX2CafQT3Kv8n2dr8e72cdp+qM8OiSCfHhVSy
         8dqdQMw0mwtpUvqsw0ImjzNxIcrSw8r0kiza7KvbukF9F1RuKOttbhesytjH5QJJZQT8
         VzaRL17AMWdY19NwM27wpGBu4y0skiswk4BOLGogzXoIsLY3GhMn+HKYmCM0lc+RkjPo
         VfIA==
X-Gm-Message-State: AOAM531KClgUm5hHgLCR6Dm0g5AcsbhA8wXH/lnxsS1JB9azlSwejuaS
        nr3m+6KYKvSuaxUWxoZd0RNt+g==
X-Google-Smtp-Source: ABdhPJwRQAn94MhcX8TKlZS+MSRaKoYOW66JAkTdlFY0xdUVssxjuQJG7SXBUSlpXdVuyBdNO6bsYw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr1331072pgg.382.1614818148909;
        Wed, 03 Mar 2021 16:35:48 -0800 (PST)
Received: from ?IPv6:2600:380:7540:52b5:3f01:150c:3b2:bf47? ([2600:380:7540:52b5:3f01:150c:3b2:bf47])
        by smtp.gmail.com with ESMTPSA id y8sm27901045pfe.36.2021.03.03.16.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 16:35:48 -0800 (PST)
Subject: Re: [PATCH] [v2] sata_dwc_460ex: Fix missing check in sata_dwc_isr
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210303073408.461-1-dinghao.liu@zju.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e734791-d008-eb93-c6f9-b054e9c6bb88@kernel.dk>
Date:   Wed, 3 Mar 2021 17:35:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303073408.461-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/3/21 12:34 AM, Dinghao Liu wrote:
> The return value of ata_qc_from_tag() is checked in the whole
> kernel except for two calls in sata_dwc_isr(), which may lead
> to null-pointer-dereference. Add return value checks to avoid
> such case.

Applied, thanks.

-- 
Jens Axboe

