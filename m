From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Mon, 26 Oct 2009 21:20:13 +0300
Message-ID: <4AE5E85D.9060408@ru.mvista.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com> <200910212139.24675.bzolnier@gmail.com> <20091021.174155.44894825.davem@davemloft.net> <Pine.LNX.4.64.0910231031200.324@hs20-bc2-1.build.redhat.com> <4AE21706.2080906@ru.mvista.com> <Pine.LNX.4.64.0910260717290.21316@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:48981 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752516AbZJZSUZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 14:20:25 -0400
In-Reply-To: <Pine.LNX.4.64.0910260717290.21316@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org, elendil@planet.nl

Hello.

Mikulas Patocka wrote:

>>  Are you sure? Anyway, there's no need as we're reading the interrupt bits
>>CFR/ARTTIM23 registers first (at least in the IDE code). Look at the
>>cmd*_test_irq() methods and ide_intr().

> Maybe the BMIDE status bit is just the same as CFR/ARTTIM23 interrupt bit.

    Maybe -- if it indeed gets set in PIO mode as well. In this case though, 
there's quite little sense in having that bit mirrored (even twice with the 
newer controllers).

>>>there is an unexpected interrupt on the inactive channel --- this should be
>>>much more safe than reading the status register. If there is an interrupt,
>>>then
>>>--- read the status of the inactive channel? (potential data corruption, but
>>>it is reported to happen only on boot).
>>>--- Or can the interrupt be acknowledged only in BM-status without touching
>>>the device? I believe yes,

>>  And I believe no. BMIDE status bit doesn't acknoledge (clear, to be precise)
>>the IDE interrupts, only the status register read does.

> There are two things: IDE interrupt line set by the device (BMIDE status 
> doesn't do anything with it) and chipset's INT[A-D] interrupt line --- and 
> BMIDE status should clear it, at least for some chipsets.

> Some chipset documentation (not for CMD64x) thatI have says that BMIDE 
> irq status is set on any interrupt regardless if it's DMA or NONDMA.

    That is rather untypical behavior although some chipsets like Intel ICH 
are known to do it.

> On ICH SATA (in legacy non-AHCI mode), it is even required to acknowledge 
> PIO interrupts with BMIDE status, otherwise the interrupt stays pending.

>>>it shoud shut the PCI interrupt but it would leave the IDE interrupt line on
>>>(should be cleared on next command).

>>   I think the negated wired-OR of both INTRQ signals serves as an -INTA
>>source, not the BMIDE status bits. At least in the general case, where the
>>BMIDE status doesn't reflect PIO mode interrupts.

> It is not as simple, INTA and BMIDE status must be postponed until the 
> chip flushes its buffers and writes the DMA last byte to the memory.

    I know. The delay logic only acts in the DMA case. And it doesn't have 
to delay the interrupt itself, only the BMIDE status read with bit 2 set -- 
which is achievable by retrying the I/O transaction on PCI until the DMA 
actually completes.

> I agree with you that for some chipsets BMIDE doesn't have to be signalled 
> in PIO mode --- but remember that here we are talking about dealing with 
> broken devices that set the interrupt line spuriously and about 
> serializing chipsets --- not about all chipsets and all devices.

> So the best that can be done for such broken devices is to try to shut the 
> interrupt in BMIDE register (or PCI registers in CMD64x). There is nothing 
> better to do.

    And we're doing it, now for the PIO case also.

> If you have serializing chipset that doesn't let you shut 
> interrupt and the inactive device fires spuriously --- there is absolutely 
> nothing that can be done about it.

    Yes, seems so from ide_intr()...

> Mikulas

WBR, Sergei
