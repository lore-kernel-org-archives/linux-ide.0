Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461F2C388F7
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF469207DE
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 16:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ejf2gPfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgKMQZQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKMQZP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2020 11:25:15 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93827C0613D1
        for <linux-ide@vger.kernel.org>; Fri, 13 Nov 2020 08:25:15 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id p7so10342232ioo.6
        for <linux-ide@vger.kernel.org>; Fri, 13 Nov 2020 08:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GA093gnnU3rSgn9lMSWAJzb5ryLJdITJQ6w1CN85AWw=;
        b=ejf2gPfB/QaA/XCHHD6owmegG3aLYdT0xIx+al8Bq4hJ4fEnyFxZ4fYKh7Ly0cnxTp
         f0QMwEgl+6fvAiw+ZojtkbmbfEmqafz/9NZh+xOyKjfJxAcHTztgDfiE0JpPHE3TF10D
         0greeSY9fc0cOTXzu0ZRiXL0rnf0tZmPOVVewDNNS7gBWibDuepHCjGa1SLjbDrCcWe7
         4HTzwpHDHs12mpQSNlsinLANRhbfBOicK4Z2fZgOo7Q063r6r1CcDgyqrntJxl4dKXj5
         wko5jzrnMmLTp/tlYClXjH+Z250S6TXFJ+rKRuHVaaAzTCbwjecxhEK7d1UyOYrPPxH2
         GQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GA093gnnU3rSgn9lMSWAJzb5ryLJdITJQ6w1CN85AWw=;
        b=dvK59D9VwHm5QY3d/t0NxqYHbuoJOHB1gM5FBUL44BFCB7XtAB1qEmsJ4Vd3TF9HE3
         RY4fQoaw5p9JF9KgOel3bR0IuwMjTJ2BK/HM+vFiL0eEwl9lV3LP5zja6IUiNHwVFVJH
         uAQv6imhhiM9Nz2IWtFD+68QjDJkHWo57CBtSTcuax+nAftax7ckuy5Wrhjex2ALvLyX
         ThL0OY9hlLsRh808PmMNNWgWk6zE4Swp+t6BJJGQ3ON8tvEMJ330v3DkYx70LU/+W7sj
         ZFvLRhEpRPldr2kXY3nkXRtgJQ8/8ZH3SanzVqZKUhRizInhaBAiyRZfHa67uCp7OuVH
         8Pzg==
X-Gm-Message-State: AOAM531/I415bYpeRDUGovzcRkbAKpTFkfQyF8ijSeVkfIMF9raEbRD1
        wQU3/dOrfNeKhno06euhZRWnIKlbdhHaeg==
X-Google-Smtp-Source: ABdhPJzl18it5pTjIBUKEb/rvQyaKjzeavbVGFQuX9QfSoTFIzpbEQp6IHLWev3u7df1mWFkdV0TUA==
X-Received: by 2002:a5e:9e07:: with SMTP id i7mr438662ioq.46.1605284709886;
        Fri, 13 Nov 2020 08:25:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y9sm5260286ily.85.2020.11.13.08.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:25:08 -0800 (PST)
Subject: Re: [PATCH 0/2] ide: Remove in_interrupt()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-ide@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20201113161021.2217361-1-bigeasy@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81acdb73-be79-98ae-f736-ae70f14f02f7@kernel.dk>
Date:   Fri, 13 Nov 2020 09:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113161021.2217361-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/13/20 9:10 AM, Sebastian Andrzej Siewior wrote:
> In the discussion about preempt count consistency across kernel
> configurations:
> 
>  https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
> 
> it was concluded that the usage of in_interrupt() and related context
> checks should be removed from non-core code.
> 
> This ide subsystem has two in_interrupts() checks before mutex/wait-event
> invocations.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

