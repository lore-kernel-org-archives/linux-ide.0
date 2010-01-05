From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 20:06:59 -0600
Message-ID: <4B429EC3.9090305@gmail.com>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B420871.2090309@garzik.org> <20100104154212.GA18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:41778 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab0AECHF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 21:07:05 -0500
Received: by gxk3 with SMTP id 3so3326979gxk.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 18:07:02 -0800 (PST)
In-Reply-To: <20100104154212.GA18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 09:42 AM, Russell King wrote:
> On Mon, Jan 04, 2010 at 10:25:37AM -0500, Jeff Garzik wrote:
>> On 01/04/2010 08:30 AM, Russell King wrote:
>>> This rather makes sense.  The PDC20247 handles the UDMA part of the
>>> protocol.  It has no way to tell the PDC20246 to wait while it suspends
>>> UDMA, so that a normal register access can take place - the 246 ploughs
>>> on with the register access without any regard to the state of the 247.
>>>
>>> If the drive immediately starts the UDMA protocol after a write to the
>>> command register (as it probably will for the DMA WRITE command), then
>>> we'll be accessing the taskfile in the middle of the UDMA setup, which
>>> can't be good.  It's certainly a violation of the ATA specs.
>>
>> Well...
>>
>> Without AltStatus, you would not be able to check and see if a command
>> is complete...
>
> I wasn't inferring that reading altstatus was a bad idea.  I was saying
> that causing altstatus to be read in the middle of an active UDMA
> transfer (in other words, while the hosts DMACK is active) is a
> violation of the spec.

I wouldn't say that's the case, as I don't see any such prohibition in 
the ATA or SFF host adapter specs. The host doesn't necessarily know 
whether or not a UDMA transfer is active or not. It's supposed to be the 
controller's job to either terminate the UDMA burst or stall the access 
until it can handle the request. It seems a bit of a deficiency of this 
controller that it can't.

The problem with just taking the altstatus read out is that in certain 
cases, the ATA spec requires that we wait for not 400ns, but one PIO 
cycle time before reading the status register (which may be up to 
600ns). The altstatus read inherently accomplishes this since it causes 
a bus cycle. The spec says nothing about not being allowed to access 
altstatus during this period, and in fact ATA-6 and up explictly suggest 
a dummy altstatus read to do this.

One alternative might be to increase the delay to 600ns and change it to 
read the BMDMA status register instead (to ensure PCI posted write 
flushing with MMIO). The trick in doing this in generic code is that the 
register might not exist (BMDMA controllers are a subset of SFF 
controllers, which is what this code deals with).

> There's no way for the 20247 (UDMA add-on) to know that the IO access
> is coming; the first the 247 knows about it is when the CS/address lines
> to the drive have been activated - in violation of the ATA specification
> (which calls for the CS lines to be inactive and address lines to be zero
> while UDMA is occuring.)
>
> That means there's absolutely no way for the 20247 to stop the UDMA
> protocol to allow a read of any registers on the drive until UDMA has
> completed.
>
> Yes, technically a buggy host design...

Indeed, which is why I suspect that a global change to handle this 
controller may not be a good idea. Overriding sff_exec_command for this 
driver to not do the altstatus read (just wait 600ns, maybe) might be 
the best solution for now.
