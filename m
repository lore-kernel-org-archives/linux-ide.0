Return-Path: <SRS0=oJiQ=UY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD5BC48BD5
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15659205ED
	for <linux-ide@archiver.kernel.org>; Tue, 25 Jun 2019 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k18QPogO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfFYUvL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:51:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUvL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jun 2019 16:51:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so37504pfl.3;
        Tue, 25 Jun 2019 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xg8gT4d8BsI9N6+GZDzqBQ1I7Ia/w6sfBkfg2K0V9ss=;
        b=k18QPogOlBdGd3RHyi+jwiMf5++nNuDxK7INLU9BVo33iK6zdrW4hKUAnOAl389EFn
         C+LTLX8VqOnnrXSoE6qMqL5sZ0qcbZ3A6/wW80Rawy0QeMmw6VaPp+/4DRT4Vy3mEBsl
         3bUWroXTPlm5Lb2VIJPoEkL6oZXQIvli+4rQbLNZqXvHcxsRnTEIp7Laqy2nwHQlWQHA
         /a5HMwA7rSDpVx88wgVE1mjORVEMi337ClHks9gllJo65X7IRTev2eXNSyc+V5NlAb8U
         SOXQ6I1KPFHFkPeWXWETLJ5mvIN2Wp8uSr+6rjhsZLsMCucHuB5BWwD4kGo8kKnjci/Y
         eiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xg8gT4d8BsI9N6+GZDzqBQ1I7Ia/w6sfBkfg2K0V9ss=;
        b=Ov7mZQHsT24Ka2RqPFXBsXIaBymdXin/SsrbuU+v4CWC65ARDEOtWgYIFT3hEZw0Zl
         /I+ZaSW01fRnD5Qqw1YX88sxwvyfZsUNLLTvSH4eS4kUtV8A5H2WFnoohOUOsTb08oF1
         yCJkiYuRoB69wyrSBSg0NSu9Iy+Lq7jWiSZMsIEkLWEX2KHOUYITTJnBPxeIRVVyhdgh
         T1cFzZ/btEA2D+ih5f2XG8ZzS6dyEZF3x1YD1uz7FbYpybZegI1M3asHP4T7tdE9M/Ls
         TJEZ1drKofm42x6siBzwhDMvCQPrkov1MAZZbTvqaDww5Hy8z/rZQP//vodI+jGjugMU
         HWuQ==
X-Gm-Message-State: APjAAAVqorXJulrmliDkhoB/HTPp4sbU+0HRg9GO0LLO1Gnlj9Bb/+mW
        5qQSl1IasMeGW25q3Sydksc=
X-Google-Smtp-Source: APXvYqxdstKiGO59oQbXQCVzl9UHJI0M25gqfX9RWSzQDGtCzwFuDQxlNaAybIybjC4nL3SFM9dKZg==
X-Received: by 2002:a63:1208:: with SMTP id h8mr39289527pgl.377.1561495870556;
        Tue, 25 Jun 2019 13:51:10 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:2cea:a92d:ab5a:6f7f? ([2001:df0:0:200c:2cea:a92d:ab5a:6f7f])
        by smtp.gmail.com with ESMTPSA id c33sm8859804pgl.70.2019.06.25.13.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 13:51:10 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k/atari: add platform device for Falcon IDE
 port
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
 <1561063642-13900-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdWMb2MFRN6ug3Jt3MROAs0nhYYC_RDexu876n9PBRZOiQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <92de0ad7-731e-c898-0cde-4265fb737d59@gmail.com>
Date:   Wed, 26 Jun 2019 08:51:05 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWMb2MFRN6ug3Jt3MROAs0nhYYC_RDexu876n9PBRZOiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

On 25/06/19 7:51 PM, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Thu, Jun 20, 2019 at 10:47 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Autoloading of Falcon IDE driver modules requires converting
>> these drivers to platform drivers.
>>
>> Add platform device for Falcon IDE interface in Atari platform
>> setup code in preparation for this.
>>
>> Add Falcon IDE base address in Atari hardware address header.
>>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Thanks for your patch!
Thanks for your feedback!
>
>> --- a/arch/m68k/atari/config.c
>> +++ b/arch/m68k/atari/config.c
>> @@ -896,6 +896,21 @@ static void isp1160_delay(struct device *dev, int delay)
>>   };
>>   #endif
>>
>> +#if IS_ENABLED(CONFIG_PATA_FALCON)
> I wouldn't bother making this depend on a config symbol, as it is
> builtin hardware (EtherNEC/NAT isn't), and prevents compiling a module
> later.

Fair enough - not sure how much it saves in kernel size when this code 
isn't compiled (falconide does not depend on it, and that's my preferred 
choice due to interrupt support).

IDE is builtin hardware only for Falcon, not TT BTW. Building the kernel 
for TT, all of IDE support may well be omitted altogether.

> arch/m68k/amiga/platform.c has everything unconditional.
> I know there's such a dependency for SCSI, perhaps it should be removed?

SCSI isn't present on the Mega ST/e, so we would not need the SCSI 
platform device there. Not sure whether it's still possible to boot 
recent kernels on that hardware though.

I'll have to try the bloat-o-meter for these changes.

>
>> +static const struct resource atari_falconide_rsrc[] __initconst = {
>> +       {
>> +               .flags = IORESOURCE_MEM,
>> +               .start = FALCON_IDE_BASE,
>> +               .end   = FALCON_IDE_BASE+0x40,
>> +       },
>> +       {
>> +               .flags = IORESOURCE_IRQ,
>> +               .start = IRQ_MFP_FSCSI,
>> +               .end   = IRQ_MFP_FSCSI,
>> +       },
>> +};
>> +#endif
>> +
>>   int __init atari_platform_init(void)
>>   {
>>          int rv = 0;
>> @@ -939,6 +954,11 @@ int __init atari_platform_init(void)
>>                          atari_scsi_tt_rsrc, ARRAY_SIZE(atari_scsi_tt_rsrc));
>>   #endif
>>
>> +#if IS_ENABLED(CONFIG_PATA_FALCON)
>> +       if (ATARIHW_PRESENT(IDE))
>> +               platform_device_register_simple("pata_falcon", -1,
>> +                       atari_falconide_rsrc, ARRAY_SIZE(atari_falconide_rsrc));
>> +#endif
>>          return rv;
>>   }
>>
>> diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
>> index 5330082..4bea923 100644
>> --- a/arch/m68k/include/asm/atarihw.h
>> +++ b/arch/m68k/include/asm/atarihw.h
>> @@ -813,6 +813,12 @@ struct MSTE_RTC {
>>   #define mste_rtc ((*(volatile struct MSTE_RTC *)MSTE_RTC_BAS))
>>
>>   /*
>> +** Falcon IDE interface
>> +*/
>> +
>> +#define FALCON_IDE_BASE        0xfff00000
> Is it worth having this as a #define in a global header file?
> You still need a hardcoded region size in config.c.

Probably not.

I'm still incubating a hare-brained scheme to allow use of IDE 
interrupts in pata_falcon without the use of the old locking scheme, and 
might need to peek at the IDE interrupt status from the shared interrupt 
handler for that. But that's gone on the back burner, so I can move the 
#define into config.c instead.

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
