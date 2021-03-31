Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2959C433DB
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 02:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05C861928
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 02:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhCaCXw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 30 Mar 2021 22:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhCaCX1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Mar 2021 22:23:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A2C061574
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 19:23:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m7so13088688pgj.8
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 19:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Su8WygcebzFTKKCHgifUWkq3uQwHLbGcTbD/6QzhQFA=;
        b=Y9JiokHr5v35wkiv4jph4u8VPmOxHEinZssITTfyCCs0Lt/OnSRwzk1QcVs5oZn7Fl
         ULuUJWk+qSvXs6lLC2DDi+zocNiwfQCkaJWZUftdpxg8NV8bfzwXfT8hQwLeIyYCSKmO
         5eOCOh1MnfxJnn1arPbXS91+qAnoHqWYP8Zw1bIoLOPpObfLjtKQeeahkxOxfN5ZVKAz
         4CgtcEpHLBWQal9HaxfS3pwVvF9BZXo6z2QZ3+XDxCcMI7oTwHfPOxJtG1UlLbU+/goU
         jTgeY1TZtgLaBkKInJgwewhTwQxQviKsRuD60jZappGyBcwtBz3d1wUWr2TuLYJqAs20
         aANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Su8WygcebzFTKKCHgifUWkq3uQwHLbGcTbD/6QzhQFA=;
        b=ZRy/o2emyO032S6enFhF+LbiE8JXWeSQgUOkW6ew+iZ0KyBvK72zcrBVhHLmRP/MmP
         71Zcw5cLyET6CupOWIXm0rP7S36qsJAT6Ns7H8fnUU6jRcdNQMQgZw8MlVlYQTDqboX2
         5qxaBlG4tSkUSmvpJI79jk1mgUv1OGXVOFV41+5Q0O35VGzENDQ4SvCRjsl1RTTbV2b8
         y1zRFsRZM8HWUeiotZEGswIRgrfRNFTbBbLNKY8oCtejIIGgeYm4IjrhmjpZvfdnxL6a
         RpM8EGePWqy3jaw0YQ/9uIROG5oPfdOS+g6ihueOcn4wpMUz+bES3PzoTZhaWGx28E05
         JgLg==
X-Gm-Message-State: AOAM532LWKJVtoFaCrqqZYXGDTRpfZEDLNaxPW00klixvMdQkuadGf5L
        eN4QOgDtOv1ks75qeFYJKbYW1H4uR8ze9g==
X-Google-Smtp-Source: ABdhPJwuluuksfxHeEyLVs+MJP7emXaOY3QaGlTQNaveL0nFvokNM9H5dHQUv+3wpcbdUZItgxTNRw==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr1001171pgo.450.1617157407002;
        Tue, 30 Mar 2021 19:23:27 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y26sm295633pfq.187.2021.03.30.19.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 19:23:26 -0700 (PDT)
Subject: Re: [PATCH] sata_mv: add IRQ checks
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <51436f00-27a1-e20b-c21b-0e817e0a7c86@omprussia.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <885d2384-79df-f2d4-0adc-5b6be48e1943@kernel.dk>
Date:   Tue, 30 Mar 2021 20:23:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <51436f00-27a1-e20b-c21b-0e817e0a7c86@omprussia.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/27/21 3:13 PM, Sergey Shtylyov wrote:
> The function mv_platform_probe() neglects to check the results of the
> calls to platform_get_irq() and irq_of_parse_and_map() and blithely
> passes them to ata_host_activate() -- while the latter only checks
> for IRQ0 (treating it as a polling mode indicattion) and passes the
> negative values to devm_request_irq() causing it to fail as it takes
> unsigned values for the IRQ #...
> 
> Add to mv_platform_probe() the proper IRQ checks to pass the positive IRQ
> #s to ata_host_activate(), propagate upstream the negative error codes,
> and override the IRQ0 with -EINVAL (as we don't want the polling mode).

Applied, thanks.

-- 
Jens Axboe

