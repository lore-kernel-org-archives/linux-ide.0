From: David Greaves <david@dgreaves.com>
Subject: Re: sata_sil + Maxtor
Date: Wed, 24 Nov 2004 10:26:48 +0000
Message-ID: <41A461E8.2040207@dgreaves.com>
References: <200410080948.45286.rme@image.dk> <4166A93A.4030403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:41679 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262595AbUKXK0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2004 05:26:52 -0500
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP id 4356EE6A9F
	for <linux-ide@vger.kernel.org>; Wed, 24 Nov 2004 10:24:07 +0000 (GMT)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31344-08 for <linux-ide@vger.kernel.org>;
 Wed, 24 Nov 2004 10:24:07 +0000 (GMT)
Received: from oak.dgreaves.com (modem-2525.kawau.dialup.pol.co.uk [81.78.153.221])
	by mail.ukfsn.org (Postfix) with ESMTP id C503AE6D3D
	for <linux-ide@vger.kernel.org>; Wed, 24 Nov 2004 10:24:05 +0000 (GMT)
Received: from ash.dgreaves.com ([10.0.0.93])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1CWuQq-0007YN-J4
	for linux-ide@vger.kernel.org; Wed, 24 Nov 2004 10:31:28 +0000
In-Reply-To: <4166A93A.4030403@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Just for the Google of it...

I had almost exactly this problem with a cheap plugin sata_sil on 2.6.9 
on Maxtor 250Gb drives with an old Asus A7V133 motherboard and solved it 
by upgrading the motherboard BIOS and/or resetting the BIOS values to 
defaults. I narrowed it down to PCI bus settings.

David

Jeff Garzik wrote:

> Rasmus Melgaard wrote:
>
>> Hi,
>>
>> I have a IDE/SATA problem. I have a Silicon Image 3112 
>> sata-controller with a Maxtor 160 Gb drive connected. Controller and 
>> drive is detected in the kernel-boot process, but an error happens 
>> during boot, I think the linux driver gets an response it doesn't 
>> expect.
>>
>> I'm using for testing the mm-kernel: 2.6.9-rc1-mm1. Every thing seems 
>> to work in Windows, but since I mainly use Linux (Gentoo), I would 
>> like it to work here.
>>
>> Does anybody have an ideer of how to proceed to solve this problem ?
>> Mvh
>> Rasmus
>>
>> Important part of log:
>> Sep  5 15:55:39 rasmus scsi1 : sata_sil
>> Sep  5 15:55:39 rasmus ata2: no device found (phy stat 00000000)
>> Sep  5 15:55:39 rasmus scsi2 : sata_sil
>> Sep  5 15:55:39 rasmus Vendor: ATA       Model: Maxtor 6Y160M0    
>> Rev: YAR5
>> Sep  5 15:55:39 rasmus Type:   Direct-Access                      
>> ANSI SCSI revision: 05
>> Sep  5 15:55:39 rasmus SCSI device sda: 320173056 512-byte hdwr 
>> sectors (163929 MB)
>> Sep  5 15:55:39 rasmus SCSI device sda: drive cache: write back
>> Sep  5 15:55:39 rasmus /dev/scsi/host1/bus0/target0/lun0:<3>ata1: 
>> command 0x25 timeout, stat 0x58 host_stat 0x60
>> Sep  5 15:55:39 rasmus ata1: status=0x58 { DriveReady SeekComplete 
>> DataRequest }
>> Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
>> Sep  5 15:55:39 rasmus Current sda: sense = 70 10
>> Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
>> Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0
>> Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
>> Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
>> Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
>> Sep  5 15:55:39 rasmus ata1: command 0x25 timeout, stat 0xd8 
>> host_stat 0x61
>> Sep  5 15:55:39 rasmus ata1: status=0xd8 { Busy }
>> Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
>> Sep  5 15:55:39 rasmus Current sda: sense = 70 10
>> Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
>> Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0
>
>
> It's quite clearly a device error...  Try upgrading your system and 
> card BIOS, try switching cables, try booting with "noapic" or 
> "acpi=off" or "pci=biosirq" or something like that...
>
>     Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

