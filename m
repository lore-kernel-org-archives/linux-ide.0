From: "Wesley Lim" <wesleylim@gmail.com>
Subject: Re: sata_sil or libata?
Date: Sun, 2 Apr 2006 00:05:29 -0800
Message-ID: <a8b98fc60604020005v3dbc20fmd9dcb6c7165dcb@mail.gmail.com>
References: <a8b98fc60604011215u4c426e21qc3c4c1e852d28b60@mail.gmail.com>
	 <442F0CB5.9020004@dgreaves.com>
	 <a8b98fc60604012243w2ca883e0rb6e0115de1ba1c40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.227]:24124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932140AbWDBIFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Apr 2006 04:05:30 -0400
Received: by wproxy.gmail.com with SMTP id i22so1134209wra
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:05:29 -0800 (PST)
In-Reply-To: <a8b98fc60604012243w2ca883e0rb6e0115de1ba1c40@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Mark Lord <lkml@rtr.ca>, albertl@mail.com, htejun@gmail.com, axboe@suse.de, jpiszcz@lucidpixels.com

The more I think about it, the more it sounds like a faulty hard disk.
I'll just RMA it. Sorry for the trouble.

Wesley

On 4/1/06, Wesley Lim <wesleylim@gmail.com> wrote:
> On 4/1/06, David Greaves <david@dgreaves.com> wrote:
> > I take it badblocks shows the drives as OK? (mine does)
>
> smartctl says that SMART overall-health self-assessment is passed.
>
> I've tinkered around with badblocks and the results are surprising. I
> really hope this is not a case of bad hard disk that intermittently
> decides to act up.
>
> badblocks gives the same errors as when copying files into the drive.
> *However* badblocks reports 0 bad sectors and no libata error if I
> test the exact same sectors it reported were bad *immediately after
> the previous (errored) run* (no cooldown/reboot/etc) It might have to
> do with length of SATA bus activity? I get both libata and badblocks
> errors around the 60000000 sector range after badblocks has been
> running ~1 hour into a test. if I just run badblocks over those
> reported blocks, it always shows up fine, no libata or badblocks error
> (including badblocks -w)
>
> I experience the errors only on the reading phase of badblocks, not
> the writing phase. Also, as said above, I get zero errors when I
> repeat badblocks -w over any specific "problem" areas. This cycle
> repeats itself. (if I run a full drive scan, similar errors occur. if
> I check just those "bad" blocks, they disappear)
>
> I'm going to try starting a long block scan from a different address n
> and see if the reported "bad" blocks show up around the n+60000000
> sector range.
>
> > Mark published *two* patches to provide scsi op/cmd info which you may
> > want to apply. (25/2/06 and 14/2/06)
> > (They don't quite apply cleanly - IIRC Mark has a DPRINTK macro that
> > needs changing to a printk call)
>
> I just patched my kernel. The new error messages are below.
>
> > By the way, 2.6.16 is not kicking the drives from the array for me.
> > Did you mean 2.6.15.1? (just checking)
>
> Yup, 2.6.16.1
>
>
> Here's the new dmesg (running badblocks)
>
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> sd 0:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sda, sector 61590952
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
> ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
> SK/ASC/ASCQ 0x3/11/04
> ata1: status=0x51 { DriveReady SeekComplete Error }
> sd 0:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key: Medium Error
>     Additional sense: Unrecovered read error - auto reallocate failed
> end_request: I/O error, dev sda, sector 61590960
>
