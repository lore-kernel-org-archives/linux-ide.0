Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31055C433B4
	for <linux-ide@archiver.kernel.org>; Tue,  6 Apr 2021 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD1C613A0
	for <linux-ide@archiver.kernel.org>; Tue,  6 Apr 2021 15:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbhDFP0Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbhDFP0Y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 6 Apr 2021 11:26:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80CC06174A
        for <linux-ide@vger.kernel.org>; Tue,  6 Apr 2021 08:26:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x26so3941241pfn.0
        for <linux-ide@vger.kernel.org>; Tue, 06 Apr 2021 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRIM6EM2YeerZ4khZjy1QfwvvKqUIOIDPq45/l8KzMk=;
        b=v95OkLHG9mdrpAnJFrYxrccr8IjScxsPF2QZvigNmyiWn/K38wXNOkg8SWiIEUmNzw
         DhgRZWcYj41kW5dgRpdynsWCVpxNUEP6YIe7bLnwtE7zfSmxpoexrJj6I0G84aUi55C2
         bypnk5TkSo7tPh0ULV+bo2+im9F8HFeFuBCmTSnJ7Oy96uXvUayy3NqoSuH8tP9GF9Ne
         ejts0iEbBIRoa8tL5OpS5bsI1mKPy7VgnEJYym7TVzHqODG2BYcwOWOaWbKrzm73ndsg
         mY9VkLsDLGjZ7TV19BVIuLd2lJM/hin4zvLExBEYQT+P9XzotHuhh81V2UQNk1FasNmA
         uOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRIM6EM2YeerZ4khZjy1QfwvvKqUIOIDPq45/l8KzMk=;
        b=Pm050/Fdb4xDcqRDD72qBAlAypoHJjRerqFQKcfy/yWPRfsf7tkrj0nzZEjj3nT8ce
         zs7NAzgFQXKB0gwhSKId5qMlpLrrnzuMkiK6Q8IXedfcEzPwre6ZjxxneW9z+jnLOOpU
         2eH/Jyc33p5hbaEfUeEynE8eBdU+de/g/EZ85X0WZnJ/87F7eHIpDlXGgFuY9iSmt47V
         nXqFpQWthStljUonXY2Gq4DiopCxcwXsmcs/+v/7wnfYwW/3dqt9YQUxY5iSk66MPelB
         t4ZLfXHxORfIe5K8HGN9+032urehV5k1XkS5MU3zA2iulu0eS1tvVMjpf7bR5/HIC3dV
         ejtg==
X-Gm-Message-State: AOAM533R0DNGdxBP9KOgrx7tNFfKuNCAGMWIu0MJtmTMWgZ28Qr8RQUn
        sx0x4u1yiEdluhZfTKh86HKNgg==
X-Google-Smtp-Source: ABdhPJwGk+B+hP8sPCLiqu3rd1u+Xa6OMw8qJOFaJ7FpQ87gs+NV+ZduAerbhnmSJtGUQamY0Luj1A==
X-Received: by 2002:a65:5289:: with SMTP id y9mr27154939pgp.447.1617722776213;
        Tue, 06 Apr 2021 08:26:16 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c2sm19223740pfb.121.2021.04.06.08.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:26:15 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-2-jim2101024@gmail.com>
 <20210406151604.GA25862@lpieralisi>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c72423a-f743-6feb-8387-3651a1c59d42@kernel.dk>
Date:   Tue, 6 Apr 2021 09:26:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406151604.GA25862@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/6/21 9:16 AM, Lorenzo Pieralisi wrote:
> On Fri, Mar 12, 2021 at 03:45:54PM -0500, Jim Quinlan wrote:
>> This driver may use one of two resets controllers.  Keep them in separate
>> variables to keep things simple.  The reset controller "rescal" is shared
>> between the AHCI driver and the PCIe driver for the BrcmSTB 7216 chip.  Use
>> devm_reset_control_get_optional_shared() to handle this sharing.
>>
>> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
>> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/ata/ahci_brcm.c | 46 ++++++++++++++++++++---------------------
>>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> Hi Jens,
> 
> I am happy to take this series via the PCI tree but I'd need your
> ACK on this patch, please let me know if you are OK with it.

That'd be fine:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

