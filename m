From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/10] libata: implement new EH action ATA_EH_SPINUP
Date: Tue, 13 Jun 2006 21:18:43 -0400
Message-ID: <448F63F3.5010909@pobox.com>
References: <11501274283970-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45993 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964863AbWFNBSx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jun 2006 21:18:53 -0400
In-Reply-To: <11501274283970-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement new EH action ATA_EH_SPINUP.  This will be used by new PM
> implementation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This patch further reinforces something I've been thinking about, as I 
watch the EH grow:  these EH actions really should be separated into 
small, discrete operations.  Then the EH "driver" will push discrete 
operations onto an execution stack.

It's always getting tough to follow ata_eh_recover() and ata_eh_reset() 
's code through multiple iterations of recovery.  This patch 
(ata_eh_spinup) also illustrates how difficult it would be if the 
ordering of these operations ever needed to change.

So, I'm not NAK'ing the patch, just throwing out a 'caution' sign.  :)

I've often thought something along the lines of a list of tasks 
("eh_op_list"), for when a port is frozen and doing EH:
	ata_eh_freeze()
	ata_eh_push(ap, EH_OP_RESET_BUS, ...)
	ata_eh_push(ap, EH_OP_SPINUP, ...)
	ata_eh_push(ap, EH_OP_CONFIGURE, ...)
	ata_eh_push(ap, EH_OP_SET_MODE, ...)
	ata_eh_run()
	ata_eh_thaw()

would be nice.  A discrete operation would handle its own discrete 
operation, prepend and append other operations to eh_op_list, or 
optionally cause the engine to fail, and return immediately.

	Jeff



