From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 13:03:36 -0500
Message-ID: <4B422D78.1060102@garzik.org>
References: <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B420871.2090309@garzik.org> <20100104154607.0b6e51dd@lxorguk.ukuu.org.uk> <4B421827.6050308@garzik.org> <20100104170236.5d85959f@lxorguk.ukuu.org.uk> <4B42251A.9030106@garzik.org> <20100104173055.GE18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:62353 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab0ADSDi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 13:03:38 -0500
Received: by ywh6 with SMTP id 6so15549847ywh.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 10:03:38 -0800 (PST)
In-Reply-To: <20100104173055.GE18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 12:30 PM, Russell King wrote:
> On Mon, Jan 04, 2010 at 12:27:54PM -0500, Jeff Garzik wrote:
>> On 01/04/2010 12:02 PM, Alan Cox wrote:
>>>> (1b)  The solution for MMIO controllers is a bit more complex:  replace
>>>> the dummy AltStatus register read with something else.
>>>
>>> If we had any SFF PATA controllers using MMIO. I can't find any. SATA is
>>> different anyway. In fact we probably want to avoid such delays on a pure
>>> SATA controller.
>>
>> Early SATA controllers are just PATA controllers in disguise.  All SFF
>> controllers want that 400ns delay.  The 400ns delay should -not- be
>> avoided.
>
> Note that ICH5 SATA is SFF, which only offers non-MMIO addressing; the
> change I made is running there just fine:

Yes, your change should be fine for all non-MMIO SFF controllers, SATA 
or PATA.

The AltStatus read is simply a dummy read, for MMIO controllers, to 
ensure the previously-written taskfile registers make it to the 
controller before the ndelay() begins execution.

	Jeff




