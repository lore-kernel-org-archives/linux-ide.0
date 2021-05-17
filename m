Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C9CC433ED
	for <linux-ide@archiver.kernel.org>; Mon, 17 May 2021 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9AD60FD9
	for <linux-ide@archiver.kernel.org>; Mon, 17 May 2021 16:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbhEQQa3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 May 2021 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237432AbhEQQaO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2021 12:30:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F628C06F8FE
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 08:12:52 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n40so6165144ioz.4
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2021 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZ+LvNcX8+Or88RW/0Dfplt7pikZ1wCTDEjghzqPEZ8=;
        b=K2J2W3C4HbMLjxlvPzM1QiNsJLahHuJe8YdR2mF7GL0nWi8UHdBv0RiYmdfsqO/VO6
         KLhaYi+hDPMrMrN263aMpp2H+GCUA3/QLoKJKwYsdft1bd38WoIDVxCbnoN3yX8j8WRn
         6z8o/el1jO9vE+8ulBjUF06nD8rM0sbtJCywVoieStO+9gwr1aoOoTD1jtFwFM887U3v
         MCtQ8F4xK9mszYoYf/1KtkH2/FuC/qw9uaoxQD6AcPubiYIwk6/R+rU3g4zIrIX1V7w2
         wHwzsJpEOVhqTTh6xXOgkmJPjnyIQzAdz6t3uW5WXFGPpMI/8lEe4SJFJ5fTC9M1zS0B
         wkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZ+LvNcX8+Or88RW/0Dfplt7pikZ1wCTDEjghzqPEZ8=;
        b=aff3Zak+Q3uO/N22Ded5cz+xJV7DPrBpZdNdbLoNs2NjMjUtaeTjENt/z3R9k2U5Jg
         laSdksa+Mk37X8X550m98jxm5X5N3CXqSHmgLKZ62RzZIDFmR5iUT2u1dh1dLn5qEmsw
         YkCZWekTMPlR5JCAr/0smXdVJqcdycDM+1QWgkEJNL0pfitxqaFQdV0AaO2R1u+X/4ZA
         r6yTzxlOVijq2sCsx9d+fxUpyrJUWk6IA3QrSDMfe1ncpsh0BOGdB+O3jvcclN2cV383
         uXKr/Ud15O3vkYHnb9faefx4XQl+o9y3HwNEUPzzVIJD15vNWV2NbK8LO0N25rX4owUq
         nIBg==
X-Gm-Message-State: AOAM533OlCWf1OZohGmBR4FPoifmFzqnBtIXE1WSsEMeuojw2+YiMWQw
        04Y8WrfGuVUrIY8aM99EEhHfuS913wLKUw==
X-Google-Smtp-Source: ABdhPJz/Zw0XvQ4/YBBjvLCDDiorNsUt9dwWLfLU2FAoH2fChUvY2NPH5ZwhXsBv9PvaoogNoEn/5Q==
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr374041ioj.53.1621264371797;
        Mon, 17 May 2021 08:12:51 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r5sm2921807ilb.1.2021.05.17.08.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:12:51 -0700 (PDT)
Subject: Re: [PATCH] sata: fsl: fix DPRINTK format string
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210514213402.691436-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <309095e5-6b12-6517-2370-737aae33f012@kernel.dk>
Date:   Mon, 17 May 2021 09:12:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210514213402.691436-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/14/21 3:33 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Printing an __iomem pointer as %x produces a warning:
> 
> drivers/ata/sata_fsl.c: In function 'fsl_sata_set_irq_coalescing':
> drivers/ata/sata_fsl.c:316:17: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'void *' [-Werror=format=]
>   316 |         DPRINTK("ICC register status: (hcr base: 0x%x) = 0x%x\n",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   317 |                         hcr_base, ioread32(hcr_base + ICC));
>       |                         ~~~~~~~~
>       |                         |
>       |                         void *
> 
> It's not clear why that pointer should be printed here, but if we do,
> then using %p is the way to avoid the warnings.

Applied, thanks.

-- 
Jens Axboe

