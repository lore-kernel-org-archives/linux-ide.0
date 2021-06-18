Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F99C49361
	for <linux-ide@archiver.kernel.org>; Fri, 18 Jun 2021 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DF61351
	for <linux-ide@archiver.kernel.org>; Fri, 18 Jun 2021 14:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhFROlG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhFROlG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jun 2021 10:41:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F329C061767
        for <linux-ide@vger.kernel.org>; Fri, 18 Jun 2021 07:38:56 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so9891459otu.6
        for <linux-ide@vger.kernel.org>; Fri, 18 Jun 2021 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T9YZ9nd9UJQBiMGTA8SwSx9fF/IkYT4ggh3TTtYGORU=;
        b=ELMedzfqm5gGYiZMpebilxyhIz30HP+7MOrFhLWMfRM7CNAGCIQMGLIobxyzi2vTvr
         aj3eqq2G0rINF61dtcVNMqxlKrb2V4BxLPEmPZiRqvpDoudbV/EgJiamQGWpXpxflQmO
         ND3tV4XYaw4ZeFHRCzpd+EOeGFKQC2rJD985zQdcFF3mqvI4ET4kgMto7ucO5bfXIzvY
         /cBGMYPqdnkSCTr4+YLVPB0A5rpI9N5gZtGLbFQa1CNCzSRtYfXQmZ4FMBc/itdFoj/X
         Z09tQjkcsSNNkxC1pLW0oyfttF9xqvdh30nPpapcASD+YC/vcdSisam+uu+KYMjXS1oZ
         jueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T9YZ9nd9UJQBiMGTA8SwSx9fF/IkYT4ggh3TTtYGORU=;
        b=CRIIU+Se/sVTUUdk/8Swd4oNE+jvvzwZK5DIBJa8N104UfB4JPDzI8W3V6q0Y7/+5m
         Du/5rJ5h4Ss3PEoAlY4QQAebMHlsxciOhR5WMPaVisO9gEw5vwFmEuBf+xr3tk/2/Iod
         DaTP+DDR6A7MXhx2lekhfyU0no3FQvuUYHKnLTqi5ZdcOHf46jOcoz63vz089vOTRApW
         85ZRA0vIdLsdF1FJ2RdUDXrYIG5tlah2XOGaieKA8pqZKJP5BOxvr3hdyPVMqVmat6Yt
         ConATXPV9xILstuBywxpLQ8Py+ap1RmOgBGZOPYHKQwRWSxx35mWr6RUb7ILSBlJqyjW
         Fj1g==
X-Gm-Message-State: AOAM533uR4NTEteP0STBy4s1VF2TEkqYQuJ2XX9FqWNtdqeV7sck1GZO
        1yZMwzjWlzgbTTyi8U6cyTPXmA==
X-Google-Smtp-Source: ABdhPJzHAmLUNJckmU3abFOD9WQomHPPF2qlw1+78hJMYelf0T+g8MkjAjpQ3BD9i4JwVNNbP4pUfw==
X-Received: by 2002:a9d:426:: with SMTP id 35mr9427857otc.162.1624027135675;
        Fri, 18 Jun 2021 07:38:55 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l2sm2126772otl.27.2021.06.18.07.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:38:55 -0700 (PDT)
Subject: Re: remove the legacy ide driver v2
From:   Jens Axboe <axboe@kernel.dk>
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
 <4b003372-41d0-507a-b74b-b73aa33189f4@kernel.dk>
Message-ID: <57488a7b-02fa-3b3a-6719-81ab8dd64b53@kernel.dk>
Date:   Fri, 18 Jun 2021 08:38:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b003372-41d0-507a-b74b-b73aa33189f4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/16/21 8:52 AM, Jens Axboe wrote:
> On 6/16/21 7:46 AM, Christoph Hellwig wrote:
>> Hi all,
>>
>> we've been trying to get rid of the legacy ide driver for a while now,
>> and finally scheduled a removal for 2021, which is three month old now.
>>
>> In general distros and most defconfigs have switched to libata long ago,
>> but there are a few exceptions.  This series first switches over all
>> remaining defconfigs to use libata and then removes the legacy ide
>> driver.
>>
>> libata mostly covers all hardware supported by the legacy ide driver.
>> There are three mips drivers that are not supported, but the linux-mips
>> list could not identify any users of those.  There also are two m68k
>> drivers that do not have libata equivalents, which might or might not
>> have users, so we'll need some input and possibly help from the m68k
>> community here.
>>
>> This series is against Jens' for-5.14/libata branch.
> 
> Unless someone complains loudly, I plan on queueing this up end this
> week.

This has now been applied for 5.14, thanks.

-- 
Jens Axboe

