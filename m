From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: siimage and two nics
Date: Sat, 27 Dec 2003 00:24:59 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FECD15B.1010004@clanhk.org>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org> <20031226195705.B4045@nettis.grimsta> <3FEBAFA5.8020604@clanhk.org> <20031226232826.A7057@nettis.grimsta> <3FEBCA3C.5000803@clanhk.org> <20031227083050.A8631@nettis.grimsta>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:48306 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S264545AbTL0S3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Dec 2003 13:29:52 -0500
In-Reply-To: <20031227083050.A8631@nettis.grimsta>
List-Id: linux-ide@vger.kernel.org
To: Daniel Brahneborg <daniel.com@wtnord.net>
Cc: linux-ide@vger.kernel.org

Daniel Brahneborg wrote:

>On Fri, Dec 26, 2003 at 05:42:20AM +0000, J. Ryan Earl wrote:
>  
>
>What matters is that I still want to be able to access the small
>IDE drive I have on the PATA connector.
>  
>
That should not be a problem.  If you build the via82cxxx into the 
kernel and use siimage as a module, the two sata drives should be hde 
and hdg, but you could build the siimage into the kernel and boot of the 
RAID if you wanted too.  Note, starting at A, every other hdX (ie hda, 
hdc, hde, hdg,...) will be a primary mastery.  Starting at B, every 
other hdX is a slave (hdb, hdd, hdf,...).  That's just the way the IDE 
layer handles names.  SATA doesn't have any slaves, it's all 1 disk per 
channel, point-to-point link, so you'll never see any of the "slave" 
harddrive names on a sata drive.  Check the dmesg and ls /proc/ide && 
cat /proc/hdX/model to see what your harddrives have been mapped to.  
Then setup your raidtab, fstab, and bootloader appropraitely.

>  
>
>>>Checking... oh, it's 1.06 in Linus 2.4.23 kernel.  The diff
>>>doesn't seem to be very much, just a check for 3114 and a fix
>>>for Seagate drives.
>>>      
>>>
>>Have you considered 2.6?
>>    
>>
>
>I tested it for a while, but had some problems with it.  I'll
>try it again and see if it makes any difference.
>  
>
I suggest the -mm tree, it includes all the patches for the siimage 
driver, plus many more.  It has been stable in my testing.

>How do I find out what happens with the PATA disk when I load the
>siimage module?
>  
>
See above.

>Btw, what speed should I be able to get with the siimage module?
>  
>
You have to consider I'm using WD360GD "Raptors" and not whatever drive 
you have.  I get 35-55 MB/sec sequential read/write throughput on a 
single disk.  I tested RAID0 and RAID1 on the siimage 3112A (btw A = 
revision 2).  In RAID0, I'm getting about 75MB/sec sequential read/write 
performance (Testbed = AthlonXP 1800 1.53Ghz, 512MB CL2 DDR).  I've seen 
others using this disk off their Southbridge--no 32bit/33MHz PCI 
bottleneck--get 100MB/sec on these with RAID0.  I think bus-speed 
somehow affects RAID0 performance especially with 16MB of coolective 
cache on the RAID drives.  RAID1 looks a lot better though.  I get 
~50MB/sec write--essentially the same as with one disk and in agreement 
with manufacturer's performance claims.  Remember it's writing to both 
disks at once, so really 100MB/s is going across the 133MB/s PCI bus.  A 
single sequential read tops out around 55MB/sec.  However, I can sustain 
2 parallel sequential reads, both at ~50MB/s so I get an aggregate of 
100+MB/s sequential read throughput with RAID1-mirroring.  
Unfortunately, RAID0 also slightly lowered the average number of seeks 
per interval while raising the avereage seek time over a single 
non-RAID'd disk.  RAID1, on the otherhand, increased the average number 
of seeks per interval by 80% over one disk (roughly ~200 seeks/s to 360 
seeks/s) and it lowered avereage seek time 10-50% on reads.  Hello 
database that's answers queries that are 70% SELECT statements.

RAID1 is absolutely perfect for my needs, this will dramatically 
increase my I/O capabilities .  I can't quote you any RAID5 results. 

-ryan

