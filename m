From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATA drivers in libata?
Date: Sun, 13 Feb 2005 19:25:03 -0500
Message-ID: <20050214002503.GA16558@havoc.gtf.org>
References: <420FCE4F.7010205@pobox.com> <200502140019.j1E0JV66028132@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:30378 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261321AbVBNAZT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Feb 2005 19:25:19 -0500
Content-Disposition: inline
In-Reply-To: <200502140019.j1E0JV66028132@falcon30.maxeymade.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@maxeymade.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Feb 13, 2005 at 06:19:31PM -0600, Doug Maxey wrote:
> 
> On Sun, 13 Feb 2005 17:01:51 EST, Jeff Garzik wrote:
> >Mark Hahn wrote:
> >>>* With ATA passthru (in libata-dev currently), libata supports SMART and 
> >>>the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
> >>>supporting other ioctls?
> >> 
> >> 
> >> is there some other mechanism to en/disable write caching?
> >
> >Besides the SG_IO | HDIO_DRIVE_CMD | HDIO_DRIVE_TASK | 
> >HDIO_DRIVE_TASKFILE ioctls?  Nope.
> >
> >	Jeff
> 
> One thing that I would hope for is the ability to recognize that a drive
> may prefer the use of write cache be set by the drive, defaulting to off,
> and not have to come back later and turn it off.  Certain drives destined
> to be used in server class machines will be coming that way.

Chuckle.  I saw you had this discussion with Bart also.

Although libata doesn't touch the write-cache setting right now, I
reserve the right to do so in the future.

Therefore, situations where the write cache is to be disabled should
modify their initscripts, just like you would if you wish to tune your
drive at boot using hdparm(1) or blktool(1).

	Jeff



