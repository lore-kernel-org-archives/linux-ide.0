From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] cleanup drivers/ata/Kconfig
Date: Tue, 15 Aug 2006 11:39:29 +0200
Message-ID: <20060815093929.GL3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813210106.GO3543@stusta.de> <20060815075144.GA31109@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39178 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965325AbWHOJja (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 05:39:30 -0400
Content-Disposition: inline
In-Reply-To: <20060815075144.GA31109@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Aug 15, 2006 at 12:51:44AM -0700, Greg KH wrote:
> On Sun, Aug 13, 2006 at 11:01:06PM +0200, Adrian Bunk wrote:
> > On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.18-rc3-mm2:
> > >...
> > >  git-libata-all.patch
> > >...
> > >  git trees
> > >...
> > 
> > This patch contains the following cleanups:
> > - create a menu for ATA
> > - replace the dependencies on ATA with an "if ATA"
> 
> Why do this?  Are we going to be doing this for all subsystems?
> 
> It seems like a bit of unnecessary churn to me...

The following two are exactly equivalent:

<--  snip  -->

tristate BAR1 "bar1"
	depends on FOO

tristate BAR2 "bar2"
	depends on FOO

<--  snip  -->

if FOO

tristate BAR1 "bar1"

tristate BAR2 "bar2"

endif

<--  snip  -->

I'd say the latter is a bit better, but there's no reason to convert all 
subsystems since the two forms are equivalent.

In this case, I was looking for a way to fix the breakage of the ATA 
menu indentation due to SATA_INTEL_COMBINED, and this is the solution I 
did choose.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

