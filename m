Return-Path: <SRS0=wlKU=WC=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE3EC31E40
	for <linux-ide@archiver.kernel.org>; Tue,  6 Aug 2019 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705C7208C3
	for <linux-ide@archiver.kernel.org>; Tue,  6 Aug 2019 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tiSelzTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfHFNpU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:45:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45814 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFNpU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 6 Aug 2019 09:45:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so41610368pgp.12
        for <linux-ide@vger.kernel.org>; Tue, 06 Aug 2019 06:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQh9z74ag+GmRjLxDeaQAgLw1V8J9pK1FZmm6doK+q0=;
        b=tiSelzTk8mWTlpoVBYaXILHfHlswQ+XRiZj0Grsrvlq2dZ9vBXV6QYwMDfzYVxWxdX
         T/sAQpQ6cK5tDefmfWEBYxAC/XqM2IHN8J6B3osQqPeIsIOSf1w0RDjhyB56jsKtkfoZ
         Fdtm+r1y+/dlnUJI2I55JepBmMRpkBWhpSu2oyibbNLC88OAlXtrwqZMDwzlVnWxkQRa
         V0AJnSAoOhb2vsOYj5ZpBaeMt0OfK8rJ2ohVGatcnnFvSHs+bpYWCHrtDGpBiAaMQ3+Q
         dTjxOBFj8mJxSbAUSTePGKwVfocf9LonuuN0vZI0+HgsW1qTC4jBA7NDLadzOF74BHdF
         g7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQh9z74ag+GmRjLxDeaQAgLw1V8J9pK1FZmm6doK+q0=;
        b=EpKc0gGgf4Y+UqlHhlE9BH1skcn2ejPRXFjHaRN8yuWjE57Iv1vavyurerc8hgTT9s
         A07JvGP5qNM63BATNZ0GDUkSeIVz4zU5fJiAcOLYbXlEX+RP1s8g/usO6O88MFKWDRFT
         LN5W/4jLVYiz8eH+2r6NO3go+kzyFp+6n6Ea8OjX7A//xWAHksZYVw4N7ogoVdlghVMm
         nhoqP4FxnhJTUkDDDZXe41NwFYP4XmTavhvtOEm0kchQxkYzXMhaWxZY3UUd3amKKJJw
         Qu0YSdWspuaFyZhN7kV9cUazl2BIJkJbPb25mBxZ7AAKseDIB2eXJ0cZV71ndXqYVVEF
         /glw==
X-Gm-Message-State: APjAAAXa/aItpVGQE3X1WpYEt37TOcVfBAVLk3Ll2R9zG72/inQgmr5d
        AvMwG6NQwrWz44409bPPrZ/8PMCGLF272A==
X-Google-Smtp-Source: APXvYqzq54EhLaujd1/sIZml45bFnQlidzBA9hT0AAdIzhGvcT8uYyfa+uY4esbkhztXp9A71Qs9fQ==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr3284927pju.63.1565099119117;
        Tue, 06 Aug 2019 06:45:19 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:5cfb:b4eb:1062:5bea? ([2605:e000:100e:83a1:5cfb:b4eb:1062:5bea])
        by smtp.gmail.com with ESMTPSA id a3sm22023266pje.3.2019.08.06.06.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:45:18 -0700 (PDT)
Subject: Re: [PATCH] ata: rb532_cf: Fix unused variable warning in
 rb532_pata_driver_probe
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190806080808.GA30026@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a80a74ae-ab49-7f58-a4f3-8bd3b3012716@kernel.dk>
Date:   Tue, 6 Aug 2019 06:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806080808.GA30026@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 8/6/19 1:08 AM, Gustavo A. R. Silva wrote:
> Fix the following warning (Building: rb532_defconfig mips):
> 
> drivers/ata/pata_rb532_cf.c: In function ‘rb532_pata_driver_remove’:
> drivers/ata/pata_rb532_cf.c:161:24: warning: unused variable ‘info’ [-Wunused-variable]
>    struct rb532_cf_info *info = ah->private_data;
>                          ^~~~

Applied, thanks.

-- 
Jens Axboe

