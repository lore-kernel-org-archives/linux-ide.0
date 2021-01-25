Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FAEC4321A
	for <linux-ide@archiver.kernel.org>; Tue, 26 Jan 2021 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4045F22D04
	for <linux-ide@archiver.kernel.org>; Tue, 26 Jan 2021 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbhAZGCK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:02:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbhAYNRG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2021 08:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611580538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk+cDfpXiHs1Bh3TfFQZWkcbmPZsVlpZuvJJS/EQ6Po=;
        b=i6hbh4mMS4PU+aIxz46QU1p07dlBkJj9MUqdJLwJss1h6a+OO0RVLSa+rZUP8IoyCH894Y
        MFDDegHdw/tYd16Rzt63Woz8LCiavakVbCvKAeoMzSnqxwVHVT7dq6ckyP6DXlI6U5Szm8
        zSss/TImBbRHKUMofw0kxnjLOuxWAi0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-N8zEnbyZOSKRkl2ujBVJtA-1; Mon, 25 Jan 2021 08:15:36 -0500
X-MC-Unique: N8zEnbyZOSKRkl2ujBVJtA-1
Received: by mail-ej1-f71.google.com with SMTP id ox17so3738769ejb.2
        for <linux-ide@vger.kernel.org>; Mon, 25 Jan 2021 05:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zk+cDfpXiHs1Bh3TfFQZWkcbmPZsVlpZuvJJS/EQ6Po=;
        b=lU32PTfYaExX/Kvx03XlV7Qz9uHu5bO5LVlPyrfu7QqHfPnJZcl6GNpixLAAlyvL+Q
         PMoBYNEoyIn4G98B+QZ85ZpodfZCqoPOgP0euhnc84ugzE+nDZMNVoCDMRTH3NPBAqI0
         RWHJ/QsLjFwI4bloFVlL/mAvd0ju9RD5Nn9HAoZvMOjnfS8511bAU9JJ0FjLL8UdVYlT
         fCPBlxaUSIi8XphAwl683qwIdva63iyH7n4pK/ZHRWCC4oZB9JftPHWoOHA6/tftr0hc
         m4Xu0Mbcr/Ye+R1y8iT87DrOQgC3DZCs7PXfuOw4bvIU60NtoVMjeY/U++xDMx+LCS7A
         9AlQ==
X-Gm-Message-State: AOAM530fxNNXshdXsCJXHXeVNdhG9y10KtrjdIn591IzmMpDNW0Mn3bP
        XDiqduPTSZTNuVffNOksMgdNFCCaiWYjSRgTz4mWqax9rOBRDCAlVRGQ83itzORFAU64vIqLZTp
        TrhS8j+fXkiwkVGFNOi0N
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr354519ejb.208.1611580535373;
        Mon, 25 Jan 2021 05:15:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvQdimcsf4hmIorymsHFeWn5I8TSKTGJ63eSmv/qM83Gr9092hZygNLpR0RqnI3yHtfgV5tQ==
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr354504ejb.208.1611580535234;
        Mon, 25 Jan 2021 05:15:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id bc6sm10636598edb.52.2021.01.25.05.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 05:15:34 -0800 (PST)
Subject: Re: 5.11 new lockdep warning related to led-class code (also may
 involve ata / piix controller)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Dan Murphy <dmurphy@ti.com>,
        linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b204637d-3b72-8320-8a62-f075467d8681@redhat.com>
 <20210112223015.GB28214@duo.ucw.cz>
 <f344f1db-1a7a-0a80-1cb1-f9c3fbf83abd@redhat.com>
Message-ID: <0ec34bca-f7e0-8954-c253-d07ed6b71b80@redhat.com>
Date:   Mon, 25 Jan 2021 14:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f344f1db-1a7a-0a80-1cb1-f9c3fbf83abd@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 1/13/21 9:59 AM, Hans de Goede wrote:
> Hi,
> 
> On 1/12/21 11:30 PM, Pavel Machek wrote:
>> Hi!
>>
>>> Booting a 5.11-rc2 kernel with lockdep enabled inside a virtualbox vm (which still
>>> emulates good old piix ATA controllers) I get the below lockdep splat early on during boot:
>>>
>>> This seems to be led-class related but also seems to have a (P)ATA
>>> part to it. To the best of my knowledge this is a new problem in
>>> 5.11 .
>>
>> This is on my for-next branch:
>>
>> commit 9a5ad5c5b2d25508996f10ee6b428d5df91d9160 (HEAD -> for-next, origin/for-next)
>>
>>     leds: trigger: fix potential deadlock with libata
>>     
>>     We have the following potential deadlock condition:
>>     
>>      ========================================================
>>      WARNING: possible irq lock inversion dependency detected
>>      5.10.0-rc2+ #25 Not tainted
>>      --------------------------------------------------------
>>      swapper/3/0 just changed the state of lock:
>>      ffff8880063bd618 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x27/0x200
>>      but this lock took another, HARDIRQ-READ-unsafe lock in the past:
>>       (&trig->leddev_list_lock){.+.?}-{2:2}
>>
>> If I'm not mistaken, that should fix your issue.
> 
> I can confirm that this fixes things, thanks.
> 
> I assume that this will be part of some future 5.11 fixes pull-req?

This *regression* fix seems to still have not landed in 5.11-rc5, can
we please get this on its way to Linus ?

Regards,

Hans

