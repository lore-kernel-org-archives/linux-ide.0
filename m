From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: CD problems booting FC7 RC3
Date: Tue, 03 Apr 2007 10:40:26 +0800
Message-ID: <4611BE9A.1010109@tw.ibm.com>
References: <4611605B.6060601@seclark.us>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:40052 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933945AbXDCCki (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Apr 2007 22:40:38 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l332ebmM029496
	for <linux-ide@vger.kernel.org>; Mon, 2 Apr 2007 22:40:37 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l332eb53198240
	for <linux-ide@vger.kernel.org>; Mon, 2 Apr 2007 20:40:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l332ebHx009402
	for <linux-ide@vger.kernel.org>; Mon, 2 Apr 2007 20:40:37 -0600
In-Reply-To: <4611605B.6060601@seclark.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: linux-ide@vger.kernel.org

Stephen Clark wrote:
> Hi,
> 
> When trying to boot FC7 RC3 on my HP N5430 laptop I get the following:
> 
> ...
> Write protecting the kernel read-only data: 845k
> input: PS/2 Generic Mouse as /class/input/input2
> SCSI subsystem initialized
> libata version 2.20 loaded.
> ACPI: Unable to derive IRQ for device 0000:00:0f.0
> ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00011000
> irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x00011008
> irq 15
> scsi0 : pata_ali
> PM: Adding info for No Bus:host0
> ata1.00: ATA-5: HITACHI_DK23CA-20, 00H1A0A3, max UDMA/100
> ata1.00: 39070080 sectors, multi 16: LBA
> ata1.00: configured for UDMA/33
> TCP bic registered
> Initializing XFRM netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
> powernow: SGTC: 10000
> Initializing XFRM netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
> powernow: SGTC: 10000
> powernow: Minimum speed 300 MHz. Maximum speed 850 MHz.
> powernow-k8: Processor cpuid 670 not supported
> Using IPI No-Shortcut mode
>  Magic number: 3:342:541
> Freeing unused kernel memory: 248k freed
> Write protecting the kernel read-only data: 845k
> input: PS/2 Generic Mouse as /class/input/input2
> SCSI subsystem initialized
> libata version 2.20 loaded.
> ACPI: Unable to derive IRQ for device 0000:00:0f.0
> ACPI: PCI Interrupt 0000:00:0f.0[A]: no GSI
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x00011000
> irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x00011008
> irq 15
> scsi0 : pata_ali
> PM: Adding info for No Bus:host0
> ata1.00: ATA-5: HITACHI_DK23CA-20, 00H1A0A3, max UDMA/100
> ata1.00: 39070080 sectors, multi 16: LBA
> ata1.00: configured for UDMA/33
> scsi1 : pata_ali
> PM: Adding info for No Bus:host1
> ata2.00: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33
> PM: Adding info for No Bus:target0:0:0
> scsi 0:0:0:0: Direct-Access     ATA      HITACHI_DK23CA-2 00H1 PQ: 0
> ANSI: 5
> PM: Adding info for scsi:0:0:0:0
> PM: Adding info for No Bus:target1:0:0
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

Looks similar to the AOpen timeout problem
(http://bugzilla.kernel.org/show_bug.cgi?id=8244)

Please try the following patch
(http://marc.info/?l=linux-ide&m=117548454130046&q=raw)

Thanks,

Albert

