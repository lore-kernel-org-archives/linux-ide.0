From: Chandra Nepali <edu4madh@gmail.com>
Subject: port multiplier problem
Date: Thu, 21 Jan 2010 11:57:39 -0500
Message-ID: <4B588783.9030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:35027 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab0AUQ5o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 11:57:44 -0500
Received: by fxm20 with SMTP id 20so214058fxm.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Jan 2010 08:57:42 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I wish to be personally CC'ed the answers/comments posted to the list in 
response to my posting.
 
Sorry, before I sent this massage to linux-kernel@.... by mistake.

I have a disk array of 12 disks. The interface card has two sil3726 port 
multiplier for 10 disks (5 disks in each port multiplier) and 2 direct 
sata connectors. The host controller is sil3124. It was connected to 
suse 10.4 and working fine.

There was a high voltage accident (high voltage to disk array only, not 
computer) and because of that we replaced the power supply of this disk 
array. Now, we are getting some problem, disks are not being 
recognized,. So, I connected it to Fedora 12 (To correct if it is 
because of some bugs) with driver sil24. Here are few things that I have 
tested.

1) If I connect only one disk to direct sata connector, it works fine.
2) If I connect two disks to both direct sata connectors, it won't work.
3) If I connect  one disk to one direct sata and one disk directly to 
host controller, it works.
3) If I connect one or more disk to PM, it won't work.
4) If I connect one disk to direct sata and one to PM, it won't work.

BIOS could not recognize the disk in case of failure. It says "Not valid 
disk ..........".

Below is the error from dmesg in case of failure:
==================================
aic7xxx 0000:03:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
       <Adaptec aic7899 Ultra160 SCSI adapter>
       aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

sata_sil24 0000:03:02.0: version 1.1
sata_sil24 0000:03:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
scsi3 : sata_sil24
scsi4 : sata_sil24
scsi5 : sata_sil24
scsi6 : sata_sil24
ata3: SATA max UDMA/100 host m128@0xea009000 port 0xea000000 irq 18
ata4: SATA max UDMA/100 host m128@0xea009000 port 0xea002000 irq 18
ata5: SATA max UDMA/100 host m128@0xea009000 port 0xea004000 irq 18
ata6: SATA max UDMA/100 host m128@0xea009000 port 0xea006000 irq 18
aic7xxx 0000:03:04.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata4.00: hard resetting link
ata4.00: SATA link down (SStatus 0 SControl 10)
ata4.01: hard resetting link
ata4.01: SATA link down (SStatus 0 SControl 320)
ata4.02: hard resetting link
ata4.02: SATA link down (SStatus 0 SControl 320)
ata4.03: hard resetting link
ata4.03: SATA link down (SStatus 0 SControl 320)
ata4.04: hard resetting link
ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.05: hard resetting link
ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata4.04: failed to IDENTIFY (I/O error, err_mask=0x11)
ata4.15: hard resetting link
ata4.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
...........................
...........................
===================================

I appreciate your help.

Thanks
Manojg
