From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: libata PATA support - work items?
Date: Mon, 3 Jan 2005 15:56:58 -0500
Message-ID: <87f94c3705010312568b48d6e@mail.gmail.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <311601c9050101111929aef5ba@mail.gmail.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.206]:8807 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261776AbVACU47 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2005 15:56:59 -0500
Received: by wproxy.gmail.com with SMTP id 36so479160wra
        for <linux-ide@vger.kernel.org>; Mon, 03 Jan 2005 12:56:59 -0800 (PST)
In-Reply-To: <311601c9050101111929aef5ba@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Mudama <edmudama@gmail.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, dan mares <dmares@dmares.com>

On Sat, 1 Jan 2005 12:19:20 -0700, Eric Mudama <edmudama@gmail.com> wrote:
> On Thu, 30 Dec 2004 18:42:33 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
> >     2. C/H/S addressing; libata currently hardcoded to use LBA
> 
> 
> Are there really people who want to run a newer 2.4 or a 2.6 kernel,
> who have disks that do not support LBA mode?  CHS will never address
> more than 32GB of the drive (unless you use vendor unique
> implementations) and heck, most companies don't even build drives that
> small anymore...  CHS is very messy, LBA is so much simpler.   Can we
> just stick with that?
> 
> --eric

I may be in the minority, but my company does computer forensics.  We
routinely connect old drives to Linux boxes and make dd images of
them.

We definately need CHS support at some level in the kernel.  If this
were ever dropped, we would have to quit using Linux for this job.

FYI, there are hundreds if not thousands of companies that provide
this service.  The current standard for the industry is to perform
these images from a DOS boot floppy, but using Linux is far superior
in my mind and there is a small but growing body of professionals
using Linux for Computer Forensic Imaging.

Greg
-- 
Greg Freemyer
