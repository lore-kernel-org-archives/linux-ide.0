Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DEC433E0
	for <linux-ide@archiver.kernel.org>; Fri, 26 Mar 2021 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87806193B
	for <linux-ide@archiver.kernel.org>; Fri, 26 Mar 2021 23:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCZXNn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 26 Mar 2021 19:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhCZXNm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 26 Mar 2021 19:13:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DEC0613AA
        for <linux-ide@vger.kernel.org>; Fri, 26 Mar 2021 16:13:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so4949851pjb.4
        for <linux-ide@vger.kernel.org>; Fri, 26 Mar 2021 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ylCrPpsmqTJAvNciys/KBAAkASuX0nYXPF+Rmh5x81w=;
        b=BQ05M5puLVP56RQVGkeeaU84mYkuy9l6i8ic062WA2lhm1KMqQEmXAXoUozAxpdf2A
         T8lfiyu4YikT1L14PnnP4+Jy6Wrvkcw+fchEkwZ7Jn5R0vxHbUhJdayNtXRBkYlP2iDM
         v4cqClt1E+/v06nDyb5YtuB8u4yUrnt1gXASxemQb6lGt2nNpEkkyxGxvtRPToJfFOYt
         iTFmZcCUYr6qz0h1TQDIaABRvpXzyxjQZzXT0IytBerAr14SsYfJCFisKuZS3cK5Kwlu
         PI+1y3BV3/2WbQi820+QClmWZAZurT2E8RmQIvHpxB78mJoaYsLLkCmtSskvuvF3a5qx
         p/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ylCrPpsmqTJAvNciys/KBAAkASuX0nYXPF+Rmh5x81w=;
        b=lRgcsUCsXHcRHu4OLcnreO9MH7GAtGHK9iQtQXx6CfAbCIbKO6ggphaQ9yH2iP2dkr
         g7EdDoP/Ek6jYKkT5TR9Mg8dbnX+qIdK7MdGcENDhKQrMBaaYscpincM2SEX8FW0t0Ci
         eRiPgJDnTi5StyzKqcY5GO9Q+NrdzSo6Yt8HNDbOLwuUwksHDOXui49lyd9iJ/NYNDkM
         ZgRfKBrnD/77Mf53Rl4GcfE45k9Femdo8Kpi3+Lyoag0H8RE81uNHP79h9zQ+HuFNu3s
         c6djRjb8fgBzgxG2KNuXhIvPlqct7gMLMtxDCnJyv1D/P7pghEIsDX6/egluLWBx0mxC
         sFwA==
X-Gm-Message-State: AOAM530OwkTHwvweFbv1TCw2VRwmDLemIMVx56QYhF1EBHON5S2KF32h
        +MPHWeefSjWmuB2F2C4kiGjKkaeEg9AG6w==
X-Google-Smtp-Source: ABdhPJyrTT8b2D0hO79mgpVfWNYtynzlShUC2j5mcNICXMmxfSLSEUhmySFDCAygoxExd+KWU6kbAQ==
X-Received: by 2002:a17:90a:b889:: with SMTP id o9mr8351201pjr.97.1616800421182;
        Fri, 26 Mar 2021 16:13:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::141d? ([2620:10d:c090:400::5:4d27])
        by smtp.gmail.com with ESMTPSA id y29sm10119018pfp.206.2021.03.26.16.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 16:13:40 -0700 (PDT)
Subject: Re: [PATCH 0/2] Correctly handle plaform_get_irq()'s result in the
 libata drivers
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Viresh Kumar <vireshk@kernel.org>, linux-ide@vger.kernel.org
References: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <67f69b7f-393e-3d7f-5689-93f9cd10e171@kernel.dk>
Date:   Fri, 26 Mar 2021 17:13:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7ba924c1-8c94-b0e7-6361-5e060746e839@omprussia.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/21 2:46 PM, Sergey Shtylyov wrote:
> Here are 2 patches against the 'master' branch of the Jens Axboe's 'linux-block.git' repo.
> The affected drivers call platform_get_irq() but mis-interprete its result -- they consider
> IRQ0 as error and the real error codes as valid IRQs... :-/
> 
> [1/2] pata_arasan_cf: fix IRQ check
> [2/2] pata_ipx4xx_cf: fix IRQ check

Applied, thanks.

-- 
Jens Axboe

