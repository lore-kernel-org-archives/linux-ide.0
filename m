From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 12:11:04 -0800
Message-ID: <20060103121104.68ce2cca.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de>
	<20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<20060103200603.GA3472@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:52697 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932519AbWACUKc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 15:10:32 -0500
In-Reply-To: <20060103200603.GA3472@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: jhpark@tuhep.phys.tohoku.ac.jp, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On Tue, 3 Jan 2006 21:06:03 +0100
Jens Axboe <axboe@suse.de> wrote:

> On Tue, Jan 03 2006, Randy Dunlap wrote:
> > > ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18C0 irq 14
> > > ata1: dev 0 cfg 49:2f00 82:346b 83:7d09 84:6003 85:3469 86:3c09 87:6003
> > > 88:203f
> > > ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
> > > ata1(0): applying bridge limits
> > > ata1: dev 0 configured for UDMA/100
> > > ata_acpi_exec_tfs: call get_GTF, ix=0
> > > ata_acpi_exec_tfs: call set_taskfiles, ix=0
> > > do_drive_set_taskfiles: unexpected GTF length (-271707516)
> > 
> > Ugh.  So the ACPI taskfile data looks like crap??
> > I guess that I'll just invalidate gtf_address (set to NULL)
> > if gtf_length looks invalid.  Is there something better to do?
> 
> Bugger me, I'm totally acpi ignorant. But did you see my note that if I
> clear gtf_address before calling into the function (where you pass it by
> reference), the problem goes away? That smells more like return-on-error
> without setting it at all, hence kfree() blows up when passed a bogus
> stack filled variable.

Yes, I'll fix that part also.

> > Jae-hyeon,
> > 
> > Please send me a dump of your ACPI tables (acpidump).
> > 'acpidump' is at
> > http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ .
> > Use the latest pmtools tarball.
> 
> I've attached mine as well, in case they are useful.
> 
> > Jens, could you see that <gtf_address> your system is
> > getting that is invalid?
> 
> Sure, will reboot it after posting this message.
> 
> -- 
> Jens Axboe


---
~Randy
