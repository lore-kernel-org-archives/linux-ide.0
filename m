From: Kevin Hilman <khilman@mvista.com>
Subject: Re: PCI SATA controllers on embedded, no-BIOS targets
Date: Thu, 07 Sep 2006 16:05:56 -0700
Message-ID: <4500A5D4.50606@mvista.com>
References: <44EB32E4.8080706@mvista.com> <44EB33BB.4090101@gmail.com> <44EB3650.1080404@mvista.com> <44EB3E2F.4040504@gmail.com> <44EB3F70.6000702@gmail.com> <44EB40DA.3010904@mvista.com> <44EB4658.3060207@gmail.com> <44EB7E13.5090807@mvista.com> <44EBCA7D.60808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:30855 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1422679AbWIGXF6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Sep 2006 19:05:58 -0400
In-Reply-To: <44EBCA7D.60808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Kevin Hilman wrote:
>> Tejun Heo wrote:
>>> Kevin Hilman wrote:
>>>>>> I've personally seen it working on XScale and ATI's mips.
>>>>
>>>> OK, that's good to know.
>>>>
>>>>> For the record, for ATI's new mips platform, sata_sil needs some
>>>>> modifications.  Their PCI bridge can't handle byte-aligned mmio and
>>>>> the driver had to be modified to use IO address space.
>>>>
>>>> I'm using 2.6.18-rc4 on this XScale IXP425 (big endian) and both the
>>>> legacy driver (drivers/ide/pci/siimage.c) and the libata driver
>>>> (drivers/scsi/sata_sil.c) cause crashes during probing due to bad
>>>> memory accesses.
>>>
>>> So, that one can't do byte-aligned mmio either?
>>>
>>>> Switching the legacy driver into PIO mode makes the probing work
>>>> well, but still can't figure out what's happening in the libata
>>>> driver, AFICT, it can't do PIO.
>>>
>>> By PIO, you mean accessing registers via IO address space instead of
>>> memory address space, right?  Not PIO as opposed to DMA.
>>
>> yes, I mean using PCI IO address space.
>>
>>>> Any chance you can share the changes to use IO address space?  Maybe
>>>> the PCI on this XScale has similar limitations.
>>>
>>> Sure, I've just got okay for releasing the code and am going to post
>>> the patches on my website anyway.  I'm attaching a patch.  This might
>>> not apply cleanly to your kernel but it should give enough idea.  Oh
>>> the code kills 4 ports support for 3114 too.
>>
>> OK, tweaking your patch onto 2.6.18-rc4, I've got it to work using IO
>> address space.  My patch attached for reference.  FYI, in addition to
>> your changes, I also had to change the data_xfer method to use
>> ata_pio_data_xfer instead of ata_mmio_data_xfer which was faulting
>> since  my arch doesn't have direct memory access to IO space.
> 
> Ah... right.  ATI is okay with work/double word aligned PIO, so I didn't
> notice it.

I've now been using a patched sata_sil driver for a while to support PCI
IO space on my embedded ARM target.  Do you have any plans of pushing
support for this upstream?

Kevin


