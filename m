Return-Path: <SRS0=88f8=2B=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19459C00454
	for <linux-ide@archiver.kernel.org>; Wed, 11 Dec 2019 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E324A208C3
	for <linux-ide@archiver.kernel.org>; Wed, 11 Dec 2019 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alFWGGfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfLKNbK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:31:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727477AbfLKNbK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 11 Dec 2019 08:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576071068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TV5FAi/Fe1/Rw5238yLkedzxccC6tTFgA5QXvsNOUGA=;
        b=alFWGGfvlADzo/3ukXISRXAmEq7ecAi3O9P14VMqmsGLdyAQTAt7OiWsgdgXw8YdEgjiIc
        FSBGQj8zay/L6mSoE4FIQ/UUGnv2Z2oJ2xoItZlbuZ5pMTGufY688yEKze593SU9PPvXa2
        ta7jknTVZ9cMz5gCHoqYB2y2+xXQgh8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-sfwMdCEMO5WOgeT7tfc6fg-1; Wed, 11 Dec 2019 08:31:05 -0500
Received: by mail-wm1-f72.google.com with SMTP id l13so2377184wmj.8
        for <linux-ide@vger.kernel.org>; Wed, 11 Dec 2019 05:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TV5FAi/Fe1/Rw5238yLkedzxccC6tTFgA5QXvsNOUGA=;
        b=F2Be2JZhatm/0mn9+7ivFB9o/lkPphU/DKQ6YVQVMjs8tDkwjAA1o+onfzf63yr0ND
         RKz3U0luudUZFXd819Xn42ec00s1+cMAT69UzcC2X+5N6VmGlQElUvR+FsuskNSr0upB
         2rBCytIRtcl0Zcg6W2ticsgNVCct8fytNl1d7xVKCgSAykZaZhbckiLFYdFwywL/d+Ut
         rkjljBavVhMdiJconnBQ+8ZoG1e3u3kABh8hd11jJ2Qz7VoqV41MWoI6jzCrO7BM7tD2
         PMkq1sksJn9Y39+wbof5BQOtHilgnMOCzbH5bT0Iv17jQ/lhlHm8nmZgT3KeDuHSwtbV
         NYIA==
X-Gm-Message-State: APjAAAW5Nguww1TTBtuGfyy2hxW7gPTT638D+341EgcHww+i65msyiNE
        nEj/hQRd7KxWjENNGX1w9SbDNi0E6JAfYrabsypH2HmZ69nwjQb34fRu2xtGPjXWRC0MHsgIG3t
        SjzguadC3EMzbiuFjYZQf
X-Received: by 2002:a1c:5451:: with SMTP id p17mr3617120wmi.57.1576071064469;
        Wed, 11 Dec 2019 05:31:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqymrCgLwNxNOpQF3dxf3OYmi9fdNcxPA2z09i7pimQR443NM/SqTB9zsjyB+GkU7qbeqV3iXA==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr3617098wmi.57.1576071064298;
        Wed, 11 Dec 2019 05:31:04 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id i5sm2281274wml.31.2019.12.11.05.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 05:31:03 -0800 (PST)
Subject: Re: [PATCH 0/8] ata: ahci_brcm: Fixes and new device support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b65b61a6-3cc7-1e9b-9fa7-83f314e9bbf2@redhat.com>
Date:   Wed, 11 Dec 2019 14:31:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
Content-Language: en-US
X-MC-Unique: sfwMdCEMO5WOgeT7tfc6fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

On 10-12-2019 19:53, Florian Fainelli wrote:
> Hi Jens,
> 
> The first 4 patches are fixes and should ideally be queued up/picked up
> by stable. The last 4 patches add support for BCM7216 which is one of
> our latest devices supported by this driver.
> 
> Patch #2 does a few things, but it was pretty badly broken before and it
> is hard not to fix all call sites (probe, suspend, resume) in one shot.
> 
> Please let me know if you have any comments.
> 
> Thanks!

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> Florian Fainelli (8):
>    ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
>    ata: ahci_brcm: Fix AHCI resources management
>    ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE
>    ata: ahci_brcm: Add missing clock management during recovery
>    ata: ahci_brcm: Manage reset line during suspend/resume
>    ata: ahci_brcm: Add a shutdown callback
>    dt-bindings: ata: Document BCM7216 AHCI controller compatible
>    ata: ahci_brcm: Support BCM7216 reset controller name
> 
>   .../bindings/ata/brcm,sata-brcm.txt           |   7 +
>   drivers/ata/ahci_brcm.c                       | 167 ++++++++++++++----
>   drivers/ata/libahci_platform.c                |   6 +-
>   include/linux/ahci_platform.h                 |   2 +
>   4 files changed, 141 insertions(+), 41 deletions(-)
> 

