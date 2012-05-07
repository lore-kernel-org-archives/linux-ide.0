From: Daniel Pocock <daniel@pocock.com.au>
Subject: Re: very slow write to AHCI device
Date: Mon, 07 May 2012 20:11:51 +0200
Message-ID: <4FA81067.80607@pocock.com.au>
References: <4FA7F563.4040708@pocock.com.au> <4FA81009.1030308@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.trendhosting.net ([195.8.117.5]:59991 "EHLO
	mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab2EGSMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2012 14:12:05 -0400
In-Reply-To: <4FA81009.1030308@fold.natur.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-ide@vger.kernel.org

On 07/05/12 20:10, Martin Mokrejs wrote:
> Hi Daniel,
>
> Daniel Pocock wrote:
>   
>>
>> Hi,
>>
>> I'm testing a problem with the following combination:
>> - SB700/SB800 type controller in AHCI mode (in a HP Microserver N36L)
>> - Seagate Barracuda 1TB 7k2 drive with NCQ
>>     
> Is that a disk with 4k hardware sectors (Advanced Format)? Where does
> you partition start? At sector 63 or 2048? ;-)
>
>   
At 2048:

Disk /dev/sdb: 1000.2 GB, 1000204886016 bytes
255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x484d5754

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1   *        2048      499711      248832   83  Linux
Partition 1 does not end on cylinder boundary.
/dev/sdb2          499712  1953523711   976512000   fd  Linux raid
autodetect





>> I've got a fresh 256MB partition, formatted ext4, mounted
>> barrier=1,data=ordered, write-cache enabled (hdparm -W 1 /dev/sdb) and
>> shared over NFS.
>>
>> When the NFS client writes,
>> - unpacking a source tarball, many small files, iostat reports speeds
>> under 500kBytes/sec
>> - dd conv=fsync, iostat reports about 50MB/sec
>>
>> If I set up a USB disk on the same box, with a partition formatted
>> exactly the same way, the iostat reports the write speed (unpacking the
>> same tarball) is over 5MBytes/sec - not so fast, but 10 times faster
>> than the AHCI device.
>>     
> So USB is at speed 10 times less, right?
>
>   

No - the USB is 10x faster, 5MBytes/sec, the SATA disk is giving me
barely 500kBytes/sec for the same write over NFS

> Martin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

