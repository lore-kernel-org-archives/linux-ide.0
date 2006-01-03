From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 09:08:47 -0800
Message-ID: <20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:64940 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751465AbWACRIF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jan 2006 12:08:05 -0500
In-Reply-To: <87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, axboe@suse.de, chris@powerblogs.com

On 30 Dec 2005 17:36:44 +0900
Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:

> I tested kernel 2.6.15-rc7 with your patch applied on my ThinkPad X41.
> While booting, it locks up after printing
> 
>     ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
>     ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
>     ata1(0): applying bridge limits
>     ata1: dev 0 configured for UDMA/100
> 
> If I select CONFIG_SCSI_SATA_AHCI, then the kernel emits an oops and
> panics during boot.

Hi,

Can you capture the kernel oops & panic messages?

Please send me your .config also.

Is this on your Fujitsu notebook with some kind of hybrid
PATA/SATA?

> By the way, I found that kernel 2.6.15-rc7 with the following patches
> work with or without the snd_intel8x0m module.

I don't understand this part.  What does the intel sound
driver have to do with this?

>     git-libata-all.patch
>     libata_resume_fix.patch
>     libata_suspend-fix.patch
>     libata_suspend.patch
>     from http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/

Thanks,
---
~Randy
