From: Sander <sander@humilis.net>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Sat, 18 Feb 2006 21:43:40 +0100
Message-ID: <20060218204340.GA2984@favonius>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca> <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:60238 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932140AbWBRUnb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Feb 2006 15:43:31 -0500
Content-Disposition: inline
In-Reply-To: <200602170959.40286.lkml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote (ao):
> On Friday 17 February 2006 03:45, Jeff Garzik wrote:
> >Submit a patch... 
> 
> You mean, something like this one?
> Untested at present, as I was hoping to hear
> back from one of the original problem reporters
> after they tested it.

Not the original reporter, but your patch Works For Me.
I get these:

[  633.449961] md: md1: sync done.
[  633.456070] RAID5 conf printout:
[  633.456117]  --- rd:9 wd:9 fd:0
[  633.456164]  disk 0, o:1, dev:sda2
[  633.456208]  disk 1, o:1, dev:sdb2
[  633.456250]  disk 2, o:1, dev:sdc2
[  633.456298]  disk 3, o:1, dev:sdd2
[  633.456340]  disk 4, o:1, dev:sde2
[  633.456383]  disk 5, o:1, dev:sdf2
[  633.456427]  disk 6, o:1, dev:sdg2
[  633.456470]  disk 7, o:1, dev:sdh2
[  633.456514]  disk 8, o:1, dev:sdi2
[  787.639858] kjournald starting.  Commit interval 5 seconds
[  787.657991] EXT3 FS on md1, internal journal
[  787.658023] EXT3-fs: mounted filesystem with writeback data mode.
[ 1872.338185] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 1872.338239] ata6: status=0xd0 { Busy }
[ 5749.285084] ata8: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 5749.285138] ata8: status=0xd0 { Busy }
[ 5906.008461] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 5906.008515] ata6: status=0xd0 { Busy }
[ 9892.904205] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[ 9892.904259] ata6: status=0xd0 { Busy }
[10146.084687] ata5: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[10146.084740] ata5: status=0xd0 { Busy }
[10293.949040] ata5: translated op=0x2a ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
[10293.949093] ata5: status=0xd0 { Busy }

Can you tell from this what they mean?

This is with 2.6.16-rc3, your patch, and running nine Maxtors disks
over onboard nForce4 and MV88SX6081 8-port SATA II PCI-X Controller (rev 09).

for i in `seq 10`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
done
md5sum bigfile.*

The errors mostly seem to happen during the md5sum (not during the dd).

I do not see data corruption or slowdown.

I do need a chunksize of 512k for the raid5. With anything lower (I tried
the default 64k, 128k, 256k, 512k and 4096k) I get data corruption and
the errors reported in:
http://marc.theaimsgroup.com/?l=linux-ide&m=114016903530007&w=2

Thanks!

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
