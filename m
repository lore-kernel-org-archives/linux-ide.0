Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84868C48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6515361009
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhFIVrB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:47:01 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:42525 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFIVrB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 17:47:01 -0400
Received: by mail-pg1-f172.google.com with SMTP id i34so14405222pgl.9;
        Wed, 09 Jun 2021 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LltumwB9HXKxeFjP0PiPwdPikNmJ5u6XaJ30/LPQJBo=;
        b=SlaZ2BU2bPP8kb6YBFnStkV7f0ahs3Y54w5jkX8+rRjcP/KhX2OFYH64GTsw+1anda
         Yxj5LpwGJ+I4jMw605AbA88SyCAYKMx2hrAkKg6yitbL7hLyKqmoZwW/8b4Z4fWWKt+E
         psx3UI/fSyY05dSVS8kqthLWOg+XOJ9OhmsSRJLywWkBcvbaL65T65mrlYMAsL1yIKBT
         rpH5fohDKaMR6e8uhcBAfK2wK56Qk6gKbjVDSx7xKUstWfTsCUZj9sKx2Rx0YTdLkcjI
         smbFuL2OQEdOvXESkH9HHtmdzJyJdzsWzA1gyg8UzoP+Jd7hT6QUJ76UONO0MF2f1Ycw
         COAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LltumwB9HXKxeFjP0PiPwdPikNmJ5u6XaJ30/LPQJBo=;
        b=saiTvmefFdkYwDtzr+BdX9nk6b6meWmXMRTEkyoxqOZt5FeJdcY7iMzAW5ifTpjpfD
         oPnANZRxFvOA3UXkh4s8VFDWadJimnMCTR95jmrLkODazf0o4/aSY6SgsAyTkQI6dDez
         sKe9aVTcDvTOpAxFKS3OXldP7816UAHQvwMgnACjrZY2PPqj4crF3W3fe31C1HqQxcUf
         VsGdEYfsRisqA8DN4BYcfJ3PFgxgV8CZC9ByKDPu5UGSFn0ZYraha0fea016Gc8npKEa
         ks0QakK4TnecK9IySOsLYFOC0GZip+NDy7hyAKWfGTp9K5B4wgRdknLY8/kLgfDwfJqP
         fAAw==
X-Gm-Message-State: AOAM5325H4sCKFzUhWG8r7jEBxTB4mBt6gLn3u7WmmZ1cDHYx9Br85Qo
        vDufoWUFQ7uxuSWhOvRjOqhAea/tEah/1w==
X-Google-Smtp-Source: ABdhPJw/ylTjXixF3q0npDXP7HxBFAU6zAgW5jz8612w4pBJsUM50ewU5IvWfx0WOt+jcYnddKgZ5g==
X-Received: by 2002:a62:380b:0:b029:2e9:9eb1:ba71 with SMTP id f11-20020a62380b0000b02902e99eb1ba71mr1808217pfa.80.1623275046038;
        Wed, 09 Jun 2021 14:44:06 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:459f:1243:2a64:9384? ([2001:df0:0:200c:459f:1243:2a64:9384])
        by smtp.gmail.com with ESMTPSA id l70sm639535pgd.20.2021.06.09.14.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:44:05 -0700 (PDT)
Subject: Re: [PATCH v2] m68k: io_mm.h: conditionalize ISA address translation
 on Atari
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        linux-ide@vger.kernel.org, fthain@linux-m68k.org
References: <1622957313-321-1-git-send-email-schmitzmic@gmail.com>
 <1623223322-4242-1-git-send-email-schmitzmic@gmail.com>
 <874ke71nd2.fsf@igel.home>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <759c4642-ac9f-690e-83e1-c825b1c9fd25@gmail.com>
Date:   Thu, 10 Jun 2021 09:43:58 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <874ke71nd2.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Andreas,

On 9/06/21 7:57 pm, Andreas Schwab wrote:
> On Jun 09 2021, Michael Schmitz wrote:
>
>> @@ -135,10 +139,13 @@ static inline u8 __iomem *isa_itb(unsigned long addr)
>>       case ISA_TYPE_AG: return (u8 __iomem *)AG_ISA_IO_B(addr);
>>   #endif
>>   #ifdef CONFIG_ATARI_ROM_ISA
>> -    case ISA_TYPE_ENEC: return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +    case ISA_TYPE_ENEC:
>> +	if (addr < 1024)
>> +		return (u8 __iomem *)ENEC_ISA_IO_B(addr);
>> +	break; /* not ROM port? fallback below! */
>>   #endif
>> -    default: return NULL; /* avoid warnings, just in case */
>>       }
>> +    return (u8 __iomem *)(addr); /* avoid warnings, just in case */
> I don't think the comment still fits here.

True - I'll remove it.

Cheers,

     Michael


>
> Andreas.
>
