From: Tejun Heo <tj@kernel.org>
Subject: Re: Infrequent soft reset of ata for silicon image 3512 cards
Date: Fri, 01 Aug 2008 13:14:40 +0900
Message-ID: <48928DB0.7050802@kernel.org>
References: <3fb94e50807110229l18def5fbjadf7af9d6f9943d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57749 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbYHAEPK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 00:15:10 -0400
In-Reply-To: <3fb94e50807110229l18def5fbjadf7af9d6f9943d9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org

Sagar Borikar wrote:
> I hope this is the right list for following questions if not please
> direct me to the correct one.
> 
> Currently  I am working with NAS box which has following configuration:
> 
> MIPS arch
> 2.6.18 kernel - comparatively older but box is in production

Ah... it's a bit too old at this point.

> 128 MB RAM
> sil 3512 SATA controller
> xfs file system
> 
> When performing the iozone stress test of the box over CIFS, NFS
> simultaneously, I find that the ata port gets soft reset once in 5-8
> hours and because of which the the continuous write activity gets
> stalled on the drives. All the smbd processes which are writing data
> to the disk goes into uninterruptilbe sleep state continuosuly and the
> test doesn't complete.
> 
> Following is the log that I get :
> 
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: configured for UDMA/100
> ata1: EH complete
> SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
> sda: Write Protect is off
> SCSI device sda: drive cache: write back

These only report the actions took by EH to recover from an error
condition.  Is there any message before this?

> After this, I start getting errors from file system :
> 
> can't seek in filesystem at bb 10686861057857128
> can't read btree block 1630685585/1000141
> can't seek in filesystem at bb 8951363201349912
> can't read btree block 1365869628/911139
> can't seek in filesystem at bb 5768064121399776
> can't read btree block 880136736/1043772
> 
> Which looks like filesystem is trying to read the block  which is not
> present in the partition.
> and because of which device driver cribs that it is trying to access
> the data beyond end of the device.
> 
> So I guess there is filesystem corruption too which can be solved
> independently but ata1 getting soft reset under load is something
> strange. Has anyone observed this before with silicon image 3512
> cards?

Yeah, it looks like fs corruption.  There have been a few reports of
data corruption on 3512 when combined with certain chipsets but they
didn't involve time outs or any other error conditions.

One common way to trigger data corruption is to briefly disconnect power
and reapply it.  All the data in the cache will get lost and the driver
has no way whether it lost any data or not, so all hell breaks loose.
Similar situations do occur on running systems if the power supply can't
maintain voltage for whatever reason.  Things like this usually occur
when a harddrive is plugged in (as the new one sucks in power to spin
up, existing ones suffer voltage drop) but I've seen it happening
without such event under heavy IO load.

Ruling it out is easy.  Just prepare a separate power supply and connect
the harddrive (only the harddrive) to it and see whether the problem
disappears.  You can power up an ATX PSU w/o motherboard easily.

  http://modtown.co.uk/mt/article2.php?id=psumod

-- 
tejun
