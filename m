From: Marc Singer <elf@buici.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 15 May 2004 18:00:08 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040516010008.GC23743@buici.com>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040515173430.GA28873@havoc.gtf.org> <200405151958.03322.bzolnier@elka.pw.edu.pl> <40A69848.9020304@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:64906 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264844AbUEPBAK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 21:00:10 -0400
Content-Disposition: inline
In-Reply-To: <40A69848.9020304@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 06:23:04PM -0400, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >On Saturday 15 of May 2004 19:34, Jeff Garzik wrote:
> >>On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>>- host drivers should request/release IO resource
> >>> themelves and set hwif->mmio to 2
> >>
> >>Don't you mean, hwif->mmio==2 for MMIO hardware?
> >
> >
> >It is was historically for MMIO, now it means that driver
> >handles IO resource itself (per comment in <linux/ide.h>).
> 
> Maybe then create a constant HOST_IO_RESOURCES (value==2) to make that 
> more obvious?
> 

Please allow me to advocate for the naive.

While I do not in favor of lengthy commented discourses within the
code for all of the usual reasons, I do believe that interface
documentation is always welcome.  It encourages everyone to learn and
follow the rules.  It allows the subsystem maintainer to establish a
boundary so that accessing lower-level structures are left alone.

I'm not talking about a HOWTO as we know it.  Let's look at this mmio
flag.  How about writing this at a very minimum.

  	int mmio; /* 0: iommio; <insert appropriate direction */
		  /* 2: custom; driver must reserve & release system resources */
		  

Certainly, I'd rather see something along the lines of a full
description.

	int mmio;
	    /* This field controls whether or not the driver blah,
	       blah.  If the driver needs to reserve system resources,
	       e.g. ports of memory, set the value to 2 and blah, blah. */

It isn't much, but it goes a long way.
