From: Ajit Prem <Ajit.Prem@motorola.com>
Subject: Re: 31244 & sata_vsc & PPC
Date: Wed, 16 Feb 2005 18:21:46 -0700
Message-ID: <4213F1AA.6060500@motorola.com>
References: <4213996C.4060301@motorola.com> <20050216190821.GA19150@havoc.gtf.org> <4213BADF.8000307@motorola.com> <4213C852.4070105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from motgate3.mot.com ([144.189.100.103]:28568 "EHLO
	motgate3.mot.com") by vger.kernel.org with ESMTP id S262187AbVBQBWG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2005 20:22:06 -0500
In-Reply-To: <4213C852.4070105@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>


It's just a dirty hack that works
for the limited case where I'm
using only 1 disk off port 1 on a
board that makes 3 ports available.
I'm not sure what the side effects
are, or how things will work if
all 3 ports are used (which I'm
unable to test).

Anyway, here's the hack I used:

@@ -174,6 +174,9 @@
    if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
        struct ata_queued_cmd *qc;
 
+       vsc_sata_scr_write(ap, VSC_SATA_SCR_ERROR_OFFSET, 0x00010001);
+       readl((void *)ap->ioaddr.status_addr);
+
        qc = ata_qc_from_tag(ap, ap->active_tag);
        if (qc && (!(qc->tf.ctl & ATA_NIEN)))
            handled += ata_host_intr(ap, qc);


Now, on "modprobe sata_vsc", I get:

 ata1: SATA max UDMA/133 cmd 0xE107C200 ctl 0xE107C229 bmdma 0xE107C270 
irq 98
 ata2: SATA max UDMA/133 cmd 0xE107C400 ctl 0xE107C429 bmdma 0xE107C470 
irq 98
 ata3: SATA max UDMA/133 cmd 0xE107C600 ctl 0xE107C629 bmdma 0xE107C670 
irq 98
 ata4: SATA max UDMA/133 cmd 0xE107C800 ctl 0xE107C829 bmdma 0xE107C870 
irq 98
 ata1: no device found (phy stat 00000000)
 scsi0 : sata_vsc
 ata2: dev 0 ATA, max UDMA/100, 78140160 sectors:
 ata2(0): applying bridge limits
 ata2: dev 0 configured for UDMA/100
 scsi1 : sata_vsc
 ata3: no device found (phy stat 00000000)
 scsi2 : sata_vsc
 ata4: no device found (phy stat 00000000)
 scsi3 : sata_vsc
   Vendor: ATA       Model: FUJITSU MHS2040A  Rev   : C003
   Type:   Direct-Access                      ANSI SCSI revision: 05
 SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
 SCSI device sda: drive cache: write back
 SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
 SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3
 Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
 Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0


I can then fdisk, mount, and use the SATA disk with no problems.

AP


Jeff Garzik wrote:

> Ajit Prem wrote:
>
>>
>> As a follow-up to my previous email where
>> I indicated that int_status on entry into
>> vsc_sata_interrupt indicates 0x8300, I
>> put in a crude fix in the vsc_sata_interrupt
>> handler to read the taskfile status register,
>> and to clear the appropriate bits in the
>> SATA SError register, and now things work
>> just fine.
>
>
> Wanna post your crude patch to the list?
>
>     Jeff
>
>
>

