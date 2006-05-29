From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH] Snoop SET FEATURES - WRITE CACHE ENABLE/DISABLE command
Date: Mon, 29 May 2006 17:18:08 +0800
Message-ID: <1148894288.3466.32.camel@forrest26.sh.intel.com>
References: <1148547763.23979.15.camel@forrest26.sh.intel.com>
	 <44779A05.4010209@garzik.org>  <447AB9FB.6020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45316 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750811AbWE2J3v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 05:29:51 -0400
In-Reply-To: <447AB9FB.6020706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, liml@rtr.ca, linux-ide@vger.kernel.org

On Mon, 2006-05-29 at 18:08 +0900, Tejun Heo wrote:

> > 
> > 1) Tejun's revalidate should trigger scsi_rescan_device(), as your patch 
> > indicates.  But that's pretty much all that needs to be done.
> > 
> > 2) Thus, a new bit (ATA_FLAG_SCSI_RESCAN) and a new workqueue are 
> > unnecessary.
> 
> SCSI rescan is done by issuing commands using scsi_execute_req().  The 
> commands are supposed to be processed via normal SCSI command execution 
> path which is blocked during EH is in progress, so we need to rescan in 
> separate context.
Thank you for giving the reason why my machine hanged when
scsi_rescan_device() is invoked in SCSI EH thread :)
> 
> * I've renamed ata_hotplug_wq to ata_scsi_wq in hotplug patches.  I 
> think rescan can use this wq instead of creating its own.
Yes, ata_scsi_wq will do the work, which can't be done in SCSI EH thread.

> * When snooping for SETFEATURES in ata_scsi_qc_complete(), why check 
> cdb[0] for ATA_16/12?  Isn't simply checking tf.command enough?
Oh, checking cdb[0] for ATA_16/12 is unnecessary since the command id is
unique.

> * There's a race window between ATA revalidation and SCSI rescan.  We 
> can plug this hole by deferring commands till rescan is complete.  But I 
> doubt it would be worth the trouble.
> 
This is really a problem. But the race condition is not so critical that
we need to bother to do some sync between libata and SCSI layer, right?

Thanks,
Forrest
