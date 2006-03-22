From: Sander <sander@humilis.net>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Wed, 22 Mar 2006 19:01:27 +0100
Message-ID: <20060322180127.GB3222@favonius>
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <311601c90603220953t291fdb85w9f6d0fb299a00ab2@mail.gmail.com>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:12223 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932265AbWCVSB3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Mar 2006 13:01:29 -0500
Content-Disposition: inline
In-Reply-To: <311601c90603220953t291fdb85w9f6d0fb299a00ab2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: sander@humilis.net, Mark Lord <lkml@rtr.ca>, Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Eric D. Mudama wrote (ao):
> On 3/22/06, Sander <sander@humilis.net> wrote:
> > I've applied the patch against 2.6.16-git4. I'm sorry to say the
> > messages are still there:
> >
> > [ 1038.536894] kjournald starting.  Commit interval 5 seconds
> > [ 1038.555040] EXT3 FS on md0, internal journal
> > [ 1038.555072] EXT3-fs: mounted filesystem with writeback data mode.
> > [ 1418.639290] ata11: status=0x50 { DriveReady SeekComplete }
> > [ 1418.639356] ata11: error=0x50 { UncorrectableError SectorIdNotFound }
> > [ 1418.639418] sdh: Current: sense key=0x0
> > [ 1418.639448]     ASC=0x0 ASCQ=0x0
> > [ 1418.639481] Info fld=0x505050
> > [ 1684.727367] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 1684.727420] ata9: status=0xd0 { Busy }
> > [ 2223.664107] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 2223.664162] ata6: status=0xd0 { Busy }
> > [ 2381.589354] ata11: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 2381.589416] ata11: status=0xd0 { Busy }
> > [ 2511.238690] ata9: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 2511.238753] ata9: status=0xd0 { Busy }
> > [ 2990.792908] ata7: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 2990.792960] ata7: status=0xd0 { Busy }
> > [ 4672.691569] ata8: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 4672.691623] ata8: status=0xd0 { Busy }
> > [ 4988.884663] ata6: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > [ 4988.884717] ata6: status=0xd0 { Busy }
> >
> >
> > Could the ata11/sdh message be bogus? I re-create the raid5 and fs every
> > reboot.
> 
> What, exactly, is timing out? How long is the timeout period?

I don't know to be honest. I just run the test and only afterwards check
if it doesn't fail and if the md5sums match:

for i in `seq 4`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
dd if=bigfile.$i of=/dev/null bs=1024k count=10000
done
time md5sum bigfile.*
time rm bigfile.*

I'm not aware of any delay or timeout. Of course the dd output differs
each run.

> The ata11 seems bogus, 50/50/50 doesn't seem right.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
