From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_sil + Maxtor
Date: Fri, 08 Oct 2004 10:50:34 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4166A93A.4030403@pobox.com>
References: <200410080948.45286.rme@image.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269997AbUJHOus
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Oct 2004 10:50:48 -0400
In-Reply-To: <200410080948.45286.rme@image.dk>
List-Id: linux-ide@vger.kernel.org
To: rme@image.dk
Cc: linux-ide@vger.kernel.org

Rasmus Melgaard wrote:
> Hi,
> 
> I have a IDE/SATA problem. I have a Silicon Image 3112 sata-controller with a 
> Maxtor 160 Gb drive connected. Controller and drive is detected in the 
> kernel-boot process, but an error happens during boot, I think the linux 
> driver gets an response it doesn't expect.
> 
> I'm using for testing the mm-kernel: 2.6.9-rc1-mm1. Every thing seems to work 
> in Windows, but since I mainly use Linux (Gentoo), I would like it to work 
> here.
> 
> Does anybody have an ideer of how to proceed to solve this problem ? 
> 
> Mvh
> Rasmus
> 
> Important part of log:
> Sep  5 15:55:39 rasmus scsi1 : sata_sil
> Sep  5 15:55:39 rasmus ata2: no device found (phy stat 00000000)
> Sep  5 15:55:39 rasmus scsi2 : sata_sil
> Sep  5 15:55:39 rasmus Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
> Sep  5 15:55:39 rasmus Type:   Direct-Access                      ANSI SCSI 
> revision: 05
> Sep  5 15:55:39 rasmus SCSI device sda: 320173056 512-byte hdwr sectors 
> (163929 MB)
> Sep  5 15:55:39 rasmus SCSI device sda: drive cache: write back
> Sep  5 15:55:39 rasmus /dev/scsi/host1/bus0/target0/lun0:<3>ata1: command 0x25 
> timeout, stat 0x58 host_stat 0x60
> Sep  5 15:55:39 rasmus ata1: status=0x58 { DriveReady SeekComplete 
> DataRequest }
> Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
> Sep  5 15:55:39 rasmus Current sda: sense = 70 10
> Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
> Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0
> Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
> Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
> Sep  5 15:55:39 rasmus ATA: abnormal status 0x58 on port 0xE882E087
> Sep  5 15:55:39 rasmus ata1: command 0x25 timeout, stat 0xd8 host_stat 0x61
> Sep  5 15:55:39 rasmus ata1: status=0xd8 { Busy }
> Sep  5 15:55:39 rasmus SCSI error : <1 0 0 0> return code = 0x8000002
> Sep  5 15:55:39 rasmus Current sda: sense = 70 10
> Sep  5 15:55:39 rasmus end_request: I/O error, dev sda, sector 0
> Sep  5 15:55:39 rasmus Buffer I/O error on device sda, logical block 0

It's quite clearly a device error...  Try upgrading your system and card 
BIOS, try switching cables, try booting with "noapic" or "acpi=off" or 
"pci=biosirq" or something like that...

	Jeff



