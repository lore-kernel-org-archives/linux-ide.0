Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAC3C433B4
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890E2613C8
	for <linux-ide@archiver.kernel.org>; Tue, 20 Apr 2021 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhDTUYb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbhDTUYb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Apr 2021 16:24:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109DFC06138A
        for <linux-ide@vger.kernel.org>; Tue, 20 Apr 2021 13:23:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p2so12053242pgh.4
        for <linux-ide@vger.kernel.org>; Tue, 20 Apr 2021 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WRZXjE4aK1HQxoLEc8jiHuo+pQW3WFAMQ4pM5BS+HIE=;
        b=i7NhxbFFUtsIx33i/FDG8VCTFQK25b4tHT+SFTrHcJTz73Km74+clEBbSLeVqZ8HDJ
         6WoTt4cIE9mpgqrflsao9s/pdE65Tt1amzudx8m58AbzPsn37iqob8Vbc2I+LzA1IvJa
         y7a9NUJ/Y7gU/BYaFc3HgJX3ez+o5+/yJOs8J0G7JOdIAZyEY9ZxHedLfnextU+paIqk
         BsCu1vJe1102KqNIRoQuj2jcVFL3h+uMr5wHcNEkbC5ZeanEMVkHeGBarGnOqi2zV00O
         mklwh9Nh1/4sr4RPsMC0vs/fmDG8OKsToiBqpzOGlCo+JjH28aXDT4ticgGWYA4QIjG4
         HjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRZXjE4aK1HQxoLEc8jiHuo+pQW3WFAMQ4pM5BS+HIE=;
        b=ntPMAtcG2Q+3OPXYu30YjJxDmRgk7ps96TYnTHZPvzFOOLLf50hCNWR2sbFtjsFuXz
         zmJiFQnFHnAoVJz6W578qctYgzwkIOFHwGC0g0AkWKMjEipug5E901u4Vfwm8qyaO2YL
         PPP6fx/Rr2TruhQwn5imgcBUlF7zwuz7QD+5BsMEQhsdRPI6Z9unx+Wda+JGXmiWDUVg
         4n635czhSdUc3YbiKYP5q9qzkuXA7eCHL34gOlV68/grGgZXRkZ7G4CnB81r6sZyUkt8
         gOLFPlakjoyP+cfq9UlAFcgQ+IFwCPjomWLgNzAPJTsTxVS/oM7bxIAKVpWrxvd8McfN
         u3BA==
X-Gm-Message-State: AOAM531bh7MDasYeKbbgnfqyhaH7WRIWMo2wKduxaEDrkysVJLSwLjNU
        DZXsPBcLa3UB0j0GjjeJLNAo2thkV0tjTg==
X-Google-Smtp-Source: ABdhPJwh9ZPPndH2NPXK2stdybN9bF8jCj7nLnvQhAQB2Rz/jX8y2GZ9xbzE/3HN6LsNQUbUKItmgw==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr26662434pfc.0.1618950238524;
        Tue, 20 Apr 2021 13:23:58 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a20sm6941312pfi.138.2021.04.20.13.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 13:23:58 -0700 (PDT)
Subject: Re: [PATCH 092/141] libata: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <e3498b34cae37d0f93db5824e5f61b183a7293f1.1605896060.git.gustavoars@kernel.org>
 <07757a90-7682-47e4-f6ab-a07b1658280c@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2cb77fac-21c3-6ba9-2f8f-0ff154ad4459@kernel.dk>
Date:   Tue, 20 Apr 2021 14:23:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <07757a90-7682-47e4-f6ab-a07b1658280c@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/20/21 2:11 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?

Applied for 5.13.

-- 
Jens Axboe

