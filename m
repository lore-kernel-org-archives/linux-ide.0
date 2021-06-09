Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B26C48BCD
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DC9613F5
	for <linux-ide@archiver.kernel.org>; Wed,  9 Jun 2021 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIT3u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:29:50 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:52823 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFIT3t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2021 15:29:49 -0400
Received: by mail-pj1-f51.google.com with SMTP id h16so2077309pjv.2;
        Wed, 09 Jun 2021 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gIB70I/Qv1t3ok3fK1L/yr9HuQT1wjAnBShvqfBtD/c=;
        b=nJxAAfk6cS48UhD59VHVmQ+Mw9o1nQnI+jrsQFbPACq4d/9ih7LiH1pjdIn1VPePVu
         CNBjITuwsGI7BxCv/Lx/u7z6EPfudl+qxG1/sBmHuF+EOHU46ic/0GVMRf0EdEv4pYMS
         PBZdCi3L1+XbJe2N3rOo83yxhqqlcdi1q7GMBOpGIs2mFnYmOIKmph7vpZO65sZhBYUl
         y/2h+EyyJ4bEr/+fC3VcyEqW7ChjZNHad+uG0cDum/7bQ/4aeGmsJcqzLCah/LBetCG2
         /yMHam5uxrcdk3yt/wsSDRE9D2OkTEdj+U28msAMyFCsZF1/W2ExLtXvmlObWpYydka6
         69IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gIB70I/Qv1t3ok3fK1L/yr9HuQT1wjAnBShvqfBtD/c=;
        b=GhiZxWl0+VIPvXEgLFY0uflb6OwI0mckQLbEdESULu0+dMzNIqjMu6HfeFJrKgxA+f
         729irWf8wpa63k8OLLvn2Jy1zQpvV8G1/5p81M578QXdmd86m+OylGd1l5swPyCifosx
         hT3eChq9dIe7mXT/gtH1Rr3KBs4Thl6byeAsAOgZ6lpoXSoX5AFsCmyvWb7twFpWH1TG
         SojiprOV3RKxY90cRVGaafWLvANo7Pi5Pj4L1zRDCArm1eErydJtrz6PFD3YoZy/2c1B
         2VFjgd6yUYZKC4cDiIXFEtSR/kre8Ju81Nu0gL3U65lWVwMt1a9H6Ak2j+vj0rvpXRAX
         lcNQ==
X-Gm-Message-State: AOAM531v94HhR755WzYY9+ui44QpnmG79gTos6+eSNuuIyb+rCgVyS/Q
        OoKiHk49nYrmgLMHrXuBu+k=
X-Google-Smtp-Source: ABdhPJyvEtegHBtUWmfBRnD/EDr9PdBnqqyw9XKy5k6kt7m9m0Xj3YbyccLmNoiKHOWTCDjTgHT9qg==
X-Received: by 2002:a17:902:265:b029:fa:9420:d2fd with SMTP id 92-20020a1709020265b02900fa9420d2fdmr1223767plc.39.1623266798486;
        Wed, 09 Jun 2021 12:26:38 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:459f:1243:2a64:9384? ([2001:df0:0:200c:459f:1243:2a64:9384])
        by smtp.gmail.com with ESMTPSA id ge13sm5719812pjb.2.2021.06.09.12.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 12:26:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Richard Zidlicky <rz@linux-m68k.org>
References: <cover.1623131194.git.fthain@linux-m68k.org>
 <YL+AqIEPjMgG519L@infradead.org>
 <d3c70f7a-368a-ad9a-6575-8289234b0ce0@kernel.dk>
 <36f7519d-698f-1284-551a-0dbd82e2a0d8@gmail.com>
 <aca5ed6b-f54d-1a3e-b905-920be85d51d8@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <aeaa343c-a656-6d72-9806-3e2a4a070b5b@gmail.com>
Date:   Thu, 10 Jun 2021 07:26:30 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aca5ed6b-f54d-1a3e-b905-920be85d51d8@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

it's this one:

https://lore.kernel.org/linux-m68k/1623223322-4242-1-git-send-email-schmitzmic@gmail.com/

But see my reply to Finn's mail - my patch is entirely orthogonal to 
his, and simply fixes a long standing issue that has recently surfaced 
with Finn's efforts to unify Atari and Q40 IDE drivers.

Cheers,

     Michael

On 10/06/21 3:23 am, Jens Axboe wrote:
> On 6/8/21 3:50 PM, Michael Schmitz wrote:
>> Hi Jens,
>>
>> please note that Finn's patch depends on one of mine currently under
>> review. Without that one, Q40 support may break in certain cases.
> Can you point me at it?
>
