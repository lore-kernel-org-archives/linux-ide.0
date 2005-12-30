From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: 30 Dec 2005 17:36:44 +0900
Message-ID: <87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tuhepnat.phys.tohoku.ac.jp ([130.34.123.133]:40203 "EHLO
	izanagi.tuhep.physp") by vger.kernel.org with ESMTP
	id S1751222AbVL3Igw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Dec 2005 03:36:52 -0500
In-Reply-To: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: ide <linux-ide@vger.kernel.org>, jgarzik <jgarzik@pobox.com>, axboe <axboe@suse.de>, chris@powerblogs.com

I tested kernel 2.6.15-rc7 with your patch applied on my ThinkPad X41.
While booting, it locks up after printing

    ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
    ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
    ata1(0): applying bridge limits
    ata1: dev 0 configured for UDMA/100

If I select CONFIG_SCSI_SATA_AHCI, then the kernel emits an oops and
panics during boot.

By the way, I found that kernel 2.6.15-rc7 with the following patches
work with or without the snd_intel8x0m module.

    git-libata-all.patch
    libata_resume_fix.patch
    libata_suspend-fix.patch
    libata_suspend.patch
    from http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/

Jae-hyeon
