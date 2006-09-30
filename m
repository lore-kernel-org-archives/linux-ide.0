From: Alessandro Bono <alessandro.bono@gmail.com>
Subject: Re: [PATCHSET] libata: implement presence detection using polling IDENTIFY for ata_piix
Date: Sat, 30 Sep 2006 11:09:45 +0200
Message-ID: <eflc8f$q6g$1@sea.gmane.org>
References: <11595988092938-git-send-email-htejun@gmail.com> <eflbl2$oq0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:61853 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751163AbWI3JKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Sep 2006 05:10:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GTarD-0007ew-QB
	for linux-ide@vger.kernel.org; Sat, 30 Sep 2006 11:10:03 +0200
Received: from ppp-96-10.29-151.libero.it ([151.29.10.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 11:10:03 +0200
Received: from alessandro.bono by ppp-96-10.29-151.libero.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 30 Sep 2006 11:10:03 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alessandro Bono wrote:

> Tejun Heo wrote:
> 
>> Please test this patchset.  If you don't feel comfortable with handling
>> patch series, this patchset is also available as...
> 
> Hi Tejun
> 
> I can confirm that 2.6.18-git3 + this patchset boot perfectly without any
                        ^^^^^^^^
                    2.6.18-git13
> delay
> 
> libata version 2.00 loaded.
> ata_piix 0000:00:1f.1: version 2.00ac6
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
> PCI: setting IRQ 7 as level-triggered
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 7 (level, low)
> -> IRQ 7
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
> scsi0 : ata_piix
> ata1.00: ATA-6, max UDMA/100, 195371568 sectors: LBA
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/100
> scsi1 : ata_piix
> input: AT Translated Set 2 keyboard as /class/input/input0
> input: AT Translated Set 2 keyboard as /class/input/input1
> ata2.00: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33
> scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHV2100A 0000 PQ: 0 ANSI:
> 5
> scsi 1:0:0:0: CD-ROM            MATSHITA UJ-820D          1.01 PQ: 0 ANSI:
> 5 SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2
> sd 0:0:0:0: Attached scsi disk sda
> .....
> sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> sr 1:0:0:0: Attached scsi CD-ROM sr0
> .....
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sr 1:0:0:0: Attached scsi generic sg1 type 5
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


