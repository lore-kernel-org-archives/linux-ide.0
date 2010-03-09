From: Tomasz Palac <palac@uci.agh.edu.pl>
Subject: Re: Comment on ATA 4 KiB sector issues
Date: Tue, 9 Mar 2010 10:22:39 +0100 (CET)
Message-ID: <Pine.GSO.4.63.1003090947570.29136@galaxy.agh.edu.pl>
References: <Pine.GSO.4.63.1003080933100.4114@galaxy.agh.edu.pl>
 <4B95AEF6.8030906@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galaxy.agh.edu.pl ([149.156.96.9]:42470 "EHLO galaxy.agh.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab0CIJmt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Mar 2010 04:42:49 -0500
In-Reply-To: <4B95AEF6.8030906@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Tue, 9 Mar 2010, Tejun Heo wrote:

> Hello,
>
> I prefer if linux-ide@vger.kernel.org is cc'd so if you're okay with
> it, please add cc when you reply.

OK.

> On 03/08/2010 05:53 PM, Tomasz Palac wrote:
>> I've read your document on ATA 4 KiB sector issues and I have a simple
>> solution for partitioning 4 KiB physical/512 B logical drives with no
>> offset.
>>
>> I use geometry of 64 heads and 32 (logical) sectors. This way cylinder
>> is exactly 1 MiB. First partition starts at 2nd cylinder and is aligned
>> at 1 MiB. Other primary partition are aligned at 1 MiB too. If one of
>> them is extended partition, then logical partitions within it will be
>> aligned at 16 KiB (32 logical sectors).
>>
>> This scheme can be applied to SSDs, with the exception of logical
>> partitions (16 KiB alignment will probably not be enough).
>>
>> I don't know if older Windows will accept such partitioning scheme, but
>> if it uses CHS values, then it should.
>
> Well, the thing is that there is no way to reliably communicate those
> geometry values and 255*63 is hardcoded everywhere.  The only way you
> can deduce the geometry is by solving equation with the CHS address
> and LBA in the partition table but for that to work the first
> partition should end before CHS limit.

This limit is 8 GiB and there is no problem with first partitions 
extending beyond that. This is because such partitions are described in 
partition table as ending at 1023/255/63 (or something like that). Real 
size of partition is specified by LBA values.

> Using custom geometry is a good way to trick a partitioner which
> partitions based on CHS alignment to align to larger units but it
> isn't meaningful outside of that.  If CHS dosen't follow 255*63, a lot
> of code (firmware, BIOS, boot loader, OS...) will just assume CHS is
> incorrect.

As of firmware, Large Disk Howto states that a lot of SCSI host adapters 
are using 64/32 geometry (at least for disks smaller than 8 GiB). If BIOS 
supports EDD (INT13h Extensions), then disk geometry is irrelevant. If 
not, then geometry can be read from partition table. The only problem with 
64/32 geometry is 1 GiB (as opposed to 8 GiB) limit for boot partition 
(without using EDD). The same applies to boot loaders. Modern OSes don't 
use CHS.

-- 
Tomasz Palac, AGH University of Science and Technology
