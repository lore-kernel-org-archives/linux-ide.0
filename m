Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D59C48BE8
	for <linux-ide@archiver.kernel.org>; Thu, 17 Jun 2021 01:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDB8613D5
	for <linux-ide@archiver.kernel.org>; Thu, 17 Jun 2021 01:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhFQBMN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Jun 2021 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFQBMN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2021 21:12:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3EC061574;
        Wed, 16 Jun 2021 18:10:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z26so3625803pfj.5;
        Wed, 16 Jun 2021 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5CFAnD2pFgTapSI0IuW8VVi8leOVL2PTk0MVDgV8WjU=;
        b=O26FgXo6QsfESEQaT+Ndre/bXFjpQ2RZWUKz+u8cQZzwjiQWxdngXyvcAaix15xtCo
         OpQmyaRTNPrmqLqsAo3iJDv/tEPVkhV/6E63Uqg3Rg6Mm3KRwp3Dhu+2Nv1v8o1BuJki
         kEDE86fVgv23R33I/pBStn+1ogOLSsZ/pYCluShIduWfcKJd4QGma26TGaVLoJBrd27T
         ach4MGapeEqonG2wa4N3Usrsf1+wb2xdWTZ2lGQ6mmqmt7NGB7Hdpqaf9ZNhvxruBvxx
         Yo9qPOS6jBGHIlch9IdzluHyQQRjiv7GQac76CH5/Mg7hqwiJXR8qs8m31miS6CRTfNO
         ZBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5CFAnD2pFgTapSI0IuW8VVi8leOVL2PTk0MVDgV8WjU=;
        b=DEjT+HPXpkcDNvjqqiqvS45g/KQfRTjntebv0jW+Ifv6upQtALyzHi5buE2eM5pp3F
         z4NpfJgCeGnh3fsorfxJoDWSJVexfZyjZEpkkG6/zY1T/SNOX4T4j2QnX8yuHKwROFEo
         uZoc64iVo8359Lg6FoaXbWDwecPpmNrf7QomiO6RhQYlElQd01UcLV8S2nl/pBgn9PXG
         CFZ4+zeWQ846YACUnvD2y3TPRj2AVwQcf1MTh2O9S6sWx1B7Ac2jwP9mwYoqsESuBLlf
         txb+52d83yM1bMcmSJRRSFwZOBWmiLRwUF5RN2R+TIa8hihWrhuQXpooZtqs3AgFtoA9
         XGAQ==
X-Gm-Message-State: AOAM531kILO8558cL+FRWb0uV2Y66pOmPL1Q7zd7rkGBVbs0wKIV/BqE
        fjLfULrVaM5gMQXuNESphI8=
X-Google-Smtp-Source: ABdhPJzPC3QiD7aZcmcAleSzjXkZaSMB7vcYTXvwvU7oVODneGdRAO+OXUeWPQVIIe/IyulRcACb2w==
X-Received: by 2002:a63:a44:: with SMTP id z4mr2349161pgk.379.1623892206137;
        Wed, 16 Jun 2021 18:10:06 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9d12:c2c8:273e:6ffd? ([2001:df0:0:200c:9d12:c2c8:273e:6ffd])
        by smtp.gmail.com with ESMTPSA id r10sm3603660pga.48.2021.06.16.18.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 18:10:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add APNE PCMCIA 100 Mbit support
To:     ALeX Kazik <alex@kazik.de>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
References: <1623224214-4836-1-git-send-email-schmitzmic@gmail.com>
 <1623290953-18000-1-git-send-email-schmitzmic@gmail.com>
 <CAFFuhJpT+2h+4O_q15VjE_77iCQaxwLJC11siSFrr5GbjQ-pFw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <904176c2-810f-0573-998f-31b55e617448@gmail.com>
Date:   Thu, 17 Jun 2021 13:10:00 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFFuhJpT+2h+4O_q15VjE_77iCQaxwLJC11siSFrr5GbjQ-pFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Alex,

Thanks for testing!

On 17/06/21 9:11 am, ALeX Kazik wrote:
> Hi,
>
> I've tested the patches and they work.
>
> At first I got it only to work with the following line removed/commented out:
>    if (apne_100_mbit)
> And thus enabling the following line always.
>
> I've changed, with the help of Michael, the parameters to:
>
>    static u32 apne_100_mbit = 0;
>    module_param_named(100_mbit, apne_100_mbit, uint, 0644);
>    MODULE_PARM_DESC(100_mbit, "Enable 100 Mbit support");
>
> And was able to enable it with the kernel option "apne.100_mbit=1".
>
> It's also available as /sys/module/apne/parameters/100_mbit
>
> The 0644 is the permission (root can change it), If it shouldn't be
> changed at runtime 0444 or 0 would be used.
Changing that parameter at runtime won't do anything (it's only tested 
at device probe time). But I'd better change the permission to 444.
> (I think there is also a bool option instead of the uint, but I'm glad
> it works like this.)

True, that would be the better option indeed. I'll change that in the 
next version (which will go to netdev as well).

Cheers,

     Michael


>
> Alex.
