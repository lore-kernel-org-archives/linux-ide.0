From: Greg KH <greg@kroah.com>
Subject: Re: long boot delay for SATA cdrom on current 2.6.17-git
Date: Thu, 29 Jun 2006 22:20:22 -0700
Message-ID: <20060630052021.GA4722@kroah.com>
References: <20060630025341.GA4675@kroah.com> <20060630044912.GA2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:152 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751007AbWF3FUp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 01:20:45 -0400
Content-Disposition: inline
In-Reply-To: <20060630044912.GA2592@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jun 30, 2006 at 01:49:12PM +0900, Tejun Heo wrote:
> On Thu, Jun 29, 2006 at 07:53:41PM -0700, Greg KH wrote:
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

Yeah, that worked great, no timeout issues anymore!  Do you want to see
the boot log again from this?

Thanks for the quick response.

greg k-h
