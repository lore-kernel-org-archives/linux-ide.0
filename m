From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes, -stable] ata_piix: add workaround for
 Samsung DB-P70
Date: Tue, 03 Mar 2009 08:17:01 -0500
Message-ID: <49AD2DCD.60807@rtr.ca>
References: <49ACB780.1070604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:50920 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbZCCNRH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2009 08:17:07 -0500
In-Reply-To: <49ACB780.1070604@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, stable@kernel.org, josephjang@gmail.com, mrsohn@gmail.com

Tejun Heo wrote:
> Samsung DB-P70 somehow botched the first ICH9 SATA port.  The board
> doesn't expose the first port but somehow SStatus reports link online
> while failing SRST protocol leading to repeated probe failures and
> thus long boot delay.
> 
> Because the BIOS doesn't carry any identifying DMI information, the
> port can't be blacklisted safely.  Fortunately, the controller does
> have subsystem vendor and ID set.  It's unclear whether the subsystem
> IDs are used only for the board but it can be safely worked around by
> disabling SIDPR access and just using SRST works around the problem.
> Even when the workaround is triggered on an unaffected board the only
> side effect will be missing SCR access.

..

A suggestion, then.  As a follow-up patch, would it be possible
to drop the workaround kludge, and restore the missing SCR access,
__after the first time that a drive is detected on that port__?

This way, there won't be any funny business for cases where
the same ID might occur on different (non-botched) hardware ?

Probably overkill, though.  :)

Cheers
