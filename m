Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF444C48BD1
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 22:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05E6613DE
	for <linux-ide@archiver.kernel.org>; Thu, 10 Jun 2021 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFJWch (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 10 Jun 2021 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJWch (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jun 2021 18:32:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E8C0617A6
        for <linux-ide@vger.kernel.org>; Thu, 10 Jun 2021 15:30:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h12so1807412plf.4
        for <linux-ide@vger.kernel.org>; Thu, 10 Jun 2021 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bNl27/chKNf7nJqRZtYWTaY8Wo6h+Jsbjb7Fm98XfjM=;
        b=jCiCmb87ZtZLGSYlrI52zzxIxynosBucCOjocRFX/sGizfI0ke6pcxMDE2tOp9tCa6
         CKt1C5YkN09m3JxkQlvkUkVJSWfMU0dHG2NOhImoT3oK9NlOGtPxPkTwoweBizRwq09d
         mgJ1X35tS2uQtOG/V98/eaKPoriNKeKlp8JLg43wjdPMz+pVNcCAAkz/HDDwhdvMeLFq
         lhtSdgsIhRC0NcyCnsVMxGmvUwkjEnjfZ/DJm8QscBe8nQvJeyvbUJ8XfweUcriulmsU
         2xz5sW/N7DUadJtUodY67+Q4szcZMHET3aHRqBtM9bm8XdNZjF/qe2z5DQAR9Gr/xVHC
         k/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bNl27/chKNf7nJqRZtYWTaY8Wo6h+Jsbjb7Fm98XfjM=;
        b=g2L/GKwaUwrmN3wcaiwaPB5ElgPDQIFhx4JJhTrXCV+0zZ9/OhYSJsy/iJItx5TXb8
         hXHPwf9BiBdH7czMFstkkSzO8sJQ1kChe9M2F19V0aNOjQmunfFPPIufy7RR/QzvAO5o
         qMYlagnadFoXDkSkaIGU0/SjHEQNis16DfVwhuZnHd76HCzQy/DRoH6qIE02GZIF8zQc
         zTg7ogkXenHLhB6cbDC2iXBr6DXyKRxVebMD/0HTAd/ErCECYtWo68Nm2huzMgqjpOwT
         VDWFh6guqQb8u+9Q3Z90l/9Rxt9giOAB1deJPvhVdnjWW3JXLVDylYvIPurzut8h9rbe
         gwYA==
X-Gm-Message-State: AOAM5306FDmv9o53Bl+EViagNOqrkPxKkeHMRHugFwsln4RZpio6TeOt
        nHe6obLWNasX4btryJ8KxWdS1w==
X-Google-Smtp-Source: ABdhPJx9c9j/u3MaSBk3DA1HSUM+hQguDjnwUT3XsYHDbPDwYq2+P04SHbAygYF20BLqKLhu5wgpWw==
X-Received: by 2002:a17:90a:bf87:: with SMTP id d7mr5616505pjs.118.1623364228440;
        Thu, 10 Jun 2021 15:30:28 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id l201sm3234885pfd.183.2021.06.10.15.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 15:30:27 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
To:     Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
References: <cover.1623287706.git.fthain@linux-m68k.org>
 <CAMuHMdWLJWBH5uz=PLL7pt2uEHz9uSO2Gh7twCDUTz3NDfhdEQ@mail.gmail.com>
 <417a2d12-6085-e796-a8a5-605a58f131f@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eec9fc3a-f485-b0c8-2502-df899f4fcd71@kernel.dk>
Date:   Thu, 10 Jun 2021 16:30:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <417a2d12-6085-e796-a8a5-605a58f131f@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/10/21 1:57 AM, Finn Thain wrote:
> On Thu, 10 Jun 2021, Geert Uytterhoeven wrote:
> 
>> On Thu, Jun 10, 2021 at 3:34 AM Finn Thain <fthain@linux-m68k.org> wrote:
>>> This patch series allows m68k platforms to switch from deprecated IDE
>>> drivers to libata drivers.
>>>
>>> Changed since v1:
>>>  - Added reviewed-by and tested-by tags.
>>>  - Improved commit log.
>>>
>>> Changed since v2:
>>>  - Added #ifdef guards to prevent build failure when CONFIG_ATARI=n.
>>
>> Thanks for the update!
>>
>> Note that Jens has already applied v2 to block/for-next.
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=9658506fbf8c1b629ca8a660862bc1ee57400506
>>
> 
> Thanks for the tip. I gather that Jens' tree can't be rebased, so I'll 
> have to send another patch...

It's top of tree for that branch, so not a huge issue to rebase it. Just
did...

-- 
Jens Axboe

