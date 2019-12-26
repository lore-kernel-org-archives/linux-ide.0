Return-Path: <SRS0=/r9a=2Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3548C2D0C8
	for <linux-ide@archiver.kernel.org>; Thu, 26 Dec 2019 03:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAAD206A4
	for <linux-ide@archiver.kernel.org>; Thu, 26 Dec 2019 03:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ol/dyqSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLZDqx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Dec 2019 22:46:53 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38788 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLZDqx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Dec 2019 22:46:53 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so2899637pje.3
        for <linux-ide@vger.kernel.org>; Wed, 25 Dec 2019 19:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+2rX8FiZ4+VJzSGDQVHPdrKdTn8xC9adwnhm0Nk3gU=;
        b=Ol/dyqSpl3pnpBMw2kx4AGAZ6uqjbCPQtpxaOuG2ZnQRYknFyxWcIimPlwPM+IWE49
         iVage9dTlEUPGAbFp1WPicTRY5fCH9oD28yqSBO8x0PNC2jfvR2L0tZf9TQeTefUZGnv
         Y5ctq5E4mO20ks2Iy3hgApeCxX7VvjcCBwVizm30S0LxE2D2wx4O5jMuPTaJ07Ex8hNE
         1eguNWXejJ8VC+QtWsqSczf76neRjtV8XDdFCIwBFIqD6mMnrfF2MngICw6TjzfMHoNr
         40UYX+3Espuyo6rLH9M6vM3+o5m5WMAdaaOGko8jMonKCamhBGE+fhBHTIBtmtROk0V2
         VNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+2rX8FiZ4+VJzSGDQVHPdrKdTn8xC9adwnhm0Nk3gU=;
        b=baMb2j8rFwiswqEd546YFKxq1Cb4PpShvIPyk6Y/T2aSvwhUsx/8RMgl1ebInkVm0i
         mcFI8fchPHjLaaCOYDoxkcFsLwXwu8VmRE0fzem4TIFDjPuw64ISbsXUCDEU58iTq8bc
         99l8mNC6bwxliZhQ6NYD4CEUpgrb9x+b3pyGwZbSgHTWV+q7drHRe4XBXVWJXeW7GB5n
         MxK+TrWzlFwQpkshfPxHVuspmZ0rJrV8QDJWG61x3i5kud4h+SBTfjpf1NBeKC9Vrm6q
         X2FYYE/74tEg40Uevi0qJ/Vq4Q+poMU/cPN7rExc6paRs7fm/iIwexeHEnDs9tTCxSMn
         zNAg==
X-Gm-Message-State: APjAAAXOMJ0NIdA+yivoAtuXz+ZnWw9W1Uv/QlYJsaaX75iR+nRk+hUA
        4wA7HDLQKABDasgjsld7N/zUqw==
X-Google-Smtp-Source: APXvYqydsNjenOjLM6kedF/cfl6vBI19aFX92/NfESo95ItFi7D0XqsSIsRtl7wuZfP5IorzxcxqKQ==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr45434184plo.5.1577332012371;
        Wed, 25 Dec 2019 19:46:52 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id hg11sm8195750pjb.14.2019.12.25.19.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 19:46:51 -0800 (PST)
Subject: Re: [PATCH 0/8] ata: ahci_brcm: Fixes and new device support
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
 <b65b61a6-3cc7-1e9b-9fa7-83f314e9bbf2@redhat.com>
 <5ef8d453-84e9-72dc-3db9-6a1923d61076@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e1b21ba3-7129-17dc-86e1-2d2d68302e39@kernel.dk>
Date:   Wed, 25 Dec 2019 20:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5ef8d453-84e9-72dc-3db9-6a1923d61076@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/25/19 8:34 PM, Florian Fainelli wrote:
> 
> 
> On 12/11/2019 5:31 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 10-12-2019 19:53, Florian Fainelli wrote:
>>> Hi Jens,
>>>
>>> The first 4 patches are fixes and should ideally be queued up/picked up
>>> by stable. The last 4 patches add support for BCM7216 which is one of
>>> our latest devices supported by this driver.
>>>
>>> Patch #2 does a few things, but it was pretty badly broken before and it
>>> is hard not to fix all call sites (probe, suspend, resume) in one shot.
>>>
>>> Please let me know if you have any comments.
>>>
>>> Thanks!
>>
>> The entire series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Regards,
> 
> Thanks Hans, Jens is this good to go from your perspective?

I'll queue 1-4 up for 5.5 and mark for stable, then add 5-8 for
5.6. Thanks!

-- 
Jens Axboe

