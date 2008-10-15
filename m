From: gettinther <gettinther@gmail.com>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Wed, 15 Oct 2008 21:23:38 +0100
Message-ID: <64630f150810151323k68ded27eie9a24e1b0579288a@mail.gmail.com>
References: <48E80F11.3060101@kernel.org>
	 <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>
	 <48F30678.7020807@kernel.org>
	 <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>
	 <48F3F368.2090901@kernel.org>
	 <64630f150810141431r1d070cddl1c2a6b32ae80b64c@mail.gmail.com>
	 <48F57E0B.6050403@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:29450 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYJOUXn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 16:23:43 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1801833wri.5
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 13:23:39 -0700 (PDT)
In-Reply-To: <48F57E0B.6050403@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

On Wed, Oct 15, 2008 at 6:22 AM, Tejun Heo <tj@kernel.org> wrote:
> gettinther wrote:
>> The log simply ignores the drive altogether.
>>
>> from the sound coming from the drive, it does seem that the drive
>> initially starts at boot, then stops.  After that stage the device
>> detection takes place.  as the item is a pata to sata converter
>> (emulated sata), it does not support hot plugging.
>>
>> I also need to mention that this behavior (start-stop during boot) did
>> not happen on the 2.6.24 and I need to check the 2.6.27.  However the
>> device is detected by both of these kernels.
>
> Hmmm...
>
>> Oct 14 21:18:12 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus
>> 113 SControl 300)
>
> Hmmm... Can you please apply the attached patch on top of it and
> report the boot log?
>
> --
> tejun
>

here it is.  Let me know if you need other parts of the logs.

Oct 15 20:00:33 localhost kernel: sata_nv 0000:00:05.0: Using SWNCQ mode
Oct 15 20:00:33 localhost kernel: scsi0 : sata_nv
Oct 15 20:00:33 localhost kernel: scsi1 : sata_nv
Oct 15 20:00:33 localhost kernel: ata1: SATA max UDMA/133 cmd 0xc480
ctl 0xc400 bmdma 0xbc00 irq 23
Oct 15 20:00:33 localhost kernel: ata2: SATA max UDMA/133 cmd 0xc080
ctl 0xc000 bmdma 0xbc08 irq 23
Oct 15 20:00:33 localhost kernel: ata1: hard resetting link
Oct 15 20:00:33 localhost kernel: XXX classify 00/00
Oct 15 20:00:33 localhost kernel: ata1: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Oct 15 20:00:33 localhost kernel: ata1.00: ATA-7: ST3120211AS, 3.AAE,
max UDMA/133
Oct 15 20:00:33 localhost kernel: ata1.00: 234441648 sectors, multi
16: LBA48 NCQ (depth 31/32)
Oct 15 20:00:33 localhost kernel: ata1.00: configured for UDMA/133
Oct 15 20:00:33 localhost kernel: ata1: EH complete
Oct 15 20:00:33 localhost kernel: ata2: hard resetting link
Oct 15 20:00:33 localhost kernel: input: ImPS/2 Generic Wheel Mouse as
/class/input/input1
Oct 15 20:00:33 localhost kernel: XXX classify 12/00
Oct 15 20:00:33 localhost kernel: ata2: SATA link up 1.5 Gbps (SStatus
113 SControl 300)
Oct 15 20:00:33 localhost kernel: ata2: EH complete
Oct 15 20:00:33 localhost kernel: scsi 0:0:0:0: Direct-Access     ATA
    ST3120211AS      3.AA PQ: 0 ANSI: 5
Oct 15 20:00:33 localhost kernel: ACPI: PCI Interrupt Link [LSA1]
enabled at IRQ 22
Oct 15 20:00:33 localhost kernel: ACPI: PCI Interrupt 0000:00:05.1[B]
-> Link [LSA1] -> GSI 22 (level, low) -> IRQ 22
Oct 15 20:00:33 localhost kernel: sata_nv 0000:00:05.1: Using SWNCQ mode
