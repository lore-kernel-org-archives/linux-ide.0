From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 09/12] libata: implement powersave timer
Date: Tue, 25 Jul 2006 10:01:32 +0200
Message-ID: <20060725080131.GE4044@suse.de>
References: <11531191522801-git-send-email-htejun@gmail.com> <44BE8C85.2080008@pobox.com> <20060719202243.GA5445@suse.de> <44C47662.4010203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:12102 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932166AbWGYI1B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jul 2006 04:27:01 -0400
Content-Disposition: inline
In-Reply-To: <44C47662.4010203@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

On Mon, Jul 24 2006, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Wed, Jul 19 2006, Jeff Garzik wrote:
> >>Tejun Heo wrote:
> >>>Implement powersave timer.  It is primarily for OS-driven HIPS
> >>>implementation but can be used for any other PS purpose LLD sees fit.
> >>>During normal operation, PS timer is automatically started with
> >>>timeout ap->ps_timeout on port idle and stopped when the port becomes
> >>>busy.  The timer is also stopped while EH.
> >>>
> >>>To minimize overhead and allow easy implementation of expected
> >>>operation model, ata_ps_timer_worker() is used as timer callback which
> >>>invokes LLD supplied ap->ps_timer_fn() if condition meets and also
> >>>helps implementing sequenced multi-step operation.
> >>>
> >>>Signed-off-by: Tejun Heo <htejun@gmail.com>
> >>This makes me wonder what Jens thinks about having a device idle timer 
> >>and callback at the block level?  At the very least, this feels like it 
> >>should be implemented in the SCSI layer, or somewhere other than libata.
> >
> >Since this will be used only when the device is idle, we can reuse the
> >unplug timer and get it pretty much for free. So I think that's a good
> >idea.
> >
> 
> Hello, Jeff, Jens.
> 
> I agree that the unplug timer can be reused here but I'm not very sure 
> about what the high level semantics would be.  This timer tracks link 
> idleness and also used to drive link power down sequence.  e.g. For 
> host-initiated partial/slumber powersave, the timer will be used like 
> the following.
> 
> 1. Timer for partial PS armed when the link becomes idle (100ms by 
> default).  The 'link' abstraction doesn't exist at the block layer yet, 
> so this one is already problematic.  I'm thinking of using link-wide 
> idleness to implement powersave on ata_piix (ICH8 can access SCRs 
> without enabling AHCI address space, hooray!) and possibly PMP.  As 
> ICH8s will end up on notebooks, supporting ata_piix is important.
> 
> 2. On timer expiration, the PS handler is invoked and transits the link 
> to partial power state.  As the link also supports slumber mode, it 
> re-arms the timer w/ 3s timeout.
> 
> 3. On timer expiration, the PS handler wakes up the link because SATA 
> link cannot transit directly from partial to slumber.  As waking up 
> takes time (1ms max by spec), the timer is rearmed (5ms).
> 
> 4. On timer expiration, the link is put to slumber mode.
> 
> In addition, whenever there is any event on the link, the timer is 
> reset.  Timer activation and canceling are tightly integrated into 
> libata core layer to reduce overhead.
> 
> This is very SATA specific and I don't think pushing this to upper layer 
> is a good idea.  Link powersave is closely related to transport topology 
> and way too low level to be at block layer, IMHO.

As long as there's a 1:1 mapping between link and disk, the block layer
can easily be used. When that isn't the case, I think we should do the
cleaner thing and leave the link management to the layer that has such
knowledge.

-- 
Jens Axboe

