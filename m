From: gettinther <gettinther@gmail.com>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Tue, 14 Oct 2008 22:31:02 +0100
Message-ID: <64630f150810141431r1d070cddl1c2a6b32ae80b64c@mail.gmail.com>
References: <48E80F11.3060101@kernel.org>
	 <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>
	 <48F30678.7020807@kernel.org>
	 <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>
	 <48F3F368.2090901@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:43745 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbYJNVbE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 17:31:04 -0400
Received: by gxk9 with SMTP id 9so5945803gxk.13
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 14:31:03 -0700 (PDT)
In-Reply-To: <48F3F368.2090901@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

On Tue, Oct 14, 2008 at 2:18 AM, Tejun Heo <tj@kernel.org> wrote:
> gettinther wrote:
>> On Mon, Oct 13, 2008 at 9:27 AM, Tejun Heo <tj@kernel.org> wrote:
>>> gettinther wrote:
>>>> OK, patching the 2.6.26 based on your patch doesn't work properly.  It
>>>> works for sata devices but not sata emulated devices (but these do
>>>> work with the 2.6.27).
>>> Eh... what do you mean it doesn't work on 2.6.26?  The same change
>>> doesn't work on 2.6.26 but it does on 2.6.27?  How did you apply the
>>> change to 2.6.26?  Can you post the diff?
>>>
>>> Thanks.
>>>
>>> --
>>> tejun
>>>
>>
>> Sorry, replied on the wrong thread
>>
>> Here's the patch I applied
>
> Hmm... that should work for 2.6.26 for MCP55.  Can you post the failing log?
>
> --
> tejun
>

The log simply ignores the drive altogether.

from the sound coming from the drive, it does seem that the drive
initially starts at boot, then stops.  After that stage the device
detection takes place.  as the item is a pata to sata converter
(emulated sata), it does not support hot plugging.

I also need to mention that this behavior (start-stop during boot) did
not happen on the 2.6.24 and I need to check the 2.6.27.  However the
device is detected by both of these kernels.

Thanking you,

Cyrille

Oct 14 21:18:12 localhost kernel: scsi0 : sata_nv
Oct 14 21:18:12 localhost kernel: scsi1 : sata_nv
Oct 14 21:18:12 localhost kernel: ata1: SATA max UDMA/133 cmd 0xc480
ctl 0xc400 bmdma 0xbc00 irq 23
Oct 14 21:18:12 localhost kernel: ata2: SATA max UDMA/133 cmd 0xc080
ctl 0xc000 bmdma 0xbc08 irq 23
Oct 14 21:18:12 localhost kernel: ata1: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Oct 14 21:18:12 localhost kernel: ata1.00: ATA-7: ST3120211AS, 3.AAE,
max UDMA/133
Oct 14 21:18:12 localhost kernel: ata1.00: 234441648 sectors, multi
16: LBA48 NCQ (depth 31/32)
Oct 14 21:18:12 localhost kernel: ata1.00: configured for UDMA/133
Oct 14 21:18:12 localhost kernel: input: ImPS/2 Generic Wheel Mouse as
/class/input/input1
Oct 14 21:18:12 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Oct 14 21:18:12 localhost kernel: scsi 0:0:0:0: Direct-Access     ATA
    ST3120211AS      3.AA PQ: 0 ANSI: 5
Oct 14 21:18:12 localhost kernel: ACPI: PCI Interrupt Link [LSA1]
enabled at IRQ 22
Oct 14 21:18:12 localhost kernel: ACPI: PCI Interrupt 0000:00:05.1[B]
-> Link [LSA1] -> GSI 22 (level, low) -> IRQ 22
Oct 14 21:18:12 localhost kernel: sata_nv 0000:00:05.1: Using SWNCQ mode
