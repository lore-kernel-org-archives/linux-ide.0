From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Per ATA host sysfs attributes?
Date: Tue, 10 Mar 2009 19:07:42 -0400
Message-ID: <49B6F2BE.3000509@pobox.com>
References: <49B6C99B.9030507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54320 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbZCJXHt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 19:07:49 -0400
In-Reply-To: <49B6C99B.9030507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Guys,
> 
> I have added IRQ coalescing to sata_mv, but need a way to activate/tune it.
> There are two simple parameters:  an IRQ count threshold, and a time 
> threshold.
> 
> Whenever either the count or the time threshold is exceeded,
> the chip will generate an interrupt (assuming at least one completed 
> event).
> 
> These two parameters are per-chip (actually, per group of four ports 
> within the chip).
> How can I export these for setting/query withing sysfs ?
> 
> It is all rather easy to create per-SCSI-host attrs in sysfs,
> but I don't see any obvious way to do it per-chip.
> Suggestions?

The absence of a kobject associated with ata_host is largely the root 
cause of this problem you've noted.  Long term, we want to move in a 
direction where we have a "storage_host" container object, containing 
one or more port-style objects that can be ATA or SCSI.  In that 
scenario (and what we want to move towards, over the years), the sysfs 
attachment points should be fairly obvious.

Lacking a better suggestion, I suppose the answer is exporting per-chip 
variables multiple times, once per scsi-host.  Just get the locking 
right, since multiple sysfs attributes access the same underlying 
per-chip variable.


> For now, I'm doing it with a module parameter,
> but that's really rather stone-age in the sysfs era.

Indeed!  :)

	Jeff



