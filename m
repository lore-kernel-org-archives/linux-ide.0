From: Harri Olin <harri.olin@gmail.com>
Subject: Re: ata device numbers
Date: Sat, 9 Oct 2010 21:58:08 +0300
Message-ID: <4CB0BB40.1090104@gmail.com>
References: <4CB0A19C.20604@gmail.com> <20101009200110.3e00a14c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:35565 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806Ab0JIS6O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Oct 2010 14:58:14 -0400
In-Reply-To: <20101009200110.3e00a14c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> ata13: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata13.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
>> ata13.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> ata13.00: configured for UDMA/133
>> scsi 12:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
>> ANSI: 5
>> sd 12:0:0:0: [sdm] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
>> sd 12:0:0:0: Attached scsi generic sg12 type 0
>> sd 12:0:0:0: [sdm] Write Protect is off
>> sd 12:0:0:0: [sdm] Mode Sense: 00 3a 00 00
>> sd 12:0:0:0: [sdm] Write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA
>>   sdm: sdm1
>> sd 12:0:0:0: [sdm] Attached SCSI disk
> 
> So /dev/sdm
> 

Sorry, I mistyped. Error was on ata23, not on ata13, as seen at the end 
of dmesg. And I'm more interested on some kind of reliable way to make 
the translation - is there anything on /sys where ata device number 
could be checked?

I suppose ata23 could still be sd22 ..

ata23 scanning messages appear around halfway of dmesg, line 710:
...
ata15: SATA link down (SStatus 0 SControl 300)
usb 1-1: new high speed USB device using ehci_hcd and address 2
usb 1-1: configuration #1 chosen from 1 choice
ata23: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata23.00: ATA-7: WDC WD7500AYYS-01RCA0, 30.04G30, max UDMA/133
ata23.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata23.00: configured for UDMA/133
usb 1-5: new high speed USB device using ehci_hcd and address 3
usb 1-5: configuration #1 chosen from 1 choice
input: Peppercon AG Multidevice as /class/input/input2
...

and sd22 scan somewhere around line 971:
...
scsi 22:0:0:0: Direct-Access     ATA      WDC WD7500AYYS-0 30.0 PQ: 0 
ANSI: 5
sd 22:0:0:0: [sdt] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
sd 22:0:0:0: [sdt] Write Protect is off
sd 22:0:0:0: [sdt] Mode Sense: 00 3a 00 00
sd 22:0:0:0: [sdt] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 22:0:0:0: Attached scsi generic sg19 type 0
  sdt:
sd 21:0:0:0: [sds] Write Protect is off
sd 21:0:0:0: [sds] Mode Sense: 00 3a 00 00
sd 21:0:0:0: [sds] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sds: sdt1
sd 22:0:0:0: [sdt] Attached SCSI disk
  unknown partition table
sd 21:0:0:0: [sds] Attached SCSI disk
...

Care to tell which line is for what drive? :)

(hint: sds contains what partitions?)

I thought of inserting USB stick in the middle of scanning just to throw 
the numbering off.. just to make things a little more interesting :)

-- 
Harri.
