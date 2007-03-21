From: "Paul Rolland" <rol@as2917.net>
Subject: RE: problem detecting ATAPI device with ahci on 2.6.21-rcx
Date: Wed, 21 Mar 2007 15:22:55 +0100
Message-ID: <045101c76bc4$6e48b810$4b00a8c0@donald>
References: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:32973 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894AbXCUOXP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Mar 2007 10:23:15 -0400
In-Reply-To: <20070320164920.0bad5c42.kristen.c.accardi@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Kristen Carlson Accardi' <kristen.c.accardi@intel.com>, linux-ide@vger.kernel.org

Could you please try adding irqpoll to the boot command line and
post result ?

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur 
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's too 
young to have logged on yet. Here's what I worry about. I worry that 10 or 15 
years from now, she will come to me and say 'Daddy, where were you when they 
took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
  

> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Kristen 
> Carlson Accardi
> Sent: Wednesday, March 21, 2007 12:49 AM
> To: linux-ide@vger.kernel.org
> Subject: problem detecting ATAPI device with ahci on 2.6.21-rcx
> 
> Hi, I upgrade a machine from 2.6.20->2.6.21-rc4 and am now 
> having problems
> with my ATAPI device getting detected properly.  Back 
> tracking to 2.6.21-rc1,
> I find the problem existed there too, but not in 2.6.20.
> 
> ahci 0000:00:1f.2: version 2.0
> ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 19 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 
> impl SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
> ata1: SATA max UDMA/133 cmd 0xffffc20000028100 ctl 
> 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
> ata2: SATA max UDMA/133 cmd 0xffffc20000028180 ctl 
> 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
> ata3: SATA max UDMA/133 cmd 0xffffc20000028200 ctl 
> 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
> scsi0 : ahci
> ata1: SATA link down (SStatus 0 SControl 300)
> scsi1 : ahci
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ATA-7: HTS721080G9SA00, MC4OC10H, max UDMA/100
> ata2.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata2.00: configured for UDMA/100
> scsi2 : ahci
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: ATAPI, max UDMA/100
> ata3.00: qc timeout (cmd 0xa1)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> ata3.00: revalidation failed (errno=-5)
> ata3.00: limiting speed to UDMA/66
> ata3: failed to recover some devices, retrying in 5 secs
> ata3: port is slow to respond, please be patient (Status 0x80)
> ata3: port failed to respond (30 secs, Status 0x80)
> ata3: COMRESET failed (device not ready)
> ata3: hardreset failed, retrying in 5 secs
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: qc timeout (cmd 0xa1)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> ata3.00: revalidation failed (errno=-5)
> ata3.00: limiting speed to PIO0
> ata3: failed to recover some devices, retrying in 5 secs
> ata3: port is slow to respond, please be patient (Status 0x80)
> ata3: port failed to respond (30 secs, Status 0x80)
> ata3: COMRESET failed (device not ready)
> ata3: hardreset failed, retrying in 5 secs
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: qc timeout (cmd 0xa1)
> ata3.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> ata3.00: revalidation failed (errno=-5)
> ata3.00: disabled
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

