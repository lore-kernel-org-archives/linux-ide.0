From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA ATAPI work in progress
Date: Fri, 14 May 2004 14:55:00 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A51604.8070208@pobox.com>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com> <1084559000.4017.52.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262205AbUENSzP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 14:55:15 -0400
In-Reply-To: <1084559000.4017.52.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> Jeff G:
> 
> 
>>This is important because some AHCI SATA controllers can only transfer
>>a _single_ DRQ block per disk transaction.  In anticipation of the
>>demise of PIO, no doubt :)
> 
> 
> Eh?  What's a "disk transaction"?

The point when the Host-to-Device Register FIS ("command FIS") is sent 
to the device, all the DMA / Data FIS's sent, and then the final 
Device-to-Host Register FIS.

In other words, one ATA taskfile, and the operations that that taskfile 
generates.

Therefore, for controllers that are limited to a single DRQ block per 
disk transaction, the OS driver _must_ limit each ATA taskfile to no 
more than a DRQ block's worth of sector.  If the ATAPI byte count limit 
is 8K, then the OS driver must guarantee that a single ATA taskfile does 
not transfer more than 8K.


> Do we mean to say that some SATA controllers choke over the (rare)
> device rudeness of an INTRQ for every two bytes of the standard x24 (36)
> bytes of op x12 (18) Inquiry, for example?

INTRQ is a PATA notion :)

SATA controllers receive FIS's with an 'I' bit set, indicating the 
device wishes to assert an interrupt.

[though certainly with bridges often on both sides, INTRQ hasn't gone away]


>>For an ATA device, we
>>* write the taskfile, except for command
>>* set up the DMA engine
>>* write the command
>>* write DMA-start bit
>>
>>And the functions used by the low-level drivers, ata_bmdma_start_mmio 
>>and ata_bmdma_start_pio, are hardcoded to use this ordering.  By 
>>contrast, for ATAPI you should do:
>>* set up DMA engine
>>* write entire taskfile, including command
>>* proceed through state diagram until DRQ==1
>>* write SCSI CDB
>>* write DMA-start bit
> 
> 
> Why we care whether we write the taskfile apart from the command before
> or after DMA engine setup, I do not understand.

Actually, after research I prefer to set up the DMA engine first, then 
write the taskfile including command, for both cases.

The latest libata atapi work (2.6.6 + the 5 patches I have posted to 
linux-ide) does not yet do this.


>>>+     int bcl = (8 * 0x400); /* PIO "byte count limit" */
>>
>>Make this a more obvious "8 * 1024".
> 
> 
> A point of pain for me moving into the world near linux-ide was
> discovering that `dd` wanted me to say 512 rather than the more familiar
> and plainly rounded value x200.

Using decimal and hexidecimal together is inconsistent, and I feel that 
1024 reads to a human eye like "1K" much more than 0x400 does.

And we're shooting clarity and readability here.


>>>+     struct ata_taskfile *tf = &qc->tf;
>>>+     tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
>>>+     tf->protocol = qc->dev->xfer_protocol;
>>>+     tf->command = ATA_CMD_PACKET; /* often 0xA0 */
>>
>>kill the comment, this should be obvious to anyone who reads the
>>public specs.  That's why we have the constant, after all...
> 
> 
> See below.
> 
> 
>>>+             tf->feature = ATAPI_PKT_DMA; /* often x01 */
>>
>>kill the comment
> 
> 
> I understood your objection to: ATA_CMD_PACKET; /* often 0xA0 */
> to mean I should never tell people what hovering the mouse over an
> identifier should (but often doesn't) tell them.
> 
> Me, I didn't know ATA_CMD_PACKET meant xA0 until I looked it up.  I'm
> likely to forget again in future.  ATA_CMD_PACKET is a Linux only term,
> whereas "A0" I find in every source I read, be it xA0 or A0h or 0A0h
> etc., be the source English, bus traces, machine code hex dumps, ....

You know the value of ATA_CMD_PACKET by looking in the header file.  The 
constant exists to -remove- the hex number completely from the source 
code.  The hex number should only be present in the header file, and in 
the specifications.

It is -crucial- to long term maintenance that C source code be readable, 
even to someone who is not very familiar with the intimacies of the ATA 
protocol and associated hardware.  (I do not claim libata is perfect in 
this regard, but it is an important goal)

Therefore, regardless of what non-Linux people may do, it is a very 
conscious decision to avoid putting what we call "magic numbers" in the 
source code.  Experience has shown using "magic numbers" just isn't 
scalable.  It's not human-friendly.


>>>+     if (dev->class == ATA_DEV_ATAPI) { /* (thus !=
>>
>>ATA_DEV_ATAPI_UNSUP) */
>>
>>>+             return atapi_xlat;
>>>+     }
>>>+
>>
>>Remove the extraneous braces ... :)
> 
> 
> Understood to mean do not enclose in { } unless two or more statements
> appear as part of the then or else of an if.

Correct.

	Jeff



