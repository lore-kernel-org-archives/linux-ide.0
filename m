From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA Sil680 Disabling IRQ
Date: Thu, 28 Feb 2008 17:24:14 -0500
Message-ID: <47C7348E.5070607@garzik.org>
References: <8202f4270802261647t505cccf7ra3c81e5fccc9366a@mail.gmail.com>	 <47C4B5BE.7010709@garzik.org>	 <8202f4270802271620u6cea6176p2bea5ff8e0b9bbef@mail.gmail.com>	 <20080228202255.5e3f0c43@core> <8202f4270802281411j747bf96dx34ff81c4d192d417@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52147 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbYB1WYT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Feb 2008 17:24:19 -0500
In-Reply-To: <8202f4270802281411j747bf96dx34ff81c4d192d417@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> On 2/28/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>> PIO read/writes with wrong direction is not the only failure mode,
>>  > PATA sil680 also failed with disabling IRQ with some unsupported
>>  > commands such as Trusted Send (0x5E) even with perfect TF data. Given
>>  > that some ATA commands are optional,  we may have a chance to hit the
>>  > trap even with well programmed code.
>>
>>
>> That sounds very strange - I regularly test PATA controlles with
>>  unsupported commands and see the correct 0x04 abort patterns.
>>
>>
>>  > What would take to harden the PATA ISR code such that it fails more gracefully?
>>
>>
>> First thing would be to work out why your system is behaving differently
>>  to the others. What is the trigger here.
>>
> For most of unsupported commands, it will be aborted by drive.
> However, for some unsupported commands, it may not.  I suspect these
> bad commands are the new ones in ATA8 issued to some drives with old
> firmware. For instance, can you try command 0x5E (Trusted Send PIO
> data out) with sector count set to 1 and see what happens?
> 
> The blame is probably on drives which should have aborted these
> commands. But the reality is that libata will handle variety of drives
> including the ones with old firmware.  So the question here is whether
> libata PATA code can be more fault tolerate. It seems the weakest link
> is on PATA PIO since I have not been able to reproduce the IRQ
> disabling problem on DMA operations.


With regards to many controllers -- and I think sil680 is one of those 
-- they snoop commands send to the device, in order to set some internal 
parameters (generally, guessing the taskfile protocol of the command).

As such, you cannot assume that all controllers will gracefully abort 
unknown commands.

Again, we are in the realm of privileged administrators creating 
scenarios which are not designed for general production use.

I support efforts to "harden" libata, but its a judgement call when it 
comes to random, unpredictable scenarios that only root may create. 
There are an infinite variety of such scenarios.

	Jeff


