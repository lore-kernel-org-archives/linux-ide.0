From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2.6.20-rc3] fix broken retval test in sr_block_ioctl
Date: Tue, 02 Jan 2007 17:52:43 -0500
Message-ID: <459AE23B.1020904@rtr.ca>
References: <200701021724.39613.liml@rtr.ca> <200701021730.07356.liml@rtr.ca> <459ADEB1.7080505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1795 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965001AbXABWwm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 17:52:42 -0500
In-Reply-To: <459ADEB1.7080505@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Douglas Gilbert <dougg@torque.net>

Jeff Garzik wrote:
> Mark Lord wrote:
..
>> Allow ATA_12 / ATA_16 passthru commands to be issued for ATAPI devices
> 
> Douglas Gilbert noticed this a while ago.
> 
> The patch's technical content is fine, but there is an open policy 
> question:  For some devices, there is an opcode overlap (BLANK?  Doug 
> probably remembers the issue better than I).  And from a practical 
> standpoint, to handle any vendor weird-isms (nahhh those never happen in 
> ATAPI), it would be nice to be able to force the current (pre-mlord 
> patch) behavior to ensure that all opcodes are passed to ATAPI.
> 
> Absent a better idea, I would simply suggest adding a module parameter 
> that restores the "all opcodes are passed to device, guaranteed" mode.
> 
> I'm fine with changing the default behavior to that which is presented 
> by your patch.

Mmmm.. yes, the "BLANK" opcode is indeed the same as ATA_12.
That looks rather dangerous to me -- isn't BLANK commonly used
with CD-RW discs and the like?  (gotta test that now..)

If so, then perhaps all we can support is ATA_16, except the upper
layers mightn't even pass them to libata without a bit of hackery.

I'll go and see about BLANK now..

Cheers

Mark
