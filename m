From: Mark Lord <liml@rtr.ca>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Fri, 22 Feb 2008 19:38:20 -0500
Message-ID: <47BF6AFC.2060301@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BEDC16.4000502@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1520 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934521AbYBWAiW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Feb 2008 19:38:22 -0500
In-Reply-To: <47BEDC16.4000502@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Mark Lord wrote:
...
>> And for that matter, is it possible for sata_pmp_read() to be called
>> while the link is active with another command ?  Not today, it seems,
>> but what about when hotplug polling gets implemented ?
> ..
> That's the one I'm most concerned about.  Should I be?
...

Tejun,

On a related note, I'm now looking into PMP error handling in the driver.
The obvious thing I see that I want to fix, is that after a media error
on any PMP attached drive, I get this:

	ata20.00: failed to read SCR 1 (Emask=0x40)
	ata20.01: failed to read SCR 1 (Emask=0x40)
	ata20.02: failed to read SCR 1 (Emask=0x40)
	ata20.03: failed to read SCR 1 (Emask=0x40)
	ata20.04: failed to read SCR 1 (Emask=0x40)

Okay, so those are from sata_pmp_read(), which cannot even
issue it's commands because the port was frozen by the EH.

Is this expected?  I'm not entirely clear what to do in
the EH for this driver.  The chipset docs say that
after just about any kind of error software must do
a hard reset of the channel to make it usable again.

But I suspect that PIO commands may be okay before that,
and sata_pmp_read() is trying to issue a PIO command.

How to resolve this?
