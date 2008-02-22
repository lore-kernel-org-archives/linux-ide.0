From: Mark Lord <liml@rtr.ca>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Fri, 22 Feb 2008 09:28:38 -0500
Message-ID: <47BEDC16.4000502@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3794 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815AbYBVO2j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 09:28:39 -0500
In-Reply-To: <47BEDAF2.8000301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
>
> Note that, while this does work for sata_mv, I'm still thinking about it.
> 
> I'm not totally clear yet (more reading to do) as to how/when
> the ATA shadow/taskfile registers get updated to reflect those
> for the currently selected pmp..
> 
> It would seem that with other parts of libata-sff directly reading
> from the ctl, status, and altstatus "registers" during polling,
> command setup, and probing, that there might (?) be a loophole
> somewhere in this strategy.
> 
> Is this scenario going to be possible:  somebody calls sata_pmp_read()
> as part of, say, hotplug polling, and after that operation completes
> we then have code that calls ata_check_status() prior to the next
> tf_load / command issue ?  If so, they'll see the wrong cached shadow 
> status register.
..

Answering my own question here: the above scenario really doesn't matter.
They'll see 0x50 in the status register, and be happy regardless.
Because that's what should have been there before the command issue
by sata_pmp_read() in the first place.  So not-a-problem.
 
> And for that matter, is it possible for sata_pmp_read() to be called
> while the link is active with another command ?  Not today, it seems,
> but what about when hotplug polling gets implemented ?
..

That's the one I'm most concerned about.  Should I be?

-ml
