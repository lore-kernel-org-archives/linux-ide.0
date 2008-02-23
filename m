From: Tejun Heo <htejun@gmail.com>
Subject: Re: new ata_port_operations for .pmp_{read,write} ?
Date: Sat, 23 Feb 2008 11:49:39 +0900
Message-ID: <47BF89C3.6030508@gmail.com>
References: <4730E312.3090900@navy.mil> <4737C16E.3070607@gmail.com> <4738827D.9060405@pobox.com> <4738F935.1000708@gmail.com> <47BC798F.6070900@pobox.com> <47BE17CA.6060406@rtr.ca> <47BE1833.9090501@rtr.ca> <47BE2C0C.3020801@gmail.com> <47BE2DBD.9010704@rtr.ca> <47BE2F9E.5040206@gmail.com> <47BE32B5.5020300@rtr.ca> <47BE3325.8060209@rtr.ca> <47BE4701.2030104@rtr.ca> <47BE4DFE.2030407@rtr.ca> <47BEDAF2.8000301@rtr.ca> <47BEDC16.4000502@rtr.ca> <47BF6AFC.2060301@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:30765 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912AbYBWCtq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 21:49:46 -0500
Received: by wx-out-0506.google.com with SMTP id h31so573584wxd.4
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 18:49:45 -0800 (PST)
In-Reply-To: <47BF6AFC.2060301@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

Hello, Mark.

Mark Lord wrote:
>>> And for that matter, is it possible for sata_pmp_read() to be called
>>> while the link is active with another command ?  Not today, it seems,
>>> but what about when hotplug polling gets implemented ?
>> ..
>> That's the one I'm most concerned about.  Should I be?
> ...
> 
> Tejun,
> 
> On a related note, I'm now looking into PMP error handling in the driver.
> The obvious thing I see that I want to fix, is that after a media error
> on any PMP attached drive, I get this:
> 
>     ata20.00: failed to read SCR 1 (Emask=0x40)
>     ata20.01: failed to read SCR 1 (Emask=0x40)
>     ata20.02: failed to read SCR 1 (Emask=0x40)
>     ata20.03: failed to read SCR 1 (Emask=0x40)
>     ata20.04: failed to read SCR 1 (Emask=0x40)
> 
> Okay, so those are from sata_pmp_read(), which cannot even
> issue it's commands because the port was frozen by the EH.

Hmm.. media error causes freeze?  Anyways, yeah, those are expected if
the port is frozen.  Those are from link autopsy.  Maybe it's better to
skip SCR access on fan-out ports if host port is frozen or at least
suppress the messages.

> Is this expected?  I'm not entirely clear what to do in
> the EH for this driver.  The chipset docs say that
> after just about any kind of error software must do
> a hard reset of the channel to make it usable again.
> 
> But I suspect that PIO commands may be okay before that,
> and sata_pmp_read() is trying to issue a PIO command.

If the controller needs to be frozen after any kind of error, I don't
think there's much left to do other than suppressing those annoying
messages.  Hmmm.. how does the controller handle ATAPI check sense?

-- 
tejun
