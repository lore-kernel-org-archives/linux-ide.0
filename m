From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: PATA Sil680 Command Timeout on ARM XScale
Date: Thu, 15 Mar 2007 10:32:59 +0800
Message-ID: <45F8B05B.50408@tw.ibm.com>
References: <8202f4270703131134x68c028fbv7fb536c694a6b898@mail.gmail.com>	 <20070313193957.396d7d1d@lxorguk.ukuu.org.uk>	 <8202f4270703131417t3daacf1tf361e0449ad1f93b@mail.gmail.com>	 <8202f4270703141527g459165dah647a8ad4116b96bb@mail.gmail.com>	 <45F878DD.9000404@garzik.org> <8202f4270703141646w48827f05xfb63041316537605@mail.gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41152 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933388AbXCOCdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 22:33:17 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2F2XHCR004658
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 22:33:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2F2XGDP047900
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 20:33:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2F2XGGN012237
	for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 20:33:16 -0600
In-Reply-To: <8202f4270703141646w48827f05xfb63041316537605@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> On 3/14/07, Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Fajun Chen wrote:
>> > Since primary channel and secondary channel share the same IRQ,  the
>> > ISR could be called to service one or both channels. So I would think
>> > it's normal to see "irq trap" traces when both channels are in IO
>> > operation, correct?
>>
>> The irq trap code only occurs after a certain number of unhandled
>> interrupts.
>>
> 
> If an interrupt fires for IDE1 while IDE0 is busy handling commands,
> the irq trap code will count one unhandled interrupts on IDE0 but the
> interrupt was not targeted for IDE0 to start with.  So  this irq trap
> code if enabled could generate false alarms even in a perfert working
> system and ata_irq_ack() function should not be called based on false
> alarm.   Please correct me if I misunderstand the intention of the
> code.
> 
>>
>> > I have another question in regard to ata_host_intr() function in
>> > libata-core.c. For PIO read/write, the status of interrupt pin was not
>> > checked before moving the host state machine.  Sil680 spec. recommend
>> > checking IDE channel interupt (bit 11 in the IDEx Task File Timing and
>> > Config + Status register) though.  Could someone explain why interrupt
>> > status does not need to be checked for PIO?
>>
>> Reading the Status register (as opposed to AltStatus) should clear the
>> interrupt condition, on standard hardware.
>>
> 
> Could this piece of code handle the sequence below well?
> 1.  A interrupt fires for IDE1 to indicate command finish
> 2.  At the same time,    IDE0 just started PIO read and its status
> register has not been updated to busy.
> 3. As part of the interrupt handling, ata_host_intr() will be called
> for IDE0 as well. Since this code doesn't check interrupt validity on
> IDE0 and count on status register to make decision,  it will be misled
> to read data register which has not been populated by the target
> device yet.

The host->lock is acquired when a command is being issued to the device.
After writing the command register, libata reads Alt Status and
waits for a short period of time (ndelay(400)) to ensure that the device
is BSY before releasing the host lock. (Please see ata_exec_command().)

So, the above scenario won't happen, unless the device is faulty and
doesn't set BSY after 400+ ns. Even under such situation, libata won't
read the data register blindly as worried. It will be detected as
HSM violation and EH will be activated to handle such situation.

--
albert


