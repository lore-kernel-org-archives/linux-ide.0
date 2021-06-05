Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F410C4743C
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 01:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD776108E
	for <linux-ide@archiver.kernel.org>; Sat,  5 Jun 2021 01:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFEBna (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEBna (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jun 2021 21:43:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567CDC061766;
        Fri,  4 Jun 2021 18:41:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so6846417pjq.3;
        Fri, 04 Jun 2021 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yPepyh5pFcu4IryFiHSZGyfOI5NXkyudmN+uoW1u4VE=;
        b=Ml1zbYrmB28wGxglbJBpFhFApD0HGmB6o3sByiu3gx7PpuVgffC9XprI1pEMLiIXON
         TGDcDmM2W2s0d8a2TxVAsECBcFsr6Tt8sUdDqqYMnhaUtBKh4LPh3hM70OrixB1MmS2g
         Gj/01+HTkEd6O/CjNX2UGXwCYKgqkObBAshU8wbq7Z5fUMmDQdqyuCw4rvxhb//OftW+
         qCXE1RXwgPR/00vZz93baGPK49nzjwR4g9OIZs5V/4b5O/i0iaIusUnjO1IF1ewTSOfa
         yOXEHCwa6YiPJJOCAK2O8D/vyys3yP4jhwKjse9YVz78aCcOlVOisDPWiWsD+pEfHw1h
         SdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yPepyh5pFcu4IryFiHSZGyfOI5NXkyudmN+uoW1u4VE=;
        b=GVfs45YM+iTMQ+4YL70olgNpFsjRr45HxvWWdsW9+jOJiqG/CQrfII88KY/FvSd9Sw
         SbtS3eA97WRh+eSH62yMKr8rGWdATsHRVlygD5SLguViW5+JfuvOueK4Vc6hxv8LaGUe
         uFHOHOhRsa3eUi1flCJF03mBvQnDGF4wXGsPeLAeHmhs0P2n1LgUKZA4bSJO5NGvnnPm
         P3c0Eb3FVAwTJTPBmavYCRSSOxRPZRoXLpATWi2vURoUZB8eUqyNPyos3QZpMnqXMsTY
         56oeVBEoNlshVevj70KKTnVIBr7v5GVnAN0hS2+/rSE5vR/Z6Ji8bqoQnazTSZR/7w/C
         3XQg==
X-Gm-Message-State: AOAM532tl+G1wHeYdrCHFgdYpljOK7RtviOvvAr1ITomNkX5XSXUbfgm
        6j+kZsleDzoVTL6gs7PKeqyyer2d5zc=
X-Google-Smtp-Source: ABdhPJxupftwHWmXS/jn4y0pP5bYo7FVS8iq6mBbFUsRODtJL9dy64zzGHsDJF+o36c1qBqi8FXcsQ==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr19907548pjb.2.1622857288586;
        Fri, 04 Jun 2021 18:41:28 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id cl2sm5485529pjb.31.2021.06.04.18.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 18:41:28 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] m68k: io_mm.h: conditionalize ISA address
 translation on Atari
To:     Brad Boyer <flar@allandria.com>
References: <CAMuHMdUskb3oicq8Kbf6MY_4mn4-Y1pJ-om4fny7k48gndscgg@mail.gmail.com>
 <1622611267-15825-1-git-send-email-schmitzmic@gmail.com>
 <1622611267-15825-2-git-send-email-schmitzmic@gmail.com>
 <25ab336d-e0e0-41a8-d468-ecbf8d83d2b@linux-m68k.org>
 <143313da-d294-f89b-d285-235230514c5a@gmail.com>
 <d7165fdd-9269-7bd2-185-c6193f864722@linux-m68k.org>
 <535b7829-f16f-4ddc-a676-dbb10c7a4a35@gmail.com>
 <20210604224955.GA12141@allandria.com>
Cc:     Finn Thain <fthain@linux-m68k.org>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-ide@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <eefa79e9-01d3-9179-9ca6-57500b9ab7c2@gmail.com>
Date:   Sat, 5 Jun 2021 13:41:22 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210604224955.GA12141@allandria.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Brad,

Am 05.06.2021 um 10:49 schrieb Brad Boyer:
> On Fri, Jun 04, 2021 at 07:30:00PM +1200, Michael Schmitz wrote:
>>>> I'm still unsure whether changing the default branch for the sake of
>>>> fixing Atari behaviour is a sane idea - I was hoping for comments either
>>>> way.
>>>>
>>>
>>> You mean, what happens if a random m68k platform (other than amiga, atari
>>> and q40) were to adopt CONFIG_ISA? I guess it would be nice if that would
>>> 'just work' but it's probably never going to be needed.
>>
>> The NULL default was meant to catch incorrect use of config options related
>> to CONFIG_ISA. My repurposing the default branch for Atari's needs (no
>> translation for IDE) defeats that. But the chance that we run into such
>> incorrect use in the future are pretty slim indeed.
>
> Well, we could in theory add a trex socket driver to get PCMCIA support
> for the PowerBook 190 hardware. There was a driver for that in ppc for
> the PowerBook 5300 which uses the same chipset. I believe the PCMCIA
> drivers use these same macros in spite of not being considered ISA.

Correct - the PCMCIA device drivers use IO port addresses in the ISA 
port range.

> I don't see anything in drivers/pcmcia that is obviously an m68k
> system even though I'm pretty sure I remember discussions of supporting
> such hardware in the past.

There's the APNE driver (Amiga PCMCIA NE2000 clone), which is already 
catered for by the current code in io_mm.h. I remember seeing patches 
for that driver that would allow support of a variant of the APNE card 
that were hard to integrate in the current NE clone code framework. 
Didn't consider adding another isa_type for that card at the time - I'll 
revisit these patches if I can find them again.

Supporting PB190 PCMCIA hardware requires adding a new isa_type and the 
corresponding IO translation cases. Not much more, for all I can see. 
Existing chipset drivers from other architectures ought to work already. 
Maybe add a specific block_input() hook as for APNE (but I surmise that 
might just be code duplication from generic code in lib8390.c - didn't 
check).

Not sure what card socket code the APNE driver uses - must be one of the 
generic variants from drivers/pcmcia. If your PB190 needs something not 
already in there, we'd need to add that as well.

> Is PCMCIA support something we should also consider in all of this?

Absolutely.

Cheers,

	Michael


>
> 	Brad Boyer
> 	flar@allandria.com
>
