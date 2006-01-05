From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Thu, 5 Jan 2006 10:36:04 -0800
Message-ID: <20060105103604.4b785239.randy_d_dunlap@linux.intel.com>
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
Received: from fmr20.intel.com ([134.134.136.19]:6592 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751881AbWAESfT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jan 2006 13:35:19 -0500
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

Hi,
While I'm looking over this, do you have a mode in which
the AHCI driver loads successfully?  If so, look for a
kernel message similar to this one:

ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x5 impl SATA mode

and post it, please.  (I think that it won't say "SATA mode".)
The "prog-if" value of 80 from your lspci output is interesting to me:
0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])

Thanks,
---
~Randy
