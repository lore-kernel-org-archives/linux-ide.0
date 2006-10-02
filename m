From: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: SATA repeated failure (command 0x35 timeout, status 0xd8)
Date: Mon, 2 Oct 2006 04:27:11 +0200
Message-ID: <62b0912f0610011927k789b63f4r370b419e5b98bb5f@mail.gmail.com>
References: <62b0912f0609240816q54c3535bt86f781745ecbfa13@mail.gmail.com>
	 <4518B643.6030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:28202 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932599AbWJBC1M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Oct 2006 22:27:12 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1564875wxc
        for <linux-ide@vger.kernel.org>; Sun, 01 Oct 2006 19:27:11 -0700 (PDT)
In-Reply-To: <4518B643.6030407@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Molle Bestefich wrote:
> > I have a box with the following hardware/software configuration.
> >
> > # uname -r
> > 2.6.16.5
> >
> > # lspci | grep SATA
> > 00:0b.0 CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
> > (rev 02)
> > 00:0d.0 CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
> > (rev 02)
> > 00:0f.0 CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
> > (rev 02)
> >
> > # cd /sys/bus/scsi/devices; for dev in `ls -1`; do name=`ls -1d
> > $dev/block*`; disk=`cat $dev/model`; echo "$name: $disk"; done
> > 0:0:0:0/block:sda: Maxtor 6Y250M0
> > 1:0:0:0/block:sdb: Maxtor 6Y200M0
> > 2:0:0:0/block:sdc: Maxtor 6Y200M0
> > 3:0:0:0/block:sdd: Maxtor 6Y200M0
> > 4:0:0:0/block:sde: Maxtor 6Y200M0
> > 5:0:0:0/block:sdf: Maxtor 6Y200M0
> >
> > It can operate normally for the longest time, but all of a sudden the
> > following happens.
> >
> > # dmesg
> > ata2: command 0x35 timeout, stat 0xd8 host_stat 0x1
> > ata2: translated ATA stat/err 0xd8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > ata2: status=0xd8 { Busy }
> > sd 1:0:0:0: SCSI error: return code = 0x8000002
> > sdb: Current: sense key: Aborted Command
> >    Additional sense: Scsi parity error
> > end_request: I/O error, dev sdb, sector 323729879
> > ATA: abnormal status 0xD8 on port 0xD095E0C7
> > ATA: abnormal status 0xD8 on port 0xD095E0C7
> > ATA: abnormal status 0xD8 on port 0xD095E0C7
> > --
> > ata2: command 0x35 timeout, stat 0xd8 host_stat 0x1
> > ata2: translated ATA stat/err 0xd8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > ata2: status=0xd8 { Busy }
> > sd 1:0:0:0: SCSI error: return code = 0x8000002
> > sdb: Current: sense key: Aborted Command
> >    Additional sense: Scsi parity error
> > end_request: I/O error, dev sdb, sector 323729887
> > ATA: abnormal status 0xD8 on port 0xD095E0C7
> > ATA: abnormal status 0xD8 on port 0xD095E0C7
> > ATA: abnormal status 0xD8 on port 0xD095E0C7
> >
> > [ .. et cetera, always with sector += 8 .. ]
> >
> > This usually happens during a write to the RAID.
> >
> > Funny thing is, it always happens to /dev/sdb.
> > It's happened 100s of times, but not once to any other device than
> > /dev/sdb.
> >
> > Resetting and running Maxtor PowerMax reports that the drive has no
> > hardware problems whatsoever.
> >
> > I can't think of anything useful, except that /dev/sdb sits on the
> > same controller card as /dev/sda, which is a slightly different disk
> > than the rest of the bunch.
> >
> > What can/should I do?
>
> Please give a shot at 2.6.18.  It contains improved EH which 1. should
> be able to recover from such conditions 2. gives more detailed
> information about the nature of errors.

Can do.

Things are much better with 2.6.18!
The box actually stays up when /dev/sdb fails, it doesn't hang anymore.
I've reduced the rate at which I'm hard resetting it with 100%.  Whee! :-D.

Actual access to the disk still breaks, however.
It's even starting to fail quite consistently.

Using 2.6.18, I get this during bootup:
===============
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x280000 action 0x2 frozen
ata2.00: (BMDMA stat 0x1)
ata2.00: tag 0 cmd 0xc8 Emask 0x12 stat 0xd9 err 0x4 (ATA bus error)
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: EH complete
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
eth0:  setting full-duplex.
===============

Hot-adding the disk to it's RAID array, causing read/write, yields the
following:
===============
ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0x35 Emask 0x10 stat 0x50 err 0x0 (ATA bus error)
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH complete
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x2280000 action 0x2 frozen
ata2.00: (BMDMA stat 0x4)
ata2.00: tag 0 cmd 0xca Emask 0x10 stat 0x50 err 0x0 (ATA bus error)
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/100
ata2: EH pending after completion, repeating EH (cnt=4)
ata2: EH complete
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
===============

The above repeats itself thru modes UDMA/66, UDMA/44, UDMA/33,
UDMA/25, UDMA/16, PIO4, PIO3, PIO1 and PIO0.

At which point /dev/sdb disappears completely, only to reappear as /dev/sdh:
===============
SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 398297088 512-byte hdwr sectors (203928 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
===============

(Odd.)

I don't get why PowerMax works this drive just fine while Linux
doesn't.  Perhaps because PowerMax only uses SMART commands and
doesn't transfer data over the SATA bus?

Anyway, with the device now failing fairly consistently, I guess I
should begin moving around cables, controllers, disks etc. again.  I'm
very worried about doing this though, since I'm pretty sure that it'll
break the MD array on the disks very quickly..
