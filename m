From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH UPDATED #upstream-fixes] libata: handle SEMB signature
	better
Date: Thu, 16 Apr 2009 09:37:49 +0200
Message-ID: <20090416073749.GA3545@liondog.tnic>
References: <49E466DE.7020701@kernel.org> <49E47DBF.9060502@garzik.org> <49E4FA13.1090400@kernel.org> <49E4FB42.7010609@garzik.org> <49E4FE46.1010006@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47680 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZDPHhz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Apr 2009 03:37:55 -0400
Received: by fxm2 with SMTP id 2so252988fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 16 Apr 2009 00:37:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49E4FE46.1010006@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, David Haun <drhaun88@gmail.com>, liw@liw.fi, jmcarranza@gmail.com

Hi Tejun,

On Wed, Apr 15, 2009 at 06:21:10AM +0900, Tejun Heo wrote:
> WDC WD1600JS-62MHB5 successfully hits the window between ATA/ATAPI-7
> and Serial ATA II standards and reports 3c/c3 signature which now is
> assigned to SEMB.  Make ata_dev_classify() report ATA_DEV_SEMB on the
> sig and let ata_dev_read_id() work around it by trying IDENTIFY once.
> 
> This fixes bko#11579.
> 
> UPDATED: Jeff spotted stupid bug caused by lingering debug code.
> 

by the way, this patch fixes the problem here with a similar WDC which
reports the same signature 3c/c3 and gets ignored as a SEMB device
initially. With your patch it looks much better:

Apr 16 09:30:05 liondog kernel: ahci 0000:00:11.0: version 3.0
Apr 16 09:30:05 liondog kernel: ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
Apr 16 09:30:05 liondog kernel: ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
Apr 16 09:30:05 liondog kernel: ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
Apr 16 09:30:05 liondog kernel: scsi0 : ahci
Apr 16 09:30:05 liondog kernel: scsi1 : ahci
Apr 16 09:30:05 liondog kernel: scsi2 : ahci
Apr 16 09:30:05 liondog kernel: scsi3 : ahci
Apr 16 09:30:05 liondog kernel: scsi4 : ahci
Apr 16 09:30:05 liondog kernel: scsi5 : ahci
Apr 16 09:30:05 liondog kernel: ata1: SATA max UDMA/133 abar m1024@0xfe9ff800 port 0xfe9ff900 irq 22
Apr 16 09:30:05 liondog kernel: ata2: SATA max UDMA/133 abar m1024@0xfe9ff800 port 0xfe9ff980 irq 22
Apr 16 09:30:05 liondog kernel: ata3: SATA max UDMA/133 abar m1024@0xfe9ff800 port 0xfe9ffa00 irq 22
Apr 16 09:30:05 liondog kernel: ata4: SATA max UDMA/133 abar m1024@0xfe9ff800 port 0xfe9ffa80 irq 22
Apr 16 09:30:05 liondog kernel: ata5: SATA max UDMA/133 abar m1024@0xfe9ff800 port 0xfe9ffb00 irq 22
Apr 16 09:30:05 liondog kernel: ata6: SATA max UDMA/133 abar m1024@0xfe9ff800 port 0xfe9ffb80 irq 22
Apr 16 09:30:05 liondog kernel: ata1: SATA link down (SStatus 0 SControl 300)
Apr 16 09:30:05 liondog kernel: ata2: softreset failed (device not ready)
Apr 16 09:30:05 liondog kernel: ata2: failed due to HW bug, retry pmp=0
Apr 16 09:30:05 liondog kernel: ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Apr 16 09:30:05 liondog kernel: ata2.00: ATA-8: WDC WD2500AAJS-62B4A0, 01.03A01, max UDMA/133
Apr 16 09:30:05 liondog kernel: ata2.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
Apr 16 09:30:05 liondog kernel: ata2.00: configured for UDMA/133

Thanks.

-- 
Regards/Gruss,
    Boris.
