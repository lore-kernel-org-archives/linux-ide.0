Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A3C71153
	for <linux-ide@archiver.kernel.org>; Mon, 28 Aug 2023 21:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjH1Vew (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjH1Vef (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2023 17:34:35 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDA11A1;
        Mon, 28 Aug 2023 14:34:28 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34bad46e5a5so12774335ab.1;
        Mon, 28 Aug 2023 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693258467; x=1693863267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwYVDQ3xXRXMfH4lMez38HnYfGEDU1c8i+UM4LILL2I=;
        b=RP/Uo/QfqLVukuQ0av4jxCJNl9H2iv5vG7Qt038h/o3IL66YUti/jdPC/UkBTuBLat
         qGLrLa0PHF/3WBcmep464tSNGXy6zNTgQcl0V64fvZ0f0VIIBtYAPb926BRjZfe6sFrI
         N5ki3/AP11D1DZT0ANsPLnO0hqE2hc91JQm1nOex7y33x9vcys9ft/wgksZ/tqNOn0NO
         dVQ87hzDRpK7VfRQlx0G9W6vOqi4opSfOsRrzIFv2r8wHjKcrIpN5GWzpK5aDMt7MLtc
         WHK28LN8HBqBJozmzyno5diJc/OMXLDbOTMCAfarl0Z6+BomTAcgQG2B7oVgl47WqMOa
         XmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693258467; x=1693863267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwYVDQ3xXRXMfH4lMez38HnYfGEDU1c8i+UM4LILL2I=;
        b=Y/xtrjZvS0L+d0xzN3E5LsXwXzcc8PSEpDJlTZlwuLXiXkUk5s6hxC3149T9WiikaX
         /xu21F7z/hVCmed/30+nppPhu7rfivsJ2gcsSOfBrdQuLWmnEq75WexrZ0TvbYq5jAqV
         Ua826eOcbajbSH8QxAHRxgfPSZw4SWMpqQsVnx+LluLrTYiY01lTYJnIdCodC39PzwnR
         Hv6fawOZygZswMuUxrDIVVtLGK/uEetYN52S593LeGHHV+6Wd7fLB4PylwuHR4sO5tBo
         R25zODfu7Aa1YDZfCdvbCmXmKUOE/BjDphPVBwFUlZ86nu4sT4J0QMzGMQsQoFfqtvKQ
         X3FA==
X-Gm-Message-State: AOJu0Yzida1f1PaaSwTvBMeOsiRThYkxWYsBCDb1IIfMZ1PA09r4vzwB
        p0z7UcyceUGm7tutvKTJ/1wQx9kd99RF2w==
X-Google-Smtp-Source: AGHT+IFbKElaN4uKVHqxKd++C5HSXuxjbA7Zfq0elQeeHmE1FCnM4I8k+JJKYqE6KaJ8pWhfkhOsbA==
X-Received: by 2002:a05:6e02:13cc:b0:349:92d4:bfed with SMTP id v12-20020a056e0213cc00b0034992d4bfedmr15603430ilj.18.1693258467428;
        Mon, 28 Aug 2023 14:34:27 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:fc87:67de:906b:60d4? ([2001:df0:0:200c:fc87:67de:906b:60d4])
        by smtp.gmail.com with ESMTPSA id a25-20020a637f19000000b00565f9694561sm7773171pgd.21.2023.08.28.14.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 14:34:26 -0700 (PDT)
Message-ID: <5f1eec37-a275-49df-4619-9c107837ddf6@gmail.com>
Date:   Tue, 29 Aug 2023 09:34:15 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/2] Q40 IDE fixes
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, s.shtylyov@omp.ru,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
References: <20230827041348.18887-1-schmitzmic@gmail.com>
 <9438885c-8e35-2387-5fc4-eff20a3977c1@kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <9438885c-8e35-2387-5fc4-eff20a3977c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thanks Damien!

Cheers,

     Michael

On 28/08/23 22:17, Damien Le Moal wrote:
> On 8/27/23 13:13, Michael Schmitz wrote:
>> Version 6 of the pata_falcon bugfix patch for Q40 support,
>> addressing the latest comments by Geert and Damien.
>>
>> No logic changes from v5 which was tested by William.
> Applied to fo-6.6. Thanks !
>
>> Cheers,
>>
>>     Michael
>>
>>
