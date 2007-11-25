From: Adrian Bunk <bunk@kernel.org>
Subject: Re: kernel bugzilla is FPOS (was: Re: "buggy cmd640" message
	followed by soft lockup)
Date: Sun, 25 Nov 2007 22:36:40 +0100
Message-ID: <20071125213640.GC18284@stusta.de>
References: <200711222007.12497.elendil@planet.nl> <200711252107.23926.rjw@sisk.pl> <20071125203236.GA18284@stusta.de> <200711252228.07312.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40917 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752302AbXKYVgx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Nov 2007 16:36:53 -0500
Content-Disposition: inline
In-Reply-To: <200711252228.07312.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Natalie Protasevich <protasnb@gmail.com>

On Sun, Nov 25, 2007 at 10:28:06PM +0100, Rafael J. Wysocki wrote:
> On Sunday, 25 of November 2007, Adrian Bunk wrote:
>..
> > First of all, Bugzilla is a quite often used bug tracker in the open 
> > source world [1], so many users already know it.
> > 
> > But more important, "it pretends to require them to spend" isn't true 
> > because there's no pretending - we actually often require bug reporters 
> > to spend a lot of time on the bug report (e.g. when asking for 
> > bisecting).
> 
> But not *initially*.
> 
> We should not confuse *debugging* with *reporting bugs*.  While the former is
> actually more difficult and more time consuming than writing the code in which
> the bug is present, the latter should be as simple as sending an email.

For hardcore geeks like you and me sending an email might be easier than 
using some web interface.

Normal humans tend to be more accustomed to web interfaces, and 
following the instructions on some web page is _much_ easier than 
reading three text files for knowing what to write in an email.

> > I'm also sometimes writing bug reports in different areas, and in my 
> > experience it doesn't matter whether it's web-based Bugzilla, the 
> > email-based Debian bug tracker or whatever else system - the time spent 
> > on a good bug report is not spend on pasting the text whereever or on 
> > clicking on a few boxes, the time is spent on tracking the issue down 
> > and writing a good bug report.
> 
> Apparently, you are expecting the reporters do *debug* problems, while they need
> not be aware of how to do that.
> 
> IMHO, we should make reporting problems as simple as reasonably possible and

Agreed, and as said above simple = web interface.

>...
> > What matters for a bug reporter is to get a solution for his problem 
> > within a reasonable amount of time.
> 
> Still, it's annoying if you attach tons of information to the report and that
> information does not turn out to be useful.

Agreed.

> > > Also, some developers do not consider the Bugzilla as a useful thing and
> > > wouldn't like to use it (which is why this thread has appeared, among other
> > > things ;-)).
> > >...
> > 
> > And that's part of the problem.
> > 
> > Bugzilla is a usable tool, but it isn't the only tool available.
> > 
> > If there was one tool all developers would be willing to use that would 
> > be a reason why we should switch to whatever tool this is.
> 
> The choice of the tool should be a result of the choice of a *method*.  IOW,
> we have to know our needs and choose the tool that satisfies them or write one
> if it doesn't exist.
> 
> For now, IMHO, we don't really know what we need.

Even worse:
Different people have different opinions what they need and what they 
don't want...

> Greetings,
> Rafael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

