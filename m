Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E1CCA9ED3
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 19:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBA320869
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tw/rxGJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfKDTR6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:17:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37832 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDTR6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 14:17:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id z24so7469558pgu.4;
        Mon, 04 Nov 2019 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4O8YMN5ooZdkIVqxGyRMSpMDnc3iab7us+VWPOF5/XU=;
        b=tw/rxGJkW3IviiAF2NtBDLFqS5V9t1Eoi11TRDrm8JziOTBQH7rwaeECkvdTHpYGvu
         BGa934MH2zi7ZYpn2R6251TdVjTawjLRUquuiWggL4PWSIvaX3lP0w/+DEaRQiGS9Dwx
         47YOvminm3OBIGuRkc6N78QAzetjgZm5NRjoDB9dBo8+qMhrYwhVFdwVVZ6GgaV2tXKP
         Fdu239qVK6e89p7hsD5ZyjPqRvRMmjuzA0nfat/oDZsycL2k0dS4jITKWafI9v2eR2uX
         YAh58P25WL8w8wRmCy4r7Sq5dQhB5viLukzq0sKNHocDQ/R04uO8a4FQ6UsbtDo3ELwm
         KwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4O8YMN5ooZdkIVqxGyRMSpMDnc3iab7us+VWPOF5/XU=;
        b=LEIdhU9/x+pCd/MkiNQ1XO3ki0dAvqmb6rQm1DrJOSSTKqZjlUVsNFALe32ak18RYr
         tMPr7bbEgbIvkvYFNMkUwYyKLeziUuUHbp7G+YLTnRhZs6w2S9T6HWL3eMUp/pBkuOe8
         jbuv8ZFIjjP0lGhjMViOUboxl2TRUOHthka3ajrr+eEnDR0zstOOAyAYOOBpq71jO9Av
         SxMff5HtkeT45YGZORY5IJpBV0BubBGwfBkYFq2nR5QWcIY3Ggy9XMTgH14E7fDvjmEs
         X53vSMzn79o6aKHm0QCRlGNXRXDebBDWuqmz8i+Hh3o2xauYC1iG/wdHseySw6wg2L3j
         xAcA==
X-Gm-Message-State: APjAAAVZJKKh4jNuUCAlrABp+qX9Asnzo280Se02V9kd4IXKXxF17zRs
        MquG9ROqRmyD6Z9PySLPcJy7HXsq
X-Google-Smtp-Source: APXvYqzwBySsEAGPpM5tE7qz54eopZOT2nDtE7N4z+OXqEeOJFOakTtHivT7zU44xBKfROTvEA0NCQ==
X-Received: by 2002:a63:6fca:: with SMTP id k193mr8806997pgc.363.1572895075827;
        Mon, 04 Nov 2019 11:17:55 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:9888:8ef6:cb36:21e0? ([2001:df0:0:200c:9888:8ef6:cb36:21e0])
        by smtp.gmail.com with ESMTPSA id w62sm18505851pfb.15.2019.11.04.11.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:17:55 -0800 (PST)
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform
 device
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
 <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
 <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
 <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <db487366-b0d7-d65d-70b5-261aa439298b@gmail.com>
Date:   Tue, 5 Nov 2019 08:17:49 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

On 5/11/19 12:04 AM, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Mon, Oct 28, 2019 at 8:03 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 27.10.2019 um 07:17 schrieb Geert Uytterhoeven:
>>>> Who's going to pick this one up? I can do it, but it'd be nice to have
>>>> m68k on patch 1 first.
>>> Sorry for the late reply.  I'll have a closer look after ELC-E, and will apply
>>> to the m68k tree if it passes.
>>>
>>> BTW, I believe v1 of both patches has been acked by Bartlomiej?
>> Correct - on July 3rd. I totally forgot about that, and didn't add his
>> Acked-by in v2, sorry.
> OK.
>
> I was about to queue the combined patch, until I realized the defconfigs
> default to falconide, which is broken by patch 1/2.
> My proposed solution for that is:
>    1. Switch the defconfigs from falconide to pata_falcon,

Ack.

>    2. Remove the legacy falconide driver.

Nack - I still use that one (because pata_falcon has no support for 
using interrupts with the Falcon IDE interface, and I'm unsure how much 
more kernel bloat libata will add). Need to check the impact of 
switching to pata_falcon first.

Cheers,

     Michael

>
> Does that sound OK? Thanks!
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
