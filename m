Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B10CA9ED5
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4DE217F4
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 06:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrBgWgq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKEGnj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:43:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfKEGni (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 01:43:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so14396860pfn.11;
        Mon, 04 Nov 2019 22:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FaMve3Wtt9bx+/yRcE1PH1lUM0A4O4VIghOweMx8KtM=;
        b=PrBgWgq3PJD+wgRML1N6BBPSLtV52uHdPUmyBrOi1I3RpPdMMYb96m9x3Mzv/6/JP/
         uN5FvBIyqX+0GiVOLXAvLJVacEGQRzRHf37J0rHTuNqyPzPQPGTfIFWK+S0BMfLzIKq2
         Db6M+VbJ7Q8ianfa/6EmqVJiNmCIx3X7QVaulwj0XRnpeCAY+tYXPnByHDKxr8Hlsj+4
         LkpTNhPCUfRKlexP0a5gSJKlwiKZUByKs7ozguWCnzXUTqWYMp+aQcKVuvKXL3+uBgSS
         gtwA8ElF+9+Gn3M6yOFMbB7fso/0XmC/jo/lwVyMBlWRfiNdbXeIpXwO1zq0PIq5KfFm
         9DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FaMve3Wtt9bx+/yRcE1PH1lUM0A4O4VIghOweMx8KtM=;
        b=SeqRfiziLRN2NVUaah1loeK2cnbfiGeJMx+50nWb7lM8cvRp8Rkp3pTW/eXgP84T9J
         dQ24XF1MCwj3cN7THyiuGAwN8I5JAleQD5vIjurrTTQp8hv6tuXMkzAPldDIG+cvQYAP
         HUE3uGr67BOPYtL3QzY0StyntLPK5g5GnfdCUgkzNLV5N6MEGxO6+9F0RsDxxKXpNXFC
         TYyr7lINAVoRRXu3GO0/wZBP+K7hPCvHLmAwxkgG2vGwPQBIj69Z2VaXykbHT+DD+MVY
         GPwnOJjhvsx5T3kkfqSpc8loUtbyy0Ol3WmHsxYHi9gETmvTkXiGbdihHsil5v7DDXku
         eE3g==
X-Gm-Message-State: APjAAAUVAIpaugdVRF5JAoIzlnqH3FEOeGDqR7Cpn0LPyge+d/AxUX7P
        25jsWTvoz7qHfHG4n0g1T34=
X-Google-Smtp-Source: APXvYqwrqkwRZFUTFqiiePaYBAyYvdDN6RRFEbJq2jNr4YXSZYno0/jZllIiiulG5J5Dsi7Dq0woqw==
X-Received: by 2002:aa7:96ef:: with SMTP id i15mr35008890pfq.242.1572936216587;
        Mon, 04 Nov 2019 22:43:36 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id r8sm5721037pgr.59.2019.11.04.22.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 22:43:36 -0800 (PST)
Subject: Re: [PATCH RESEND v2 1/2] m68k/atari: add platform device for Falcon
 IDE port
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <1569470064-3977-2-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdULi8F8Ky4VxiQew25p5vOTQuf1tXrg7Dx-6aRu1Tj3qw@mail.gmail.com>
 <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <aca5118f-98d2-2f9a-11c7-bd3cea821d2e@gmail.com>
Date:   Tue, 5 Nov 2019 19:43:31 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <4cb95fe6-c2ea-0195-9124-fc2e1223ab38@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Geert,

Am 05.11.2019 um 10:09 schrieb Michael Schmitz:
>>> --- a/arch/m68k/atari/config.c
>>> +++ b/arch/m68k/atari/config.c
>>> @@ -939,6 +959,13 @@ int __init atari_platform_init(void)
>>>                          atari_scsi_tt_rsrc,
>>> ARRAY_SIZE(atari_scsi_tt_rsrc));
>>>   #endif
>>>
>>> +       if (ATARIHW_PRESENT(IDE)) {
>>> +               pdev =
>>> platform_device_register_simple("atari-falcon-ide", -1,
>>> +                       atari_falconide_rsrc,
>>> ARRAY_SIZE(atari_falconide_rsrc));
>>> +               if (IS_ERR(pdev))
>>> +                       rv = PTR_ERR(pdev);
>>> +       }
>>> +
>>>          return rv;
>>>   }
>> This breaks both falconide and pata_falcon, as it marks the resource
>> busy:
>>
>>      ide: Falcon IDE controller
>>      falconide: resources busy
>>
>> and
>>
>>      pata_falcon: Atari Falcon PATA controller
>>      pata_falcon: resources busy
>>
>> For pata_falcon, that regression can easily be fixed by merging both
>> patches.
>
> I obviously need to test this again, but from what I remember from my
> last testing, falconide still worked OK after applying both patches.

No idea what happened on that test, but booting a kernel with these 
patches applied on real hardware indeed does see the (builtin) driver 
fail to load.

> That would have been without loading pata_falcon at all.
>
> I'll rewrite falconide to use the same platform device as pata_falcon.

Just sent a patch for that in order to get some review - will combine 
with the two earlier patches once it's in acceptable shape.

Cheers,

	Michael
