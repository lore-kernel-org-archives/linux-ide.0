From: Mark Lord <liml@rtr.ca>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Fri, 22 Feb 2008 09:23:46 -0500
Message-ID: <47BEDAF2.8000301@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1816 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935321AbYBVOXs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 09:23:48 -0500
In-Reply-To: <47BE4DFE.2030407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Tejun,
> 
> Here's a first cut at this for discussion.
> 
> You may prefer different names for the invoking functions
> inside libata-pmp.c, rather than simply pmp_read() and pmp_write(),
> but I've been up too long and couldn't think of a better name.
> 
> An alternative to all this, might be to expose the "select_pmp()"
> function shown in the sample code, and have libata-pmp.c call that,
> instead of having the new new .pmp_{read,write} functions.
> 
> What do you think?
> 
> * * *
> 
> SATA host controllers which are not purely FIS-based require setup
> of a special register to select the active pmp for taskfile accesses.
> 
> This can be done in the low-level driver for regular command issue
> on a link.  But commands directed at a port-multiplier cause problems,
> because they leave the original link pmp de-selected afterwards.
> 
> To fix this in a sane fashion, without tons of code duplication
> from libata into the low-level driver, it is necessary to be able
> to wrap the sata_pmp_read() and sata_pmp_write() functions.
> 
> This patch provides two new struct ata_port_operations methods for this,
> and modifies the code in libata-pmp to use them if provided.
...

Note that, while this does work for sata_mv, I'm still thinking about it.

I'm not totally clear yet (more reading to do) as to how/when
the ATA shadow/taskfile registers get updated to reflect those
for the currently selected pmp..

It would seem that with other parts of libata-sff directly reading
from the ctl, status, and altstatus "registers" during polling,
command setup, and probing, that there might (?) be a loophole
somewhere in this strategy.

Is this scenario going to be possible:  somebody calls sata_pmp_read()
as part of, say, hotplug polling, and after that operation completes
we then have code that calls ata_check_status() prior to the next
tf_load / command issue ?  If so, they'll see the wrong cached 
shadow status register.

And for that matter, is it possible for sata_pmp_read() to be called
while the link is active with another command ?  Not today, it seems,
but what about when hotplug polling gets implemented ?

Mmm.. an amazing amount of complexity there for something that
ought to be very simple.

More reading to do, but comments from Tejun/others are welcomed.

Thanks.
