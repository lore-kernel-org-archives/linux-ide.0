From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Sat, 24 Oct 2009 00:50:14 +0400
Message-ID: <4AE21706.2080906@ru.mvista.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <200910212139.24675.bzolnier@gmail.com> <20091021.174155.44894825.davem@davemloft.net> <Pine.LNX.4.64.0910231031200.324@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:5983 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751351AbZJWUuS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 16:50:18 -0400
In-Reply-To: <Pine.LNX.4.64.0910231031200.324@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org, elendil@planet.nl

Hello.

Mikulas Patocka wrote:

>> Right, and see also:
>>
>> commit 6b5cde3629701258004b94cde75dd1089b556b02
>> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Date:   Mon Dec 29 20:27:32 2008 +0100
>>
>>     cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
>>
>> Which is how we got there.
>>
>> The most conservative thing to do is to set the flag as
>> is done by mpatocka's patch but I'd like Frans to regression
>> test that on his ultra5.
>>
>> Frans can you do that?
>>
>> Thanks.
>>     
>
> I read the thread about wild interrupts that Frans was observing and that 
> led to disabling the serialization.
>
> The thing is tricky --- if we read status register on interrupt, we break 
> the serialization principle and introduce potential data corruption.
>
> If we don't read the status register, the wild interrupt kills the whole 
> interrupt line.
>
> I think the interrupt handler should read the BM-status register on both 
> channels (it reflects the interrupt state even in PIO mode) to test if 
>   

   Are you sure? Anyway, there's no need as we're reading the interrupt 
bits CFR/ARTTIM23 registers first (at least in the IDE code). Look at 
the cmd*_test_irq() methods and ide_intr().

> there is an unexpected interrupt on the inactive channel --- this should 
> be much more safe than reading the status register. If there is an 
> interrupt, then
> --- read the status of the inactive channel? (potential data corruption, 
> but it is reported to happen only on boot).
> --- Or can the interrupt be acknowledged only in BM-status without 
> touching the device? I believe yes,

   And I believe no. BMIDE status bit doesn't acknoledge (clear, to be 
precise) the IDE interrupts, only the status register read does.


> it shoud shut the PCI interrupt but it 
> would leave the IDE interrupt line on (should be cleared on next command).
>   

    I think the negated wired-OR of both INTRQ signals serves as an 
-INTA source, not the BMIDE status bits. At least in the general case, 
where the BMIDE status doesn't reflect PIO mode interrupts.

> Mikulas

WBR, Sergei


