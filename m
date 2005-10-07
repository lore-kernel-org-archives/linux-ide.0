From: Nick Pasich <NewsLetters@NickAndBarb.net>
Subject: Re: no device found for TX4000
Date: Fri, 7 Oct 2005 06:43:24 -0700
Message-ID: <20051007134324.GA18871@69.17.112.251>
References: <20051005180223.GA17900@10.1.0.5> <43445009.6010608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl017-112-251.lax1.dsl.speakeasy.net ([69.17.112.251]:17384
	"EHLO NickAndBarb.net") by vger.kernel.org with ESMTP
	id S932577AbVJGNnd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Oct 2005 09:43:33 -0400
Content-Disposition: inline
In-Reply-To: <43445009.6010608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff,

The sata_promise fixes in linux-2.6.14-rc3 "did the trick".

All 4 drives are now accessible.

*******************************************************************************************************
*******************************************************************************************************
Oct  6 15:09:49 Server05 kernel: ata1: PATA max UDMA/133 cmd 0xF0CE2200 ctl 0xF0CE2238 bmdma 0x0 irq 11
Oct  6 15:09:49 Server05 kernel: ata2: PATA max UDMA/133 cmd 0xF0CE2280 ctl 0xF0CE22B8 bmdma 0x0 irq 11
Oct  6 15:09:49 Server05 kernel: ata3: PATA max UDMA/133 cmd 0xF0CE2300 ctl 0xF0CE2338 bmdma 0x0 irq 11
Oct  6 15:09:49 Server05 kernel: ata4: PATA max UDMA/133 cmd 0xF0CE2380 ctl 0xF0CE23B8 bmdma 0x0 irq 11
Oct  6 15:09:49 Server05 kernel: ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Oct  6 15:09:49 Server05 kernel: ata1: dev 0 configured for UDMA/33
Oct  6 15:09:49 Server05 kernel: scsi1 : sata_promise
Oct  6 15:09:49 Server05 kernel: ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Oct  6 15:09:49 Server05 kernel: ata2: dev 0 configured for UDMA/33
Oct  6 15:09:49 Server05 kernel: scsi2 : sata_promise
Oct  6 15:09:49 Server05 kernel: ata3: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Oct  6 15:09:49 Server05 kernel: ata3: dev 0 configured for UDMA/33
Oct  6 15:09:49 Server05 kernel: scsi3 : sata_promise
Oct  6 15:09:49 Server05 kernel: ata4: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
Oct  6 15:09:49 Server05 kernel: ata4: dev 0 configured for UDMA/33
Oct  6 15:09:49 Server05 kernel: scsi4 : sata_promise
Oct  6 15:09:49 Server05 kernel:   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
Oct  6 15:09:49 Server05 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Oct  6 15:09:49 Server05 kernel: SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
Oct  6 15:09:49 Server05 kernel: SCSI device sda: drive cache: write through
Oct  6 15:09:49 Server05 kernel: SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
Oct  6 15:09:49 Server05 kernel: SCSI device sda: drive cache: write through
Oct  6 15:09:49 Server05 kernel:  sda: sda1
Oct  6 15:09:49 Server05 kernel: Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Oct  6 15:09:49 Server05 kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Oct  6 15:09:49 Server05 kernel:   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
Oct  6 15:09:49 Server05 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Oct  6 15:09:50 Server05 kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
Oct  6 15:09:50 Server05 kernel: SCSI device sdb: drive cache: write back
Oct  6 15:09:50 Server05 kernel: SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
Oct  6 15:09:50 Server05 kernel: SCSI device sdb: drive cache: write back
Oct  6 15:09:50 Server05 kernel:  sdb: sdb1
Oct  6 15:09:50 Server05 kernel: Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Oct  6 15:09:50 Server05 kernel: Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Oct  6 15:09:50 Server05 kernel:   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
Oct  6 15:09:50 Server05 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Oct  6 15:09:50 Server05 kernel: SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
Oct  6 15:09:50 Server05 kernel: SCSI device sdc: drive cache: write through
Oct  6 15:09:50 Server05 kernel: SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
Oct  6 15:09:50 Server05 kernel: SCSI device sdc: drive cache: write through
Oct  6 15:09:50 Server05 kernel:  sdc: sdc1
Oct  6 15:09:50 Server05 kernel: Attached scsi disk sdc at scsi3, channel 0, id 0, lun 0
Oct  6 15:09:50 Server05 kernel: Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
Oct  6 15:09:50 Server05 kernel:   Vendor: ATA       Model: WDC WD2500JB-00F  Rev: 15.0
Oct  6 15:09:50 Server05 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Oct  6 15:09:50 Server05 kernel: SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
Oct  6 15:09:50 Server05 kernel: SCSI device sdd: drive cache: write back
Oct  6 15:09:50 Server05 kernel: SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
Oct  6 15:09:50 Server05 kernel: SCSI device sdd: drive cache: write back
Oct  6 15:09:50 Server05 kernel:  sdd: sdd1
Oct  6 15:09:50 Server05 kernel: Attached scsi disk sdd at scsi4, channel 0, id 0, lun 0
Oct  6 15:09:50 Server05 kernel: Attached scsi generic sg4 at scsi4, channel 0, id 0, lun 0,  type 0
*******************************************************************************************************
*******************************************************************************************************


   Thanks for all your excellent work and quick response,

	         ---( Nick Pasich )---



>Thanks Jeff.....
>
>I'll compile 2.6.14-rc3 and let you know what happens...
>
>             ---( Nick Pasich )---
>
>
>On Wed, Oct 05, 2005 at 06:13:29PM -0400, Jeff Garzik wrote:
>> Nick Pasich wrote:
>> >Jeff,
>> >
>> >
>> >I'm running Slackware 10.1 and have compiled linux-2.6.13.3 kernel
>> >with the sata_promise.c as kernel resident.
>> 
>> Should be fixed in 2.6.14-rcX...
>> 
>> 	Jeff
>> 
>> 
>> 

-- 
--------
WebSite: http://NickAndBarb.net
--------

