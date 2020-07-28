Return-Path: <SRS0=dbCU=BH=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C310FC433E8
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jul 2020 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E69A206F5
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jul 2020 15:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lUyKTfB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgG1Pvg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbgG1Pve (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2020 11:51:34 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13211C0619D2
        for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2020 08:51:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so21269990ion.0
        for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2020 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dH6pnqUmNf/i6iHZHPZfywyFLxvK6otPa1F0GV7pPjo=;
        b=lUyKTfB3WctkmeX1eVNXVJsib+4c9wLasaDqX42aNbolOJ/Db81up7EUZaq5uewE5y
         IYU3oqcYaUYZ454VgTeKMXmydqHpW3FyOYn/40dsD0ilLFMApi5T3FxPp+3rdDBh60FX
         AAuXKSKF3tYTwuqD/Gx4yfyKi94EvY5+Et/0l8HFOSUPhcTeNCKKXVZ04RennniWcntG
         BtkTCl7zFLu+lcTpQh0oNliQK/j/bKCKCakhJ6O37xgNOgI185wqYqZi4NWm8FubelAJ
         WdOnUnarGCi7BWPyCcpDKh1TIv1eHcyRwj1KpbE6KZHFT48Pl0SoKcfNqJWURzwsQoVN
         MoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dH6pnqUmNf/i6iHZHPZfywyFLxvK6otPa1F0GV7pPjo=;
        b=glttJ9MnDOtmGQdX7e87pg8oD789+XmPEYorXnn6wW8dEXrtiPJP6db5r2wsbxAcQN
         Bgvcy8wSvC5ZhUeWjIy0lgEFpe41WQqngcptm4dwhcBgSAHCV5SFoiU/Bv5B/0i+Udze
         oQtW0Zu3Lp6r6sd9wqSUO7ENruG8D4G7HwOiiQNhRCSPb+xTeSbpGs7BHk5HHPRiIpUu
         BBICxep+WsyWC/K1v663IXavedV0MwqqCC9B2YUEVbfQF5VaH/AU9U5zbmjRyHOjbEqW
         1d2pyNj0TMjUavJ3Ya6tgx7jz4hkSXnD5fWjL2oT77xzZS/ziq1A6q9TAZWLFlbmQiry
         I3eg==
X-Gm-Message-State: AOAM532Mixdpn4qXL82TcMTF2hW5mq5jRbfaSqc0ZZklEK7WiXGU6Eiw
        urEBnAa9Aa1sMrwhh73V8+ZYTA==
X-Google-Smtp-Source: ABdhPJyYLGifiiVBXQbvt/BcnUbYuXMillxP6k4q0gn80oLYD1wDMGPlzF0lDW5ajNIzGkaOI+jY1g==
X-Received: by 2002:a02:5502:: with SMTP id e2mr32643518jab.56.1595951492249;
        Tue, 28 Jul 2020 08:51:32 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j4sm10596866iog.35.2020.07.28.08.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:51:31 -0700 (PDT)
Subject: Re: [PATCH v2] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
 <20200727175119.GA700880@gmail.com>
 <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
 <20200727181144.GA543@gmail.com>
 <9718954b-2152-1bc2-e702-ebe8799fdfb3@kernel.dk>
 <20200728051742.GA198538@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8ae9a1a-ba89-497a-c539-30f3f6dac5e9@kernel.dk>
Date:   Tue, 28 Jul 2020 09:51:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728051742.GA198538@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 7/27/20 11:17 PM, Vaibhav Gupta wrote:
> On Mon, Jul 27, 2020 at 02:30:03PM -0600, Jens Axboe wrote:
>> On 7/27/20 12:11 PM, Vaibhav Gupta wrote:
>>> On Mon, Jul 27, 2020 at 11:59:05AM -0600, Jens Axboe wrote:
>>>> On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
>>>>> On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
>>>>>> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
>>> Yes, I agree. Actually with previous drivers, I was able to get help
>>> from maintainers and/or supporters for the hardware testing. Is that
>>> possible for this patch?
>>
>> It might be, you'll have to ask people to help you, very rarely do people
>> just test patches unsolicited unless they have some sort of interest in the
>> feature.
>>
>> This is all part of what it takes to get code upstream. Writing the code
>> is just a small part of it, the bigger part is usually getting it tested
>> and providing some assurance that you are willing to fix issues when/if
>> they come up.
>>
>> You might want to consider splitting up the patchset a bit - you could
>> have one patch for the generic bits, then one for each chipset. That
>> would allow you to at least get some of the work upstream, once tested.
>>
> I think I can break this patch into one commit per driver. The reason that
> all updates got into one single patch is that I made
> ata_pci_device_suspend/resume() static and exported just the
> ata_pci_device_pm_ops variable. Thus, all the driver using .suspend/.resume()
> had to be updated in a single patch.
> 
> First I will make changes in drivers/ata/libata-core.c, but won't make any
> function static. Thus, each driver can be updated in independent commits
> without breaking anything. And then in the last commit, I can hide the
> unnecessary .suspend()/.resume() callbacks. This will create patch-series of 55
> or 56 patches.
> 
> Will this approach work?

That should work, but more importantly, ensure you get some folks signed up
for testing this functionality.

-- 
Jens Axboe

