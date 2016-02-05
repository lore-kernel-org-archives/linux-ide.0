From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7] SATA: OCTEON: support SATA on OCTEON platform
Date: Fri, 05 Feb 2016 16:10:40 +0100
Message-ID: <4427989.vm6oM7UICv@wuerfel>
References: <1454520915-27948-1-git-send-email-Zubair.Kakakhel@imgtec.com> <56B342FF.1090709@caviumnetworks.com> <56B376CE.9010600@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:58257 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcBEPLI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Feb 2016 10:11:08 -0500
In-Reply-To: <56B376CE.9010600@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 04 February 2016 16:05:34 Zubair Lutfullah Kakakhel wrote:
> Thank-you for the review.
> 
> On 04/02/16 12:24, Aleksey Makarov wrote:
> >
> > Hi Zubair,
> >
> >> +    void __iomem *base;
> >
> > [..]
> >
> >> +    cfg = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
> >
> > sparse will complain here.  See Documentation/sparse.txt
> 
> Yes. sparse says
> 
> ...
> CHECK   drivers/ata/sata_octeon.c
> drivers/ata/sata_octeon.c:50:30: warning: cast removes address space of expression
> drivers/ata/sata_octeon.c:65:25: warning: cast removes address space of expression
> ...
> 
> Use of (__force uint64_t) removes the sparse warning. But it was
> frowned upon by arnd.
> 
> He suggested a wrapper helper in asm/octeon/cvmx.h which handles iomem
> addresses and __force behind the scenes rather than in the driver.

Obviously I was not suggesting to remove the __force without fixing
the address space mismatch first.

> static inline void cvmx_write_csr_resource(void __iomem *csr_addr, uint64_t val)
> {
>         cvmx_write_csr((__force uint64_t)csr_addr, val)
> }
> 
> Alternatives? Or should I resend with the above wrapper?

Maybe just name it cvmx_writeq()? This is close enough to the normal
writeq, except it does not serialize against DMA or spinlocks as
writeq does, and it assumes that the device is the same endianess
as the CPU, whereas writeq assumes that devices are fixed-endian.

	Arnd
