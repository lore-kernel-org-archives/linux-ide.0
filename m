Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F00AC48BE8
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4506115C
	for <linux-ide@archiver.kernel.org>; Wed, 16 Jun 2021 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhFPOy2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbhFPOy1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 10:54:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C5C06175F
        for <linux-ide@vger.kernel.org>; Wed, 16 Jun 2021 07:52:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b14so3269089iow.13
        for <linux-ide@vger.kernel.org>; Wed, 16 Jun 2021 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ho0nMLLWDiEI8PWRRnO12oSgVwkuBUrJL0BDNxvINsA=;
        b=hoREoaRWaUrQikoDfDACdirEoAtNi+fOmNy3ydxCJMLyS1AYVOlkcC6i6q2ACi7hoR
         YdvK7zt01zFnWIoInOM4K4wHv15MobleKQ1Md6yZJgidSl5oEj8UBm6vgBx5+levT+bF
         gqF6j+MUp/6RnngHTAeIvJzipUGYH5hjKD1VuO/9eya66IdaHMbpo/KgDZ3DVaHvErqA
         B3qi1ZmurpgN6d4R5YCa0cXu/kDnuxtw+1LeEfjQcxRp6ZbVEoBzspOFJuy/TVVDm65t
         V0QVWPMfUuOXT+50eXThDDyewiClZ1fYk3Xwe/r2yV0gFF5zxhb9twIsyab3WIZv3KyY
         DAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ho0nMLLWDiEI8PWRRnO12oSgVwkuBUrJL0BDNxvINsA=;
        b=iX9Jss+DJN70WDVairt0FrULbxsl1KCWoysnjTeNcBId9+FCb8jfBp5lUERLGNhE7w
         0pJy7X7o4dzqKYCHksB7sngnMrkior8iy3769Ct26Rb5ErXmG8fPyNW/2EyAXizgukuq
         NkPBPJCUurUddAtNeQjL9OEDyISzdYJiby9rWFpspVEeO+k5TNrOWORAZAR2rLOy99Hm
         zkg9W4lTNTFxmCF2q8+Rn7k8FJJZxVe+3OAuaHSVCTXRhHAibicPGVWxyOVh+3IosKOP
         DlXSSGEBH2PcgYKd4Q6H9GIzPl+efo880+fJyocoD3p1cmifh9m7KVEyKFK7pCKS5wpw
         re/Q==
X-Gm-Message-State: AOAM5333q4ttNcfzt9sX/U5jiUwRVIIvO+p1yVfYpbqMW9ZZPedEwYw7
        iEnymk7YfZWmH627OVXJ2CnT4A==
X-Google-Smtp-Source: ABdhPJwRYyaHR20NfmOGxiiM9sMUCdWhA1YbxXGNbJVFB3qF4ZclbwduUBkSVJG7m8JN/4680wB/fg==
X-Received: by 2002:a5d:91ca:: with SMTP id k10mr292660ior.23.1623855140114;
        Wed, 16 Jun 2021 07:52:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h200sm1298166iof.6.2021.06.16.07.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:52:19 -0700 (PDT)
Subject: Re: remove the legacy ide driver v2
To:     Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
References: <20210616134658.1471835-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b003372-41d0-507a-b74b-b73aa33189f4@kernel.dk>
Date:   Wed, 16 Jun 2021 08:52:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/16/21 7:46 AM, Christoph Hellwig wrote:
> Hi all,
> 
> we've been trying to get rid of the legacy ide driver for a while now,
> and finally scheduled a removal for 2021, which is three month old now.
> 
> In general distros and most defconfigs have switched to libata long ago,
> but there are a few exceptions.  This series first switches over all
> remaining defconfigs to use libata and then removes the legacy ide
> driver.
> 
> libata mostly covers all hardware supported by the legacy ide driver.
> There are three mips drivers that are not supported, but the linux-mips
> list could not identify any users of those.  There also are two m68k
> drivers that do not have libata equivalents, which might or might not
> have users, so we'll need some input and possibly help from the m68k
> community here.
> 
> This series is against Jens' for-5.14/libata branch.

Unless someone complains loudly, I plan on queueing this up end this
week.

-- 
Jens Axboe

