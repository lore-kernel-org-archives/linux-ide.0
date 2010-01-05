From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 19:03:49 -0600
Message-ID: <4B428FF5.7040702@gmail.com>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:55588 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756Ab0AEBDw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 20:03:52 -0500
Received: by yxe26 with SMTP id 26so15137350yxe.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 17:03:52 -0800 (PST)
In-Reply-To: <20100104133024.GA10521@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 07:30 AM, Russell King wrote:
> On Mon, Jan 04, 2010 at 10:37:56AM +0000, Alan Cox wrote:
>>> 1. There is no way for the 247 to see any configuration settings;
>>>     the only thing it can see are the taskfile reads and writes, and
>>>     the timing of the DMA signals from the 246.
>>>
>>> 2. The 246 timings for MWDMA2 and UDMA0 are identical; there is no
>>>     programming difference between these two modes.  The only way the
>>>     246 can know that UDMA is selected is by looking for the SET
>>>     FEATURES command to the drive.
>>
>> The 2026x certainly snoops SET FEATURES so that would be a reasonable
>> assumption.
>>
>>> I've tried changing the set xfermode code to use a version of
>>> ata_exec_internal() which doesn't return the taskfile, but this makes no
>>> difference to the promise exploding with CRC errors with UDMA writes.
>>> Is it possible to do a similar thing with IDENTIFY?
>>
>> No because you need to know if it worked.
>>
>>> Also, is it possible to get rid of the additional identify and read native
>>> max address commands which seem to be repeated (command register writes
>>> listed):
>>
>> You can turn off Host Protected Area support for this. You could also btw
>> turn *on* host protected area for the IDE stack and see what occurs but I
>> imagine its a red herring anyway. If the snoop is failing then it is more
>> likely to be that the chip has some limitations on the taskfile snooping
>> and perhaps requires that the device register is always written or that
>> the registers are written in a specific order when writing the set
>> features command.
>>
>> Another thing to try if that fails is using a polled set features in case
>> the chip has problems in that area. We've seen a similar bug on some older
>> VIA devices.
>
> Found the problem - getting rid of the read of the alt status register
> after the command has been written fixes the UDMA CRC errors on write:
>
> @@ -676,7 +676,8 @@ void ata_sff_exec_command(struct ata_port *ap, const struct
> ata_taskfile *tf)
>          DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
>
>          iowrite8(tf->command, ap->ioaddr.command_addr);
> -       ata_sff_pause(ap);
> +       ndelay(400);
> +//     ata_sff_pause(ap);
>   }
>   EXPORT_SYMBOL_GPL(ata_sff_exec_command);
>
>
> This rather makes sense.  The PDC20247 handles the UDMA part of the
> protocol.  It has no way to tell the PDC20246 to wait while it suspends
> UDMA, so that a normal register access can take place - the 246 ploughs
> on with the register access without any regard to the state of the 247.
>
> If the drive immediately starts the UDMA protocol after a write to the
> command register (as it probably will for the DMA WRITE command), then
> we'll be accessing the taskfile in the middle of the UDMA setup, which
> can't be good.  It's certainly a violation of the ATA specs.

I don't think it is. From ATA-8 APT:

"HDMA0: Check_Status State: This state is entered when the host has 
written a DMA command to the device; when all data for the command has 
been transferred and nIEN is set to one; or when all data for the 
command has been transferred, nIEN is cleared zero, and INTRQ has been 
asserted.

When in this state, the host shall read the device Status register. When 
entering this state from the HI4 state, the host shall wait 400 ns 
before reading the Status register. When entering this state from the 
HDMA1 state,
the host shall wait one PIO transfer cycle time before reading the 
Status register. The wait may be accomplished by reading the Alternate 
Status register and ignoring the result."

The last sentence is basically what the code in ata_sff_pause is doing..
