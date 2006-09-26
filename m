From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA repeated failure (command 0x35 timeout, status 0xd8)
Date: Tue, 26 Sep 2006 14:10:27 +0900
Message-ID: <4518B643.6030407@gmail.com>
References: <62b0912f0609240816q54c3535bt86f781745ecbfa13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:49186 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751020AbWIZFKd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 01:10:33 -0400
Received: by wx-out-0506.google.com with SMTP id s14so2071013wxc
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2006 22:10:33 -0700 (PDT)
In-Reply-To: <62b0912f0609240816q54c3535bt86f781745ecbfa13@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide]

Molle Bestefich wrote:
> Hi,
> 
> I have a box with the following hardware/software configuration.
> 
> # uname -r
> 2.6.16.5
> 
> # lspci | grep SATA
> 00:0b.0 CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller 
> (rev 02)
> 00:0d.0 CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller 
> (rev 02)
> 00:0f.0 CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller 
> (rev 02)
> 
> # cd /sys/bus/scsi/devices; for dev in `ls -1`; do name=`ls -1d
> $dev/block*`; disk=`cat $dev/model`; echo "$name: $disk"; done
> 0:0:0:0/block:sda: Maxtor 6Y250M0
> 1:0:0:0/block:sdb: Maxtor 6Y200M0
> 2:0:0:0/block:sdc: Maxtor 6Y200M0
> 3:0:0:0/block:sdd: Maxtor 6Y200M0
> 4:0:0:0/block:sde: Maxtor 6Y200M0
> 5:0:0:0/block:sdf: Maxtor 6Y200M0
> 
> It can operate normally for the longest time, but all of a sudden the
> following happens.
> 
> # dmesg
> ata2: command 0x35 timeout, stat 0xd8 host_stat 0x1
> ata2: translated ATA stat/err 0xd8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata2: status=0xd8 { Busy }
> sd 1:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Aborted Command
>    Additional sense: Scsi parity error
> end_request: I/O error, dev sdb, sector 323729879
> ATA: abnormal status 0xD8 on port 0xD095E0C7
> ATA: abnormal status 0xD8 on port 0xD095E0C7
> ATA: abnormal status 0xD8 on port 0xD095E0C7
> -- 
> ata2: command 0x35 timeout, stat 0xd8 host_stat 0x1
> ata2: translated ATA stat/err 0xd8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata2: status=0xd8 { Busy }
> sd 1:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Aborted Command
>    Additional sense: Scsi parity error
> end_request: I/O error, dev sdb, sector 323729887
> ATA: abnormal status 0xD8 on port 0xD095E0C7
> ATA: abnormal status 0xD8 on port 0xD095E0C7
> ATA: abnormal status 0xD8 on port 0xD095E0C7
> 
> [ .. et cetera, always with sector += 8 .. ]
> 
> This usually happens during a write to the RAID.
> 
> Funny thing is, it always happens to /dev/sdb.
> It's happened 100s of times, but not once to any other device than 
> /dev/sdb.
> 
> Resetting and running Maxtor PowerMax reports that the drive has no
> hardware problems whatsoever.
> 
> I can't think of anything useful, except that /dev/sdb sits on the
> same controller card as /dev/sda, which is a slightly different disk
> than the rest of the bunch.
> 
> What can/should I do?

Please give a shot at 2.6.18.  It contains improved EH which 1. should 
be able to recover from such conditions 2. gives more detailed 
information about the nature of errors.

-- 
tejun
