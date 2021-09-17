Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28905C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 17 Sep 2021 13:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C92E610C7
	for <linux-ide@archiver.kernel.org>; Fri, 17 Sep 2021 13:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhIQNFQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 17 Sep 2021 09:05:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55054
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239001AbhIQNFP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2021 09:05:15 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F36B83F4B9
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2021 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631883830;
        bh=BtPQgu/JVrGaxOIwp6e1J+UI80xieldZPRf8MxNQimw=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=mu9iHW3tVQ2GZ1Md2Dh28pwlZT6rdlmSi3uIUk71H522BMARTw+BgHX1FwNVlKsld
         8CFXRNA9vSc+B0yZFihQGjOP5heDZaGcy4gvioTrePjiDySvaWQGqjJoBEjP0AYtH8
         fLyxmDVLotpPKLn7OsjQrOIW9hLqUg4Ew0AuAczirVdtO0MfOyQhXmYL9Hz6SBCl5D
         M8Y4/7nSh6lFXDsXGUi1SfcWZUcKqNU4cNjGqPBiAyKmmjMUofOHMOq0td2IphtsmA
         PE4mQsa0SV62V5dWH/JGHsxlyqps1qGhQPzyqeU7hxZ8R24qMcponYPtkBUtxdKhfQ
         GV/TWrDsXHIxg==
Received: by mail-ed1-f70.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso8992938edp.0
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2021 06:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BtPQgu/JVrGaxOIwp6e1J+UI80xieldZPRf8MxNQimw=;
        b=mKqkxxH+/DljQna8KYzu6Y6MuV2e85BNVJxlrXkBp1+C3cK090tZ9ipRIprg5tvvqJ
         xNah0yxoyigQwJgg5UPU+G3zCNnOFu+SEGi5ZWZkKun6tzPV7AeePs0/QDTHqcLVcJEF
         XS/VHv7jgsS0qY/i/9SfL8WyjtyKT7rwvmZJZvHpuqlvQMgo621c+YUFx05Lg3m81IMh
         LWNV0tkHj0Ys1TDdjO+HS/uAaq6qWG4cQdLtTrKdMKjM9JZqmf//n59r0d5Xdzthx1dX
         mcVO7AiMMORCDfYFvuhcE1AtpKkd8JTZPx//RxhzAW97lqjZjFkPOkgsKyd3kSk44+nJ
         GhPg==
X-Gm-Message-State: AOAM5301MeUyv2IVvSHp849ATw2wyY8EUZkMpwr0o7++ylseQvBC8nQV
        OCm/rO490Pq2g4HbiUgVF/GSYJNrO50a87BigbC+ys26zViBP9Y/OnzcswvtxREUyTMmFu5izFj
        HcxWBFf95R9J7tgTYUA161udBa/limLPyWFgTeA==
X-Received: by 2002:a17:907:8693:: with SMTP id qa19mr11652896ejc.497.1631883829966;
        Fri, 17 Sep 2021 06:03:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb9h8Q/Swzmu6LP3OJVFY5jF/ihVwDVg7z0XJ3AD8ulIfVhJIwCXH2O+TEtyHUlKtGsmSq0Q==
X-Received: by 2002:a17:907:8693:: with SMTP id qa19mr11652719ejc.497.1631883827947;
        Fri, 17 Sep 2021 06:03:47 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id e21sm2619082edj.47.2021.09.17.06.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 06:03:47 -0700 (PDT)
Subject: Re: [PATCH] ahci: remove duplicated PCI device IDs
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandra Yates <alexandra.yates@linux.intel.com>,
        Shaohua Li <shaohua.li@intel.com>
References: <20210917102442.24818-1-krzysztof.kozlowski@canonical.com>
 <dbfab8de-487d-a5ea-6397-7e16c5eb5185@opensource.wdc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <649b7c3b-0e01-0d26-ed03-c5ac66e32bce@canonical.com>
Date:   Fri, 17 Sep 2021 15:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <dbfab8de-487d-a5ea-6397-7e16c5eb5185@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 17/09/2021 13:21, Damien Le Moal wrote:
> On 2021/09/17 19:24, Krzysztof Kozlowski wrote:
>> Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
>> as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
>> has board_ahci_nosntf (for ICH8).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> Not tested.
> 
> I cannot test this either. I do not have this hardware. No chance of getting
> this tested by someone ?
> 
> Changes for 0x2823, 0x2826 and 0x2827 seem OK, but 0x2822 is weird.
> Since it is replicated, I think that the second entry was in fact never used as
> the first one would be a hit before the second. So shouldn't we keep the first
> entry with board_ahci_nosntf and remove the second one with board_ahci ?

The second 0x2822 entry was added by Alexandra Yates
<alexandra.yates@linux.intel.com>.

However first entry was added with much bigger explanation by Shaohua Li
<shaohua.li@intel.com>, where he/she tested it.

Indeed it points to using board_ahci_nosntf.

Best regards,
Krzysztof
