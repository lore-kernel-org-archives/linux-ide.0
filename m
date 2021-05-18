Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742ACC433ED
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC03611BD
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 21:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhERVTa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 May 2021 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhERVT3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 May 2021 17:19:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034B8C061573
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2021 14:18:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so2294211pjp.4
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2021 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BIaiKYKgl3EpNXkpkbN8wz+S/qi0TtSBJVRYNmCAAEY=;
        b=T7qerQLmc4HLpg3lFpdXFC7fodw6AjfRFtq8J0bqYZmZsDRN7iSRudIfLKNtexHpEk
         szqWitocNiJ1YH/JYI4uOgDp9izJQjfBwruW5bfB2UhQgA15DLMIa34unF9Cf9Kc8XvW
         jKnTzgGge7ht4IeZDh7GRgvzNwC4ucPCcQHn65LEuQ+CBqmZyzoQi4kEMme4b5HjaHLR
         3iTS7DjD7AkJQK5nSydmdP1YRk4g08s3SXB+jDwUsYH0E64Y83wGaUB32YJOx1O5EKR9
         EkHHHHXyh0VxnGxrPy1MqZ3fB1wg76z0pkWVRhDGdvKDYZG3qUaGqdcrlVRGozde/Vaj
         W7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BIaiKYKgl3EpNXkpkbN8wz+S/qi0TtSBJVRYNmCAAEY=;
        b=PVzHdXYUtkj7VE1eiEBhwhtJ4o/hhJaRZTvdEDFWmq6BmcB83wZ8lEvQgS7g5ZDGMf
         T9dkmkjMiRmDCJX0z1Dcl1EIjDRdf6Y9HEanIKAhdf9rD2U1/pjrBvXfigC28XDkWyni
         4ieb4zqu8HwnqkX+p2woU8OXSwhoN2OLO3bJkjp76FQTN4yNHGQ9lC6JjPJujL33Yfcy
         z/ECRySWqgCnnkTtMrmLwfiqyhhGpz0x6crc64t+TZpYAuvR7k2zb1a6dXsri3FCnSmi
         KbfoszDetmqt+8MwMpFINMmJin6YkIZX0zcHF9YcnoevLkmAjluYZFmOz/1zEQQgi8Xp
         98RQ==
X-Gm-Message-State: AOAM533qfHx4r9fKPExCfURhXkoCmqbKD9AG4zi/Q7ujK43XSblli4iT
        PSkRTASQ6myvfIIXEiq/dAkOtLozeJYLSQ==
X-Google-Smtp-Source: ABdhPJyI416k8hwnKQ/ySW3j8AFtFXA5IO1CG/X6xslXRm/7+1K8mrszz1rLwxjGJMQRvRBsf7nxYw==
X-Received: by 2002:a17:90a:8991:: with SMTP id v17mr6927220pjn.132.1621372690114;
        Tue, 18 May 2021 14:18:10 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s65sm13864563pjd.15.2021.05.18.14.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 14:18:09 -0700 (PDT)
Subject: Re: [PATCH] sata_highbank: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        linux-ide@vger.kernel.org
References: <105b456d-1199-f6e9-ceb7-ffc5ba551d1a@omprussia.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c93797c-4012-3402-28f3-95a8c145d4b5@kernel.dk>
Date:   Tue, 18 May 2021 15:18:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <105b456d-1199-f6e9-ceb7-ffc5ba551d1a@omprussia.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/14/21 2:34 PM, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -EINVAL, so if it returns -EPROBE_DEFER, the driver would fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error code upstream, still checking/overriding IRQ0 as libata regards it
> as "no IRQ" (thus polling) anyway...

Applied, sorry about the delay.

-- 
Jens Axboe

