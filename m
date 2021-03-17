Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7FCC433E6
	for <linux-ide@archiver.kernel.org>; Wed, 17 Mar 2021 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940B564F80
	for <linux-ide@archiver.kernel.org>; Wed, 17 Mar 2021 15:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhCQPso (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 17 Mar 2021 11:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232470AbhCQPsK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 17 Mar 2021 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615995874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iPq/z/5s93exettJBQ0E7OqZ74IyFIfYkYXttCd5A4I=;
        b=YJDsQkFdmeRuxwtgqtJYl+iQJP8GU1d+FBVxCB9ctDqekeia1HLCG0G8YQAOuzWGKMyekD
        V19nK6HWfrVBzOvLAvs7QljtJ4PbM8SUAkJJXWN4sX5T35gHG+r0/ITxlDD0+ub7JLuM1n
        2U41GhvyzlWciqcP3nxxeU8zkmt5XWg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-HkBC6ViDNQyrizrWoyt1vQ-1; Wed, 17 Mar 2021 11:02:14 -0400
X-MC-Unique: HkBC6ViDNQyrizrWoyt1vQ-1
Received: by mail-ed1-f72.google.com with SMTP id i19so19612135edy.18
        for <linux-ide@vger.kernel.org>; Wed, 17 Mar 2021 08:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iPq/z/5s93exettJBQ0E7OqZ74IyFIfYkYXttCd5A4I=;
        b=NEWf0lltModJlexMBPDdUC7vhn7isD3TAZDU4MBzQ9Efmzw9J+Wgbz7A1o/XnESq45
         qMowrwBxURWo48LsTgj04O3OTSWeFTn8it+wj6A8TZ/XpehcG8jNO3/XgA8voUXHbc3l
         YA3HoVpuQ/vo/x6ouSxIj//I++jIvffxRIuaHSXFMsnXKEaKkomCHrdHNOdpl3kJD9xv
         bvnv8aTJjq4giozsDHIKWkMJsaMrIw2EO7fxkCHz7GG1naOaVAxeRTjrNM8ZpasOzzk3
         2lXACX0ntpARl4ueMU77iCUb1kZOhOzeritXe4jRdSrMDny2fPGVpphOiMbUPnY8u+Wj
         XLLw==
X-Gm-Message-State: AOAM533/xqezd5sPAbDwngwR72mJWJ150VMYynwbyFR8FwdF2qFnJpLK
        rJBmagC16qovqhqBgw3UwrQVj8fD/gAJEF4Z+I+nmyvuFzlzLePIJqOAZkpOPipG2bw8eVI+4p/
        4c/FlMsMpHBPS1gTtas4k0w92huHxYV55KrHLl5ec9ctbTIgZuMZL2saf4e1WHf107PW90Fcr
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34755183ejx.386.1615993333404;
        Wed, 17 Mar 2021 08:02:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQOWxYb9DN6Byzwidr3K3+h7DNGVqQ1iESvq0wrLG4Q+s+bR01GCCD8HQlPCDgUoZNePvlQA==
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34754705ejx.386.1615993328232;
        Wed, 17 Mar 2021 08:02:08 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lu26sm11531097ejb.33.2021.03.17.08.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:02:07 -0700 (PDT)
Subject: Re: AHCI SATA Runtime PM
To:     Alexander Monakov <amonakov@ispras.ru>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org
References: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f74cdf09-c08f-5cff-e046-2729aeb703be@redhat.com>
Date:   Wed, 17 Mar 2021 16:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.13.2103041814050.15170@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 3/4/21 4:34 PM, Alexander Monakov wrote:
> Hello, Hans, Linux PM folks,
> 
> I'm looking for clarification regarding this patch discussion:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/20180420101834.15783-2-0v3rdr0n3@gmail.com/
> 
> Hans said,
> 
>> Ah, so the AHCI code has runtime pm enabled by default (so there
>> is another pm_runtime_allow() somewhere, but then disables it for
>> unused ports to make hotpluging something into those ports work.
> 
> I have a laptop where two unused AHCI SATA controllers are present (but
> obviously nothing can be hotplugged into them). Apparently due to the above,
> they do not enter runtime autosuspend.
> 
> The problem is, these "ATA port" nodes don't seem to participate in udev
> hierarchy, so it's unclear how I'm supposed to automatically re-enable
> runtime PM for them. For PCI device nodes, I have
> 
> ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"
> 
> but ata1/uevent is empty, so there's no obvious way to write the corresponding
> UDev rule.

You can enable runtime-pm from udev using the following rule:

ACTION=="add", SUBSYSTEM=="ata_port", ATTR{../../power/control}="auto"

> Prior to discovering the above patch discussion, I have filed a bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=211837
> 
> Does the above correctly reflect how AHCI PM is supposed to be?

This is a complicated question, I just checked and according to:
https://www.intel.com/content/www/us/en/io/serial-ata/serial-ata-ahci-spec-rev1-3-1.html

AHCI 1.3 compliant controllers should raise a PME signal on hotplug
changes even when in D3. So perhaps the solution is to catch this signal
and then wakeup the controller; and remove the pm_runtime_forbid(dev); call
from ata_tport_add().

I don't have much experience with dealing with the PME stuff, so you will
need to do some research there, or perhaps someone else can help?

This seems to be more of a sata/ahci question then a generic linux-pm question
though, so I have added Jebns and linux-ide to the To / Cc.

> If so, what is
> the proper way to enable runtime PM for unused ATA ports?

Regards,

Hans

