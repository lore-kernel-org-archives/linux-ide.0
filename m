From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Question about PATA Sil680 Cache Line Size and Performance Degradation
 on ARM XScale
Date: Thu, 22 Feb 2007 18:23:06 -0500
Message-ID: <45DE25DA.6080308@garzik.org>
References: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>	 <20070222000400.2c220b8f@lxorguk.ukuu.org.uk>	 <8202f4270702211721o1629aa63q3670823b7348df1f@mail.gmail.com>	 <20070222185202.03121afc@lxorguk.ukuu.org.uk>	 <45DDDE68.8070609@garzik.org> <8202f4270702221514v680bb78byf5dd840e1ef861ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41544 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbXBVXXL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Feb 2007 18:23:11 -0500
In-Reply-To: <8202f4270702221514v680bb78byf5dd840e1ef861ca@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> On 2/22/07, Jeff Garzik <jeff@garzik.org> wrote:
>> Alan wrote:
>> >> Since Sil3124 has better PCI read/write performance, as a reference,
>> >> could someone explain or point me to the PCI configuration code for
>> >> Sil3124? I couldn't find it in sata_sil24.c.
>> >
>> > Are you sure the values used are not the power on ones in this case ?
>>
>> The values used, most likely, are BIOS-programmed.
>>
>> sata_sil24.c does not call pci_set_mwi(), which is the only code in the
>> kernel (besides driver-specific, hand-coded stuff) that adjusts the PCI
>> cacheline register value.
>>
> 
> I traced the latency timer and cache line size setup in  SATA Sil3124.
> Latency timer is set to 0x40 and cache line size is set to 0.  For
> PATA Sil680, latency timer is set to 0 and cache line size is set to
> 1.  If Sil3124 is a good reference for performance, we probably should
> set latency timer to 0x40 and cache line size to 0 or 8 for Sil680.
> Both Sil3124 and Sil680 specs recommend using Read Multiple as a PCI

If you are going to be using PCI transactions that operate on cacheline 
size-based quantities of data, you should definitely program the PCI 
config register to a non-zero value.


> master, ARM XScale cache line is 32 bytes, so it is probably better to
> set cache line size to 8 for ARM XScale.   I tested both
> configurations(cache line of 0 vs 8) though, no big difference in IO
> performance but both are much better than default configuration in
> Sil680.

Read pci_set_cacheline_size() in drivers/pci/pci.c for the proper method 
of programming.

	Jeff


