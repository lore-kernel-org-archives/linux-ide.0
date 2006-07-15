From: Adrian Bunk <bunk@stusta.de>
Subject: Re: tighten ATA kconfig dependancies
Date: Sat, 15 Jul 2006 12:28:25 +0200
Message-ID: <20060715102825.GR3633@stusta.de>
References: <20060715053418.GA5557@redhat.com> <1152942548.3114.4.camel@laptopd505.fenrus.org> <20060715063827.GA24579@mars.ravnborg.org> <1152945956.3114.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51979 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932497AbWGOK21 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 06:28:27 -0400
Content-Disposition: inline
In-Reply-To: <1152945956.3114.6.camel@laptopd505.fenrus.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Sat, Jul 15, 2006 at 08:45:56AM +0200, Arjan van de Ven wrote:
> On Sat, 2006-07-15 at 08:38 +0200, Sam Ravnborg wrote:
> > On Sat, Jul 15, 2006 at 07:49:08AM +0200, Arjan van de Ven wrote:
> > > On Sat, 2006-07-15 at 01:34 -0400, Dave Jones wrote:
> > > > A lot of prehistoric junk shows up on x86-64 configs.
> > > 
> > > 
> > > ... but in general it helps compile testing if you're hacking stuff;
> > > if your hacking IDE on x86-64 you now have to compile 32 bit as well to
> > > see if you didn't break the compile for these as well
> > > 
> > > So please don't do this, just disable them in your config...
> > 
> > An i686 cross compile chain seems to be the natural choice here
> 
> the point is that it doesn't fall out naturally, and thus things get
> needlessly missed.

It seems the main question is:
Is the kernel configuration mainly designed for users or for developers?

For users, showing drivers for hardware that is not present on their 
platform only causes confusion.

Only developers who want to do compile tests could benefit from 
compiling such drivers.

IMHO the kernel configuration is mainly designed for users.

We could do some kind of (X86_32 || DEVELOPER_COMPILE_TEST).

Or simply disable this driver on other platforms - these are only 
compile errors and amongst all possible problems in the kernel compile 
errors are amongst my least worries (obvious error, usually quickly 
fixed after the first bug report).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

