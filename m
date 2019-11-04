Return-Path: <SRS0=j7Np=Y4=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C69C47E49
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 21:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF1C2084D
	for <linux-ide@archiver.kernel.org>; Mon,  4 Nov 2019 21:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkfQRwa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfKDVVp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:21:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36696 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVVp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 4 Nov 2019 16:21:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so1026570pgh.3;
        Mon, 04 Nov 2019 13:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UEAn4djsOV882Y0lzgBCHOGsSQ9BIKf6CIEUzvzO5p8=;
        b=tkfQRwa1LmyEEMHZkGju+lSG+sEG9jUcQADwxGTfl/easeEUFf+9Cvc8CMGQwn9n17
         3UWXMwgnakNYwujFJgH/yv0qqyFcfI1iTEkOQ17fX4kkRvPET4GjEpjd/AjPY4mvcp6C
         TpzNjcVhfk7q5g7bBflqW/YOi1KMlWwvgIEEq0+AdYgVSJYiNjQW+ACSERgk7gc7HPzX
         vQEWsdG3/RDOXSfj7ryYV2F+QQAOZSUJutjtEAH7HdrfgomBJcBKkvlQIU6LCTHsin6C
         rpLARmsPj/gCxbxBKvgSeczPbMyE8ur+QyBpakVgsUYtAqFkeMNhtuYykNWt/s0KnRdB
         9H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UEAn4djsOV882Y0lzgBCHOGsSQ9BIKf6CIEUzvzO5p8=;
        b=YDKqGXW80iSl8v4ZOUulYoDzTWfpP6I6Zor3s1gW9jBSQJ466zPwuJUl54juW14D3J
         j6cGqec88Q43KvStxh8uGkSAcFpDVxCMbUETnlMmyaMdo54hsbrScGGUjE5sZlPJVMLz
         7Zt5KQNWQdc9sP7CjYDbxg37C3jBDSarKrV8usyJXityHPKYha5fWtotUbctRa21iOtL
         NOPuCKOcb1eQc/27z8EY+lAwZWYm8Uz9V8TqY5JkImy4uwoojHdrGwrZ7ROP8NPQqdre
         k8eU1fTlewKKOb+k14Q6Ry7PyDLXPhK65JUBG0OAFFyIsWGTmhycZMlyVYj7TikHFHTP
         Vk0A==
X-Gm-Message-State: APjAAAW9fwSwmqY4y4TZFHEdtUN3RYohChK++TWRU0cOybGMxqr4XSSA
        31tO9DStXBMiWP2IMOk3AjlhDI9y
X-Google-Smtp-Source: APXvYqwrpmnCiy4cUMcFq4umHG5BMfSBzCRE5406NO7ST1MQKLevEsTGAgwFGTOtXX3+X82jcdKv7g==
X-Received: by 2002:a63:c405:: with SMTP id h5mr32512799pgd.60.1572902504324;
        Mon, 04 Nov 2019 13:21:44 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:9888:8ef6:cb36:21e0? ([2001:df0:0:200c:9888:8ef6:cb36:21e0])
        by smtp.gmail.com with ESMTPSA id 127sm17793018pfy.56.2019.11.04.13.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:21:43 -0800 (PST)
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform
 device
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
 <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
 <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
 <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
 <db487366-b0d7-d65d-70b5-261aa439298b@gmail.com>
 <f02faa63-83bd-6be1-e014-e400d180e10c@physik.fu-berlin.de>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6a5e4644-ba7a-079d-d49d-73509bc1cf65@gmail.com>
Date:   Tue, 5 Nov 2019 10:21:39 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f02faa63-83bd-6be1-e014-e400d180e10c@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Adrian,

fine - that'll be the time when I gladly hand over testing of 030 m68k 
stuff (at least on Atari) to someone else.

Any takers?

Cheers,

     Michael

On 5/11/19 10:10 AM, John Paul Adrian Glaubitz wrote:
> Hi!
>
> On 11/4/19 8:17 PM, Michael Schmitz wrote:
>>>     2. Remove the legacy falconide driver.
>> Nack - I still use that one (because pata_falcon has no support for using interrupts with the Falcon IDE interface, and I'm unsure how much more kernel bloat libata will add). Need to check the impact of switching to pata_falcon first.
> I think we have to switch over to libata sooner or later as the old IDE
> stack has officially been deprecated now and will probably be removed
> at some point.
>
> Adrian
>
