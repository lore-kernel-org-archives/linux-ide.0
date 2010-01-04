From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 18:06:08 +0000
Message-ID: <20100104180608.GG18335@flint.arm.linux.org.uk>
References: <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B420871.2090309@garzik.org> <20100104154607.0b6e51dd@lxorguk.ukuu.org.uk> <4B421827.6050308@garzik.org> <20100104170236.5d85959f@lxorguk.ukuu.org.uk> <4B42251A.9030106@garzik.org> <20100104173055.GE18335@flint.arm.linux.org.uk> <4B422D78.1060102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59453 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0ADSGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 13:06:22 -0500
Content-Disposition: inline
In-Reply-To: <4B422D78.1060102@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Mon, Jan 04, 2010 at 01:03:36PM -0500, Jeff Garzik wrote:
> On 01/04/2010 12:30 PM, Russell King wrote:
>> On Mon, Jan 04, 2010 at 12:27:54PM -0500, Jeff Garzik wrote:
>>> On 01/04/2010 12:02 PM, Alan Cox wrote:
>>>>> (1b)  The solution for MMIO controllers is a bit more complex:  replace
>>>>> the dummy AltStatus register read with something else.
>>>>
>>>> If we had any SFF PATA controllers using MMIO. I can't find any. SATA is
>>>> different anyway. In fact we probably want to avoid such delays on a pure
>>>> SATA controller.
>>>
>>> Early SATA controllers are just PATA controllers in disguise.  All SFF
>>> controllers want that 400ns delay.  The 400ns delay should -not- be
>>> avoided.
>>
>> Note that ICH5 SATA is SFF, which only offers non-MMIO addressing; the
>> change I made is running there just fine:
>
> Yes, your change should be fine for all non-MMIO SFF controllers, SATA  
> or PATA.
>
> The AltStatus read is simply a dummy read, for MMIO controllers, to  
> ensure the previously-written taskfile registers make it to the  
> controller before the ndelay() begins execution.

Can we solve the problem by doing a read of the BMDMA status register?

As it is, the command register and alt status registers are in different
BARs on the controller, so reading from BAR 4 instead of 1/3 should have
the same effect?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
