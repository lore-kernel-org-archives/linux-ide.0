From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Output
Date: Fri, 13 Jan 2006 13:18:08 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0601131316400.5563@shark.he.net>
References: <18a8ddb18a33a6.18a33a618a8ddb@shaw.ca> <43C817E4.3090804@crossflux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:20713 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965000AbWAMVSJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2006 16:18:09 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 13:18:08 -0800
In-Reply-To: <43C817E4.3090804@crossflux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Seitz <jseitz@crossflux.com>
Cc: linux-ide@vger.kernel.org

On Fri, 13 Jan 2006, Justin Seitz wrote:

>
> >I am having problems getting the VIA VT8251 southbridge SATA (AHCI) support running on Fedora Core 4. Here is all the information i could possibly give you.
> >
> >
> >Ok I am trying to apply the patch found at
> >http://seclists.org/lists/linux-kernel/2005/Dec/3220.html
> >
> >
> >
> >So here is the patch code:
> >--- ahci.c.orig 2005-11-21 14:24:48.000000000 +0800
> >+++ ahci.c 2005-11-21 14:25:35.000000000 +0800

[snip]

> >Now when I run:
> >
> >patch -p1 ahci.c < ahci-patch
> >
> >I get the following output:
> >
> >missing header for unified diff at line 3 of patch
> >patching file ahci.c
> >Hunk #1 FAILED at 59.
> >Hunk #2 FAILED at 127.
> >Hunk #3 succeeded at 198 with fuzz 2 (offset 13 lines).
> >Hunk #4 succeeded at 240 with fuzz 2 (offset -1 lines).
> >Hunk #5 FAILED at 280.
> >Hunk #6 FAILED at 311.
> >Hunk #7 succeeded at 1140 with fuzz 2 (offset 40 lines).
> >4 out of 7 hunks FAILED -- saving rejects to file ahci.c.rej
> >
> >
> >*I really need to get this SATA controller working on this VIA VT8251 board on Fedora Core 4. What am I doing wrong to get this patch installed correclty? Does anyone have a fully patched ahci.c that compiles into the kernel properly?
> >
> >JS
> >
> >ps Here is the output from ahci.c.rej:*

Hi,

You should get the patch from here:
  http://marc.theaimsgroup.com/?l=linux-ide&m=113436067230517&w=2

The one that you referred to is quite whitespace-damaged.

-- 
~Randy
