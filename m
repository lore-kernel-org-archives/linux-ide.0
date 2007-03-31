From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [1/4] 2.6.21-rc5: known regressions (v2)
Date: Sat, 31 Mar 2007 17:01:23 +0200
Message-ID: <20070331150123.GU14134@stusta.de>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org> <20070330213209.GM14134@stusta.de> <20070331002310.GA3213@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070331002310.GA3213@ellpspace.math.ualberta.ca>
Sender: linux-acpi-owner@vger.kernel.org
To: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 30, 2007 at 06:23:10PM -0600, Michal Jaegermann wrote:
> On Fri, Mar 30, 2007 at 11:32:09PM +0200, Adrian Bunk wrote:
> > 
> > Subject    : kernels fail to boot with drives on ATIIXP controller
> >              (ACPI/IRQ related)
> > References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=229621
> >              http://lkml.org/lkml/2007/3/4/257
> > Submitter  : Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
> > Status     : unknown
> 
> I have now even better one with pata_via.  A kernel, which for
> all practical purposes is 2.6.21-rc5, not only refuses to boot
> (and I cannot find some option combination which would allow me to
> do so anyway) but simply refuses to read _any_ data from a media.
> This included a partitioning information.
> 
> Earlier kernel on the same hardware boots without raising any fuss.
> 
> Details are collected as
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=234650

If I understand this correctly, a plain 2.6.20 kernel is already broken?

>    Michal

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

