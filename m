From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 11:23:56 +0300
Message-ID: <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
 <20120724204454.GC5167@liondog.tnic> <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com> <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
 <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
 <20120726180854.GD9161@aftab.osrc.amd.com> <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56068 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135Ab2G0IYj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 04:24:39 -0400
Received: by lahd3 with SMTP id d3so1982887lah.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Jul 2012 01:24:37 -0700 (PDT)
In-Reply-To: <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: linux-ide@vger.kernel.org

Hello,

You will laugh, but I've found the issue. These particular drives do
not like the fan vibration and lowering the spin speed ;) Sh*t ...
Sorry for bothering all of you and big thanks for support !

Rus

2012/7/26 Rus V. Brushkoff <brushkoff@gmail.com>:
>> Yes, probably. Right about now I'm all out of ideas about what on the
>> motherboard could be causing this. Maybe we should ask Tyan for help or
>> whether they've seen a similar issue.
>
> Already asked, but they can't reproduce this as I think that they do
> not use Linux for tests ;(
>
>>
>>> Can we see (or debug) what is happenning on bad S8005GM2NR-LE
>>> motherboard during write ?
>>
>> I don't think so, without special hardware.
>
> Hmm, what exact hardware needed for this ?
>
>>
>> Just a stab in the dark: you've done all those with the systemrescuecd
>> which has kernel 3.2, correct? Would it be possible to redo those tests,
>> especially the ones which show the slowdown, with the latest kernel -
>> 3.5 - to see whether the issue still persists?
>
> I've tried the systemrescuecd 3.0.0-beta too, its running 3.5 kernel.
>
> Rus
>
> --
> Rus



-- 
Rus
