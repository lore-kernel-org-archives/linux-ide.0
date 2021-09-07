Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A2C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FE461077
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhIGA6p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhIGA6p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2021 20:58:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22880C061575
        for <linux-ide@vger.kernel.org>; Mon,  6 Sep 2021 17:57:40 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g9so10610904ioq.11
        for <linux-ide@vger.kernel.org>; Mon, 06 Sep 2021 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Yjo3eRXgX3z7JwfJBCcDtSMIJV6KNWOaUOtoZ9E3HzA=;
        b=ajm2RQx/5ZTvcex3n/uTFdMltXYZCTdXlJDJQ+pXxMkyPNaKd44DXnkMFthptV5kiQ
         vr6ZLivjl9SvlWx2yk83LYU5/BgJcQ4mVOySuqDR3/gQACFUhACOHhNFNUigP5wz6KcK
         Z44Jeh2tlNNA9bw/IL6OmRz0ibIWWo0OAaY7mkh5ZmPC23N7wzIml2AYOM9DWLlRUlbN
         icQwE9ofeLUUyEtZCKje3BKwitVo8lElygIWR2V7JKmtqWRHAXRAT+CCiJuzT/vDTYk+
         9BVl5U2XJaN+bgWDeDgKR+YLBhYTTlTDEHwlYbdFLdN+HiCbgsB7kEJEu67sBIEbbKTD
         B1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yjo3eRXgX3z7JwfJBCcDtSMIJV6KNWOaUOtoZ9E3HzA=;
        b=U8FJdIl9yNbQmzsFwmalWpFZVmVhfqy7f1PMuIj2MZdXU8wmzRRox0PS/GI3z5c5to
         NYKk2r/b0gqwkhs7TT+HKHsH6CdqZixd1g/5Ry0ZosECqdE7m4ruEOQ0FxiyPN0uiDvQ
         OHGsCEBv8W0bq4g4+l8uaUfA6Vn+Av60Xk5vWmDu0oA2uitHcMn+fggdW9WjU7o0TpQK
         I17Icq8LJTYDkTDGuKZmNc+gaIsh8c/+MP/nzq9+qchuNz7zkjgyww2lzMr7xGoCIyTK
         BqSu2fD5FfgtbrOCIeV88SMr31ydCCBuzk9cXKanj/HYHv05lRN3RU/xPbWS31sMXbPV
         9Uwg==
X-Gm-Message-State: AOAM533oNYxinBVXlsYQqTMNTGmhLQC4JAlnN11gyhaXyQieU2KSqElh
        Cd0oOLK8iVUoDKpM9Xj3sEioz8jZ5Owcpw==
X-Google-Smtp-Source: ABdhPJwUtcWRAYWx+32Zvk62kPGnemXtNQ0HJuAfeaytnR+wsn+DX2K9eheQADR8lyGSi3Mx/Mchrw==
X-Received: by 2002:a5d:8b04:: with SMTP id k4mr11811422ion.58.1630976259275;
        Mon, 06 Sep 2021 17:57:39 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x1sm5427380ilg.33.2021.09.06.17.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 17:57:38 -0700 (PDT)
Subject: Re: [PATCH] libata: pass over maintainership to Damien Le Moal
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
References: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
 <4f9b5f1d-7130-9434-8c54-23b4117bbad7@opensource.wdc.com>
 <1b3ad1ca-b3d9-3258-059c-44d74344b9a3@kernel.dk>
 <0ddfe118-39c2-ea97-73e0-9751c8efe94e@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fad3b185-da43-9657-0f7a-469b9f62149a@kernel.dk>
Date:   Mon, 6 Sep 2021 18:57:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ddfe118-39c2-ea97-73e0-9751c8efe94e@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/6/21 6:52 PM, Damien Le Moal wrote:
> On 2021/09/07 9:50, Jens Axboe wrote:
>> On 9/6/21 6:47 PM, Damien Le Moal wrote:
>>> On 2021/09/07 9:45, Jens Axboe wrote:
>>>> Damien has agreed to take over maintainership of libata, update the
>>>> MAINTAINERS file to reflect that.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index fb1c48c34009..ed9e3770d8b5 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -10597,10 +10597,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>  F:	drivers/ata/sata_promise.*
>>>>  
>>>>  LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
>>>> -M:	Jens Axboe <axboe@kernel.dk>
>>>> +M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>>  L:	linux-ide@vger.kernel.org
>>>>  S:	Maintained
>>>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
>>>>  F:	Documentation/devicetree/bindings/ata/
>>>>  F:	drivers/ata/
>>>>  F:	include/linux/ata.h
>>>>
>>>
>>> Jens,
>>>
>>> Thanks for sending this. I did name the tree "libata" but since this includes
>>> many drivers, would "ata" be a simpler and more general name ?
>>
>> I think libata is fine, but it's really up to you. 'ata would definitely work
>> too, especially now that all the old IDE code is gone.
> 
> OK. Since I think everybody is used to libata, let's keep that then.

It's the most straight-forward for sure.

Want me to add you Acked-by to the patch?

-- 
Jens Axboe

