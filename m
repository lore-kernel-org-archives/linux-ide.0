From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Thu, 15 Jun 2006 09:33:41 +0800
Message-ID: <1150335221.7132.71.camel@forrest26.sh.intel.com>
References: <11501274293403-git-send-email-htejun@gmail.com>
	 <1150271814.7132.55.camel@forrest26.sh.intel.com>
	 <44900F41.8020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7527 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932410AbWFOBqH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 21:46:07 -0400
In-Reply-To: <44900F41.8020602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On Wed, 2006-06-14 at 22:29 +0900, Tejun Heo wrote:
> zhao, forrest wrote:
> > On Tue, 2006-06-13 at 00:50 +0900, Tejun Heo wrote:
> >> + */
> >> +static void ata_eh_handle_resume(struct ata_port *ap)
> >> +{
> >> +	unsigned long flags;
> >> +	int rc = 0;
> >> +
> >> +	spin_lock_irqsave(&ap->host_set->lock, flags);
> >> +	if (!(ap->flags & ATA_FLAG_PM_PENDING) ||
> >> +	    !(ap->flags & ATA_FLAG_SUSPENDED) ||
> >> +	    ap->pm_mesg.event != PM_EVENT_ON) {
> >> +		spin_unlock_irqrestore(&ap->host_set->lock, flags);
> >> +		return;
> >> +	}
> >> +	ap->flags &= ~ATA_FLAG_PM_PENDING;
> >> +	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> >> +
> >> +	if (ap->host_set->dev->power.power_state.event == PM_EVENT_SUSPEND) {
> >> +		struct ata_eh_context *ehc = &ap->eh_context;
> >> +
> >> +		ehc->i.action |= ATA_EH_SPINUP;
> >> +		ata_ehi_hotplugged(&ehc->i);
> >> +	}
> >> +
> >> +	if (ap->ops->resume)
> >> +		rc = ap->ops->resume(ap);
> >> +
> >> +	spin_lock_irqsave(&ap->host_set->lock, flags);
> >> +	ap->flags &= ~ATA_FLAG_SUSPENDED;
> >> +	ap->pm_result = rc;
> >> +	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> >> +}
> > 
> > I ported AHCI suspend/resume patches against your new PM framework. At
> > first resume from memsleep took 65 seconds to go through soft-reset,
> > hard-reset; then after I removed line 
> > "if (ap->host_set->dev->power.power_state.event == PM_EVENT_SUSPEND)" in
> > ata_eh_handle_resume(), AHCI can resume from memsleep in a few seconds.
> > After inserting a printk(), I found the "ap->host_set->dev->power.
> > power_state.event" is always 0(PM_EVENT_ON).
> 
> Can you post the AHCI patch you did?  The suspend routine is supposed to 
> set power state to PM_EVENT_SUSPEND on memsleep such that resume can 
> notice it's resuming from actual suspend.

Yeah, on memsleep host_set->dev->power.power_state is set to
PM_EVENT_SUSPEND in ata_host_set_suspend(). Then during resume process,
firstly ata_host_set_resume() is called, in which host_set->dev->power.
power_state is set to PMSG_ON, then ata_eh_handle_resume() is called
later. This is the reason why ap->host_set->dev->power.power_state.event
is 0 in ata_eh_handle_resume(). This is a race condition.

Thanks,
Forrest
