Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94839C433DB
	for <linux-ide@archiver.kernel.org>; Thu, 21 Jan 2021 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADD5239D1
	for <linux-ide@archiver.kernel.org>; Thu, 21 Jan 2021 20:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbhAUUsV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbhAUUsQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2021 15:48:16 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66102C06174A;
        Thu, 21 Jan 2021 12:47:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g3so1988986plp.2;
        Thu, 21 Jan 2021 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ELInXzZ8TUNTAEej3drCLWmZEdzDmk8Uo5iybhZjGao=;
        b=vHaK+CWc4FOZ/kNe0O/IZNq9yw29fH+NxREotadYV1JNSgdz6wK16XJXlSbizorJDn
         N8mZljdnEYxfZb8CFKjefuuyUb90v35A2CRrebI3iLY76q7lO3NGp5+v6gm7EPkX0tl9
         hyDuNXSEduFml9z74kru9YbM6Pe1WMhRHFAvSyDF3GRvl1QzxO4BCmAmUT2CxBotg95k
         IkIz5m11SGBtftNddCoJgOJ8TaDT3OZpRjpL8FsdX4Bt5KqZ4KAGmm1ZrXRD5XNX2PMc
         l4BHLjhfkhe8cK4CKXE0f5NDOkA8YD0FidBjvioPNGopCWAZTiVI3/QKi3sImt/U/2vI
         0WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ELInXzZ8TUNTAEej3drCLWmZEdzDmk8Uo5iybhZjGao=;
        b=fi6C8zi1UHOqZ/3OhHYfaTJY101qXi6wD/+QyjOsP/zM52qjoeVpvP6hil6hIICv2l
         vMTaPX6tQJ7AHIL6mSNCMfnST8UCME2n9LyzOgInJ0ZUSBwRS7PXPMNo81G7/dZI4fEM
         gx6udxq8fy3jqScDVuHXZF0YadBzD9KoUMxCLOB6wr5eM+Ta2LdUp6QAi4rd2AjSeyJL
         WFZp6aaw1uBC1Cm2H93nLRYSOEFkGxcxYH0gvEvYG1LrjOxgqcvKxKsCi13s0kiUeYib
         /Y50FL3d2TAZHNBt5lUhX8sR2v7CV75B8tlzek0VFk7er3/gR+jF97lrtkwKq44YgqSW
         JWGw==
X-Gm-Message-State: AOAM5325QKkVcgfqCsViChsyWML2YD0R6CHxsLjZCZ6mRQYTALrW7mNX
        LD24Lz/i9bgdSfxxwVrzSDbEW6eod8E=
X-Google-Smtp-Source: ABdhPJyjsdFeLHVJHwq5y1JgXapjXbM770ZwENnHCMpH6PDrGPswomhz8Dbfjqep5tUiMlu/5e8SVg==
X-Received: by 2002:a17:902:e750:b029:de:8c17:fd64 with SMTP id p16-20020a170902e750b02900de8c17fd64mr1136847plf.54.1611262053535;
        Thu, 21 Jan 2021 12:47:33 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c189sm6611473pfb.175.2021.01.21.12.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 12:47:32 -0800 (PST)
Subject: Re: [PATCH] ata: ahci_brcm: Add back regulators management
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, axboe@kernel.dk
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
References: <20201223224130.738590-1-f.fainelli@gmail.com>
 <057c3619-022f-1d79-6c9d-51f9085ea963@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1cc0cacd-7ab2-c11e-db5c-363c69991f1e@gmail.com>
Date:   Thu, 21 Jan 2021 12:47:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <057c3619-022f-1d79-6c9d-51f9085ea963@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 1/14/2021 12:46 PM, Florian Fainelli wrote:
> On 12/23/20 2:41 PM, Florian Fainelli wrote:
>> While reworking the resources management and departing from using
>> ahci_platform_enable_resources() which did not allow a proper step
>> separation like we need, we unfortunately lost the ability to control
>> AHCI regulators. This broke some Broadcom STB systems that do expect
>> regulators to be turned on to link up with attached hard drives.
>>
>> Fixes: c0cdf2ac4b5b ("ata: ahci_brcm: Fix AHCI resources management")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Jens,
>>
>> This is based on your for-next branch, let me know if you need me to
>> rebase to a different branch. Thanks!
> 
> Jens, this is a bug fix so it would be nice to get this applied at some> point. Thank you

Jens, can you apply this patch or let me know if you need me to change
something? Thanks
-- 
Florian
