From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Bug or my setup?
Date: Thu, 28 Oct 2004 22:32:06 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041028133252e723c9@mail.gmail.com>
References: <1098986037.4933.6.camel@first> <418153C8.8080800@developers.dk>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.193]:35900 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262889AbUJ1UcN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Oct 2004 16:32:13 -0400
Received: by wproxy.gmail.com with SMTP id 64so541696wri
        for <linux-ide@vger.kernel.org>; Thu, 28 Oct 2004 13:32:06 -0700 (PDT)
In-Reply-To: <418153C8.8080800@developers.dk>
List-Id: linux-ide@vger.kernel.org
To: Peter Christensen <ungod@developers.dk>
Cc: linux-ide@vger.kernel.org

On Thu, 28 Oct 2004 22:17:12 +0200, Peter Christensen
<ungod@developers.dk> wrote:
> Citroklar wrote:
> 
> 
> > Hi there,
> >
> > I posted that before, but I didn't get an answer, so I post again, this
> > time with a more recent kernel (2.6.10-rc1-bk6). I wonder if this is a
> > bug or just my setup.
> >
> > I have a dvd writer (parallel ata) connected to a PATA/SATA converter
> > which in turn is connected to a Silicon Image 3114 PCI Card.
> >
> > Now, funny thing is, the device gets detected somehow, but no /dev/sd*
> > is attached to it!
> >
> > this is the dmesg output that troubles me:
> >
> > ata1: SATA max UDMA/100 cmd 0xE881AC80 ctl 0xE881AC8A bmdma 0xE881AC00
> > irq 19
> > ata2: SATA max UDMA/100 cmd 0xE881ACC0 ctl 0xE881ACCA bmdma 0xE881AC08
> > irq 19
> > ata3: SATA max UDMA/100 cmd 0xE881AE80 ctl 0xE881AE8A bmdma 0xE881AE00
> > irq 19
> > ata4: SATA max UDMA/100 cmd 0xE881AEC0 ctl 0xE881AECA bmdma 0xE881AE08
> > irq 19
> > ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> > 88:207f
> > ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
> > ata1: dev 0 configured for UDMA/100
> > scsi0 : sata_sil
> > ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> > 88:207f
> > ata2: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
> > ata2: dev 0 configured for UDMA/100
> > scsi1 : sata_sil
> > ata3: dev 0 cfg 49:0f00 82:421c 83:0000 84:0000 85:0000 86:0000 87:0000
> > 88:0007
> > ata3: dev 0 ATAPI, max UDMA/33
> > ata3: dev 0 configured for UDMA/33
> > scsi2 : sata_sil
> > ata4: no device found (phy stat 00000000)
> > scsi3 : sata_sil
> >   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
> > SCSI device sda: drive cache: write back
> >  sda: sda1 sda2 < sda5 >
> > Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> >   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
> >   Type:   Direct-Access                      ANSI SCSI revision: 05
> > SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
> > SCSI device sdb: drive cache: write back
> >  sdb: sdb1 sdb2 < sdb5 >
> > Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
> >
> > And that's it. no attaching scsi cdrom drive at scsi2. :(
> >
> > Is it a bug or is it a feature that will come later or is it just my
> > setup?
> >
> > thanks,
> > Tobias Ottmar
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Hi Tobias
> 
> The support for ATAPI over SATA is there, however since it is still quite buggy, it is disabled by default.

What bugs are left in 2.6.10-rc1?
