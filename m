From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: seagate disks on sil3114 - slow?
Date: Fri, 26 Oct 2007 07:49:37 +0200
Message-ID: <1193377777.5984.13.camel@localhost>
References: <1192683290.5720.38.camel@localhost>
	 <4716EA25.7060205@garzik.org> <1192697546.5720.51.camel@localhost>
	 <472151D3.6060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:58581 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbXJZFwW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Oct 2007 01:52:22 -0400
In-Reply-To: <472151D3.6060403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 2007-10-26 at 11:32 +0900, Tejun Heo wrote:
> Soeren Sonnenburg wrote:
> > On Thu, 2007-10-18 at 01:07 -0400, Jeff Garzik wrote:
> >> Soeren Sonnenburg wrote:
> >>> Dear all,
> >>>
> >>> I just now realize that all disk i.o. on my machine is quite slow
> >>> compared with the pata disks I had before. Furthermore I recognized that
> >>> I only have seagates (ST3400832AS,ST3400620AS,ST3750640AS,ST3750640AS)
> >>> connected to a sil3114 controller.
> >>>
> >>> Being on kernel 2.6.23.1 and stumbling across
> >>> http://home-tj.org/wiki/index.php/Sil_m15w I am now wondering if this
> >>> patch made it already in kernel (or when it will make it if it is not
> >>> yet in/why never).
> >> Are you sure you have a 3114?  the mod15write isn't applied to that chip.
> >> Does your dmesg say "applying Seagate errata fix (mod15write workaround)" ?
> > 
> > At least lspci / dmesg indicates I have a 3114 ... but maybe the problem
> > is something else. Is there a raw device speed, readonly benchmark to
> > check whether things are as expected?

looks like I did not fully reply to this one: yes I have a 3114 and
based on Bernds patch to enable m15w support for sil3114 I added the
first two drives to the blacklist and yes I saw the applying mod15write
workaround messages for these disks afterwards. These disks attached to
the internal promise seems to work stably now (uptime is a week now),
with the occasional error that thanks to the new EH is successfully
recovered from - good job!!

> "dd if=/dev/sdX of=/dev/null bs=1M"?  Also, does changing IO scheduler
> to deadline make any difference?

OK I knew that one... about 50-60M/s - sounds reasonable, but if I
understand the m15w problem correctly it can only be triggered on
writes...

Soeren
