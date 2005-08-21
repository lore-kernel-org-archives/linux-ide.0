From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 02/02] libata: add host_set locking
 to ata_scsi_error()
Date: Sun, 21 Aug 2005 15:52:27 -0400
Message-ID: <4308DB7B.7090706@pobox.com>
References: <20050820141408.62050C34@htj.dyndns.org> <20050820141408.52DFBF95@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:52936 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751096AbVHUVE4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:04:56 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LJqWd0032755
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 12:52:32 -0700
In-Reply-To: <20050820141408.52DFBF95@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> 02_libata_add-locking-to-ata_scsi_error.patch
> 
> 	SCSI EH can start before ata_qc_complete is completely
> 	complete.  so, latter part of ata_qc_complete can run
> 	side-by-side with ->eng_timeout(), interfering EH.
> 
>         This patch makes ata_scsi_error() to grab and release host_set
> 	lock before invoking ->eng_timeout().
> 
> 	Note: host_failed decrementing and eh_cmd_q banging are moved
> 	above ->eng_timeout() invocation such that they're done while
> 	holding the lock.

I think it's better to follow a path that sets a "EH owns this port now" 
flag inside spinlock,

	spin_lock_irqsave()
	ap->in_eh = 1;
	spin_unlock_irqrestore()

and then check that flag in ata_qc_complete()

	if (qc->ap->in_eh)
		return; /* do nothing else with command */

so that for the case of a late interrupt, the interrupt handler should 
acknowledge the interrupt, but not actually touch the ata_queued_cmd state.

	Jeff


