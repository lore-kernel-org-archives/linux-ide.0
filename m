From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Command Timeout on ARM XScale
Date: Wed, 14 Mar 2007 16:46:49 -0700
Message-ID: <8202f4270703141646w48827f05xfb63041316537605@mail.gmail.com>
References: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>
	 <20070313193957.396d7d1d@lxorguk.ukuu.org.uk>
	 <8202f4270703131417t3daacf1tf361e0449ad1f93b@mail.gmail.com>
	 <8202f4270703141527g459165dah647a8ad4116b96bb@mail.gmail.com>
	 <45F878DD.9000404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:21508 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422745AbXCNXqw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 19:46:52 -0400
Received: by wr-out-0506.google.com with SMTP id i28so372090wra
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 16:46:52 -0700 (PDT)
In-Reply-To: <45F878DD.9000404@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 3/14/07, Jeff Garzik <jeff@garzik.org> wrote:
> Fajun Chen wrote:
> > Since primary channel and secondary channel share the same IRQ,  the
> > ISR could be called to service one or both channels. So I would think
> > it's normal to see "irq trap" traces when both channels are in IO
> > operation, correct?
>
> The irq trap code only occurs after a certain number of unhandled
> interrupts.
>

If an interrupt fires for IDE1 while IDE0 is busy handling commands,
the irq trap code will count one unhandled interrupts on IDE0 but the
interrupt was not targeted for IDE0 to start with.  So  this irq trap
code if enabled could generate false alarms even in a perfert working
system and ata_irq_ack() function should not be called based on false
alarm.   Please correct me if I misunderstand the intention of the
code.

>
> > I have another question in regard to ata_host_intr() function in
> > libata-core.c. For PIO read/write, the status of interrupt pin was not
> > checked before moving the host state machine.  Sil680 spec. recommend
> > checking IDE channel interupt (bit 11 in the IDEx Task File Timing and
> > Config + Status register) though.  Could someone explain why interrupt
> > status does not need to be checked for PIO?
>
> Reading the Status register (as opposed to AltStatus) should clear the
> interrupt condition, on standard hardware.
>

Could this piece of code handle the sequence below well?
1.  A interrupt fires for IDE1 to indicate command finish
2.  At the same time,    IDE0 just started PIO read and its status
register has not been updated to busy.
3. As part of the interrupt handling, ata_host_intr() will be called
for IDE0 as well. Since this code doesn't check interrupt validity on
IDE0 and count on status register to make decision,  it will be misled
to read data register which has not been populated by the target
device yet.
...
I'm new to the code, so I want to double check with your guys to see
if this is a valid case and if the code can handle it.

Thanks,
Fajun
