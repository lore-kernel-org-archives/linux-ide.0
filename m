From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Thu, 7 Oct 2004 21:48:32 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041007214832.C21662@florence.linkmargin.com>
References: <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com> <4164B548.7030700@pobox.com> <4164BDD6.6000404@pobox.com> <20041007171457.B21662@florence.linkmargin.com> <4165C263.4080102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:13481 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S267435AbUJHCuc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Oct 2004 22:50:32 -0400
Content-Disposition: inline
In-Reply-To: <4165C263.4080102@pobox.com>; from jgarzik@pobox.com on Thu, Oct 07, 2004 at 06:25:39PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>

Jeff Garzik wrote:
> Andy Warner wrote:
> > 		sdev = scsi_add_device(ap->host, 0, 0, 0) ;
> 
> > 		sdev = scsi_device_lookup(ap->host, 0, 0, 0);
> 
> These args are wrong.  Consider master/slave configurations.

Like I said: "... (ignore hardcoded values and sloppy error
checking for now)"

> Also, remember my short message about a debounce timer.  It's not as 
> simple as this... you need to make sure the driver doesn't "scream" 
> add_device/remove_device while the SATA bus settles.

I didn't show that logic, but I think the code in the interrupt
handler deals with that:

if ((err & SCR_DIAG_N) && (ap->hotplug_task_state == HOTPLUG_ST_IDLE)) {
	/*
	 * Schedule hotplug task to deal with it.
	 */
	ap->hotplug_task_state = HOTPLUG_ST_PENDING;
	queue_delayed_work(ata_wq, &ap->hotplug_task, 20);
}

[again, ignore locking issues for now]

What this effectively does is start a one-shot on the first
interrupt due to bit 16, and ignore any subsequent transitions.
>= 20 jiffies later (TODO: figure out the optimal value) the other
hotplug_task runs, by which time the bus will have settled. It reads
the value and does what it must. I think this will accomplish
what is needed.

I too want to cache dev in *ap, but that's another bunch of issues
(like either unrolling scsi_scan_host() as called from ata_device_add(),
figuring out ap->dev after scsi_scan_host() has run, or just
letting the hotswap logic add the drives after initting the
host.) I'll get to that after I fixup the scsi_remove_device()
problems.

I think I also need logic to ensure that I don't call scsi_add_device()
twice [if (!(ap->dev)) { ...} springs to mind].

Thanks for confirming that the "sync the disk that just went
away"/scsi_remove_device() problem is structural, not just me
calling the wrong function. I'll look into implementing flags
as you suggest.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
