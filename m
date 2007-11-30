From: Mark Paulus <mark.paulus@verizonbusiness.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Fri, 30 Nov 2007 08:56:31 -0700
Message-ID: <475032AF.6090001@verizonbusiness.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com>
Reply-To: mark.paulus@verizonbusiness.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------030905080602070903000003
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pmesmtp03.mci.com ([199.249.20.32]:56213 "EHLO
	pmesmtp03.mci.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbXK3QPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 11:15:52 -0500
Received: from pmismtp05.wcomnet.com ([166.37.158.165])
 by firewall.verizonbusiness.com (Iplanet MTA 5.2)
 with ESMTP id <0JSB0039KTZ63X@firewall.verizonbusiness.com> for
 linux-ide@vger.kernel.org; Fri, 30 Nov 2007 16:05:43 +0000 (GMT)
Received: from pmismtp05.wcomnet.com ([127.0.0.1])
 by pmismtp05.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with SMTP id <0JSB00KSUTM2IT@pmismtp05.mcilink.com> for
 linux-ide@vger.kernel.org; Fri, 30 Nov 2007 15:56:26 +0000 (GMT)
Received: from [127.0.0.1] ([166.34.133.85])
 by pmismtp05.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with ESMTP id <0JSB00K5NTM1J0@pmismtp05.mcilink.com> for
 linux-ide@vger.kernel.org; Fri, 30 Nov 2007 15:56:26 +0000 (GMT)
In-reply-to: <474CC29E.8020102@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905080602070903000003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Tejun Heo wrote:
> Hello,
> 
> Mark Paulus wrote:
>> sata_sil 0000:02:0b.0: version 2.2
>> ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 22 (level, low) -> IRQ 18
>> scsi0 : sata_sil
>> scsi1 : sata_sil
>> ata1: SATA max UDMA/100 cmd 0xe0812080 ctl 0xe081208a bmdma 0xe0812000
>> irq 18
>> ata2: SATA max UDMA/100 cmd 0xe08120c0 ctl 0xe08120ca bmdma 0xe0812008
>> irq 18
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
>> ata1.00: 19541088 sectors, multi 16: LBA ata1.00: applying bridge limits
>> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>> ata1.00: revalidation failed (errno=-5)
>> ata1: failed to recover some devices, retrying in 5 secs
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata1.00: failed to set xfermode (err_mask=0x40)
>> ata1.00: limiting speed to UDMA/100:PIO3
>> ata1: failed to recover some devices, retrying in 5 secs
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> ata1.00: failed to set xfermode (err_mask=0x40)
> 
> It looks like for some reason the port is being frozen repeatedly.  Can
> you please apply the attached patch and post the dmesg?
> 
> Thanks.
> 
> 
I applied the patch, and not much difference.  Still the same issue, and here
is the new dmesg output.

SCSI subsystem initialized
libata version 2.21 loaded.
hda: Maxtor 34098H4, ATA DISK drive
hdb: WDC WD200BB-00DEA0, ATA DISK drive
hda: selected mode 0x45
hdb: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: COMPAQ SC-148F, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x22
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.4: irq 16, io base 0x00002440
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0x41000000, irq 17, MAC addr 00:02:A5:10:5A:37
sata_sil 0000:02:0b.0: version 2.2
ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 22 (level, low) -> IRQ 18
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 cmd 0xe0812080 ctl 0xe081208a bmdma 0xe0812000 irq 18
ata2: SATA max UDMA/100 cmd 0xe08120c0 ctl 0xe08120ca bmdma 0xe0812008 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=3)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=2)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=1)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after 5 tries, giving up
ata1: EH complete
ata2: SATA link down (SStatus 0 SControl 310)
hda: max request size: 128KiB
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 >
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/8192KiB Cache, CHS=38792/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20


-- 
Mark Paulus
2424 Garden of the Gods Rd  | Phone:  v622-5578 / 719-535-5578
0419/117 - LEC Access ; D5-1010   | FAX:    719-535-1665
Colo Springs, CO  80919    | 1800PageMCI / 1406052
AIM : mgpaulus1    /  sametime : mark.paulus


--------------030905080602070903000003
Content-Type: text/x-vcard; charset=utf-8;
 name="mark_paulus.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mark_paulus.vcf"

begin:vcard
fn:Mark Paulus
n:Paulus;Mark
org:MCI;Lec Interfaces / 40419
adr;dom:;;2424 Garden of the Gods Rd;Colorado Springs;CO;80919
email;internet:mark.paulus@verizonbusiness.com
title:Mark Paulus
tel;work:719-535-5578
tel;pager:800-pagemci / 1406052
tel;home:v622-5578
version:2.1
end:vcard


--------------030905080602070903000003--

