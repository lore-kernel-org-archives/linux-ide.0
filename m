Return-Path: <SRS0=THTS=5Z=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E48DC2BB86
	for <linux-ide@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ECD20784
	for <linux-ide@archiver.kernel.org>; Thu,  9 Apr 2020 15:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OIR5ZNUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDIPcK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:32:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37948 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgDIPcH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2020 11:32:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so4273950pfo.5
        for <linux-ide@vger.kernel.org>; Thu, 09 Apr 2020 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gUkBJIwjL6c1i80rJw/jRyY4YU7YY837/BAt+IGwYg0=;
        b=OIR5ZNUF36cxDqFK9L+J5igMg8ZCS7m3/g4zeqjdYhRCeED7eVs3NHmmSI0EdjJgkB
         rVNodL3o4YQpEV5p9c+mzXvSh0dnUETR9FiY4QJwBHc4p2Jv65GZuAcH/NrZHHmIojXF
         ZcvTFfvROV0g1qXiPsqRvXx78jZiikIpG5enR4tYVPtoYr7WVRjKkIFHNxnjg3gO6M40
         J0OwHXdpxEFXEFjifMLdXoTdTVXKmjQ3VxXyxOj2GShkyPELSof8sSxhUeuTUtZfv6Va
         B0lT1seoHucYiXeEGlqivmxbGZP5nrK7uBduc81YznOIb56eU7WT4edzfOh+akOOF6V7
         Sb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gUkBJIwjL6c1i80rJw/jRyY4YU7YY837/BAt+IGwYg0=;
        b=RjQuOa4auMOlSiVijjggoOaWJFyqr56ecfJgfn+d9JIRgFqieJOVkQP0QNrnBbRZKj
         9hbdCaN8Wgg1ceVEZZbT2008wrXek6QM1eMyI4jpW7Dyqhj/FLGOEE3FLoFGjxC3HXKA
         24U3vSJyp2R8Qv/lceK32c33/doB6PzFqnopuOR+zyyXIww3wRoZtdLzMzcpr8MtEnf6
         nkLYpilMY5CjtS9rOSp3o6Sz5fMB37pyhLArp9ZmHDgBSgcXAnwqgi8LLrNMWO1d+IZV
         8sIC4ZxHEfiTO/Q/9vVaByIWtSw+WyAmxoiXsMQ/g0CrOVmkJWAHfrwgDBToVmb81cJ+
         wlfg==
X-Gm-Message-State: AGi0PuYlQggI86+FxEI4+gNEyz7Avcr2BXTk8nVVpQ90YfXPaBmiq1uz
        dEMiSeKiei+KITSAQWaF0QlNdclw2yBJkQ==
X-Google-Smtp-Source: APiQypKNlZ14U/uT0xMe60gkPySojlMSCRNf1ct5gzQHU5iSCR/MVLk9gSTb62on9UaJm0iLABTgAQ==
X-Received: by 2002:a63:1705:: with SMTP id x5mr51086pgl.12.1586446326856;
        Thu, 09 Apr 2020 08:32:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:70f8:a8e1:daca:d677? ([2605:e000:100e:8c61:70f8:a8e1:daca:d677])
        by smtp.gmail.com with ESMTPSA id y18sm4525174pfe.82.2020.04.09.08.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:32:06 -0700 (PDT)
Subject: Re: [PATCH] ahci: Add Intel Comet Lake PCH RAID PCI ID
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux@endlessm.com
References: <20191128081041.6948-1-jian-hong@endlessm.com>
 <EF580FD3-2C0F-4268-8B39-8B339D590353@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86bd45f8-8868-0ec9-b5f6-19dc1a528b57@kernel.dk>
Date:   Thu, 9 Apr 2020 08:32:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <EF580FD3-2C0F-4268-8B39-8B339D590353@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/9/20 2:16 AM, Kai-Heng Feng wrote:
> Hi Jens,
> 
>> On Nov 28, 2019, at 16:10, Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>>
>> Intel Comet Lake should use the default LPM policy for mobile chipsets.
>> So, add the PCI ID to the driver list of supported devices.
>>
>> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> 
> Would it be possible to also merge this patch?
> We also have some system that use this controller.

Added, thanks.

-- 
Jens Axboe

