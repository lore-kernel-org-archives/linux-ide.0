Return-Path: <SRS0=wLrF=DJ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2FC46466
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 23:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43204206A4
	for <linux-ide@archiver.kernel.org>; Fri,  2 Oct 2020 23:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ks+IR8q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJBXwg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXwf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Oct 2020 19:52:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083AC0613E2
        for <linux-ide@vger.kernel.org>; Fri,  2 Oct 2020 16:52:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 34so1849713pgo.13
        for <linux-ide@vger.kernel.org>; Fri, 02 Oct 2020 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0DJfVPYB+sVtt5O1Oa8Zekpgikluk6DkPQtGUjAgJlA=;
        b=ks+IR8q3r+6/HLVgizvYpFbU+qnF/X4yPlu/67dItSrGoLaiBgypQx8xGSk2y3QL3C
         g/wn8tvlFnwHQNBn3lU7NupfGmOfXUy64ZKyNzVqMJVPAohEKvDvFHEqB58LQVLV0IZc
         GsR+MGvfzF7asnMMZb7iOhar7Zf9fFubiXddL6lODcZIA4PXw2XhWow70F4rhQcQvnDD
         47mGZcUXyMQS7z1KQpVXY3EnR+G9q4p3byrjW+MMqJ4hf4uOVPmG6b//o0P9EIQYuwqw
         wmqjNz7nW9F7eIKdo2aEuIK0zINsb+qSP6VZdp2lJ5TRTJucT/he1mA3td/PZJtX1VeF
         N+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0DJfVPYB+sVtt5O1Oa8Zekpgikluk6DkPQtGUjAgJlA=;
        b=AKRq5OV0SsBRXAkn2GC99xHhmbht6YyIi6A1gwkzl4mDU815EZ6KQlS6ldN5d7+gSi
         9PEb346PpIAcSLl349AOG/9eKaRMpN5vWOLptoNAHh9BRqZG4sxRWZUY0/steIu/0NUt
         i/lepXzaLOkr3fOcOJXJ88aXASJ4Vm2iFF3XlHnHSO5q+TG21CTws7Pwo0HmwRqDphfn
         /1ah746d1rhWO6XNpeWSvhH2YNMGuix8afhSRgiNXKAGgjPMOYYhEL6skLQP6F7GVkxK
         cJDk7rc/i8xac5BpWtFhlYwm+mEzlMIb13SHq34OYdR23pL8+luBc4/rH7wP0tE0MxaY
         eqnQ==
X-Gm-Message-State: AOAM5304Q5ORnBK96UoCi4MxJMbUnqLPpXNMRRrWGEfsCJ9CMEKBHOlJ
        893Xx5TATWzpplVpoKti4eOvKA==
X-Google-Smtp-Source: ABdhPJy7K+Q8r0RzR7rSAzeX3kKVhmlq4kUYPcbn7wh1uB/vDrsgSEnR4qhfNLKOa5/U01XewwtSSg==
X-Received: by 2002:aa7:9ac9:0:b029:13e:d13d:a133 with SMTP id x9-20020aa79ac90000b029013ed13da133mr5067023pfp.27.1601682753874;
        Fri, 02 Oct 2020 16:52:33 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x140sm3270606pfc.211.2020.10.02.16.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:52:33 -0700 (PDT)
Subject: Re: [PATCH][next] pata_cmd64x: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20201002224852.GA463@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8cad7d36-b5d5-41bb-0f40-502720dc2e53@kernel.dk>
Date:   Fri, 2 Oct 2020 17:52:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002224852.GA463@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/2/20 4:48 PM, Gustavo A. R. Silva wrote:
> Replace /* FALL THRU */ comment with the new pseudo-keyword macro
> fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Applied, thanks.

-- 
Jens Axboe

