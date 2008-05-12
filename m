From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.24.*/2.6.25.*: attempt to access beyond end of device
Date: Mon, 12 May 2008 06:31:55 -0400
Message-ID: <200805120631.55917.gene.heskett@verizon.net>
References: <4827D626.50903@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:35441 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760088AbYELKcJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 May 2008 06:32:09 -0400
Received: from coyote.coyote.den ([72.65.72.129]) by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K0R006OO3SG6H82@vms173003.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 12 May 2008 05:29:05 -0500 (CDT)
In-reply-to: <4827D626.50903@aon.at>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-ide@vger.kernel.org

On Monday 12 May 2008, Peter Klotz wrote:
>I compiled several kernel.org kernels (2.6.24.3, 2.6.24.7, 2.6.25.1,
>2.6.25.3) but when booting them up the following messages appear:
>
>  attempt to access beyond end of device
>  sda: rw=0, want=273956253, limit=268435455
>  Buffer I/O error on device sda3, logical block 39085952
>  attempt to access beyond end of device
>  sda: rw=0, want=273956254, limit=268435455
>  Buffer I/O error on device sda3, logical block 39085953
>  attempt to access beyond end of device
>...
>  attempt to access beyond end of device
>  sda: rw=0, want=273956255, limit=268435455
>  attempt to access beyond end of device
>  sda: rw=0, want=273956256, limit=268435455
>  attempt to access beyond end of device
>
>
>There is no problem when using the supplied kernel of Ubuntu 8.04
>(2.6.24-16.30).
>
>I tracked the problem down to this difference in the dmesg output of the
>bootup sequences:
>
>2.6.24-16.30 (Ubuntu 8.04):
>
>  ata1.00: HPA unlocked: 268435455 -> 312581808, native 312581808
>  ata1.00: ATA-8: SAMSUNG HM160HC, LQ100-10, max UDMA/100
>  ata1.00: 312581808 sectors, multi 16: LBA48
>
>2.6.24.7:
>
>  ata1.00: HPA detected: current 268435455, native 312581808
>  ata1.00: ATA-8: SAMSUNG HM160HC, LQ100-10, max UDMA/100
>  ata1.00: 268435455 sectors, multi 16: LBA48
>
>
>The HDD is 160GB in size, so 312581808 sectors seem much more logical
>than 268435455 sectors. It seems that kernel.org kernels limit the HDD
>to 128GiB.
>
Not so. All of my drives are larger than that, with a sata sdc of 400GB that 
dmesg reports as:
[    8.103237] ata4.00: ATA-7: Hitachi HDT725040VLA360, V5COA7EA, max UDMA/133
[    8.103241] ata4.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    8.118762] ata4.00: configured for UDMA/100
[    8.118871] scsi 3:0:0:0: Direct-Access     ATA      Hitachi HDT72504 V5CO PQ: 0 ANSI: 5
[    8.118953] sd 3:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
[    8.118970] sd 3:0:0:0: [sdc] Write Protect is off
[    8.118973] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    8.118997] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.119053] sd 3:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)

I've never seen this error here, and I've built everything recently but 24.7.
I only keep .25 and later stuff although there may be some leftovers in /boot
I haven't removed.  My latest in the .24 series in .6, and it didn't do that.
Perhaps you don't have all the big file stuff enabled in your .config?
Running 2.6.26-rc1 ATM here.

>Here the "fdisk -l" output:
>
>  user@centrino:~$ sudo fdisk -l /dev/sda
>
>  Disk /dev/sda: 160.0 GB, 160041885696 bytes
>  255 heads, 63 sectors/track, 19457 cylinders
>  Units = cylinders of 16065 * 512 = 8225280 bytes
>  Disk identifier: 0x0008e799
>
>     Device Boot      Start         End      Blocks   Id  System
>  /dev/sda1   *           1          31      248976   83  Linux
>  /dev/sda2              32       14620   117186142+  83  Linux
>  /dev/sda3           14621       17053    19543072+   7  HPFS/NTFS
>
>I may have been lucky up to now because I only use partitions sda1 and
>sda2 on this drive.
>
>Any help regarding this issue is appreciated.
>
>Please CC me since I am no list member.
>
>Best regards, Peter.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
stop bit received
