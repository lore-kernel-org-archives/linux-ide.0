From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: piix dma setup code
Date: Wed, 19 May 2004 19:19:19 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40ABEB77.4090109@pobox.com>
References: <40A9F150.4070209@turbolinux.co.jp> <200405191851.06281.bzolnier@elka.pw.edu.pl> <40ABE058.7070705@pobox.com> <200405200059.19575.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32736 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264671AbUESXTc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 19:19:32 -0400
In-Reply-To: <200405200059.19575.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Go Taniguchi <go@turbolinux.co.jp>, linux-ide@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>

Bartlomiej Zolnierkiewicz wrote:
> On Thursday 20 of May 2004 00:31, Jeff Garzik wrote:
> 
>>(added Jun to CC)
>>
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>>On Tuesday 18 of May 2004 13:19, Go Taniguchi wrote:
>>>
>>>>If speed is XFER_UDMA_6, base clock is set to low base clock.
>>>>It should be "speed >= XFER_UDMA_5". My ICH6 system reported XFER_UDMA_6,
>>>
>>>Jeff, does ICH6 support UDMA6?
>>>ICH5 doesn't but ata_piix.c allows it.
>>
>>Good question.  AFAICS ICH5 and ICH6 are the same such that:
>>* PATA does not support UDMA6
>>* internal base clock is 133Mhz for UDMA5
> 
> 
> strange, it is 100MHz according to the datasheet

Grab the latest ICH5 docs from developer.intel.com, they say the same 
thing as the ICH6 docs.  Section 5.16.6, "Ultra ATA/33/66/100 Timing":

> The internal Base Clock for Ultra ATA/100 (Mode 5) runs at 133 MHz, and 
> the Cycle Time (CT) must be set for three Base Clocks. The ICH5 thus 
> toggles the write strobe signal every 22.5 ns, transferring two bytes of


>>* SATA PCI device exports, but completely ignores, PATA timing registers
>>
>>So for ata_piix at least, I would prefer to do
>>* patch1: your patch, based on Go's patch
>>* patch2: only configure timing registers for PATA port (PATA is only
>>used when an #ifdef is defined)
>>* patch3: do not limit SATA to udma5
> 
> 
> OK
> 
> this reminds me that long time ago I spotted small bug in configuring PATA
> timing registers in ata_piix.c but was too lazy to send a patch because code
> is #ifdef-ed and bug was (is?) only for slave device 8)

Patches welcome :)  Slave device is a possibility on ICH6, which maps 4 
SATA ports onto IDE primary/secondary master/slave, when not in evil 
combined mode.

If you are motivated, I need to re-copy the drivers/ide/pci/piix.c 
tune_chipset function to ata_piix.c, because I need to add MWDMA support 
back to that function.

	Jeff



