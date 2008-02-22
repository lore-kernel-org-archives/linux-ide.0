From: Mark Lord <liml@rtr.ca>
Subject: Re: What's needed for PMP support?
Date: Thu, 21 Feb 2008 22:52:33 -0500
Message-ID: <47BE4701.2030104@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1959 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758719AbYBVDwf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 22:52:35 -0500
In-Reply-To: <47BE3325.8060209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Mark Lord wrote:
>..
>> We already have .pmp_scr_{read,write} operations.
>> If NULL, then default to the built-ins that are there now.
> ..
> 
> Mmm.. lost some lines there, try again:
> 
> We already have .scr_{read,write} operations, and
> what I think we need are .pmp_scr_{read,write} in addition.
> If NULL, then default to the built-ins that are there now.

Tejun Heo wrote:
> Adding ->sata_pmp_scr_read/write should do but I wanna avoid that if possible.
..

Well, what it really needed was .pmp_read() and .pmp_write().

I implemented that, and (finally!!) sata_mv works perfectly
with the Marvell port multiplier I have here.

All other attempts to do this entirely within sata_mv
just left me (and the hardware) dazed and confused.

But being able to wrap sata_pmp_read/write() with save/restore
logic fixed things enough to work on the first try.

Whew!

I'll post a summary patch once I get it generated here.
Lots of debug code to back out first.

Thanks Tejun, Saeed!
