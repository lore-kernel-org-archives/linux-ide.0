From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/n] libata-core.c conversion to new debugging scheme, part 1 (25% done)
Date: Thu, 1 Jun 2006 02:14:33 -0400
Message-ID: <20060601061433.GC5869@havoc.gtf.org>
References: <20060531054633.GA4875@zmei.tnic> <20060531063957.GD14179@havoc.gtf.org> <20060601053849.GB8523@gollum.tnic> <447E849B.8020208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:34232 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751811AbWFAGOf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2006 02:14:35 -0400
Content-Disposition: inline
In-Reply-To: <447E849B.8020208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, linux-ide@vger.kernel.org

On Thu, Jun 01, 2006 at 03:09:31PM +0900, Tejun Heo wrote:
> Those ATA_MSG_* constants designates two things..
> 
> * message level (debug, info, warning...)
> * message origin (probe, intr...)
> 
> although above distinction isn't clear for some constants.  libata now 
> uses ata_port/dev_printk() macros to print messages and the second 
> argument is message level (KERN_INFO, KERN_WARNING...), which carries 
> duplicate information as above ATA_* constants.  IMHO, it would be 
> better to fold the two into one.  e.g.
> 
>   ata_port_printk(ap, ATA_MSG_INFO, "blah blah\n");
> 
> instead of
> 
>   if (ata_msg_info(ap))
> 	ata_port_printk(ap, KERN_INFO, "blah blah\n");
> 
> Some constants probably need to be adjusted a bit though.

Although I agree, it is best to integrate the msg_enable support in
"waves", not doing too much at once, so that we have time to reflect
better on the next step -- just like what we're doing now.

The ata_msg_xxx level and KERN_xxx level are not perfectly mapped, nor
should they be, so the proposed scheme may not work out once we have all
the message levels integrated.

The most important goal to achieve is (a) eliminating the need for users
to rebuild libata to get verbose messages and (b) allowing fine-grained
per-port verbose debugging and tracing.  We can address cleanups after
those goals.

	Jeff



