From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 20 Nov 2007 19:29:56 +0100 (CET)
Message-ID: <alpine.LFD.0.9999.0711201905240.25057@localhost.localdomain>
References: <198606.73895.qm@web52608.mail.re2.yahoo.com> <47423245.1050109@gmail.com> <alpine.LFD.0.9999.0711201559520.25057@localhost.localdomain> <200711201644.25615.ak@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:58167 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761590AbXKTSaF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Nov 2007 13:30:05 -0500
In-Reply-To: <200711201644.25615.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org

On Tue, 20 Nov 2007, Andi Kleen wrote:

> 
> > This requires propably working 64bit DMA, which is not possible with
> > the SB600 controller.
> 
> It should not no. The remapping is done into the GART which is <4GB
> and that is the address the SB600 sees.

Hmm, I just checked the boot logs of the failing 4GB kernel:

BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
...
CPU 0: aperture @ c000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ c000000
Memory: 4055984k/4718592k available (2146k kernel code, 136780k reserved, 1273k data, 296k init)

4718592k * 1024 == 0x120000000

So now we have addresses > 4G and I suspect that this is somehow
related to the problem. 

When mem=3500M is given on the kernel command line, we do not use this
address space.

Also is the aperture size of 32MB somehow related to this ?

     tglx
