From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 18:26:49 +0100
Message-ID: <20060103172649.GV2772@suse.de>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com> <87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp> <20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:15445 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932460AbWACRZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 12:25:16 -0500
Content-Disposition: inline
In-Reply-To: <20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On Tue, Jan 03 2006, Randy Dunlap wrote:
> On 30 Dec 2005 17:36:44 +0900
> Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:
> 
> > I tested kernel 2.6.15-rc7 with your patch applied on my ThinkPad X41.
> > While booting, it locks up after printing
> > 
> >     ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
> >     ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
> >     ata1(0): applying bridge limits
> >     ata1: dev 0 configured for UDMA/100
> > 
> > If I select CONFIG_SCSI_SATA_AHCI, then the kernel emits an oops and
> > panics during boot.
> 
> Hi,
> 
> Can you capture the kernel oops & panic messages?

I think I triggered the same oops on my T43, I'll try applying your sata
acpi patches and see if it reproduces.

> Please send me your .config also.
> 
> Is this on your Fujitsu notebook with some kind of hybrid
> PATA/SATA?

He notes it's an X41 - by the messages above, it is indeed a PATA drive
hidden behind a SATA bridge. The T43 uses the same kind of setup.

-- 
Jens Axboe

