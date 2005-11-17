From: "James O. Rose, III" <james.o.rose@gmail.com>
Subject: Re: sata_sil24 test support
Date: Wed, 16 Nov 2005 23:51:30 -0600
Message-ID: <200511162351.30872.james.o.rose@gmail.com>
References: <46377.137.32.101.32.1132172329.squirrel@www.stubbornroses.com> <437C0F2D.1000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf23.cluster1.charter.net ([209.225.28.223]:27073 "EHLO
	mxsf23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932481AbVKQFvg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Nov 2005 00:51:36 -0500
Received: from mxip20a.cluster1.charter.net (mxip20a.cluster1.charter.net [209.225.28.150])
	by mxsf23.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id jAH5pWPq024358
	for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 00:51:34 -0500
In-Reply-To: <437C0F2D.1000406@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 16 November 2005 11:03 pm, you wrote:

I'm keeping this mail intact for reference on linux-ide.

> James Rose wrote:
> > Mr. Heo:
> > 
> > I have a couple of questions regarding the sata_sil24 driver, and 
I would
> > also like to offer up some test support.
> > 
> > I'm by no means any kind of kernel hacker and only have a 
rudimentary
> > understanding of C at best, so I can't provide any code help.  I 
am
> > interested in running whatever tests you think could help you with 
the
> > driver development.  This box is basically not doing anything, so 
I can
> > run automated testing for days at a time.
> > 
> > Here's my h/w specs:
> > --------------------
> > Intel SE7620AF2 Motherboard
> > Dual XEON 3.2 GHz with HyperThreading
> > 4 Gig Memory
> > Silicon Image 3124
> > Silicon Image 3132
> > Rancho Technologies MiniStor 3 (Silicon Image 3726 Port Multiplier 
Chip)
> > with 4 100GB Hitachi Travelstar SATA Drives
> > SteelVine 2000 (Silicon Image 3726 Port Port Multiplier Chip) with 
5 400GB
> > Hitachi SATA Drives
> > Various External 500G SATA2 Drives
> > 
> > NOTE: All the hard drives are essentially blank, and can be set up 
as
> > RAID/LVM/Whatever, on a per test basis.
> > 
> > Here's my s/w specs:
> > --------------------
> > kernel 2.6.15rc1-netdev
> > Debian Sarge for x86 (with udev v0.056-3) [I'm working on getting 
64 bit
> > working as well, I'm just not there yet].
> > 
> > I regret I'm unable to provide any kind of shell access (corporate
> > firewall), but I will happily run whatever you think can help.  
I'm very
> > interested in seeing a fully functional (if it already is, my 
apologies. 
> > I need to figure out some stuff still) driver released into the 
kernel.
> > 
> > I'll happily provide lspci's, .configs, etc. upon request.
> 
> One thing I wanna verify on sil24 is data integrity with multiple 
disks 
> attached.  It would be very helpful if you can do some parallel data 
> stress testing with multiple disks.
> 
> * Parallel 'badblocks -w -t random' on all attached disks.  Maybe 
repeat 
> it for a few days and verify no corrupted IO occurs.
> 
> * Create a random 2G or 4G file on a disk (dd if=/dev/urandom 
> of=testfile bs=1M count=4K) and parallely fill all disks with the 
file 
> (for ((i=0;i<20;i++)); do cp testfile /mnt/sdx/testfile$i; done).  
After 
> disks are filled, calculate md5sum of all copies and verify that 
they 
> haven't corrupted.  Repeat for a few days.
> 

Thanks for getting back to me on this.  I'll try to set something up 
tomorrow.  BTW, is there any particular filesystem you'd prefer I 
test on (at least initially)?  I've currently got ext3 compiled in, 
but I can reconfigure to whatever.  I'll send results as I get them.

> > 
> > One Problem:
> > ------------
> > I am able to see the first drive on each of the port multipliers, 
but I
> > cannot seem to find a way to locate the other drives.  Is there an 
option
> > I can pass through modprobe, or some other kind of magic?
> 
> Unfortunately, port multiplier support is not implemented yet.  
Edward 
> Falk (CC'd above, Hi! Edward) used to work on PM support for sil24 a 
> while ago and might be able to help you out.
> 

Depressing news.  I'm willing to do what I can to help someone out 
with this.

> > If I should have sent this to someone else, please forward this 
along.  I
> > didn't know if this was appropriate for me to send to the LKML, so 
I sent
> > it to you instead (apologies if I was mistaken).  Please let me 
know what
> > I can (or can't) do.
> 
> If you have certain requests/questions regarding SATA in general or 
> specific SATA driver in particular, write a mail TO the maintainer 
and 
> CC linux-ide@vger.kernel.org.  And your mail is completely 
appropriate 
> for linux-ide.
> 

will do

> -- 
> tejun
> 
Regards,

James Rose
