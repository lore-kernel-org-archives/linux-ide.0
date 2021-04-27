Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45927C43460
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 08:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F528600D1
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 08:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhD0IMn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Apr 2021 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhD0IMm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Apr 2021 04:12:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A561C061756;
        Tue, 27 Apr 2021 01:11:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d15so15955655ljo.12;
        Tue, 27 Apr 2021 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RgSnRCCB0oWiFs/rtIr8SFKxBQ6FoIGyq2ye1qyRRhI=;
        b=QauDzMQAQTlryaZUvpR/GoI2mcmGwFCy2eQW2fN1O1JHTMNTJowKHMO8xz3wkIYshN
         8nzeSEIYZ+qAikz8/mqgXyfs7vMfEffh07+wSxafRBd5Ogq21nGbpcRM7bwhXbH/rpsC
         qm64gBAo4GeOhP4t2Hi6OlhS+EVzfSzk5IfVSj9MGXVfMDbYtHcr21l7IXafsfBz7B8W
         t+uSD+aKhjFUc0yT4xpcun/mjSO13AIvksLaQD/Xsz9QqsoHKReqK7UWDViI8KBHlXCX
         r2ErV4y5n9FgRcIrnnN+kYnLc+37BFtmGJfl8mi2ZO5eum/bAsllf4fD1TbMfN0rR9kc
         cd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RgSnRCCB0oWiFs/rtIr8SFKxBQ6FoIGyq2ye1qyRRhI=;
        b=T9Ip16ig+iZ0pioM5KZ5FlmgsjHgc5fgoypfjo4I1nMKe0ItBWojGgzl8zkUO44CIl
         QIo5dfpfz2+0Vye3E3OqLT13gyCF/CeV5EvhgHagZdwsJEjMC3j1YQLPdehIojQ72WxO
         Erj9eK2+RRgTmlEhWRQ5f47sFKpsOiEMgFsqrafOqDgbZukDOHLvaL4VwdC1/1gNOniZ
         mOedCGeY0UMk5cKLPrKz2jop4nrFwJ0D9Hbw+lwO2f4XJSIXJ/r5rL0i8R+7Dlk45lSv
         RhSTwiHyH4c3hb5UTw0nKw6HcQGeqKsBQtQKMUW5ptO/RaI3MQbf+xrhG6ErriU98KaW
         TOTg==
X-Gm-Message-State: AOAM532GlP2nZonWPHZN0zqG6Eq/W2G2CtxxDd3VGJV3aCHQ68EDjmcO
        D035UnzdgGNpUk116FcoeW1EJQnZpLw=
X-Google-Smtp-Source: ABdhPJz+020pec5DE+Einn89O0r3qDi8hxGFWTJEOsfoujaGfzVS2fJzjlCK4wMiTS3p081CiqteKw==
X-Received: by 2002:a2e:b8d2:: with SMTP id s18mr15587741ljp.148.1619511116760;
        Tue, 27 Apr 2021 01:11:56 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.82.40])
        by smtp.gmail.com with ESMTPSA id r14sm1656734lfi.198.2021.04.27.01.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 01:11:56 -0700 (PDT)
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@fastmail.com.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
 <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
 <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
 <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <dbd5ddaa-c0ee-5aad-20d9-7fae5e2618af@gmail.com>
Date:   Tue, 27 Apr 2021 11:11:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 27.04.2021 4:51, Michael Schmitz wrote:

>> Was macide the only IDE driver in Debian/m68k kernels without a libata
>> alternative? If so, this patch would allow you to finally drop CONFIG_IDE.
>>
> There's still q40ide.c (ISA IDE interface, byte-swapped, so would need 
> treatment similar to Falcon IDE). Hasn't been updated to a platform device yet.

    ISA drivers shouldn't be "updated" to the platform drivers. But I don't 
see 'struct isa_driver' there either...

> Cheers,
> 
>      Michael

MBR, Sergei
