From: "Steven Haigh" <netwiz@crc.id.au>
Subject: Re: Adaptec 1210SA raid issues.
Date: Sun, 15 Aug 2004 15:11:00 +1000 (EST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <44231.210.8.4.34.1092546660.squirrel@210.8.4.34>
References: <002201c4814c$7e1ace00$128b8ecb@enigma>
    <64637.210.8.4.34.1092446192.squirrel@210.8.4.34>
Reply-To: netwiz@crc.id.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.crc.id.au ([203.142.139.230]:28803 "EHLO zeus.crc.id.au")
	by vger.kernel.org with ESMTP id S266498AbUHOFLF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 01:11:05 -0400
Received: from zeus.crc.id.au (localhost.localdomain [127.0.0.1])
	by zeus.crc.id.au (8.12.10/8.12.10) with ESMTP id i7F5B0p8013267
	for <linux-ide@vger.kernel.org>; Sun, 15 Aug 2004 15:11:00 +1000
In-Reply-To: <64637.210.8.4.34.1092446192.squirrel@210.8.4.34>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Not much more progress playing with this... I know it's software based,
but I guess what I'm trying to do is to import/convert the adaptec 'raid'
partition into to something I can access as a usable partition/raid.

It's a raid 0 - however as it's laid out on the disks at the moment, I
don't believe I can use the kernel raid to mount/recover/convert/anything
to it.

[root@zeus root]# fdisk /dev/sda
Command (m for help): p

Disk /dev/sda: 163.9 GB, 163928604672 bytes
255 heads, 63 sectors/track, 19929 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1     39859 320167386   83  Linux

Command (m for help): q

[root@zeus root]# fdisk /dev/sdb
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF
disklabel
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.

Warning: invalid flag 0x0000 of partition table 4 will be corrected by
w(rite)

Command (m for help): p

Disk /dev/sdb: 163.9 GB, 163928604672 bytes
255 heads, 63 sectors/track, 19929 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System

Command (m for help): q

As you can see, SATA disk 1 has a partition that shows as disk size x 2,
however disk 2 shows as an invalid partition...

With the existing tools, is there a way to make this usable? or is the
only way to set this up to copy the data off using the Adaptec module, and
create a new software raid with the kernel raid?

-- 
Signed,
Steven Haigh

I am root. If you see me laughing, you'd better have a backup.
