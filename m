From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Sat, 7 Jan 2006 08:55:13 -0800
Message-ID: <20060107085513.7147cb11.rdunlap@xenotime.net>
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
	<20060106124310.10157732.randy_d_dunlap@linux.intel.com>
	<87d5j418uz.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:8868 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030507AbWAGQzQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jan 2006 11:55:16 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Sat, 7 Jan 2006 08:55:14 -0800
In-Reply-To: <87d5j418uz.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: randy_d_dunlap@linux.intel.com, axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On 07 Jan 2006 22:11:00 +0900 Jae-hyeon Park wrote:

> Randy Dunlap <randy_d_dunlap@linux.intel.com> writes:
> 
> > To clarify more (for me):
> > Without the libata verbose debugging patch, do you (still)
> > have a problem with the AHCI driver causing an Oops?
> 
> I compiled six versions of kernels anew and tested again.
> The results are as follows:
> 
>     2.6.15-rc7 + libata-combine.patch AHCI=n
>         Kernel panics.  Symbols in call trace are as in
>         http://marc.theaimsgroup.com/?l=linux-ide&m=113632815321896&w=2
>     
>     2.6.15-rc7 + libata-combine.patch AHCI=y
>         Kernel panics.  Symbols in call trace are as in
>         http://marc.theaimsgroup.com/?l=linux-ide&m=113632815321896&w=2
>     
>     2.6.15-rc7 + libata-combine.patch + verbose patch AHCI=n
>         Kernel panics.  Symbols in call trace are as in
>         http://marc.theaimsgroup.com/?l=linux-ide&m=113647020707839&w=2
>     
>     2.6.15-rc7 + libata-combine.patch + verbose patch AHCI=y
>         Kernel panics.  Symbols in call trace are as in
>         http://marc.theaimsgroup.com/?l=linux-ide&m=113647020707839&w=2
>     
>     2.6.15 + libata-combine-2615.patch AHCI=n
>         Resume works if snd_intel8x0m has been loaded.
>     
>     2.6.15 + libata-combine-2615.patch AHCI=y
>         Resume works if snd_intel8x0m has been loaded.
> 
> It turned out that kernel panic is independent of AHCI option.  I made
> a wrong statement in the bug report perhaps because I was compiling
> too many kernels.  I am sorry for the confusion.

No problem.  I'll take a look at those panics again.

---
~Randy
