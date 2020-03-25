Return-Path: <SRS0=f0ic=5K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0455CC1975A
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E882073E
	for <linux-ide@archiver.kernel.org>; Wed, 25 Mar 2020 16:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Er6cHZIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCYQbV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:31:21 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51055 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgCYQbV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2020 12:31:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so1261075pjb.0
        for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2020 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MVG98NBF04+aJn+MHcVlRYfaV45uhx2A6USCU0pgBxc=;
        b=Er6cHZIuT/xdcR92jbOKwq5mLujKK7jhZ/vvCqKYJm1NKvlENpT7NkX2W22wWr/jRa
         mZkO4eoiW9ydcwRxHT1ame/BhTpzVKO9Eyo3Eaa2Z1vBiBTexBVoek4MAfEtjp6NWoy1
         FtpVu4Hiavu0/xAeH/AOMTrzLn9QONt2e7r9TG8DjR55vmAS5euNIS4HpphwOcWUojkn
         cVqxGjenzfw3+kDdsUUL0BKNSqjkcyU8Db12sr+PsdEWI+igD7cJE0lUgqew91x8W2Ta
         yQ01EG0f2ZRkSx8bNILyRoNmaXTmGQzv0aEEhMMigEqn2JJlaqW/wmKUkmcxD62dypfM
         tsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MVG98NBF04+aJn+MHcVlRYfaV45uhx2A6USCU0pgBxc=;
        b=XpBQkXr+Kk9GC1d83Zi/9bINb4mm3F4CRp1HMGHgvON7Dzq1OIveBjgx9+MRAzAX2c
         T02d0JxjiYuzDJ3hntgqVJDQBTRNIWYv3W6FXJWa5rPWXcNC4Yvy4sDYwyMN4A+pHNoY
         C6jpitbCeTl8J6xdg3ZRkoomOJHPubRBYaqmF3bnKv7GTOXAWOX1ejeaB6Id0X+H65Ly
         +mjIhnGg2MMQPFsveGEnoTKd5hkf1R2j+JtEMdT1LI0fvmVEaHaNO0JHU0PTugPj5Z8J
         9A9d/1gocDHh13pbzhUmXuV7+SQoGZzUUCOS35zhBk5Yx947qCsd8lwdiEAz/uQLshHO
         A3YQ==
X-Gm-Message-State: ANhLgQ1PY7l31F01IC4hWi1oE/J6Y9h5AAB0uJKd587o+YVaHoB/jfH3
        x6lNeaMY3zv07CW6dy1B0rQQRruu0fnuIQ==
X-Google-Smtp-Source: ADFU+vva+9SVhPBlYvqwYrWPuCkCD8zbKC8rGeH+W5lXa4RXxPdQJOxDDqIh8qE9WsiN+xPBJWX4Kg==
X-Received: by 2002:a17:90a:24af:: with SMTP id i44mr3211857pje.136.1585153879217;
        Wed, 25 Mar 2020 09:31:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q43sm5018061pjc.40.2020.03.25.09.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 09:31:18 -0700 (PDT)
Subject: Re: [PATCH] sata_fsl: build fix
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
References: <CGME20200325151525eucas1p1870a02b81ef13a8e449b0dfbabd0fe81@eucas1p1.samsung.com>
 <98bf5f87-3601-efd5-57ce-58e6db308e95@samsung.com>
 <87a9e403-efd2-5464-9e8c-4d966ed1ab39@kernel.dk>
 <5e52900b-6674-4220-15e4-8156ebd98df5@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53445c8e-2395-4f5f-3760-9715f34d3fcc@kernel.dk>
Date:   Wed, 25 Mar 2020 10:31:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5e52900b-6674-4220-15e4-8156ebd98df5@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/20 10:25 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 3/25/20 4:17 PM, Jens Axboe wrote:
>> On 3/25/20 9:15 AM, Bartlomiej Zolnierkiewicz wrote:
>>> Fix incorrect DPRINTK() conversion in sata_fsl_init_controller()
>>> (dev_dbg() should be used instead of ata_port_dbg()).
>>
>> Thanks Bart, another piece of fallout. Applied.
>>
>> With the recent discussion as well, I wonder if we should just kill
>> this series entirely.
> I hate to admit it but probably yes..
> 
> It seems that the one of base concepts needs to be redesigned and
> we are at -rc7 so it is a bit too late do it now..
> 
> I've also tried to find a way to revert it partially but changes are
> inter-dependent and it doesn't seem to be easy way to do it..
> 
> Hannes?

I've killed it, we can always try again later, if we have to.

-- 
Jens Axboe

