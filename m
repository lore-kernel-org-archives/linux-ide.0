From: "Marko Koivusalo" <marko.koivusalo@gmail.com>
Subject: Re: Promise TX4 performance problems
Date: Sun, 13 Apr 2008 02:20:38 +0300
Message-ID: <cdcaea5a0804121620x6fe3dd55w5deeb3021d256793@mail.gmail.com>
References: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
	 <20080412162628.334d66f1@core>
	 <cdcaea5a0804121350n167b3715y4a0e52d543253423@mail.gmail.com>
	 <18433.12313.976468.250059@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:46042 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbYDLXUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 19:20:39 -0400
Received: by an-out-0708.google.com with SMTP id d31so259232and.103
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 16:20:38 -0700 (PDT)
In-Reply-To: <18433.12313.976468.250059@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

>  That includes overheads from whatever file system / raid layers
>  you have on top of the device. Please do the dd straight to
>  /dev/sdd or /dev/sdd1.
>
>  Also, I note that while you have an Intel 845 chipset, your kernel
>  doesn't mention either the local APIC or the I/O APIC. I would have
>  expected both to be present; using them typically results in less
>  IRQ sharing and lower IRQ handling overheads. Might be worthwhile
>  to try to enable them.
>
>  /Mikael

I think I've figured out what's the problem.

Measuring directly from device performance increased up to 13MB/s.
After enabling APIC & I/O APIC it was up to 18MB/s. I tried to yank
all other controllers but it didn't have any effect. This ruled out
pretty much everything except the Promise TX4 .. and the HDD itself. I
tried to plug disk into motherboard controller (HPT374) and it gives
me exactly same write performance ... 18MB/s.

Apparently this brand new 1 Tt Western Digital is either amazingly
slow on write or I have faulty unit.

Model number: WDC WD1000FYPS-01ZKB0
Model name: Western Digital RE2-GP (Green Power)

Western Digitals Specification for the drive state:
Transfer Rate (Buffer To Disk)	84 MB/s (Sustained)

Uh, I'm a little puzzled .. what to do next .. I don't think I want to
have drive with real world 5-10MB/s write performance .. replacing it
trough warranty may be troublesome since it works fine otherwise.
Perhaps I'll contact WD directly ...

It would seem to be as always, problems is where you least expect it to be.

--
Marko Koivusalo
