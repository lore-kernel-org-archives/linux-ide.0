From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Wed, 09 Aug 2006 18:30:51 +0900
Message-ID: <44D9AB4B.9050107@gmail.com>
References: <44D336EE.5000907@gmail.com> <44D36823.7020406@pobox.com> <44D37129.9030100@rtr.ca> <44D37519.1020908@gmail.com> <44D82CCF.8020705@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:26218 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030597AbWHIJa7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 05:30:59 -0400
Received: by wx-out-0506.google.com with SMTP id s14so110397wxc
        for <linux-ide@vger.kernel.org>; Wed, 09 Aug 2006 02:30:58 -0700 (PDT)
In-Reply-To: <44D82CCF.8020705@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
>>
>>> Is this "IDENTIFY using IRQs rather than polling" a newish feature?
>>> Because I just don't see how it could work with the the existing
>>> adma_intr_mmio routine --> that code is only correct for non-data
>>> commands, and IDENTIFY definitely has data.
>>
>> IDENTIFY w/ IRQs came with Albert Lee's irq-pio which was merged into
>> mainline together with new EH.
>>
> 
> Oops, pdc_adma.c was overlooked by the irq-pio patch.
> Only HSM_ST_LAST interrupts should be delivered to this LLDD.
> Could you please check if the attached patch helps?

Yay, with your patch pdc_adma detects all devices and works great.

=================================================================
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 3
ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKG] -> GSI 3 (level, low) 
-> IRQ 3
ata1: PATA max UDMA/66 cmd 0xF881AC00 ctl 0xF881AC38 bmdma 0x0 irq 3
ata2: PATA max UDMA/66 cmd 0xF881AC40 ctl 0xF881AC78 bmdma 0x0 irq 3
scsi0 : pdc_adma
ata1.01: ATA-4, max UDMA/66, 30064608 sectors: LBA
ata1.01: ata1: dev 1 multi count 0
ata1.01: configured for UDMA/66
scsi1 : pdc_adma
ata2.01: ATAPI, max MWDMA2
ata2.01: configured for PIO4
   Vendor: ATA       Model: WDC WD153AA       Rev: 05.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 30064608 512-byte hdwr sectors (15393 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 30064608 512-byte hdwr sectors (15393 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:1:0: Attached scsi disk sda
sd 0:0:1:0: Attached scsi generic sg0 type 0
   Vendor: LG (KOR)  Model: CD-ROM CRD-8520B  Rev: 1.00
   Type:   CD-ROM                             ANSI SCSI revision: 05
sr0: scsi3-mmc drive: 52x/52x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:1:0: Attached scsi generic sg1 type 5
=================================================================

Please send the patch to Jeff with proper header.

Thanks.

-- 
tejun
