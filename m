From: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: tighten ATA kconfig dependancies
Date: Sun, 16 Jul 2006 11:14:22 -0700
Message-ID: <1153073662.7604@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:37799 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751139AbWGPSOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jul 2006 14:14:24 -0400
Received: from shark.he.net ([127.0.0.9]) by xenotime.net for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 11:14:22 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



> On Sat, Jul 15, 2006 at 08:45:56AM +0200, Arjan van de Ven wrote:
> > On Sat, 2006-07-15 at 08:38 +0200, Sam Ravnborg wrote:
> > > On Sat, Jul 15, 2006 at 07:49:08AM +0200, Arjan van de Ven wrote:
> > > > On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> > > > > A lot of prehistoric junk shows up on x86-64 configs.
> > > > 
> > > > 
> > > > ... but in general it helps compile testing if you're hacking stuff;
> > > > if your hacking IDE on x86-64 you now have to compile 32 bit as
well to
> > > > see if you didn't break the compile for these as well
> > > > 
> > > > So please don't do this, just disable them in your config...
> > > 
> > > An i686 cross compile chain seems to be the natural choice here
> > 
> > the point is that it doesn't fall out naturally, and thus things get
> > needlessly missed.
> 
> It seems the main question is:
> Is the kernel configuration mainly designed for users or for developers?
> 
> For users, showing drivers for hardware that is not present on their 
> platform only causes confusion.
> 
> Only developers who want to do compile tests could benefit from 
> compiling such drivers.
> 
> IMHO the kernel configuration is mainly designed for users.

or at least should be.

> We could do some kind of (X86_32 || DEVELOPER_COMPILE_TEST).

Let's not complicate it more.

> Or simply disable this driver on other platforms - these are only 
> compile errors and amongst all possible problems in the kernel compile 
> errors are amongst my least worries (obvious error, usually quickly 
> fixed after the first bug report).


---
~Randy
