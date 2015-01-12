From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: SATA link power management issues
Date: Mon, 12 Jan 2015 21:54:59 +0100
Message-ID: <1609988.v8ICLj4Nnx@xps13>
References: <3352987.ugV1Ipy7Z5@xps13> <83596004.97VzmK2jef@xps13> <CAOHikRC43JBMwCahBqT1znJLBnbr3Ui+szKhVQoK8cpfapTQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOHikRC43JBMwCahBqT1znJLBnbr3Ui+szKhVQoK8cpfapTQyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tuesday 13 January 2015 02:17:00 Suman Tripathi wrote:
> Hi,
> 
> On Tuesday 13 January 2015 02:00:45 Suman Tripathi wrote:
> > On Monday 12 January 2015 22:46:02 Suman Tripathi wrote:
> > > Can you dump the ata_id parameters(LPM section) from the drive and we
> > > can check the related LPM parameters of the drive ?
> >
> > Hi,
> >
> > I'm sorry, but I'm not really familiar with ata, could you be a bit
> > more specific about what you'd like to see?
> > ok no issues. First can show the log from the point the drive got
> > enumerated ? Like for eg :
> > ata2.00: ATA-8: WDC WD5000AAKX-08U6AA0, 19.01H19, max UDMA/100
> >
> > ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> >
> > ata2.00: configured for UDMA/100
> >
> > I would like to the ATA version the drive is complaint. In the above case
> > it is ATA-8
> 
> [    0.698842] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    0.701419] ata3.00: ATA-8: LITEONIT LMT-256M6M mSATA 256GB, DM8110F,
> max UDMA/133
> [    0.701421] ata3.00: 500118192 sectors, multi 1: LBA48 NCQ (depth
> 31/32), AA
> [    0.701982] ata3.00: configured for UDMA/133
> 
> You can see the entire log here:
> http://www.spinics.net/lists/linux-ide/msg50069.html
> 
> Can you try the below fix ? In the libata-core.c

Tried, unfortunately it does not solve the problem. I no longer get
"ahci 0000:00:1f.2: port does not support device sleep"

[   60.170199] ata3.00: exception Emask 0x10 SAct 0x2000 SErr 0x50000 action 0xe frozen
[   60.170209] ata3.00: irq_stat 0x00400000, PHY RDY changed
[   60.170215] ata3: SError: { PHYRdyChg CommWake }
[   60.170221] ata3.00: failed command: WRITE FPDMA QUEUED
[   60.170231] ata3.00: cmd 61/01:68:01:08:00/00:00:00:00:00/40 tag 13 ncq 512 out
         res 40/00:6c:01:08:00/00:00:00:00:00/40 Emask 0x10 (ATA bus error)
[   60.170236] ata3.00: status: { DRDY }
[   60.170244] ata3: hard resetting link
[   60.894728] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   60.897672] ata3.00: configured for UDMA/133
[   60.910690] ata3: EH complete
