From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: ATAPI devices in AHCI mode not working
Date: Wed, 31 Oct 2007 10:40:46 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701EE38E6@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com><20071029203028.35645f26@the-village.bc.nu><39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com> <20071029221332.1c9525a9@the-village.bc.nu> <39B20DF628532344BC7A2692CB6AEE0701EA70F4@orsmsx420.amr.corp.intel.com> <472837B4.3000109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29085 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095AbXJaRlZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 13:41:25 -0400
Content-class: urn:content-classes:message
In-Reply-To: <472837B4.3000109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

>-----Original Message-----
>From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>owner@vger.kernel.org] On Behalf Of Tejun Heo
>Sent: Wednesday, October 31, 2007 1:07 AM
>To: Gaston, Jason D
>Cc: Alan Cox; linux-ide@vger.kernel.org
>Subject: Re: ATAPI devices in AHCI mode not working
>
>Gaston, Jason D wrote:
>>> -----Original Message-----
>>> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>>> Sent: Monday, October 29, 2007 3:14 PM
>>> To: Gaston, Jason D
>>> Cc: linux-ide@vger.kernel.org
>>> Subject: Re: ATAPI devices in AHCI mode not working
>>>
>>>> ata1: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101100 irq
216
>>>> ata2: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101180 irq
216
>>>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>>> ata1.00: ATAPI: ATAPI   DVD D  DH16D2S, EP52, max UDMA/100
>>>> ata1.00: configured for UDMA/100
>>> Much better - no misdetected link type, no device claiming to be
PATA
>>> when its SATA.
>>>
>>>
>>> Right that eliminates all the obvious goings on being caused by
broken
>>> devices which is a start. Doesn't shed any light on the rest of it.
>> What
>>> happens if you boot with irqpoll enabled ? (wondering if the
timeouts
>> are
>>> ACPI or IRQ routing stuff)
>>
>> I rebuilt the kernel; the DVD and USB devices are functional now. I'm
>> not sure what the problem was before.  On a side note: In 2.6.24.rc1
the
>> DVD starts working right away, but on a SLES10_SP1 kernel, it takes
some
>> time for it to step down to a PIO mode before the DVD can be mounted.
>> Oh well.
>
>Yeah, there has been quite some update in libata between SLES10_SP1 and
>2.6.24-rc1.  The controller being ahci, I wonder whether this is caused
>by the different in check_atapi_dma().
>
>1. Does other optical drives have the same problem?  If not, please
post
>the result of "hdparm -I /dev/sr0" with the problematic one attached.
>
>2. If you apply the attached patch to 2.6.24-rc1, does it behave the
>same as the SLES10SP1 kernel?
>
>--
>Tejun

All of the ATAPI drives seem to have the issue of taking a while to slow
down and start working.  I will try the patch and see what happens.  I
will also get the hdparm info from all of the drives I am using to see
if something stands out.

Thanks,

Jason
 
