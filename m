From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.20-rc3] fix broken retval test in sr_block_ioctl
Date: Tue, 02 Jan 2007 17:37:37 -0500
Message-ID: <459ADEB1.7080505@pobox.com>
References: <200701021724.39613.liml@rtr.ca> <200701021730.07356.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47373 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965011AbXABWhl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 17:37:41 -0500
In-Reply-To: <200701021730.07356.liml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Douglas Gilbert <dougg@torque.net>

Mark Lord wrote:
> This patch adds support for passing ATA_12 and ATA_16 commands
> through to ATAPI devices in libata.  In practice, the upper layers will
> still currently prevent ATA_16 commands, as no (?) ATAPI drives support
> them yet.  But it will work if such a drive is ever encountered.
> 
> This patch is necessary for using SG_IO from userspace,
> and an upcoming hdparm release will be updated to use this interface.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> Allow ATA_12 / ATA_16 passthru commands to be issued for ATAPI devices

Douglas Gilbert noticed this a while ago.

The patch's technical content is fine, but there is an open policy 
question:  For some devices, there is an opcode overlap (BLANK?  Doug 
probably remembers the issue better than I).  And from a practical 
standpoint, to handle any vendor weird-isms (nahhh those never happen in 
ATAPI), it would be nice to be able to force the current (pre-mlord 
patch) behavior to ensure that all opcodes are passed to ATAPI.

Absent a better idea, I would simply suggest adding a module parameter 
that restores the "all opcodes are passed to device, guaranteed" mode.

I'm fine with changing the default behavior to that which is presented 
by your patch.

	Jeff



