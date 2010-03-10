From: Tejun Heo <tj@kernel.org>
Subject: Re: Comment on ATA 4 KiB sector issues
Date: Wed, 10 Mar 2010 17:33:32 +0900
Message-ID: <4B97595C.7010104@kernel.org>
References: <Pine.GSO.4.63.1003080933100.4114@galaxy.agh.edu.pl> <4B95AEF6.8030906@kernel.org> <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl> <4B97323E.1040807@kernel.org> <Pine.GSO.4.63.1003100853360.21647@galaxy.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58807 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab0CJIdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2010 03:33:38 -0500
In-Reply-To: <Pine.GSO.4.63.1003100853360.21647@galaxy.agh.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Palac <palac@uci.agh.edu.pl>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/10/2010 05:15 PM, Tomasz Palac wrote:
>> Yes, the geometry is basically arbitrary values which can be queried
>> using a BIOS call and the reason why SCSI hosts can choose them is
>> they implement BIOS extensions themselves.
> 
> I mentioned SCSI host adapters to show that 64/32 geometry is no problem
> for Linux (and other OS-es). Really is 255/63 hardcoded in many places?

For starters, on some mobos I have, I can't change the reported
geometry.

>>> If not, then geometry can be read from partition table.
>>
>> From where?
> 
>> From the ending CHS values of partition if it ends at cylinder boundary.
> How do you calculate geometry from newer Windows partition tables (cases
> W-1, W-2 and W-3)?

By solving the equations matching CHSs and LBAs.  It only works if the
first partition ends before the CHS address limit (2 variables to
solve for so we need 2 different equations).

>> For modern OSes, geometry doesn't matter at all.  Older ones are the
>> ones having problems (I've been corrected: XP seems okay while 2000
>> depends on CHS).
> 
> You are proposing "doing what Windows is doing". This way:
> 
> 1. Partitions are aligned at 1 MiB (which is very good).
> 2. Geometry is "standard", i.e. 255/63 (which is good).
> 3. Partitions don't start and end at cylinder boundary (which is not so
>    good).
> 
> With 64/32 you can have:
> 
> 1. Partitions aligned at 1 MiB.
> 2. Geometry is not standard, but is widely used (SCSI disks, USB flash
>    disks).
> 3. Partitions start and end at cylinder boundary.

2 and 3 are meaningful iff the users agree on using that specific
geometry.  W/o any reliable way to communicate that custom geometry to
other users of the partition table, 2 and 3 virtually don't exist.
Partitioner partitions according to 64/32, BIOS reports 63/255.  It's
just broken.

We can feed 64/32 or whatever geometry to partitioners to trick them
into beliving certain geometry so that the end result is aligned in
certain way but that works only if the users of the partition table
don't care about CHS addresses in the partition table at all (most
modern ones don't).  The only reason we're talking about geometry is
for compatibility w/ older operating systems.  So, at this point,
diddling with geometry just doesn't make any sense at all.

Thanks.

-- 
tejun
