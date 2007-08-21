From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Tue, 21 Aug 2007 18:30:04 +0800
Message-ID: <46CABEAC.3070203@tw.ibm.com>
References: <200708191717.l7JHHtMO021933@harpo.it.uu.se> <46C8832D.8040801@ru.mvista.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:38063 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbXHUKaP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 06:30:15 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7LAUEp7015465
	for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 06:30:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7LAUENG261992
	for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 04:30:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7LAUD9x009856
	for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 04:30:14 -0600
In-Reply-To: <46C8832D.8040801@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, albertl@mail.com, jeff@garzik.org, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Mikael Pettersson wrote:
> 
>>>> Previously I reported that the pata_pdc2027x PLL detection changes
>>>> in kernel 2.6.22 broke the driver on my PowerMac:
> 
> 
>>>>> pata_pdc2027x: Invalid PLL input clock 1691742kHz, give up!
> 
> 
>>>> This is followed by a number of errors and speed reduction
>>>> steps on the affected ports.
> 
> 
>>>> There are two bugs in pata_pdc2027x's PLL detection code:
> 
> 
>>>> 1. The PLL counter's start value is read before the chip is
>>>>   put in "test mode". Outside of test mode the counter is
>>>>   halted, and on the PowerMac the counter is zero because
>>>>   the chip hasn't been initialised by its BIOS.
> 
> 
>>>    So what?
> 
> 
>> a) causes an unnecessary wraparound, which in turn is one of the
>>    causes for PLL detection failures on non-x86
> 
> 
>    It is *not* the cause of failure -- the old IDE driver copes well
> with this on non-x86. ;-)
> 
>> b) puts more work [the enter test mode stuff] in between the start
>>    and and sampling points, reducing the precision of the PLL
>>    detection; I actually observed quite noticeable differences
>>    in detected PLL frequency based on whether the start was sampled
>>    before or after the test mode enter code
> 
> 
>    I'd think this differnce is negligible with 100 ms delay. But why not
> -- shouldn't harm indeed (except it's better to read a stable counter
> before than unstable one after entering test mode)?
> 
>>>>   The fix is to move the read of the start value to after
>>>>   test mode is started, but before the mdelay() in test mode.
> 
> 
>>>    This is not an issue, so no fix is needed.
> 
> 
>>>>   This also improves the precision of the PLL detection.
> 
> 
>>>    BTW, looks like we don't even need to bother reading the darn
>>> counter beforehand: bit 1 of the indexed register 1 (the same used to
>>> enter/exit test mode by twiddling its bit 6) when being cleared
>>> should reset the counter to 0 
> 
> 
>    Or maybe to 0x7fff?  I can't remember already -- never seen those
> infamous Promise papers, and I was testing this code looong ago
> already... :-)


I've tested reloading the pata_pdc2027x module before.
The counter seems not cleared when leaving the test mode.


> 
>>> -- I'm looking at the internal sources which were written based on
>>> the *fragment* of the PDC20270 datasheet (yeah, Promise didn't even
>>> give us the whole datasheet!) about the PLL calibration.
> 
> 
>> Well, I have no data sheet and no sources except what's in the kernel
>> and what debug info PDC_DEBUG generates.
> 
> 
>    IIRC, Albert should have the docs but he's under NDA.
>    What have really surpried me about Promise was that they gave their
> SATA chip docs to Jeff who made them public and yet they continue to
> conceal the old PATA chip docs... :-/
> 
>>>> 2. The code to compute the number of PLL decrements during the
>>>>   mdelay() in test mode fails to consider that the PLL counter
>>>>   only is 30 bits wide. If there is a wraparound, it will compute
>>>>   an incorrect and much too large value. On the PowerMac, the
>>>>   start count is zero, the end count is a large 30-bit value, so
>>>>   wraparound occurs and an out of bounds PLL clock is detected.
> 
> 
>>>>   The fix is to mask the (start - end) computation to 30 bits.
> 
> 
>>>    Yeah, that's what I've done for the old IDE driver...
> 
> 
>> Except that due to what may be a typo pdc202xx_new masks to
>> 26 bits, not 30.
> 
> 
>    Indeed! :-<
>    Thanks for noticing -- this is a typo, of course... And it's a pity
> that Albert failed to notice it when he last touched that driver...

I was too blind to notice the wrong 26-bit mask. :(

Fortunately with the 10ms delay used by the IDE pdc202xx_new driver,
(start_count - end_count) is smaller than the 26-bit mask. So it
doesn't actually damage anything.

> 
>> I was going to address that if/when this patch
>> goes in.
> 
> 
>    Please do, I'm too short of time.  But I guess the difference was
> never that large, so the clipped mask worked...
>    I wonder if the true reason of the former issue which was attibuted
> mdelay() being imprecise...

mdelay() is actually imprecise on my x86 PC. This can be measured by
doing some do_gettimeofday() tests. It's quite precise when tested on
ppc64...

--
albert

> 
>>>> While debugging this I also noticed that pdc_read_counter()
>>>> reads the two halves of the 30-bit PLL counter as 16-bit values,
>>>> and then combines them as if the halves only are 15 bits wide.
>>>> To avoid confusion, the halves should be read as 15-bit values.
> 
> 
>>>    Shouldn't matter, the bit is most probably reseved and so always
>>> remains 0.
>>> Actually, those 2 counters count the data bytes transferred over PCI
>>> bus when the chip in not in the test mode.
> 
> 
>> It matters when someone reads the code and wonders why two 16-bit values
>> (readl() & 0xffff) are combined with a 15-bit shift ((x << 15) | y).
> 
> 
>    Well, let it be. :-)
> 
>>>> This patch implements all three changes. It fixes the PLL detection
>>>> failure on my PowerMac, and doesn't cause any regressions on an x86
>>>> with an identical card.
> 
> 
>>>> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> 

