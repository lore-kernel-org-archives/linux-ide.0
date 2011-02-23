From: Damon Lynch <damonlynch@gmail.com>
Subject: Re: ExpressCard compact flash card very slow
Date: Wed, 23 Feb 2011 02:24:38 -0600
Message-ID: <4D64C446.4050803@gmail.com>
References: <4D645C59.8090406@gmail.com> <4D649FA2.5010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45921 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab1BWIYq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 03:24:46 -0500
Received: by qyg14 with SMTP id 14so2634363qyg.19
        for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2011 00:24:45 -0800 (PST)
In-Reply-To: <4D649FA2.5010204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On 02/22/2011 11:48 PM, Robert Hancock wrote:
>
> The CF adapter probably doesn't support the 80-wire cable detect 
> protocol properly so the kernel thinks there's only a 40-wire cable 
> connected to it. You can try libata.force=80c on the kernel command 
> line and see what that does.
>

It seemed to work. I got read speeds of ~55MB/s, which is ok because I 
was writing what was being read to an SSD.

dmesg:

[    1.651748] pata_jmicron 0000:05:00.0: PCI INT A -> GSI 19 (level, 
low) -> IRQ 19
[    1.651783] pata_jmicron 0000:05:00.0: setting latency timer to 64
[    1.652212] scsi0 : pata_jmicron
[    1.652813] scsi1 : pata_jmicron
[    1.652855] ata1: PATA max UDMA/100 cmd 0x4020 ctl 0x4014 bmdma 
0x4000 irq 19
[    1.652857] ata2: PATA max UDMA/100 cmd 0x4018 ctl 0x4010 bmdma 
0x4008 irq 19
[    1.850716] ata1: FORCE: cable set to 80c
[    1.850723] ata1.00: CFA: TRANSCEND, 20091215, max UDMA/133
[    1.850726] ata1.00: 125059072 sectors, multi 0: LBA
[    1.870111] usb 1-6: new high speed USB device using ehci_hcd and 
address 3
[    1.890684] ata1.00: configured for UDMA/100
[    1.890845] scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        
2009 PQ: 0 ANSI: 5
[    1.891008] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.891020] sd 0:0:0:0: [sda] 125059072 512-byte logical blocks: 
(64.0 GB/59.6 GiB)
[    1.891070] sd 0:0:0:0: [sda] Write Protect is off
[    1.891073] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.891099] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.892022]  sda: sda1
[    1.892395] sd 0:0:0:0: [sda] Attached SCSI disk

What next? Can the CF reader be whitelisted by libata?
