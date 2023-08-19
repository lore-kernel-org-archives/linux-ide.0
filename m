Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E9EE49A2
	for <linux-ide@archiver.kernel.org>; Sat, 19 Aug 2023 00:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbjHSAky (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 20:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbjHSAk0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 20:40:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D74205;
        Fri, 18 Aug 2023 17:40:25 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a412653352so1035806b6e.0;
        Fri, 18 Aug 2023 17:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692405624; x=1693010424;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flupLnMUUcV6PyPpu0plxL80rcplTFaDkiD0oNbhwOE=;
        b=cP1mHfblvKXMP2KRjfaoB6mo4sUPkB7rEEW2Du04VGHEjlpZTLcpBgC0qMTNKFaiwk
         q52H8PbpZxM5C3c2zaQw1XtzBqrZPSaQh42PYQTAolTiHKrCjVt0AqxBa2/Z03RDVIC+
         0i1+54CdABpJGxU6LtxBX4ITJslGsM+Zs2PXaCDfdObeWxvbx5ldzxZKgZdqe+b0nvRL
         FrkeLfqZqO6dDz8RGo8sny9hOOx5xYwLGiJgbwuBknqUqfd7RkYlxqDsLx6tBZZo9MqO
         k35TCI8RgTtyoqQy2Rvflz5V/1FF2JAhxzqaMruzspyNr+DCTHQ+/7BQasW0Whd/KZ2r
         tnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692405624; x=1693010424;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=flupLnMUUcV6PyPpu0plxL80rcplTFaDkiD0oNbhwOE=;
        b=cVrystc3Ae4/5qneXIpYbTDLv8MOi5pgeI7OGR8p67gVZ4aB+hmT1IajDFj7wj43U9
         T9l0JHI+tjQhl3PCNzGDliyTv8HkYktl9jt+oHIcYIYXVLw5ZcahWAscabq9oi2sshay
         N6f1ovI7m8D9koHeO/RPMRHz6GF/gtfk7d7bsbCpk5YGOv0A1TnK/FZ/BILD46D4cqao
         8mGTFd/B3eMRfiqSJdi6c57z78F4bG4OYioh2uwZfcUOA3++ugaho0roTAwr0ZA7vCvb
         6ZX6NT/GlSOuryJJT9MafPGcRfbOeV3VesXwk6Bcu0jmZImgiwsq0tQ854cfQnCNYI63
         A9tQ==
X-Gm-Message-State: AOJu0Yzve9TwZLlAM0YR4uwBrxpkvOlSWmUugJAafpo5uoySGkNL5d4c
        63wqVQRjb80HKHpDt1yOvTRZmX1uXKw=
X-Google-Smtp-Source: AGHT+IECMvC7JOBiX/UkRfw9UKMmnLELOGR/lJuNZR6r/lVFqUwNhcfcvhQKsXp9ug5jgJ9YMdIm0w==
X-Received: by 2002:a05:6808:150a:b0:3a7:62ad:af39 with SMTP id u10-20020a056808150a00b003a762adaf39mr1134030oiw.13.1692405624446;
        Fri, 18 Aug 2023 17:40:24 -0700 (PDT)
Received: from [10.1.1.24] (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b006887be16675sm2070027pfh.205.2023.08.18.17.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2023 17:40:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] m68k/atari: change Falcon IDE platform device to
 id 0
To:     Finn Thain <fthain@linux-m68k.org>
References: <20230818071405.28581-1-schmitzmic@gmail.com>
 <20230818071405.28581-4-schmitzmic@gmail.com>
 <CAMuHMdUkzk9DxAicq7U5yp3LT0mzaP+tgbwcSYNFx7sripBDcg@mail.gmail.com>
 <41d64e82-5995-4e5c-68f5-3e9248ece153@gmail.com>
 <5cb447ce-6436-38e1-b6e9-8a5547202a47@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        will@sowerbutts.com, rz@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <76f0bb19-bcdd-00a6-7bf2-ad05e303ae60@gmail.com>
Date:   Sat, 19 Aug 2023 12:40:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <5cb447ce-6436-38e1-b6e9-8a5547202a47@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Finn,

Am 19.08.2023 um 12:07 schrieb Finn Thain:
>
> On Sat, 19 Aug 2023, Michael Schmitz wrote:
>
>>>
>>> Iff this patch is accepted, it must go in before [PATCH v2 2/3], else
>>> the latter would cause a regression. And backporting to stable must
>>> take that into account, too.
>>
>> I don't see it as a regression - the driver still works OK, it's only
>> the byte swap option that's broken on Atari, and that's newly
>> introduced.
>>
>> But this patch changes the user space exposed platform device name, as
>> you point out elsewhere. That's reason enough to drop it.
>>
>
> Such a script would be broken on q40 already.

Not necessarily - what I thought of was something like the Debian 
installer.

I don't know for a fact that it relies on the device naming as it is at 
present (or even that it supports Q40), but I'd rather not needlessly 
change something that might break user space code.

> When a fix has a dependency on a separate patch you can backport both by
> specifying a cherry-picking sequence. We may need Geert to add those
> commit hashes though. This is discussed in
> Documentation/process/stable-kernel-rules.rst

If Geert prefers to change the Atari IDE platform device ID, he's always 
free to do that :-)

The current patch will work either way.

Cheers,

	Michael
