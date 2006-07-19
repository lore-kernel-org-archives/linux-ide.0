From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 09/12] libata: implement powersave timer
Date: Wed, 19 Jul 2006 22:22:43 +0200
Message-ID: <20060719202243.GA5445@suse.de>
References: <11531191522801-git-send-email-htejun@gmail.com> <44BE8C85.2080008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:24665 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030272AbWGSUWy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 16:22:54 -0400
Content-Disposition: inline
In-Reply-To: <44BE8C85.2080008@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

On Wed, Jul 19 2006, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Implement powersave timer.  It is primarily for OS-driven HIPS
> >implementation but can be used for any other PS purpose LLD sees fit.
> >During normal operation, PS timer is automatically started with
> >timeout ap->ps_timeout on port idle and stopped when the port becomes
> >busy.  The timer is also stopped while EH.
> >
> >To minimize overhead and allow easy implementation of expected
> >operation model, ata_ps_timer_worker() is used as timer callback which
> >invokes LLD supplied ap->ps_timer_fn() if condition meets and also
> >helps implementing sequenced multi-step operation.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> This makes me wonder what Jens thinks about having a device idle timer 
> and callback at the block level?  At the very least, this feels like it 
> should be implemented in the SCSI layer, or somewhere other than libata.

Since this will be used only when the device is idle, we can reuse the
unplug timer and get it pretty much for free. So I think that's a good
idea.

-- 
Jens Axboe

