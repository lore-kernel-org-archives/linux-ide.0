Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8492CA9ED3
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 21:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2A020842
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRZaEwU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfKDVJc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:09:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45213 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDVJc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 16:09:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id y24so8219859plr.12;
        Mon, 04 Nov 2019 13:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GS3fugTA2a7Yt1UpBdNzvr8P7jV9TpKGIQc839n4xws=;
        b=IRZaEwU4isjLJqky5EHJmlYSY9uPgmm/Dx6KGRQWEs9s1AmUtWlZOxpRPlUfWxb0Q4
         NTSK7La2NievKNNe4jf2ROSULq6osAPd/jJx84q8jtqJDwHQJnYlFEuYZrvZoBlOTqIr
         0/RfqjnDtHZkw8gzeHrBUfwcP0Oyq7rN3fLl/iWU9zlAmvjcWF71vCeESRi/X96O5VLV
         LybEfrOfPGXxbVktfNH4AeBf6WMe1BLvSg5hbMaj5d5MkSQHlG16YcZmWBRpr6b7240d
         wZ5XyfApk+zYqduwd2vyYugDyomyw+RpDl7CVVLSeC9m3qKxr0EIrwfUhZobBz/VYhXB
         qRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GS3fugTA2a7Yt1UpBdNzvr8P7jV9TpKGIQc839n4xws=;
        b=RMRKI2C+ffCrtr2EMDRaZoX/Ui3RyQp7vXQqm4c3n2vpCML5gw044+zARd1hQcWz/6
         S9Ze7/1OriOnZBcOHY+aCXXQ2gbe0EzESBjp0HVONh2iQfGcqlfrd9wK7/36D5ofoPUV
         vEYIbsCXeeESzFn8wp/ewuHbAXd0ROi87lfIYx9l63cg2ura6B5Zxr+3pVg3ozOE3LwZ
         YgZxU24Zvb27LygBo/gsee8AivY0DGUepU8uctNoR5UwXw422oUgRr+CNwaLIou8fhB5
         5jZXzf3lhdpwCp7wEx2yt5scOfMx2e89FZHmeUrb13D3Gi8T7Bb4jelrY02o8r2dQDN4
         xWaA==
X-Gm-Message-State: APjAAAWNOIrA7qxIvt9fIkwitv2TS1r5DSLO4C819ntjRMDWgD0eWUe+
        T8S4QlI9BTYij1OX1j3801HUpmFm
X-Google-Smtp-Source: APXvYqw9gOtdZDELq5OfGDTTBeWysbo82JPmj9qz9oTv1l0A+790agRJzbLjfaqZePn/NwQ6Bcn5qQ==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr28784833plb.140.1572901771483;
        Mon, 04 Nov 2019 13:09:31 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:9888:8ef6:cb36:21e0? ([2001:df0:0:200c:9888:8ef6:cb36:21e0])
        by smtp.gmail.com with ESMTPSA id e5sm18326699pfa.110.2019.11.04.13.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:09:30 -0800 (PST)
Subject: Re: [PATCH RESEND v2 1/2] m68k/atari: add platform device for Falcon
 IDE port
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <1569470064-3977-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdULi8F8Ky4VxiQew25p5vOTQuf1tXrg7Dx-6aRu1Tj3qw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
Date:   Tue, 5 Nov 2019 10:09:26 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdULi8F8Ky4VxiQew25p5vOTQuf1tXrg7Dx-6aRu1Tj3qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

thanks for your review!

On 4/11/19 11:56 PM, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Thu, Sep 26, 2019 at 5:54 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Autoloading of Falcon IDE driver modules requires converting
>> these drivers to platform drivers.
>>
>> Add platform device for Falcon IDE interface in Atari platform
>> setup code in preparation for this.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>
>> --
> This should be a triple dash.
>
>> Changes from RFC
>>
>> - fix region size (spotted by Szymon Bieganski <S.Bieganski@chello.nl>)
>> - define IDE interface address in atari/config.c, create platform device
>>    always (suggested by Geert Uytterhoeven <geert@linux-m68k.org>)
>>
>> Changes from v1
>>
>> - add error checking for Falcon IDE platform device register
> Thanks for the update!
>
>> --- a/arch/m68k/atari/config.c
>> +++ b/arch/m68k/atari/config.c
>> @@ -939,6 +959,13 @@ int __init atari_platform_init(void)
>>                          atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
>>   #endif
>>
>> +       if (ATARIHW_PRESENT(IDE)) {
>> +               pdev = platform_device_register_simple("atari-falcon-ide", -1,
>> +                       atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
>> +               if (IS_ERR(pdev))
>> +                       rv = PTR_ERR(pdev);
>> +       }
>> +
>>          return rv;
>>   }
> This breaks both falconide and pata_falcon, as it marks the resource
> busy:
>
>      ide: Falcon IDE controller
>      falconide: resources busy
>
> and
>
>      pata_falcon: Atari Falcon PATA controller
>      pata_falcon: resources busy
>
> For pata_falcon, that regression can easily be fixed by merging both patches.

I obviously need to test this again, but from what I remember from my 
last testing, falconide still worked OK after applying both patches. 
That would have been without loading pata_falcon at all.

I'll rewrite falconide to use the same platform device as pata_falcon.

Cheers,

     Michael

> For falconide, I think the sensible thing to do is just remove the driver.
> But before that, the defconfigs should be updated to use pata_falcon
> instead of falconide.
>
> For the actual code changes:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
