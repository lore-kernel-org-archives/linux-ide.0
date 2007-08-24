From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.23-rc3] pata_pdc2027x: PLL detection fixes
Date: Fri, 24 Aug 2007 20:24:55 +0400
Message-ID: <46CF0657.3080004@ru.mvista.com>
References: <200708191717.l7JHHtMO021933@harpo.it.uu.se> <46C8832D.8040801@ru.mvista.com> <46CABEAC.3070203@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:43796 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751512AbXHXQWV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Aug 2007 12:22:21 -0400
In-Reply-To: <46CABEAC.3070203@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mikael Pettersson <mikpe@it.uu.se>, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org

Hello.

Albert Lee wrote:

>>>b) puts more work [the enter test mode stuff] in between the start
>>>   and and sampling points, reducing the precision of the PLL
>>>   detection; I actually observed quite noticeable differences
>>>   in detected PLL frequency based on whether the start was sampled
>>>   before or after the test mode enter code

>>   I'd think this differnce is negligible with 100 ms delay. But why not
>>-- shouldn't harm indeed (except it's better to read a stable counter
>>before than unstable one after entering test mode)?

>>>>>  The fix is to move the read of the start value to after
>>>>>  test mode is started, but before the mdelay() in test mode.

>>>>   This is not an issue, so no fix is needed.

>>>>>  This also improves the precision of the PLL detection.

>>>>   BTW, looks like we don't even need to bother reading the darn
>>>>counter beforehand: bit 1 of the indexed register 1 (the same used to
>>>>enter/exit test mode by twiddling its bit 6) when being cleared
>>>>should reset the counter to 0 

>>   Or maybe to 0x7fff?  I can't remember already -- never seen those
>>infamous Promise papers, and I was testing this code looong ago
>>already... :-)

> I've tested reloading the pata_pdc2027x module before.
> The counter seems not cleared when leaving the test mode.

     I never saud that. Counter should be cleared by resetting "test mode" bit.
But I'm seeing the cause of misinteprettion: one may think that bit 1 is used 
to clear counters but I meant to say that clearing bit 1 of that ssme register 
should clear the counters...

>>>>>2. The code to compute the number of PLL decrements during the
>>>>>  mdelay() in test mode fails to consider that the PLL counter
>>>>>  only is 30 bits wide. If there is a wraparound, it will compute
>>>>>  an incorrect and much too large value. On the PowerMac, the
>>>>>  start count is zero, the end count is a large 30-bit value, so
>>>>>  wraparound occurs and an out of bounds PLL clock is detected.

>>>>>  The fix is to mask the (start - end) computation to 30 bits.

>>>>   Yeah, that's what I've done for the old IDE driver...

>>>Except that due to what may be a typo pdc202xx_new masks to
>>>26 bits, not 30.

>>   Indeed! :-<
>>   Thanks for noticing -- this is a typo, of course... And it's a pity
>>that Albert failed to notice it when he last touched that driver...

> I was too blind to notice the wrong 26-bit mask. :(

> Fortunately with the 10ms delay used by the IDE pdc202xx_new driver,
> (start_count - end_count) is smaller than the 26-bit mask. So it
> doesn't actually damage anything.

    Yeah, I thought so.

>>>I was going to address that if/when this patch
>>>goes in.

>>   Please do, I'm too short of time.  But I guess the difference was
>>never that large, so the clipped mask worked...
>>   I wonder if the true reason of the former issue which was attibuted
>>mdelay() being imprecise...

> mdelay() is actually imprecise on my x86 PC. This can be measured by
> doing some do_gettimeofday() tests. It's quite precise when tested on
> ppc64...

    Hm...

> --
> albert

    Don't overquote, please. ;-)

MBR, Sergei

