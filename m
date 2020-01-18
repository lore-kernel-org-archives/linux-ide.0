Return-Path: <SRS0=kgRP=3H=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26785C33C9E
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jan 2020 00:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8083206D7
	for <linux-ide@archiver.kernel.org>; Sat, 18 Jan 2020 00:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h//ca95y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgARAOr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Jan 2020 19:14:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgARAOr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jan 2020 19:14:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so12416407pga.4
        for <linux-ide@vger.kernel.org>; Fri, 17 Jan 2020 16:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rIiAvm32XEnWHnoC4eW2jcWJDNVynX17TBKUA2iGuwU=;
        b=h//ca95yCGwVF9dI2j1jcWYQ3VZ1utPcu2hpXdMAljPJikwZ+YeoRbIu/cb4F9MY33
         buwUXxrKw7om1mxwS7xy/X0RbUFF/mvwSDWBWMxKvHlgs24mzRa1FOr0+NBJCWOnyOV2
         Y2JTJSoa0R2OXH1t9Ojg6tz24053YnBAxATcXc/qFryKO1TwLq1O+pavaHReZjpUrHuG
         CQddxSduiFQNij++HQCaE3RORcZhaIKxq9vAqQc75QGtzQOJrwGvU5+OPp0a5uaoq9lK
         0qUodEAYPJhFB7hQLwiMjZEzv0NCCrM2U2yIHCCimSZfP1NYRe2fO2DD7/SMXM3QdXNi
         VITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIiAvm32XEnWHnoC4eW2jcWJDNVynX17TBKUA2iGuwU=;
        b=jAht6zSmwAs6GA+0PM2bkj7dT96qXpX19Enmrc2IBYffY22GnbSQtQyCzwemCMGK3+
         l08/ryH0sVo07+XOSRXVueilWxuOnGNQ/f/r6kaNUhfj3vSGWgONG/Arz0VRipwHi166
         vKL7D0RFasEvAYZuaASfWegVvqcV8PCv6Mh8VARN8ksN5hVchvFhV+TYhWLJks5niO1M
         VQI196fyi0rkV/z46TdkHsyFh2rPR9Gvnz4v6WQ9UD1pB9YesEdPqJBRg0INOQUUhwZ1
         ZlvTGzIVk4QuSYfRLRYX4QWD3zbNG+YQgRRVT18tAnmvKEromE4z0fTufmnE74fNKdKY
         Irxg==
X-Gm-Message-State: APjAAAUNTbmdmBPilt7yhsu2nnVju86eMxrefS/gC5OSQcnVLSUP3Cz/
        RxGlamosP5eEsikIUhrveWqX7Q==
X-Google-Smtp-Source: APXvYqzqWBYrMw1HB+Gk+5row/Uyjq+Gu6i/XptFJ1/s9DZ0JyZM4VsGKwPDgo+z8F1YNamjT0Ippg==
X-Received: by 2002:aa7:971d:: with SMTP id a29mr5700501pfg.29.1579306486813;
        Fri, 17 Jan 2020 16:14:46 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id j2sm30294998pfi.22.2020.01.17.16.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 16:14:46 -0800 (PST)
Subject: Re: [PATCH v4 0/2] ata: ahci_brcm: Follow-up changes for BCM7216
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20200117235313.14202-1-f.fainelli@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d171e5fa-7fcd-2176-12d4-5c2286bee46e@kernel.dk>
Date:   Fri, 17 Jan 2020 17:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117235313.14202-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/17/20 4:53 PM, Florian Fainelli wrote:
> Hi Jens,
> 
> These three patches are a follow-up to my previous series titled: ata:
> ahci_brcm: Fixes and new device support.
> 
> After submitting the BCM7216 RESCAL reset driver, Philipp the reset
> controller maintained indicated that the reset line should be self
> de-asserting and so reset_control_reset() should be used instead.
> 
> These three patches update the driver in that regard. It would be great if
> you could apply those and get them queued up for 5.6 since they are
> directly related to the previous series.

Thanks, applied.

-- 
Jens Axboe

