From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Fw: [Bugme-new] [Bug 1340] New: small FAT32 partitions cannot be used properly
Date: Mon, 13 Oct 2003 03:13:39 +0900
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <87zng6iass.fsf@devron.myhome.or.jp>
References: <20031010081436.7652c427.akpm@osdl.org>
	<87llrrty3z.fsf@devron.myhome.or.jp> <3F89400B.5020607@king.net.pl>
	<87brsm8tg6.fsf@devron.myhome.or.jp> <3F898EEA.6090907@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.parknet.co.jp ([210.171.160.6]:21510 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263500AbTJLSOJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 12 Oct 2003 14:14:09 -0400
In-Reply-To: <3F898EEA.6090907@king.net.pl>
List-Id: linux-ide@vger.kernel.org
To: Paul Osmialowski <newchief@king.net.pl>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hi,

Paul, thanks a lot for test.

Andrew, this looks like IDE bug with PIO-mode. So could you please
handle the bugzilla? I don't know about bugzilla.

Bartlomiej, are you interesting the following problem? Any idea?

Paul Osmialowski <newchief@king.net.pl> writes:

> Dear Ogawa!
>   I did more test and I discovered:
> 1. DriveReady SeekComplete Error was always present and DMA was disabled.
> 2. Whenever I connected CF disk alone (as master or slave) I WAS ABLE
> TO MOUNT THIS PARTITION IN READ/WRITE MODE!!! That's the solution for
> now.
> 3. Whenever I connected CF disk as slave with ATAPI disk as master I
> couldn't mount this partition properly.
> 4. I was always able to read boot sector using fdisk.
> 
> The problem is with operating CF TrueIDE disk as a slave. I'm not sure
> but I think I didn't try to mount this partition when I was using CF
> disk alone (no master or slave on the same cable), so I was quite
> surprised when I saw no dmesg error messages after such mount.
> The problem should be fixed anyway, since it's not present on M$
> Windows. It may be caused by some piece of code written for Compact
> Flash volumes, since they're mentioned in dmesg as CFA DISK drive
> while other HDD's are mentioned as ATA DISK drive.
>   Since I'm new to bugzilla I'd like to ask you to redirect my problem
> report to proper section of kernel developers. Two issues are
> important:
> 1. DriveReady SeekComplete Error message in dmesg and DMA disabled (I
> think CFs are PIO-only anyway).
> 2. Partitions cannot be mounted properly when CF is used as a slave
> with other drive on the same cable (i.e. hdb with hda present).
> Greetings,
> Paul
> 
> Uz.ytkownik OGAWA Hirofumi napisa?:
> > Paul Osmialowski <newchief@king.net.pl> writes:
> >
> >>hdb: max request size: 128KiB
> >>hdb: 125952 sectors (64 MB) w/1KiB Cache, CHS=246/16/32, BUG
> >>  hdb:hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >>hdb: dma_intr: error=0x00 { }
> >>hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >>hdb: dma_intr: error=0x00 { }
> >>hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >>hdb: dma_intr: error=0x00 { }
> >>hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >>hdb: dma_intr: error=0x00 { }
> >>hda: DMA disabled
> >>hdb: DMA disabled
> >>ide0: reset: success
> > Um. Looks like hdb has hardware or driver(PIO-mode) problem.
> > Could you test with /dev/hdb1? If it has corruption problem,
> > completely not filesystem layer bug. So it should goes to IDE
> > maintainer.
> > Thanks.


> From: Paul Osmialowski <newchief@king.net.pl>
> Subject: Re: Fw: [Bugme-new] [Bug 1340] New: small FAT32 partitions cannot
>  be used properly
> To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Date: Sun, 12 Oct 2003 13:50:35 +0200
> User-Agent: Mozilla/5.0 (X11; U; Linux i686; PL; rv:1.4) Gecko/20030704
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> Hello Ogawa!
>   I've checked twice everything and I've noticed, that problem is
> somewhere else. I should have done that before I've wrote anything to
> bugzilla, it's my fault, sorry.
>   First. Hardware background of the problem. To do the test I used my PC:
> - popular Microstar motherboard 845PE Max2 with Pentium IV 1.7GHz
> - 64MB CompactFlash connected as TrueIDE through CF-25 and IDE25-35
> connectors made by Port80h (http://www.port80h.com.pl/cf25.html,
> http://www.port80h.com.pl/ide35_hdd25.html), once as a slave
> (/dev/hdb) with 60GB Seagate disk as a master, once alone as a master
> (/dev/hdc). Also I was switching on/off BIOS Setup option "Use 32-bit
> transfer mode" - it didn't make any differences. (CF-25 internally is
> something like that: http://213.25.10.65/~newchief/2.6/IDE-CF.gif with
> exception that it can work only in +5V mode, which is acceptable for
> most of compactflash cards).
>   Second. Why I assumed it's FAT module problem:
> - fdisk on both Linux and Windows can see and create partitions properly
> - mkdosfs can create FAT32 filesystem without any warnings (Windows
> create only FAT16, since it has no -F parameter and consequently
> cannot create FAT32 on partition smaller than 512MB)
> - After creating FAT32 filesystem on Linux using mkdosfs -F32 I was
> able to operate it without any problem on Windows98 so I assumed Linux
> can't operate non-standard FAT partition properly. I didn't check
> kernel code, I looked at filesystem internals and I've found only one
> non-standard thing: one sector per cluster (while smallest standard
> cluster is 8 sectors).
> At that point I wrote to bugzilla.
>   Finally. After reading your mail I've checked twice dmesg (you can
> see it here: http://213.25.10.65/~newchief/2.6/dmesg.txt) (how could I
> forget to do that before?) and I've found:
> 
> hdb: max request size: 128KiB
> hdb: 125952 sectors (64 MB) w/1KiB Cache, CHS=246/16/32, BUG
>   hdb:hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: dma_intr: error=0x00 { }
> hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: dma_intr: error=0x00 { }
> hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: dma_intr: error=0x00 { }
> hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: dma_intr: error=0x00 { }
> hda: DMA disabled
> hdb: DMA disabled
> ide0: reset: success
> 
> Gosh! It switched off DMA for both of my HDD! (hda, hdb). I suspect
> Microstars 845PE Max2 MB has problems with DMA, sometimes music on
> xmms (SB Live!) stops for a short while when disk I/O works heavy
> (RedHat9, 2.4.20 kernel with lots of RedHat patches that makes it
> closer to 2.6 line).
> You can also read hdparm -i /dev/hdb output
> (http://213.25.10.65/~newchief/2.6/hdparm-i.txt) and hdparm /dev/hdb
> output (http://213.25.10.65/~newchief/2.6/hdparm.txt), both made while
> using 2.6.0-test7-bk3.
> Maybe TrueIDE protocol of comact flash isn't so true? Anyway, how can
> it work properly on Windows9x then? And why boot sector is accessed
> properly? Why BIOS Setup discovers disk right way (and says it's
> LBA-compatible)?
> I was also able to operate properly this 64MB card with non-PC device
> that is able to operate FAT32 and it worked fine (I've put it in place
> of 2.5'' 20GB HDD that was used by default, again I used CF-25 to do
> that).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
