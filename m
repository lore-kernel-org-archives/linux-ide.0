From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide patches
Date: Tue, 24 Jul 2007 08:00:25 +1000
Message-ID: <1185228025.5439.139.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
	 <1185155835.5439.91.camel@localhost.localdomain>
	 <1185156084.5439.93.camel@localhost.localdomain>
	 <200707232322.22129.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48274 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbXGWWAc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 18:00:32 -0400
In-Reply-To: <200707232322.22129.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2007-07-23 at 23:22 +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Thanks for reviewing and testing this patch series.
> 
> On Monday 23 July 2007, Benjamin Herrenschmidt wrote:
> > 
> > > Ok, there's a combination of things here:
> > > 
> > >  - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
> > > to disable DMA, which I think is incorrect. It's not the case with
> > > 2.6.22 from my quick tests. The problem is that ide_config_drive_speed
> > > disables DMA, but only re-enables it when setting a DMA speed. I think
> 
> The problem is that _many_ chipsets don't support separate PIO and DMA
> timings so disabling DMA while programming chipset for PIO timings is a
> necessity for them.

Disabling while programming is fine with me. The problem is that we
don't restore DMA after programming the PIO timings.

Yes, but we still need to address it as it's a regression for ide-pmac
when moving to the generic ide_config_drive_speed.

> > >  - For some reason, nowadays, hdparm -p /dev/hda will not autotune, but
> > > will set PIO 0 (hdparm -p 255 /dev/hda will autotune). Might be a bug in
> > > whatever hdparm version I have here.
> 
> Since -p 255 works fine it would indicate a hdparm issue.

Yup. All hdparm's around do that, I need to find out when it actually
broke (if it did, but I -think- that early versions used to autotune
with just -p).

> > >  - Some userland scripts installed on debian as part of the pbbuttonsd
> > > package are doing hdaprm -p /dev/device on all IDE devices at boot.
> > 
> > In the meantime, that patch applied on top of your latest series fixes
> > the PIO setting in the driver to send the correct mode value in
> 
> Looks fine.
> 
> Could you please rebase it on top of the fixed "ide-pmac: PIO mode setup
> fixes" patch, remove debugging printks and add description/Signed-off-by?

Sure.

> Also since the patch series has been tested please verify that your concerns
> wrt patches #4, #8 and #10 are still valid.

I've been using that weird machine without problems at boot, but I still
need to test actual hotplug of the media bay, this is usually when the
shit hits the fan. It's quite possible that some of the fixes you did to
ide_config_drive_speed() (or other changes around) are also fixing that
problem, it used to look a lot like a heisenbug back then. However, I'm
still annoyed that with all current debian or ubuntu distro, you'll end
up with DMA disabled at boot because of those pbbuttons scripts.

> > pmac_ide_set_pio_mode(). I still object to your patch serie at this
> > point because hdparm -p N should not, imho, cause DMA to be disabled.
> 
> If this change indeed causes some serious problem which breaks userland on
> ppc (that can't be workarounded otherwise) we may add a new ->host_flags
> flag and special hack to ide-io.c::do_special(), something like:
> 
> ...
> 		int keep_dma = drive->using_dma;
> ...
> 			ide_set_pio(drive, req_pio);
> ...
> 		if (hwif->host_flags & IDE_HFLAG_SET_PIO_MODE_KEEP_DMA) {
> 			if (keep_dma)
> 				hwif->ide_dma_on(drive);
> 		}
> ...
> 
> which should preserve the old behavior.

Yea, please.

> I will respin patch #11 with necessary changes if needed.
> 
> > I really believe that the kernel should keep track separately of PIO and
> > DMA speeds.
> 
> Agreed.

Excellent, we all agree :-)

Cheers,
Ben.


