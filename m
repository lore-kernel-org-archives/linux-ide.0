From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Mon, 20 Aug 2007 13:56:36 -0600
Message-ID: <DFEB0E31-D017-4527-85A4-8D18D379CB0B@infogears.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com> <46C5E3A6.9020907@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:35130 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbXHTT4i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2007 15:56:38 -0400
In-Reply-To: <46C5E3A6.9020907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

I've taken your advice, reseat-ed and re-cabled everything.  I did  
find one bad drive that I've removed, but sadly I'm still having  
problems.

I've done some more testing that may be able to help you out.

I've tested all 5 WDC drives, they all work.  The problem is I get  
this exception:

ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata6.00: cmd 60/80:00:3f:45:08/00:00:00:00:00/40 tag 0 cdb 0x0 data  
65536 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

It only happens whenever I have any drive in any of the PMP ports.  I  
can have 4 drives in all native ports and they all work great. I've  
tested all of the position/port/disk combinations, so I've eliminated  
the drives as being part of the problem. I can swap any combination  
into the 4 native SATA ports and things work great (that is I can  
setup a RAID10, and create a ext3 fs without any resets).

It doesn't matter if I place the drive in the first or second PMP  
group it still causes a timeout.

On the Norco-1220 block diagram it shows:

Bays
1-4 = Sil3726 #1 - PMP
5   = Sil3726 #1 - Native SATA port
6-9 = Sil3726 #2 - PMP
10  = Sil3726 #2 - Native SATA port
11  = Sil3124 - Native SATA port
12  = Sil3124 - Native SATA port

When I've got disks in ports 5, 10, 11, and 12 thinks work great, if  
any disks are in ports 1-4 or 6-9 I have timeout problems.

I've tried turning down the speed of the PCI-X board, but it doesn't  
have any effect.

I've posted my kernel log at:

http://rusty.devel.infogears.com/silerrors.txt

The interesting thing is when I create the raid with:

echo -n 500000 > /proc/sys/dev/raid/speed_limit_max
mdadm --create /dev/md2 --chunk=128 --level=10 --layout n2 --raid- 
devices=5 /dev/sd{c,d,e,f,g}1
mkfs -t ext3 -b 4096 -m 0 -R stride=16 /dev/md2

It always fails around the same area but not the same exact inode  
table number, with just over 2000 inode tables written its where the  
first error is triggered.  Could this be some point a point of  
inflection where the I/O is no longer hitting the cache, and  
therefore the disk times out since the disk or PMP port can't keep up  
with some built in timer?

I've posted the results of

hdparm -I and smartctl -a for all of the disks at:

http://rusty.devel.infogears.com/disk.info.txt

Thank you for your help,

Rusty
