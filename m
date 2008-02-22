From: Mark Lord <liml@rtr.ca>
Subject: Re: What's needed for PMP support?
Date: Thu, 21 Feb 2008 19:31:06 -0500
Message-ID: <47BE17CA.6060406@rtr.ca>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4705 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936214AbYBVAbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Feb 2008 19:31:09 -0500
In-Reply-To: <47BC798F.6070900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Tejun Heo wrote:
>>
>> The following things are needed for a LLD to support PMP.
> ..
>> I think that's about it.  Feel free to ask if something isn't clear.
..

I think we need better semantics around sata_scr_{read,write}(),
or more specifically 

These need to be moved into ata_port_operations
so that LLDs can wrap them to properly manage
the host controller's global link->pmp value.

The problem I've been debugging here for the past 24hrs,
is that sata_mv sets the pmp number globally in hardware,
but then libata does a call to sata_scr_read()
which causes it to change.  Without ever changing it back.

Subsequent accesses of shadow registers now point at
the pmp==15 instead of the original PM port.

Doh!  No wonder device detection fails for me.

The LLD needs a way to properly manage the current pmp selection,
without having to clone all of the reset logic from libata-core.

I'd like to just re-use that code, but I cannot if it's going
to muck up the pmp selection.

I *think* ata_link_online() is my immediate problem.
It gets called from inside ata_std_softreset(),
and it invokes sata_scr_read().

This prevents me from re-using ata_std_softreset(),
and all of the non-exported functions that *it* calls.

There's very little that's special in the LLD for pmp support,
but the amount of code required seems huge, just to cope with
this simple problem caused.

Ugh.

If sata_scr_{read,write}() were in ata_port_operations,
then I could wrap them to save/restore the original pmp value.
But I'm not sure if that would result in a race against
other command-issue paths on the same port (?).

Tejun ???

For now, I'll try to hack it into sata_mv locally, somehow.

Suggestions?

