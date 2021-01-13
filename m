Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308FC433E0
	for <linux-ide@archiver.kernel.org>; Wed, 13 Jan 2021 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FFA2339F
	for <linux-ide@archiver.kernel.org>; Wed, 13 Jan 2021 09:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbhAMJBP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727322AbhAMJBO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jan 2021 04:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610528389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuTRToQJZ9ENJOQ+foe03ejm+/o+GM2tw6NDRHaUP34=;
        b=QWIxqVRNOHU26/O3wlg5A1RK6A20t381oBJ25QdbdKIIfjufu31jmqL44qOhZ5Hgek88oc
        OVpDYmuPsHfFfRGw329E2onaIzZQtylSvKViFDMrmmwR5oQnPVEqflRQOFE94+f/r15ecm
        Lb4YKILZpCLSxmrXEugf11MylDxFEEM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-hSdZR5l6P5yAq7YIVAjFQw-1; Wed, 13 Jan 2021 03:59:46 -0500
X-MC-Unique: hSdZR5l6P5yAq7YIVAjFQw-1
Received: by mail-ej1-f70.google.com with SMTP id k3so623580ejr.16
        for <linux-ide@vger.kernel.org>; Wed, 13 Jan 2021 00:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QuTRToQJZ9ENJOQ+foe03ejm+/o+GM2tw6NDRHaUP34=;
        b=hQg+sgnkRq0jAXZMleq9R5eLIxl8iyx2gBqZ+UhN0aRNI74qG5SN3+y4f6wnuMQJy7
         4WmK4R613/NAquN3IwMBKBWTEWgo0Ichx7YX8wUZeNJ2bCZL12zub5Mb5Ws5CQZZLvGs
         GThilQGq6lvJe/C8hWhJY1RbkDwwo8nkg25sOJ4jIVkJM3u+Uxyhqm4EBij2HilDVpnc
         srhOWo/xF8XnM2Ss2QIyqbCtl5l3lNye3LpeGoZEisq2iBiu7hA7pDwW4cOFT7DKMrjO
         rf49PU//WgF0U+bkr/DUWlgUNn4h3xbJb8nWb/SyENvLWjY8svxgJJkFyID1cfqwdYQ6
         /NSw==
X-Gm-Message-State: AOAM532g57a7K5XX1P2L4558CzZAI1Htq2+xaJYlBuHcKqVJTsptEq4G
        xujJIl9cdH+kt2wOR1rjsplRdBGAVxbVoUMzOC6Ih936JMPArhIKJLvOokSWNPBzRvhjSdHc6ft
        9meCX6Tyrl/9CeKZ/2i7Z
X-Received: by 2002:a17:906:adce:: with SMTP id lb14mr825179ejb.502.1610528385587;
        Wed, 13 Jan 2021 00:59:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFa+J3n+6YPkg6zlbrlGTjqx+UvGVawy0I7OSetvR0OSlaqpYHVx5JIy3LcDri33K59tFgZQ==
X-Received: by 2002:a17:906:adce:: with SMTP id lb14mr825165ejb.502.1610528385451;
        Wed, 13 Jan 2021 00:59:45 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id ga11sm441697ejb.34.2021.01.13.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:59:44 -0800 (PST)
Subject: Re: 5.11 new lockdep warning related to led-class code (also may
 involve ata / piix controller)
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Dan Murphy <dmurphy@ti.com>,
        linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b204637d-3b72-8320-8a62-f075467d8681@redhat.com>
 <20210112223015.GB28214@duo.ucw.cz>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f344f1db-1a7a-0a80-1cb1-f9c3fbf83abd@redhat.com>
Date:   Wed, 13 Jan 2021 09:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112223015.GB28214@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 1/12/21 11:30 PM, Pavel Machek wrote:
> Hi!
> 
>> Booting a 5.11-rc2 kernel with lockdep enabled inside a virtualbox vm (which still
>> emulates good old piix ATA controllers) I get the below lockdep splat early on during boot:
>>
>> This seems to be led-class related but also seems to have a (P)ATA
>> part to it. To the best of my knowledge this is a new problem in
>> 5.11 .
> 
> This is on my for-next branch:
> 
> commit 9a5ad5c5b2d25508996f10ee6b428d5df91d9160 (HEAD -> for-next, origin/for-next)
> 
>     leds: trigger: fix potential deadlock with libata
>     
>     We have the following potential deadlock condition:
>     
>      ========================================================
>      WARNING: possible irq lock inversion dependency detected
>      5.10.0-rc2+ #25 Not tainted
>      --------------------------------------------------------
>      swapper/3/0 just changed the state of lock:
>      ffff8880063bd618 (&host->lock){-...}-{2:2}, at: ata_bmdma_interrupt+0x27/0x200
>      but this lock took another, HARDIRQ-READ-unsafe lock in the past:
>       (&trig->leddev_list_lock){.+.?}-{2:2}
> 
> If I'm not mistaken, that should fix your issue.

I can confirm that this fixes things, thanks.

I assume that this will be part of some future 5.11 fixes pull-req?

Regards,

Hans

