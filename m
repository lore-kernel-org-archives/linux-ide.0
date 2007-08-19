From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Sun, 19 Aug 2007 08:14:15 +0800
Message-ID: <46C78B57.5070808@tw.ibm.com>
References: <200708182058.l7IKwrcJ016820@harpo.it.uu.se> <46C763D1.7060801@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:59164 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbXHSAOS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 20:14:18 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7J0EHgf015928
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 20:14:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7J0EH0W158986
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 18:14:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7J0EHo1019968
	for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 18:14:17 -0600
In-Reply-To: <46C763D1.7060801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, albertl@mail.com

Jeff Garzik wrote:
> Mikael Pettersson wrote:
> 
>> Previously I reported that the pata_pdc2027x PLL detection changes
>> in kernel 2.6.22 broke the driver on my PowerMac:
>>
>>> pata_pdc2027x: Invalid PLL input clock 1691742kHz, give up!
>>
>>
>> This is followed by a number of errors and speed reduction
>> steps on the affected ports.
>>
>> There are two bugs in pata_pdc2027x's PLL detection code:
>>
>> 1. The PLL counter's start value is read before the chip is
>>    put in "test mode". Outside of test mode the counter is
>>    halted, and on the PowerMac the counter is zero because
>>    the chip hasn't been initialised by its BIOS.
>>
>>    The fix is to move the read of the start value to after
>>    test mode is started, but before the mdelay() in test mode.
>>    This also improves the precision of the PLL detection.
>>
>> 2. The code to compute the number of PLL decrements during the
>>    mdelay() in test mode fails to consider that the PLL counter
>>    only is 30 bits wide. If there is a wraparound, it will compute
>>    an incorrect and much too large value. On the PowerMac, the
>>    start count is zero, the end count is a large 30-bit value, so
>>    wraparound occurs and an out of bounds PLL clock is detected.
>>
>>    The fix is to mask the (start - end) computation to 30 bits.
>>
>> While debugging this I also noticed that pdc_read_counter()
>> reads the two halves of the 30-bit PLL counter as 16-bit values,
>> and then combines them as if the halves only are 15 bits wide.
>> To avoid confusion, the halves should be read as 15-bit values.
>>
>> This patch implements all three changes. It fixes the PLL detection
>> failure on my PowerMac, and doesn't cause any regressions on an x86
>> with an identical card.
>>
>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> 
> Fantastic!  Thanks for putting in a great effort to track these down.
> 
> I'll queue it up [unless someone responds with a problem requiring
> revision, of course]
> 
> 
>> diff -rupN linux-2.6.23-rc3/drivers/ata/pata_pdc2027x.c
>> linux-2.6.23-rc3.pata_pdc2027x-pll-detection-fixes/drivers/ata/pata_pdc2027x.c
>>
>> --- linux-2.6.23-rc3/drivers/ata/pata_pdc2027x.c    2007-07-09
>> 22:01:31.000000000 +0200
>> +++
>> linux-2.6.23-rc3.pata_pdc2027x-pll-detection-fixes/drivers/ata/pata_pdc2027x.c   
>> 2007-08-18 21:53:40.000000000 +0200
>> @@ -563,13 +563,13 @@ static long pdc_read_counter(struct ata_
>>      u32 bccrl, bccrh, bccrlv, bccrhv;
>>  
>>  retry:
>> -    bccrl = readl(mmio_base + PDC_BYTE_COUNT) & 0xffff;
>> -    bccrh = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0xffff;
>> +    bccrl = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
>> +    bccrh = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
>>      rmb();
>>  
>>      /* Read the counter values again for verification */
>> -    bccrlv = readl(mmio_base + PDC_BYTE_COUNT) & 0xffff;
>> -    bccrhv = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0xffff;
>> +    bccrlv = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
>> +    bccrhv = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
>>      rmb();
>>  
>>      counter = (bccrh << 15) | bccrl;
> 
> 
> Unrelated to your changes, but, I wonder why those rmb() are there at
> all...?
> 

The first rmb() is to make sure bccrl is read before bccrlv for later
(bccrl >= bccrlv) check since both reading the same memory address.

The second rmb() looks like leftover when the code copy-and-paste'ed.
Maybe we can remove this one.
--
albert


