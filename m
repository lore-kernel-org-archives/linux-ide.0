From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19
Date: Wed, 20 Dec 2006 20:16:18 -0800 (PST)
Message-ID: <20061221041618.12158.qmail@web813.biz.mail.mud.yahoo.com>
References: <429226.30925.qm@web807.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web813.biz.mail.mud.yahoo.com ([209.191.90.86]:23908 "HELO
	web813.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422685AbWLUEQT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Dec 2006 23:16:19 -0500
In-Reply-To: <429226.30925.qm@web807.biz.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--- Bob Stewart <bob@evoria.net> wrote:
> As further data, I have discovered that the problem with the lockups only
> occurs when mkfs.xfs reports that it will create more then 16383 blocks in
> the
> new filesystem.
> 
> Bob

Sorry, that should have been "logblocks".  As shown below, it works unless the
partition is such that logblocks will be larger than 16383.  In fdisk, that
number of cylinders anything greater than 16709.  "Works" is relative, though. 
When doing a copy of several gigabytes, the syslog shows periodic device
errors, which I have posted previously.  Each time, it lowers the access rate
until it eventually reaches PI04.

# mkfs.xfs -f /dev/sda1

meta-data=/dev/sda1              isize=256    agcount=16, agsize=2097109 blks
         =                       sectsz=512   attr=0
data     =                       bsize=4096   blocks=33553744, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal log           bsize=4096   blocks=16383, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0


Here is the fdisk screen for the above disk.  If I use a figure larger than
16709 cylinders mkfs.xfs will not be successful.

Disk /dev/sda: 200.0 GB, 200049647616 bytes
255 heads, 63 sectors/track, 24321 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1       16709   134215011   83  Linux

Bob
