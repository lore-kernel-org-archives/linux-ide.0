Return-Path: <SRS0=Eprx=45=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60949C10DCE
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336652067C
	for <linux-ide@archiver.kernel.org>; Thu, 12 Mar 2020 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kNrCAc8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCLPH7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:07:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35441 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgCLPH7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2020 11:07:59 -0400
Received: by mail-io1-f66.google.com with SMTP id h8so6031643iob.2
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2020 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KtQaH9KXOQlJHeG5o9weoEGCTXOh3L9hHlBarSlajOk=;
        b=kNrCAc8ogR9Xq83wOSFtS9Gq2pfebSz+cYuSC4Ye60Lefx0uRuoOcl/dYVwcBpzZ0c
         ARwd529wlJ4OAZRHnKvs3cQ56OqfH8ofKhgoQQK7uBPySkWCy8psJGh/SMRpsFc8463P
         leVBXiyv36xEUQibsfSd0QFOAAQCAcr1ZIQ/v/jd5p7wLU2embDdyB95bMgQm/NnAImK
         teXHnEXM9TVBX+uDOGmig1M9EwkAkRAZvB3Vrsjntrdp2BFaRw/QJGangAPJI4UTWt5S
         EvEKhCDq/evAhKbe+ZFS/Yb66oEJKKyau8qvF/pkLISopbglSfRLFDbtxXCx56+IYZF1
         RJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KtQaH9KXOQlJHeG5o9weoEGCTXOh3L9hHlBarSlajOk=;
        b=Hf71Lzhc6Z5f/qFIrjmA1W3m61b8/esYf5mwCSJFetYWnNGjjZOIYQi0cduLHSIYY4
         Veh+rX65yUJ+JRDLyoaTDyvYvPvCuBlKNCmW4AWhfpg0lElRJYOgi/osxQJcl8qTNGrI
         wDLpY5LFZ7GA4AlSIZck6LWZmW7zHWYl/zLUkjX2IGFxVBOSDq0L1OfmkX+gyjA8Cfwe
         ufHjL+vyIWTi4kFifEfgj3A9DwXUlZou8P6sWUut7vu0VJXA9YAesw9MbjPO+EBqibH7
         gSjy52pd7Ym9UpIufCL0+R+iIPLwOsOsyfYqJoum0MVFUCct8a8kMVCoQ7QHfBis+1Vq
         5l+Q==
X-Gm-Message-State: ANhLgQ13CNxCjI2bMvjBRqz1yKk6y3KKBoEdY6UlZWhPSDlYld0JO+yS
        AAVy6BZ3P3pZMgLxia9MW39slA==
X-Google-Smtp-Source: ADFU+vt2eeLCKlnEFuWg0tw6jEX0u/SFCCC7I/YAeIqtH0SU1YeBU8kvHxUWeqdcM5K/gwOz3IjzSg==
X-Received: by 2002:a02:8801:: with SMTP id r1mr8190913jai.50.1584025679011;
        Thu, 12 Mar 2020 08:07:59 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h14sm10246024iow.23.2020.03.12.08.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 08:07:58 -0700 (PDT)
Subject: Re: [PATCH v2] libata: Assign OF node to the SCSI device
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-ide@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20200222112057.31476-1-linus.walleij@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ae878c8-a4ed-4aee-68bf-806463f31e37@kernel.dk>
Date:   Thu, 12 Mar 2020 09:07:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200222112057.31476-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/22/20 4:20 AM, Linus Walleij wrote:
> When we spawn a SCSI device from an ATA device in libata-scsi
> the SCSI device had no relation to the device tree.
> 
> The DT binding allows us to define port nodes under a
> PATA (IDE) or SATA host controller, so we can have proper device
> nodes for these devices.
> 
> If OF is enabled, walk the children of the host controller node
> to see if there is a valid device tree node to assign. The reg
> is used to match to ID 0 for the master device and ID 1 for the
> slave device.
> 
> The corresponding device tree bindings have been accepted by
> the device tree maintainers.

Applied, thanks.

-- 
Jens Axboe

