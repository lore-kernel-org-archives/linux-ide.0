From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hard drives only detected when booting from CD on nVidia MCP67
 SATA
Date: Mon, 10 Dec 2007 18:43:30 +0900
Message-ID: <475D0A42.9030502@gmail.com>
References: <47573A0A.4070401@redhat.com> <47588025.6090203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:52325 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401AbXLJJnh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 04:43:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3246645wah
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 01:43:36 -0800 (PST)
In-Reply-To: <47588025.6090203@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <peerchen@gmail.com>

Chuck Ebbert wrote:
> On 12/05/2007 06:53 PM, Chuck Ebbert wrote:
>> With kernel 2.6.23 on an Acer 7220 notebook using nVidia MCP67 SATA,
>> hard drives are only detected after first booting from a CD.
>>
>> Boot from hard drive      No drives detected
>>
>> Boot live CD              Detected
>>
>> Boot CD to GRUB menu,     Detected
>> then warm-boot from hard
>> drive
>>
>>
>> Non-detect case:
>>
>> ahci 0000:00:09.0: version 2.3
>> ACPI: PCI Interrupt Link [LSI0] enabled at IRQ 23
>> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LSI0] -> GSI 23 (level, low) -> 
>> IRQ 16
>> input: ImPS/2 Generic Wheel Mouse as /class/input/input2
>> ahci 0000:00:09.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl IDE mode
>> ahci 0000:00:09.0: flags: 64bit sntf led clo pmp pio slum part
>> PCI: Setting latency timer of device 0000:00:09.0 to 64
>> scsi0 : ahci
>> scsi1 : ahci
>> scsi2 : ahci
>> scsi3 : ahci
>> ata1: SATA max UDMA/133 cmd 0xf8854100 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata2: SATA max UDMA/133 cmd 0xf8854180 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata3: SATA max UDMA/133 cmd 0xf8854200 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata4: SATA max UDMA/133 cmd 0xf8854280 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata2: SATA link down (SStatus 0 SControl 300)
>> ata3: SATA link down (SStatus 0 SControl 300)
>> ata4: SATA link down (SStatus 0 SControl 300)
>> Waiting for driver initialization
>>
>> But, if a LiveCD is used to boot or if a LiveCD was used before an hot reboot 
>> (without a power off), disks are correctly found :
>>
>> Loading ahci.ko
>> ahci 0000:00:09.0: version 2.3
>> ACPI: PCI Interrupt Link [LSI0] enabled at IRQ 23
>> ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LSI0] -> GSI 23 (level, low) -> 
>> IRQ 16
>> input: ImPS/2 Generic Wheel Mouse as /class/input/input2
>> ahci 0000:00:09.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl IDE mode
>> ahci 0000:00:09.0: flags: 64bit sntf led clo pmp pio slum part
>> PCI: Setting latency timer of device 0000:00:09.0 to 64
>> scsi0 : ahci
>> scsi1 : ahci
>> scsi2 : ahci
>> scsi3 : ahci
>> ata1: SATA max UDMA/133 cmd 0xf8854100 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata2: SATA max UDMA/133 cmd 0xf8854180 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata3: SATA max UDMA/133 cmd 0xf8854200 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata4: SATA max UDMA/133 cmd 0xf8854280 ctl 0x00000000 bmdma 0x00000000 irq 221
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: ATA-7: Hitachi HTS541612J9SA00, SBDOC70P, max UDMA/100
>> ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
>> ata1.00: configured for UDMA/100
>> ata2: SATA link down (SStatus 0 SControl 300)
>> ata3: SATA link down (SStatus 0 SControl 300)
>> ata4: SATA link down (SStatus 0 SControl 300)
>>
>>
> 
> Possibly fixed by:
> 
> Commit:     3cc3eb1148e4b2dfabf7a1dcf36fd8be1331ca95
> [libata] AHCI: enable AHCI mode, before using AHCI reset
> 
> Plus:
> 
> Commit:     ab6fc95f609b372a19e18ea689986846ab1ba29c
> [libata] AHCI: fix newly introduced host-reset bug
> 
> ??

Is it fixed by the above two patches?  Or are you saying that the above
two patches look like they might fix the problem?

Thanks.

-- 
tejun
