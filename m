Return-Path: <SRS0=rygF=Y5=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8B6CA9ED5
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 06:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047FF217F4
	for <linux-ide@archiver.kernel.org>; Tue,  5 Nov 2019 06:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va5E/Nlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbfKEG6A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:58:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfKEG6A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2019 01:58:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so13349069pgt.7;
        Mon, 04 Nov 2019 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=I0gO0Bt2g4K6r/PdhE8H159lL+rclEdWAxfWmMAD044=;
        b=Va5E/NlgTaapARtglVRiF0cWY4IB9bRltjvKR1YgO5Z+jnL5fuycbmPV8BElGggi6I
         La9rEFLaHQEp/MYC31+s1nff8lRvmJSPG1V5+iAeZopqXv19sj8drP0JPGM47JhiYRc/
         VBizZTOGkb/J/Az67DK1uH0ui4KxlLtRrNL/fpUdRBTB1OecCxNdyz7IWDWxIcnAKuO5
         f5CEKOfnpfZXxZhBzl4qOIZajFTu+GiH98+0Rp97Wntj2hEzC0fjvTZD6lTRTQ4jMOUR
         GjXfg+B2vp/HFwJo4sSDHOlkMZLutdVVgLGVUOUUg3VsnWJgaxBjm52AdOKH5QPI8YNv
         tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I0gO0Bt2g4K6r/PdhE8H159lL+rclEdWAxfWmMAD044=;
        b=URM5MqU+BrnXa54+6q/ZYoCjvV/ot8YzOHEmzfZ0imD66xGD9va8TrajBrbpGZdu6m
         BAeotPG/ypslG/yybAcjEmGvN7QGxUYjhTJj8gpUaolewU91ua3REyRZyjca+LsEJyJN
         qCasMuZskxNjpoPCmbTdUfVSvSLhI3O0Ue0l6N6Yeg1ybnir6PrKoZGSj1StsRGgml8b
         /Tis2c5SVnDPzUwcrjlW6nwdrhoyH1wuCtAEwuzsxp9CGO5IuUSV1e2Ftp8d+ZAGYNzj
         Jo3bePdv2tfvqLmqgJGhsw7LgbYjeFjmgS3V/+ciQP1O0hvJuiRcnDfwryT5YO6rt3cW
         V9xg==
X-Gm-Message-State: APjAAAVKJtGoYNdWb4IeNhC9csmA1LIXARFs/usJkOC4w0e/wiXd/DWP
        MPCN9wnf/adrD5LcNUPxsfk=
X-Google-Smtp-Source: APXvYqywff/STiypdBHmPCIEIRMfO3opFaH4SIcCFuVbQLPXJuUkdT2AMv8X200U7YzC773migMoYw==
X-Received: by 2002:a65:654e:: with SMTP id a14mr11007673pgw.170.1572937079800;
        Mon, 04 Nov 2019 22:57:59 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id a5sm22401360pfk.172.2019.11.04.22.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 22:57:59 -0800 (PST)
Subject: Re: [PATCH RESEND v2 0/2] Convert Atari Falcon IDE driver to platform
 device
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1569470064-3977-1-git-send-email-schmitzmic@gmail.com>
 <7bd80760-0d46-3b3d-16e7-41cbc9169822@kernel.dk>
 <CAMuHMdWFoC8YUbmW8J7tJSsq4b67WkjyRzhkW=yfrEEJJmsZKQ@mail.gmail.com>
 <edb1ab21-9b60-4a25-b18c-76173ae6b28f@gmail.com>
 <CAMuHMdU6mcW_EcmE3bCTRGVCdouFPDoawTVyyGJP50oGES=duA@mail.gmail.com>
 <db487366-b0d7-d65d-70b5-261aa439298b@gmail.com>
 <f02faa63-83bd-6be1-e014-e400d180e10c@physik.fu-berlin.de>
 <6a5e4644-ba7a-079d-d49d-73509bc1cf65@gmail.com>
 <317f3b1e-20a8-65eb-3a26-3bb79dc22786@physik.fu-berlin.de>
Cc:     Linux/m68k <linux-m68k@vger.kernel.org>, linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6fb6c69f-ef48-1b35-bbb2-011c12bb02b6@gmail.com>
Date:   Tue, 5 Nov 2019 19:57:54 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <317f3b1e-20a8-65eb-3a26-3bb79dc22786@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Adrian,

Am 05.11.2019 um 10:42 schrieb John Paul Adrian Glaubitz:
> On 11/4/19 10:21 PM, Michael Schmitz wrote:
>> fine - that'll be the time when I gladly hand over testing of 030 m68k stuff (at least on Atari) to someone else.
>>
>> Any takers?
>
> I'm not sure I understand the reasoning. Does the pata_falcon driver not
> work on a real Atari?

I honestly don't know. I never tried that. With only 14 MB of RAM, 
keeping code size to the absolute minimum is quite important to me.

Aside from the lack of interrupt support for the Falcon IDE adapter in 
pata_falcon: I recall some criticism regarding the size of libata a few 
years back, combined with suggestion to allow libata to be built in a 
more modular fashion so features not requried to support what is 
essentially a dumb PIO mode IDE interface could be excluded. Not sure 
what became of that.

I'd have to test both the impact of missing IDE interrupt support, and 
that of code size when using either the old IDE code or libata at some 
stage. Having a stable SCSI driver for the Falcon is one of the 
prerequisites to that. We've just had a lot of fun with some of the m68k 
SCSI drivers breaking in the 5.x kernel series, so I'd rather leave IDE 
alone for now, or someone else step in and sort that particular mess out.

Cheers,

	Michael


>
> Adrian
>
