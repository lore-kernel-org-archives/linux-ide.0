Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B004C48BE6
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E398F60FDB
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 12:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhFPMw7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 08:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFPMw6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 08:52:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190FC061574
        for <linux-ide@vger.kernel.org>; Wed, 16 Jun 2021 05:50:51 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so2357916oti.2
        for <linux-ide@vger.kernel.org>; Wed, 16 Jun 2021 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9EeUX2UsPaCBEnAKSjR99hjgC77Z+OizHQhkbZcMkqw=;
        b=LE+ZfMrJkutKA1SU9/ZQsE22a3ilajA+T7eIQIu6PqnEe+ituJSy7XEKuxTWY44z5I
         fIVSteoEGeOk35eaUL0sXUSnLvxlkjs/ywW5xJwgLqTqL9JopLcihafwwnsx+vXjzR4y
         OywK6VLthqddMp634Fj4+Xjkfg/lNkWLTwS1REHpaAwiIj/WDcHiHVUXENXg3VWMp32S
         LdT2sXNK3z9hIIePuHFpygt4cP+pCZfd27eNrVK21oI6lxp25fZtQbma96qvnwEpBu9k
         Adr9BQ96SDiMyii1IE3uhwJ8AdH4BU7H1Rtui46q0fXSTUaXEFczp7mSgpJWAjjWQepC
         dfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9EeUX2UsPaCBEnAKSjR99hjgC77Z+OizHQhkbZcMkqw=;
        b=ei4dZnTlcdomCidHyArFNNaIDrIRtNHNGwmDIlOPSE20vjk+2Zua9qkDjHcsVPW5zj
         TpADn4Ri/80JIAsNjqFJ1Q1YzmgAeLSHE4SgyP89vBvyuRK/2B/lTwt3/ACZPjDzlFFk
         tPXA9zdbD3R0CMmFknPNySkO2xJCoarJbWu96979cAiNbvKVT8potW7P2xrU/l0rQ2xv
         U0qTKzUqHkUYiqOz5On7Tql5YdssB+VrUUaycuI6ACBquIMVOssiXSsQkqHyEaWEXIUm
         UtFFFj7CRrRygVfDXKB97CeFIcpfaMEMaCwQRnDlBjw68FloV1SL77xe08IUZ5hauze1
         d0ig==
X-Gm-Message-State: AOAM532nGr69ysMFnVtXB3sLYf4h9W3eRi84zRBiIHI8UuYWjunAyoQZ
        OAliLhvdVnxzXeFa9w1WLGwi4w==
X-Google-Smtp-Source: ABdhPJw2MSjcGm08Xx2Mx/PBazpPm+5j6gpvsVQRpa4iq3Izh655EVDvEEEY/JIyZYNzBfC0ILY5dw==
X-Received: by 2002:a05:6830:1e99:: with SMTP id n25mr3874549otr.279.1623847850728;
        Wed, 16 Jun 2021 05:50:50 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id c188sm465013ooc.29.2021.06.16.05.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:50:50 -0700 (PDT)
Subject: Re: [PATCH 00/11] Rid W=1 warnings from ATA
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
References: <20210528090502.1799866-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <463f14c8-c597-2b29-88ff-2929df55acdd@kernel.dk>
Date:   Wed, 16 Jun 2021 06:50:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210528090502.1799866-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/28/21 3:04 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Queued up for 5.14, thanks.

-- 
Jens Axboe

