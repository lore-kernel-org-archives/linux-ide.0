Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05210C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C950360BD3
	for <linux-ide@archiver.kernel.org>; Tue,  7 Sep 2021 00:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhIGAvT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 6 Sep 2021 20:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhIGAvS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2021 20:51:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8242BC061575
        for <linux-ide@vger.kernel.org>; Mon,  6 Sep 2021 17:50:13 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id b4so8297090ilr.11
        for <linux-ide@vger.kernel.org>; Mon, 06 Sep 2021 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z5w6lO+5SPqWO9cQBB/8ANWnumux8713MEdTBzU79KI=;
        b=GqFiRnJhFLvwWrMCK4SxfZ06hClDx7Jh0en/v0HEZ2cmoQi2nXW5F9UnvcoIxeAHZD
         CizyU9BGMjZ8AN/OwtuqMJzd/vvh9nXQA1fj7wMXILZiAx5scmf4Qs0dLjsQ4WwXgV3N
         /I5trQlnWwoUMlF7sePGGq32TJeF+6346/GeJ46CZV9cUisNtPN2ToQc60oFy2nfrpOf
         vCYH9+AphvVqllh4crSOZBzRqlGF9wqoSwFMZBU2LKLhX8F+s3xILK1Jy1s9te67+SCR
         xDfUnq3zOF0JNUTY060xCBjmEhhNr1f/nkkLWb0v6oSGQ+5SPk4g3gFhstRjA7nUe73Y
         lmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z5w6lO+5SPqWO9cQBB/8ANWnumux8713MEdTBzU79KI=;
        b=d/eiagzjBYySN+C8IzyC2cOlfVBC6mk5UrXDBVROitAMA9vBuvrJywrxeyOlIsmevc
         Q6/5C3sj6B4peKuNsTLquqFAumtByTZGPYL3IPanLjj/a5gGqSJUkf+ainxx08xgu/F6
         bulYDVqzxxILaeDHfBJ9HSEvGKJkzw+NkGlAMsfxxN+D2VeRV/XIK+2UqPnxXYhU0cXj
         pGVx/yJ0GK0hn7MV6b6Ct/rCO/Txdd9PBg8o4mEm2ff4TrJu80JF8nT61iLwLVovb331
         xUpVTF9c5tXXFajY9PSYtTYr6bBAjwKbqVeWJQcFiTDKwXfUORdDLtHR9kvmwb46xosV
         pK8Q==
X-Gm-Message-State: AOAM532UDZ0yX9DrkDoCQK4h5mq1GGtENp8XzGQDR369IfO7iAkgJ6Uz
        dAYQZG5NfeZSj8VN9uM2jd31Y5/qpE5Cjg==
X-Google-Smtp-Source: ABdhPJyxfvC97mADeTUZ2lwwBtwq9stIs/CRXfJsrKk234LW3MBMvDy+CxoBEimpZUTZqy3Lp5Vn8w==
X-Received: by 2002:a92:6802:: with SMTP id d2mr9850610ilc.40.1630975812761;
        Mon, 06 Sep 2021 17:50:12 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s5sm5431735ilq.59.2021.09.06.17.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 17:50:12 -0700 (PDT)
Subject: Re: [PATCH] libata: pass over maintainership to Damien Le Moal
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ALWAYS copy <linux-ide@vger.kernel.org>
References: <b4cafca7-ad37-ec70-7b89-9025c35902a8@kernel.dk>
 <4f9b5f1d-7130-9434-8c54-23b4117bbad7@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b3ad1ca-b3d9-3258-059c-44d74344b9a3@kernel.dk>
Date:   Mon, 6 Sep 2021 18:50:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4f9b5f1d-7130-9434-8c54-23b4117bbad7@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/6/21 6:47 PM, Damien Le Moal wrote:
> On 2021/09/07 9:45, Jens Axboe wrote:
>> Damien has agreed to take over maintainership of libata, update the
>> MAINTAINERS file to reflect that.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fb1c48c34009..ed9e3770d8b5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10597,10 +10597,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>  F:	drivers/ata/sata_promise.*
>>  
>>  LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
>> -M:	Jens Axboe <axboe@kernel.dk>
>> +M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>  L:	linux-ide@vger.kernel.org
>>  S:	Maintained
>> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
>>  F:	Documentation/devicetree/bindings/ata/
>>  F:	drivers/ata/
>>  F:	include/linux/ata.h
>>
> 
> Jens,
> 
> Thanks for sending this. I did name the tree "libata" but since this includes
> many drivers, would "ata" be a simpler and more general name ?

I think libata is fine, but it's really up to you. 'ata would definitely work
too, especially now that all the old IDE code is gone.

-- 
Jens Axboe

