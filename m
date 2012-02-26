From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Braindead newbie questions, DMA-backed PIO
Date: Sat, 25 Feb 2012 19:11:56 -0600
Message-ID: <CAKGA1bnFcCkDCJZEKjRpjo7q+srbe6UWT5+pEkC2e+n=5uwZ-g@mail.gmail.com>
References: <CAKGA1b=XvOS_dk3HV8H7-S1Ppc76FoW51xgnvKX2XWzCpfH4xA@mail.gmail.com>
 <4F35F367.9070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod7og127.obsmtp.com ([64.18.2.210]:39615 "EHLO
	exprod7og127.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab2BZBMR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2012 20:12:17 -0500
Received: by obcwo16 with SMTP id wo16so5423884obc.13
        for <linux-ide@vger.kernel.org>; Sat, 25 Feb 2012 17:12:16 -0800 (PST)
In-Reply-To: <4F35F367.9070301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, Feb 10, 2012 at 10:49 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
> On 02/09/2012 01:43 PM, Matt Sealey wrote:
>>
>> Hi guys,
>>
>> The other question semi-related is whether I really need to, as in the
>> current implementation, use the ata_sff_data_xfer_noirq (or a
>> derivative of
>> it) variant as this causes some incredible stuttering in the system
>> and impacts things like audio. What exactly are we protecting against
>> here,
>> an occurance of any system IRQ that might steal from the transfer, or
>> just the occurance of the ATA IRQ? With the drive interrupt enabled
>> (the manual just states that when it happens the drive is looking for
>> attention) is this going to cause some insanity with the transfer with
>> libata
>> servicing the interrupt behind my back and doing something odd? The
>> default interrupt handler in libata seems to be fairly safe and checks
>> if
>> the controller is busy or not, but since there are a lot of drivers
>> that use _noirq variant for PIO I am just curious what they are
>> looking to avoid
>> happening, perhaps if this is a legacy behavior nobody bothered to
>> change since libata got more advanced?
>
>
> I have a vague recollection of hearing that the main reason for this was
> that some flaky controllers would choke if you allow interrupts to be
> processed in the middle of data transfer (the CMD640 seems to be one
> infamous example where reading the status register during a transfer as a
> result of an interrupt will corrupt the data). The ones using _noirq in
> libata seem to be fairly old and crusty controllers in general.

Okay, just a FYI I removed the _noirq variant from the driver in my
local copy and
did a bunch of PIO transfers (actually did some disk imaging, rsyncs, hashing)
while also playing an MP3 and compiling (on an SD card just to generate an
interrupt elsewhere) and re-read the docs; apparently reading a PIO
register will
pause a DMA transfer on the disk (yay) and in general I can't find any
bugs or errata
about this nor can I make any ATA activity other than the FIFO
handling cause any
disk weirdness - in about 4 hours of various disk activity, and
without so much as a
peep on audio besides the music (as opposed to fairly regular
stop-starts and pops),
everything came out fine and there was a somewhat noticable performance increase
(around 600kb/s in PIO4 according to iozone).

So, that's that then. Thanks for the advise.. I have a bunch of stuff
to push now on
pata_imx but want to get the DMA code sorted out before I make a series.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
