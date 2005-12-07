From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 6/6 update] SATA ACPI: ata_acpi functions
Date: Wed, 7 Dec 2005 09:16:39 -0800
Message-ID: <20051207091639.00a7a232.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
	<20051202100850.11b831ea.randy_d_dunlap@linux.intel.com>
	<20051206135815.5026647c.randy_d_dunlap@linux.intel.com>
	<1133973407.43970f9fdf6dd@www.ijichi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:34219 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751212AbVLGRNp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 12:13:45 -0500
In-Reply-To: <1133973407.43970f9fdf6dd@www.ijichi.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominic Ijichi <dom@ijichi.org>
Cc: linux-ide@vger.kernel.org, axboe@suse.de, jgarzik@pobox.com

On Wed, 07 Dec 2005 16:36:47 +0000
Dominic Ijichi <dom@ijichi.org> wrote:

> I get a segfault when applying these patches to 2.6.15-rc4.  ahci compiled as
> module and inserted through initrd so the module fails with segfault and kernel
> doesnt go any further through boot, hence no logging.  last thing screen shows is:
> 
> Code: e3 36 34 c0 c7 44 24 18 29 02 00 00 59 5b 5e 5f 5d e9 f3 05 00 00 53 8b 5c
> 2408 e8 e9 03 00 00 a1 dc 0c 42 c0 eb 04 39 d8 74 07 <8b> 40 04 85 c0 75 f5 5b
> c3 55 57 56 53 50 8b 44 24 20 8b 5c 24

Can you provide any more of the segfault messages?  That one
isn't particularly helpful.

Is this on your Fujitsu notebook, with the same hardware
configuration as last week?

> also, is there a working archive for this list?  the MARC archive died on 25th
> november.

I contacted them.  It appears that their subscription to linux-ide
was dropped, so they resubscribed.  However, they are missing
linux-ide archives from Nov. 25 - Dec. 7, so if anyone has those,
they would like to get them and stuff those into the archives.
If you have linux-ide archives from that period, please let me
know or (even better) send them to hlein at progressive-comp.com .

Thanks,
---
~Randy
