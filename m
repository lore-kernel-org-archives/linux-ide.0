From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: libata: cdrw/dvdrom disabed after s2ram (2.6.24-rc2)
Date: Thu, 8 Nov 2007 11:58:50 -0800
Message-ID: <20071108115850.32e7adf3.akpm@linux-foundation.org>
References: <4731C86B.1040704@infracomspa.it>
	<20071107121355.5eaf4496.akpm@linux-foundation.org>
	<47333CCF.1050403@infracomspa.it>
	<20071108094958.5c9b1b22.akpm@linux-foundation.org>
	<20071108180256.GB3491@havoc.gtf.org>
	<20071108101341.6c4f88d4.akpm@linux-foundation.org>
	<20071108181905.GA4895@havoc.gtf.org>
	<20071108110240.df3214e7.akpm@linux-foundation.org>
	<4733684D.6080108@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4733684D.6080108@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, roppedisano@infracomspa.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> On Thu, 08 Nov 2007 14:49:33 -0500 Mark Lord <liml@rtr.ca> wrote:
> Andrew Morton wrote:
> >> On Thu, 8 Nov 2007 13:19:05 -0500 Jeff Garzik <jeff@garzik.org> wrote:
> >> On Thu, Nov 08, 2007 at 10:13:41AM -0800, Andrew Morton wrote:
> >>>> On Thu, 8 Nov 2007 13:02:56 -0500 Jeff Garzik <jeff@garzik.org> wrote:
> >>>> On Thu, Nov 08, 2007 at 09:49:58AM -0800, Andrew Morton wrote:
> ..
> >>> I suspect it wold be best to disable the feature for the 2.6.24 release,
> >>> then reenable it afterwards and keep doing this until the code is
> >>> sufficiently stable.
> >> Re-read my message :)
> >>
> >> The code is stable.  Behavior _by definition_ will vary by BIOS.
> >>
> >> This feature (a) enables suspend/resume, but (b) now sends random
> >> unvalidated shite to the device that we hope will work.
> >>
> >> Look at all the messages where turning on ACPI in libata _fixed_
> >> suspend/resume (because its obviously required for many, including
> >> laptops).
> > 
> > We fixed a somewhat-known number of machines and broke an unknown number. 
> > Linus will come after you with a pointy stick if he finds out.
> > 
> > Fixing previously-broken machines is nice, but breaking previously-working
> > ones gets people a lot more upset.
> > 
> >> So it's not an easy "turn it off" answer, you break shitloads of
> >> suspend/resume that way, that we just fixed.
> >>
> >> The message "_GTF unexpected object type" indicates a broken BIOS, so
> >> IMO we should proceed in that direction, blacklisting that platform.
> >>
> > 
> > Suggest that the feature be disabled until we have most of these
> > blacklistings in place.
> ..
> 
> The problem is, this code has already sat out the last release,
> and nobody noticed problems exactly because it was not enabled before.
> 
> If Jeff disables it again, then it will sit out another cycle without
> anybody exercising it.  At some point, we need to turn it on, and collect
> information about where there are problems (and fix them).
> 

We get a decent amount of testing during the -rc's.  I think it's OK to turn
a feature on during -rc and off for release while it gets settled in.

Hopefully Matthew's fix will address this particular problem.
