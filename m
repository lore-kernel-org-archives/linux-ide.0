From: Greg KH <greg@kroah.com>
Subject: Re: long boot delay for SATA cdrom on current 2.6.17-git
Date: Thu, 29 Jun 2006 22:10:47 -0700
Message-ID: <20060630051047.GA8150@kroah.com>
References: <20060630025341.GA4675@kroah.com> <20060630044912.GA2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:28564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750971AbWF3FMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 01:12:51 -0400
Content-Disposition: inline
In-Reply-To: <20060630044912.GA2592@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jun 30, 2006 at 01:49:12PM +0900, Tejun Heo wrote:
> On Thu, Jun 29, 2006 at 07:53:41PM -0700, Greg KH wrote:
> > With Linus's current -git tree (like 2.6.17-git13), it takes a long time
> > to boot my laptop.  Turns out the SATA cdrom discovery process is taking
> > up many seconds.
> 
> Was any previous version okay?  No timeout messages on boot?

2.6.17 and previous was just fine, no timeout messages that I remember
(definatly no slowdown on boot.)

I can do a git bisect tomorrow to try to narrow it down to the single
changeset if you want me to.

> > This laptop does not have a SATA hard drive, only a SATA cdrom drive.
> > I've included the boot log below and trimmed it after the delay
> > happened, as I doubt anything after it would be relevant.
> > 
> > Is there any patch I can test to help fix this?
> 
> This seems to be the ghost device problem which occurs when the first
> device is ATAPI but the second slot is empty.
> 
> > My .config is also attached, if that helps any.
> 
> Please try the following patch.

Ok, will do.

thanks,

greg k-h
