From: "Steven Haigh" <netwiz@crc.id.au>
Subject: Re: Adaptec 1210SA raid issues.
Date: Sat, 14 Aug 2004 11:16:32 +1000 (EST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <64637.210.8.4.34.1092446192.squirrel@210.8.4.34>
References: <002201c4814c$7e1ace00$128b8ecb@enigma>
Reply-To: netwiz@crc.id.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.crc.id.au ([203.142.139.230]:5760 "EHLO zeus.crc.id.au")
	by vger.kernel.org with ESMTP id S267852AbUHNBQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Aug 2004 21:16:50 -0400
In-Reply-To: <002201c4814c$7e1ace00$128b8ecb@enigma>
List-Id: linux-ide@vger.kernel.org
To: Steven Haigh <netwiz@crc.id.au>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Further to this, I have found: http://people.redhat.com/~heinzm/sw/dmraid/

I'm installed the RPM, and re-compiled the kernel after the patches
required (giving me 2.6.7-mm4) compiled dm-mod as a module. I've modprobed
dm-mod so I have:

[root@zeus md]# lsmod
Module                  Size  Used by
dm_mod                 59260  0
<trimmed rest of list>

when looking at dmraid however, I get:
[root@zeus md]# dmraid -r
Failed to find sysfs mount point
Carrying on with /dev/
No Software RAID disks

now, what /dev entries does this actually look for? I have a RAID0 set up
in the BIOS of the 'raid' card. Ideally, I'd like to rescue this so I
don't lose the data on the array.

Is this not supported yet? or have I missed something?

Steven Haigh said:
> Hi all,
>
> Firstly I'm sorry if this has been asked before - I've had a quick skim
> through the archives but with no joy.
>
> I'm just moving away from the Adaptec drivers for the 1210SA SATA RAID
> adapter (urgh at being locked into kernel 2.4.20!) to the sata_sil driver
> -
> and am having much more luck that I have a few months ago when I tried...
>
> It see's the two drives:
>
> [netwiz@zeus netwiz]$ cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
>   Type:   Direct-Access                    ANSI SCSI revision: 05
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
>   Type:   Direct-Access                    ANSI SCSI revision: 05
>
> It sees the correct partition size (via fdisk)
> Disk /dev/sda: 163.9 GB, 163928604672 bytes
> 255 heads, 63 sectors/track, 19929 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
>
>    Device Boot    Start       End    Blocks   Id  System
> /dev/sda1             1     39859 320167386   83  Linux
>
> But I can't mount /dev/sda1... My guessing is that as it's seeing two
> drives, they're not being combined into one volume - however I could be
> completely off base here. Is there something else I need to do?

-- 
Signed,
Steven Haigh

I am root. If you see me laughing, you'd better have a backup.
