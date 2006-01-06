From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Fri, 6 Jan 2006 12:43:10 -0800
Message-ID: <20060106124310.10157732.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de>
	<20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
	<20060103164009.1c7418a7.randy_d_dunlap@linux.intel.com>
	<87ek3o22z8.fsf@marrow.phys.tohoku.ac.jp>
	<20060104114222.25182742.randy_d_dunlap@linux.intel.com>
	<87aceag437.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:23758 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752556AbWAFUnW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jan 2006 15:43:22 -0500
In-Reply-To: <87aceag437.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On 05 Jan 2006 23:08:12 +0900
Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:

> Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:
> >
> > Does your system work without using the AHCI driver?
> > or is it required?
> 
> I tested turning off AHCI with 2.6.15-rc7 + git-libata-all.patch +
> libata_resume_fix.patch + libata_suspend-fix.patch +
> libata_suspend.patch.  The system runs okay, and ACPI suspend/resume
> and suspend2 work, without AHCI.
> 
> > Of course, even if the AHCI driver is not needed,
> > it shouldn't be oopsing like this.
> > 
> > It looks like the ata_piix driver is the one that is
> > actually being used, from what I can see here.
> > 
> > Please send your /proc/interrupts, /proc/iomem, /proc/ioports,
> > and 'lspci -v'.
> 
> They are enclosed below.
> 
> > If you are up to it, please enable libata verbose debugging
> > and then boot & cause this bug again and send me as much
> > output as you can collect.
> > Patch is below.
> 
> Let me remind you that I used kernel 2.6.15-rc7 +
> http://www.xenotime.net/linux/SATA/2.6.15-rc7/libata-combine.patch +
> libata verbose debug patch.  libata-combine-2615.patch does not cause
> kernel panic.

Thanks for that clarification.
So enabling ATA debugging via:
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#define ATA_DEBUG		/* debugging output */
+#define ATA_VERBOSE_DEBUG	/* yet more debugging output */

is causing this particular Oops.  Hmph.


> I copied boot up messages below for cases with CONFIG_SCSI_SATA_AHCI
> turned off and on.  After turning on verbose debugging messages, the
> call trace has changed, and the kernel panics for
> CONFIG_SCSI_SATA_AHCI=n as well.

To clarify more (for me):
Without the libata verbose debugging patch, do you (still)
have a problem with the AHCI driver causing an Oops?

Thanks,
---
~Randy
