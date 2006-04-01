From: David Greaves <david@dgreaves.com>
Subject: Re: sata_sil or libata?
Date: Sun, 02 Apr 2006 00:28:53 +0100
Message-ID: <442F0CB5.9020004@dgreaves.com>
References: <a8b98fc60604011215u4c426e21qc3c4c1e852d28b60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:46749 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932310AbWDAX2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 18:28:22 -0500
In-Reply-To: <a8b98fc60604011215u4c426e21qc3c4c1e852d28b60@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wesley Lim <wesleylim@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Mark Lord <lkml@rtr.ca>, albertl@mail.com, htejun@gmail.com, axboe@suse.de, jpiszcz@lucidpixels.com

Wesley Lim wrote:

>Jeff,
>
>I have encountered a problem with my SATA controller and would like to
>report the bug - I'm not sure if you are the person to contact but
>here goes:
>
>2.6.16.1 from kernel.org
>Syba SD-SATA150R PCI (Silicon Image 3112A flashed to 4.2.76)
>Maxtor 6L250M0 Rev:BACE
>
>ata1: no sense translation for status: 0x51
>ata1: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>ata1: status=0x51 { DriveReady SeekComplete Error }
>sd 0:0:0:0: SCSI error: return code = 0x8000002
>sda: Current: sense key: Medium Error
>    Additional sense: Unrecovered read error - auto reallocate failed
>end_request: I/O error, dev sda, sector 63268998
>raid5: read error not correctable.
>raid5: Disk failure on sda3, disabling device. Operation continuing on 1 devices
>  
>
Hi Wesley; I'm glad you've come along :) I have almost identical problems.

I take it badblocks shows the drives as OK? (mine does)

I suggest a scan of the linux-ide archives from early february ago.
Subject: LibPATA code issues / 2.6.15.4

Mark published *two* patches to provide scsi op/cmd info which you may
want to apply. (25/2/06 and 14/2/06)
(They don't quite apply cleanly - IIRC Mark has a DPRINTK macro that
needs changing to a printk call)

Your results will then look like this (vanilla 2.6.16 with cmdpatch):

ata2: no sense translation for op=0x28 cmd=0x25 status: 0x51
ata2: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: command 0x25 timeout, stat 0x51 host_stat 0x0
ata2: no sense translation for op=0x28 cmd=0x25 status: 0x51
ata2: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }
sd 1:0:0:0: SCSI error: return code = 0x8000002
sdb: Current: sense key: Medium Error
    Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 393692817
raid1: sdb2: rescheduling sector 2975952
raid1: sdd2: redirecting sector 2975952 to another mirror
ata2: no sense translation for op=0x28 cmd=0x25 status: 0x51
ata2: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
SK/ASC/ASCQ 0x3/11/04
ata2: status=0x51 { DriveReady SeekComplete Error }

By the way, 2.6.16 is not kicking the drives from the array for me.
Did you mean 2.6.15.1? (just checking)

David
PS I added the people from the last thread to this one as I assume
you'll be interested - hope that's OK.

