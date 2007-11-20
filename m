From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 20 Nov 2007 19:43:14 +0100
Message-ID: <200711201943.14697.ak@suse.de>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <200711201644.25615.ak@suse.de> <alpine.LFD.0.9999.0711201905240.25057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:38959 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbXKTSnU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 13:43:20 -0500
In-Reply-To: <alpine.LFD.0.9999.0711201905240.25057@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <htejun@gmail.com>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org

On Tuesday 20 November 2007 19:29:56 Thomas Gleixner wrote:
> On Tue, 20 Nov 2007, Andi Kleen wrote:
> 
> > 
> > > This requires propably working 64bit DMA, which is not possible with
> > > the SB600 controller.
> > 
> > It should not no. The remapping is done into the GART which is <4GB
> > and that is the address the SB600 sees.
> 
> Hmm, I just checked the boot logs of the failing 4GB kernel:
> 
> BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
> ...
> CPU 0: aperture @ c000000 size 32 MB
> Aperture too small (32 MB)
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ c000000
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The aperture is mapped at c000000 and c000000 + 64MB < 4GB


> Memory: 4055984k/4718592k available (2146k kernel code, 136780k reserved, 1273k data, 296k init)
> 
> 4718592k * 1024 == 0x120000000
> 
> So now we have addresses > 4G and I suspect that this is somehow
> related to the problem. 

Yes of course -- without >4GB the PCI-GART would not be used at all
(unless you force it) and then no merging.

> 
> Also is the aperture size of 32MB somehow related to this ?

This just means the BIOS didn't initialize it properly (a lot of 
BIOS don't do anymore these days because they assume it's a AGP
only feature) -- that is why the kernel allocated its own over
memory.

I think we really have to find out which request freezes it.
Can you perhaps just apply this patch and post the output?

Index: linux-2.6.24-rc1-hack/arch/x86/kernel/pci-gart_64.c
===================================================================
--- linux-2.6.24-rc1-hack.orig/arch/x86/kernel/pci-gart_64.c
+++ linux-2.6.24-rc1-hack/arch/x86/kernel/pci-gart_64.c
@@ -385,13 +385,19 @@ static int gart_map_sg(struct device *de
 	unsigned long pages = 0;
 	int need = 0, nextneed;
 	struct scatterlist *s, *ps, *start_sg, *sgmap;
-
+	
 	if (nents == 0) 
 		return 0;
 
 	if (!dev)
 		dev = &fallback_dev;
 
+	if (*dev->dma_mask <= 0xffffffff) { 
+		for_each_sg(sg, s, nents, i) { 
+			printk("%d: map %lx len %u dir %d\n", i, sg_phys(s), s->length, dir);
+		}
+	}
+
 	out = 0;
 	start = 0;
 	start_sg = sgmap = sg;



Tejun can probably figure out from that output where it comes
from in libata :)

-Andi
