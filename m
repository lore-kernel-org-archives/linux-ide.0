Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06672C433DB
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 02:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E5B61928
	for <linux-ide@archiver.kernel.org>; Wed, 31 Mar 2021 02:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCaCYz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 30 Mar 2021 22:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhCaCYl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Mar 2021 22:24:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915EC061574
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 19:24:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so8442733pgj.10
        for <linux-ide@vger.kernel.org>; Tue, 30 Mar 2021 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=K12ASK/rbrDSMJY+hMg4tmuNAvdOvhASXF3evgX8bUE=;
        b=VWAd5Up1G0IcTQKoFmKai+r0hwbHofAdV6gkNwuyO/VNegg7UJKn06O/PtKiB6EPjj
         VornpUlXlv4bOX0yoIsKi39dFbfDsqPuZsliFb7lkqhtx2xQAKQHUV3ktVe2B0YP//n1
         D+kIGAMq08ICqoczLCS8TkprS5WQDYzS8es1+4i0KtCUk8d6IZ4N7PmhTk0d48vxO83X
         1J2qQnedVeWhTFWJK4IeACcFCXxnItly4l+bP+Elh2slQVUoO1yP0Da0baffbkADNCco
         pQH7dcwjHjevzKbxOqCOUQ9DKWu3oAqY8eTrreE62dUKqXbAqIsREzOfEBrp2Z1grF8i
         0dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K12ASK/rbrDSMJY+hMg4tmuNAvdOvhASXF3evgX8bUE=;
        b=bffgsWPYIL865G8s9q5YNfR2lNY38/VXXZFqhuco79NJWPa+qxHHK9dTQjJQBaoJdc
         OEksmr0eBWb+Q8TCsPzlFkDwsz01eIwOCZNSO4ZKPxvAGqBgy7KNFTznwqkD4BIIJGGR
         +D91nzjJr9hGPzLp2jyFuCrWxiKoLWY3l4ZPRNBP94j9yWbcsnVLhEGcB7WoxFsi0VDc
         7ZyGcdlk4UW4A4qhDG0DFpnWgT0tuXymUUJLdeDiUO3ylWSundAWu729RJfPzpKzsza+
         HXPmSDJG3IoOE333l8W6xngANlrtpTLC674GGHqZBYaBxdXIkCRMV20TKzS14D068See
         CW5Q==
X-Gm-Message-State: AOAM532H5pbr1UVTbS5Hx7R3woXz6+JDOuhg9qUpvvwWOqLejZOkxeUU
        Y46ZenDaBWHVg1kyPqZFzHH/R2w7LdksJw==
X-Google-Smtp-Source: ABdhPJyO5Z+UQARRixoLKfXV4HTCeyBGLMaz4w+mp5oAzY4YNwmmDxHGHxl7d+ckaHl/p3LOb4V1aQ==
X-Received: by 2002:a62:fb14:0:b029:22e:e189:c6b1 with SMTP id x20-20020a62fb140000b029022ee189c6b1mr828441pfm.31.1617157480327;
        Tue, 30 Mar 2021 19:24:40 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id co20sm361974pjb.32.2021.03.30.19.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 19:24:39 -0700 (PDT)
Subject: Re: [PATCH v2] ata: libahci_platform: fix IRQ check
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org
References: <4448c8cc-331f-2915-0e17-38ea34e251c8@omprussia.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e2d31a7-9a28-9aee-bd28-84f3d4d7701d@kernel.dk>
Date:   Tue, 30 Mar 2021 20:24:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4448c8cc-331f-2915-0e17-38ea34e251c8@omprussia.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/15/21 2:15 PM, Sergey Shtylyov wrote:
> Iff platform_get_irq() returns 0, ahci_platform_init_host() would return 0
> early (as if the call was successful). Override IRQ0 with -EINVAL instead
> as the 'libata' regards 0 as "no IRQ" (thus polling) anyway...

Applied, thanks.

-- 
Jens Axboe

