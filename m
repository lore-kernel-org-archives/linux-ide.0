From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 02/02] libata: add host_set locking to ata_scsi_error()
Date: Mon, 22 Aug 2005 17:23:29 +0900
Message-ID: <20050822082329.GB3252@htj.dyndns.org>
References: <20050820141408.62050C34@htj.dyndns.org> <20050820141408.52DFBF95@htj.dyndns.org> <4308DB7B.7090706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751412AbVHVW0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:26:14 -0400
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.193])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M8OdCi010662
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 01:24:42 -0700
Received: by zproxy.gmail.com with SMTP id r28so685623nza
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 01:23:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4308DB7B.7090706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Aug 21, 2005 at 03:52:27PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >02_libata_add-locking-to-ata_scsi_error.patch
> >
> >	SCSI EH can start before ata_qc_complete is completely
> >	complete.  so, latter part of ata_qc_complete can run
> >	side-by-side with ->eng_timeout(), interfering EH.
> >
> >        This patch makes ata_scsi_error() to grab and release host_set
> >	lock before invoking ->eng_timeout().
> >
> >	Note: host_failed decrementing and eh_cmd_q banging are moved
> >	above ->eng_timeout() invocation such that they're done while
> >	holding the lock.
> 
> I think it's better to follow a path that sets a "EH owns this port now" 
> flag inside spinlock,
> 
> 	spin_lock_irqsave()
> 	ap->in_eh = 1;
> 	spin_unlock_irqrestore()
> 
> and then check that flag in ata_qc_complete()
> 
> 	if (qc->ap->in_eh)
> 		return; /* do nothing else with command */
> 
> so that for the case of a late interrupt, the interrupt handler should 
> acknowledge the interrupt, but not actually touch the ata_queued_cmd state.

 Hi!

 I think above is larger subject than what this patch deals with and
should be dealt with when we revamp EH (implementing in_eh will
certainly involve other changes, I think).  So, I think, for short
term, either Albert's patch[1][2] or above one should go in to plug
ATA_QCFLAG_ACTIVE race.

 I think if Albert's patch goes in, above patch is not necessary, as
the only race we currently have is ATAPI EH case and clearing
ATA_QCFLAG_ACTIVE is the only thing we do after ->complete_fn() in
such cases.

 Thanks.

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=112417360223374&w=2
[2] Well, this referencing thing is neat.  ;-)

-- 
tejun
