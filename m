Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6502C433ED
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDEC61209
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhERVT7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 May 2021 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhERVT7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 May 2021 17:19:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FB5C061573
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2021 14:18:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so2296720pjb.3
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2021 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/aFc8kH5YmPyOor4QmBrOjgKebWAC/xtYeXNuPRLBhw=;
        b=kySxmI1ntUL1RMhvHruLeB06zUX/XS+ZbE4WeSUJRGxQgInxgp3wbzIYq+943c20pr
         ZeZGX3FuFyBJkgDaeLfu0z9mTHmHyPV+RuIxBqQLBLfXQk71l36x59BMKNwH7AP2hnko
         yl2J6Iiv2Rbc+iZwP8ASvQqMuh+IQIlfIlH2CjwpMuBReRoPNk/gu6IecWZBufmoD5Ud
         nxLCg+E/DzaXRmeZ0jyqmlvoN6S3H1oNnvGCFfy4veZ8xcACxwWlPqaIiUEeS9r6YrzD
         qVfwslzscQzZSHN9mIU0MCsDly7aNeuClGRfo17ugYJ+/5GM3Uc8gX+XYSgUd/7aGyG8
         IOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/aFc8kH5YmPyOor4QmBrOjgKebWAC/xtYeXNuPRLBhw=;
        b=gwA4RN8ClSwOGyURCDxcUgW9o9OA5Hi/fh3hiuejZ4Ji8MrxYxAqv7HMngaw+fepp9
         0aNvfX2XVlSXt4wp/BiQYqyacbgVEwZtHixTEe3X9Lo7x874B0w963xE4hE/Nyk+tfX9
         9Xws05LMmPuJ+CmORStN5w+12eEdMWguKFM5RFB3NB5C+zdg3svfO4kClaWFIEjEJ2aF
         fc0QqmqOydU3I4J2nxDmpah4GTR8QrP515q4adp7D/S1AWslm7CcLKyQTV5Xp7EpuCP9
         3YAguNpG0cnGOtHI+55NdKyT/fR2NMW432+/usAS6eQU0tPDMiylz9V2IS7prwYziNRV
         iKfg==
X-Gm-Message-State: AOAM533wBP6jElggtAnGxrD/Bl1lC4nAHDlE0BpfSdDnCZpE/RglIOIr
        bka41F9VHevM7D/grGyat/Bj+uSq0BHMNA==
X-Google-Smtp-Source: ABdhPJzW7p4JHlabXxkCYzXMhL48vjITdbuHuvBEnfDoMqUvt7qirQXf+tcjfvu3g+jK+Sm7pKJUhA==
X-Received: by 2002:a17:902:229:b029:ef:6107:188d with SMTP id 38-20020a1709020229b02900ef6107188dmr6821179plc.41.1621372720230;
        Tue, 18 May 2021 14:18:40 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b15sm12802277pfi.100.2021.05.18.14.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 14:18:39 -0700 (PDT)
Subject: Re: [PATCH] pata_rb532_cf: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        linux-ide@vger.kernel.org
References: <771ced55-3efb-21f5-f21c-b99920aae611@omprussia.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6baaf8cf-ab97-273b-4171-185863340018@kernel.dk>
Date:   Tue, 18 May 2021 15:18:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <771ced55-3efb-21f5-f21c-b99920aae611@omprussia.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/21 5:46 AM, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -ENOENT, so if it returns -EPROBE_DEFER, the driver would fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error code upstream, still checking/overriding IRQ0 as libata regards it
> as "no IRQ" (thus polling) anyway...

Applied, sorry about the delay.

-- 
Jens Axboe

