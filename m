From: Eric Mudama <edmudama@gmail.com>
Subject: Re: libata PATA support - work items?
Date: Mon, 3 Jan 2005 14:20:40 -0700
Message-ID: <311601c905010313201d5a02fa@mail.gmail.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <311601c9050101111929aef5ba@mail.gmail.com>
	 <87f94c3705010312568b48d6e@mail.gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.192]:14964 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261901AbVACVbH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2005 16:31:07 -0500
Received: by rproxy.gmail.com with SMTP id j1so296739rnf
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2005 13:31:07 -0800 (PST)
In-Reply-To: <87f94c3705010312568b48d6e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, dan mares <dmares@dmares.com>

On Mon, 3 Jan 2005 15:56:58 -0500, Greg Freemyer
<greg.freemyer@gmail.com> wrote:
> I may be in the minority, but my company does computer forensics.  We
> routinely connect old drives to Linux boxes and make dd images of
> them.
> 
> We definately need CHS support at some level in the kernel.  If this
> were ever dropped, we would have to quit using Linux for this job.
> 
> FYI, there are hundreds if not thousands of companies that provide
> this service.  The current standard for the industry is to perform
> these images from a DOS boot floppy, but using Linux is far superior
> in my mind and there is a small but growing body of professionals
> using Linux for Computer Forensic Imaging.

Would it be a problem to keep any of the existing 2.4 or non-libata
2.6 systems around?  Since you're doing it now, I wouldn't expect it
to be a problem to keep them running so you can continue connecting to
very old hard drives.

I'm simply trying to say that it'd be nice if future libata stayed
focused on non-CHS mode stuff, since CHS has been obsolete from the
ATA specifications for years.  Revision 5 of the ATA-3 specification,
6 October 1995, made LBA support mandatory for all disk drives
claiming support of that level of the spec.  Over 9 years ago.

Obviously, forensics and data recovery are cases where you might be
working with 9+ year old hard drive, but for that I would think we can
keep the existing PATA drivers around if maintaining an older system
wasn't an option, for those who need it.

Would that work?

--eric
