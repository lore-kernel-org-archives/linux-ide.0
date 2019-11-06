Return-Path: <SRS0=8Rmv=Y6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5ABC47E49
	for <linux-ide@archiver.kernel.org>; Wed,  6 Nov 2019 01:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6433421D81
	for <linux-ide@archiver.kernel.org>; Wed,  6 Nov 2019 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMAeMa/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfKFBfP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 20:35:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34372 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfKFBfO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 20:35:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id e4so15983150pgs.1;
        Tue, 05 Nov 2019 17:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Va53YaJwr5fuhLyJEHNLbuBdoLhLlMbp6buyORKUk9o=;
        b=BMAeMa/KXWCvoOJWuWd/aC4ecTUiZ7Siblc0LywCjpdGxa7G8FecZM283BN3oqcRar
         1wEiauCf4LoyJ3z17DCiPtDzMEBbRNYm4Pu/wLbt4GkLh7KcR25fbEJJxdlWUUp/dxtK
         sTqfI5+sgMKGEOHR6Q/dD2zRyEL2XgMq5MV5qteIDI73KRirReShE+MBbOZ7YUQez0sk
         6ZFnRFyFYpYaR4+Y4X8ls+pZbtiXs2S8HBNRpXeGjTgn/0QVvHpYiQlxsR14PXk1YbHY
         HixIhP9HlhxzU6YBpWs+BlsH2W+S1d0KMSr/T2TLcph30IrBxtDJfKFXjygi4jDpOUv+
         tj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Va53YaJwr5fuhLyJEHNLbuBdoLhLlMbp6buyORKUk9o=;
        b=A3fsJnegtZrVxtzs2xPxx+c1218T9eGKpLvIBtBgs/NVWSkxmCohtwl12XRdS295Xu
         kNw2dmIGdXw0Sj9ERpo2m9aQ2Y6f7U9XBUbD4FDQ7MbiC7+J2lahnN+3Ij3jJY3oy376
         6rURB1yKWJ6jBoYlSWxVSyCMA8FFbXfm9mpaenlL4R5uVcMbpw1Plkd3tMO9z1Y2lndF
         otEe/e38iX3bmGKDuMjbNlg0GJ1BPNr2TBXvTVm2mvpPaSNPlHc4zvXMAdRL6pxnBFsN
         3/avRnxuUktXiMwH4dIUZqbGYoKx8VpE48WN48xFM3n0kaWoD9iOQqrSStmaBSFU0w8T
         Po5w==
X-Gm-Message-State: APjAAAUCq58ncbY47XyuJkCgsF79VkMNaLfcnmLsc5WjuSHvxCfgwIii
        lr6XxDNOUEn0W57gviNKImi+1d6N
X-Google-Smtp-Source: APXvYqzg8QHS/EhBTKlQaXYmVAjYnz3JnQjIQ1efgT/trMoHyr1+I4EcQKcvmAo2IlJfCc4wgeVt6g==
X-Received: by 2002:a17:90a:fa84:: with SMTP id cu4mr131330pjb.65.1573004114335;
        Tue, 05 Nov 2019 17:35:14 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:8d0b:8375:2a32:c157? ([2001:df0:0:200c:8d0b:8375:2a32:c157])
        by smtp.gmail.com with ESMTPSA id x2sm24027871pfj.90.2019.11.05.17.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 17:35:13 -0800 (PST)
Subject: Re: [PATCH] ide: falconide: convert to platform driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Schmitz <schmitz@debian.org>
References: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
 <1572935872-28394-1-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXM+h_GsbkSvyfpLJ0DJixmr-wOS_d5qQrZ8e7VY_bbPg@mail.gmail.com>
 <CAOmrzkKLosq7LdXS6BuvHSARPXCXPiasW1zGywY3+hoys4NxoA@mail.gmail.com>
 <CAMuHMdVBpMJ6E9N1=YG6VPNJifexdbM9=PWAkjyLwdz9b5n0YQ@mail.gmail.com>
 <CAOmrzk+-FD63N88MTE6993V8-Z96vXpAcB7yd33fftcj3ZebbA@mail.gmail.com>
 <CAOmrzkJ+tmEnYu4tz1Fvs8XJK2W_n9JWcFa7vpNLNy=SX2Yh1w@mail.gmail.com>
 <CAMuHMdU_HHw7i9gP1yC8w4BLDo9php6+_FXBsmL8Zr-+hvCptA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d8f897c8-9786-c6da-f589-c7ba2cb055b2@gmail.com>
Date:   Wed, 6 Nov 2019 14:35:09 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU_HHw7i9gP1yC8w4BLDo9php6+_FXBsmL8Zr-+hvCptA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

thanks for confirming, I'll send a merged version shortly.

Cheers,

     Michael

On 6/11/19 10:43 AM, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Tue, Nov 5, 2019 at 10:13 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>> On Wed, Nov 6, 2019 at 7:46 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>> Shall I merge this one with part one of the old series so there's no
>>>>> chance of a bisection going wrong?
>>>> Yes please.
>>>> Thanks!
>>> Thanks, I'll send a new version shortly.
>> Just confirming - the changes to pata_falcon.c will remain as a
>> separate patch which should be applied together with the patch that
>> will introduce the new platform device, and rewrite the legacy driver
>> to use it. That would require Bartlomiej and you to coordinate
>> closely.
> Bartlomiej already acked both patches, so they can go in through the m68k
> tree.
>
> To avoid bisection regressions, both patches should be merged into a
> single patch...
>
>> If that's too onerous, I can merge the lot and you just ack the m68k
>> bits? Please let me know what you'd prefer.
> ... and with the falconide.c conversion, all three patches should be merged
> into a single patch.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
