From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Wed, 14 Nov 2007 22:55:04 +1100 (EST)
Message-ID: <198606.73895.qm@web52608.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52608.mail.re2.yahoo.com ([206.190.48.211]:41160 "HELO
	web52608.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750866AbXKNLzG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 06:55:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

[Sorry to reply to my own email thread]

Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:
...
> No problems. Here's the log of unworking kernel with IOMMU turned on.
> Basically it goes on reseting the SATA ports throwing many errors (none are
> present in 2.6.23 or on 2.6.24-rc with mem=3500M) for many minutes at which
> point I do a power reset :-(.
> 
> Also the log of the working kernel with IOMMU but with mem=3500M is also
> attached for the record. It's basically the same above kernel just with the
> added parameter.

Gentlemen,

This changeset has introduced a regression in 2.6.24-rc, such that my machine
boots no more:
http://www.kernel.org/hg/linux-2.6/rev/ddf8804136fb
changeset:   72064:ddf8804136fb
user:        Andi Kleen <ak@suse.de>
date:        Fri Oct 19 20:35:03 2007 +0200
files:       arch/x86/kernel/pci-dma_64.c
description:
x86: enable iommu_merge by default

[ tglx: arch/x86 adaptation ]

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

committer: Thomas Gleixner <tglx@linutronix.de>


diff -r 8c8683cbdc05 -r ddf8804136fb arch/x86/kernel/pci-dma_64.c
--- a/arch/x86/kernel/pci-dma_64.c      Fri Oct 19 20:35:03 2007 +0200
+++ b/arch/x86/kernel/pci-dma_64.c      Fri Oct 19 20:35:03 2007 +0200
@@ -11,7 +11,7 @@
 #include <asm/iommu.h>
 #include <asm/calgary.h>

-int iommu_merge __read_mostly = 0;
+int iommu_merge __read_mostly = 1;
 EXPORT_SYMBOL(iommu_merge);

 dma_addr_t bad_dma_address __read_mostly;

As a work-around, I can get it to boot with mem=3500M, but then it's ugly ;-)
& I lose some valuable memory I have.

Here's my email thread on linux-ide capturing the good & bad kernel behaviour
for reference:
http://marc.info/?t=119456213200005&r=1&w=2

Thanks

Hari

PS: Here's hoping for a kernel mem= parameter free bootable 2.6.24 ;-).



      Feel safe with award winning spam protection on Yahoo!7 Mail.  
www.yahoo.com.au/mail 

