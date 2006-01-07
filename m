From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: 07 Jan 2006 22:11:00 +0900
Message-ID: <87d5j418uz.fsf@marrow.phys.tohoku.ac.jp>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de> <20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
	<20060103164009.1c7418a7.randy_d_dunlap@linux.intel.com>
	<87ek3o22z8.fsf@marrow.phys.tohoku.ac.jp>
	<20060104114222.25182742.randy_d_dunlap@linux.intel.com>
	<87aceag437.fsf@marrow.phys.tohoku.ac.jp>
	<20060106124310.10157732.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tuhepnat.phys.tohoku.ac.jp ([130.34.123.133]:46350 "EHLO
	izanagi.tuhep.physp") by vger.kernel.org with ESMTP
	id S1030439AbWAGNLX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jan 2006 08:11:23 -0500
In-Reply-To: <20060106124310.10157732.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:

> To clarify more (for me):
> Without the libata verbose debugging patch, do you (still)
> have a problem with the AHCI driver causing an Oops?

I compiled six versions of kernels anew and tested again.
The results are as follows:

    2.6.15-rc7 + libata-combine.patch AHCI=n
        Kernel panics.  Symbols in call trace are as in
        http://marc.theaimsgroup.com/?l=linux-ide&m=113632815321896&w=2
    
    2.6.15-rc7 + libata-combine.patch AHCI=y
        Kernel panics.  Symbols in call trace are as in
        http://marc.theaimsgroup.com/?l=linux-ide&m=113632815321896&w=2
    
    2.6.15-rc7 + libata-combine.patch + verbose patch AHCI=n
        Kernel panics.  Symbols in call trace are as in
        http://marc.theaimsgroup.com/?l=linux-ide&m=113647020707839&w=2
    
    2.6.15-rc7 + libata-combine.patch + verbose patch AHCI=y
        Kernel panics.  Symbols in call trace are as in
        http://marc.theaimsgroup.com/?l=linux-ide&m=113647020707839&w=2
    
    2.6.15 + libata-combine-2615.patch AHCI=n
        Resume works if snd_intel8x0m has been loaded.
    
    2.6.15 + libata-combine-2615.patch AHCI=y
        Resume works if snd_intel8x0m has been loaded.

It turned out that kernel panic is independent of AHCI option.  I made
a wrong statement in the bug report perhaps because I was compiling
too many kernels.  I am sorry for the confusion.

Jae-hyeon
