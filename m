Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00048C433B4
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD714611BD
	for <linux-ide@archiver.kernel.org>; Tue, 18 May 2021 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhERVZI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 May 2021 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhERVZI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 May 2021 17:25:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BCC061573
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2021 14:23:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 6so7925660pgk.5
        for <linux-ide@vger.kernel.org>; Tue, 18 May 2021 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ahk6fQ4xzI2YyxJ4iMRMr01uTbgS9Uyc+7Prf8I3lmY=;
        b=c7bZmOkyMwQykR3enUAWvv6cY4qach8hjFWqORIzNxuuw3SORL4AVf/ifslHiFoH3V
         AzskfxVjDT0QilCYS3PBgnDdDIdQBFm3lpha98XkqihnH1LsG0jv8BbyM5xDfkY58vuF
         LCzGL4/+jJftYO6T2wrWunSfNBCQJx6zCUVHOnXwtFTH3dqk+VH9ZiAO/HjnYGczRh13
         /o8Qqmc9gLC3G+27pUDHR45MU/CWSksjddQTlsVxWPJCAE7dSeBdET3gNqsX9jRpaMs2
         RFpPSRyBBb6ZzWlfbAtD3t7MEjm7uAQ1z/NqUFqj0/BhFX3I1G6MZxLSidI/iTa8uX1U
         +Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ahk6fQ4xzI2YyxJ4iMRMr01uTbgS9Uyc+7Prf8I3lmY=;
        b=E/3cP/tlQHvIao7mgu38dahP5fZ3MUjCT5zcW/dpGZtC3Hen+MSQAhTUw8HR6qtA16
         udIXnhPzjaDNS7Wiy4d8p/y6hndyT6miFM9XiKxSIgbf75cQ0i4HhXQduMec1jreQBdt
         npl4eYbgt8EDrSy9ow+13fgaT9pNPzD93t/PvLQYcvX6aI4olQoJSDqMvz+8ItHspPM+
         6pivpNoQMjU9JM7XWzeTh+x2u45JAJfzc2FKzLvEFWa/tcG2yGWtJZuFjh22tiw8ynKU
         YPB/xRRTZPRtIwbLZbijqN0vLW/MDn5hT+oqNeLrJFSy1Opf4HL/zKpY6Cz3YNdXFiLw
         1jJg==
X-Gm-Message-State: AOAM531nHXNlZ7+B1eT3rFCxBvG+5XSISoKBUpCFzTlzYsWYh/wyzdSq
        XDbQ3hcD160Igs842axQjcPVbMGspZ32OA==
X-Google-Smtp-Source: ABdhPJztFm+zrp0QhVEDjTIVGGMFXVv40r7Hy9Au2O3aCSz1p8/QIydqahkgCG/Cr0M9tjuhgzF8Gw==
X-Received: by 2002:a63:358c:: with SMTP id c134mr7015596pga.114.1621373027544;
        Tue, 18 May 2021 14:23:47 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id kk7sm2528582pjb.16.2021.05.18.14.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 14:23:46 -0700 (PDT)
Subject: Re: [PATCH] pata_octeon_cf: avoid WARN_ON() in ata_host_activate()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <3a241167-f84d-1d25-5b9b-be910afbe666@omp.ru>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <760bcc25-7dc5-3105-36e7-d55c19ece32b@kernel.dk>
Date:   Tue, 18 May 2021 15:23:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3a241167-f84d-1d25-5b9b-be910afbe666@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/18/21 2:38 PM, Sergey Shtylyov wrote:
> Iff platform_get_irq() fails (or returns IRQ0) and thus the polling mode
> has to be used, ata_host_activate() hits the WARN_ON() due to 'irq_handler'
> parameter being non-NULL if the polling mode is selected.  Let's only set
> the pointer to the driver's IRQ handler if platform_get_irq() returns a
> valid IRQ # -- this should avoid the unnecessary WARN_ON()...

Applied, thanks.

-- 
Jens Axboe

