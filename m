From: Didde Brockman <didde.brockman@illianced.com>
Subject: ADS3GX4R5-E IO problem?
Date: Sat, 20 Oct 2007 14:57:09 +0200
Message-ID: <B22C35D0-A23F-4FBD-9984-0FEC338055DB@illianced.com>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from messaging.illianced.net ([213.115.59.14]:55604 "EHLO
	messaging.illianced.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764616AbXJTNQz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 09:16:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Our company recent purchased a "ADS3GX4R5-E" (SiI 3124) PCI-X port  
multiplier E-SATA card (http://www.addonics.com/products/host_controller/ads3gx4r5-e.asp 
) along with an external 4xSATA chassi supporting port multiplier as  
well.

While Googling I came across your patch and applied it using the  
2.6.23 code base. All seems well until I use "mdadm" to create a RAID  
using the disks attached via the card. After a few minutes in to  
creating the array,  a random disk fails and is marked as "failed  
spare" when checking "/proc/mdstat" or "mdadm --misc --detail /dev/md0".

I have swapped the disks and even swapped the chassi _and_ PCI-X card  
to no avail. During a weak moment I even reverted to an older kernel  
using one of your older patches but this too failed. Using the disks  
one-by-one seems to be working fine; it's when > 1 is in use this will  
occur.

Below you'll find messages from when I attempted to create a simple  
RAID1 using "mdadm". The messages beginning at 13:50:37 simply repeats  
and repeats while "/proc/mdstat" reports a halting of the creation  
process.

Please let me know if there's anything else you wish to see which  
might help. I'm all ears  :)

Thanks for your time.

Oct 20 13:48:34 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:48:34 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:48:34 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:48:34 infra kernel:  sda: sda1
Oct 20 13:48:36 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:48:36 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:48:36 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:48:37 infra kernel:  sda: sda1
Oct 20 13:48:51 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:48:51 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:48:51 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:48:51 infra kernel:  sdb: sdb1
Oct 20 13:48:54 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:48:54 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:48:54 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:48:54 infra kernel:  sdb: sdb1
Oct 20 13:49:00 infra kernel: md: bind<sda1>
Oct 20 13:49:00 infra kernel: md: bind<sdb1>
Oct 20 13:49:00 infra kernel: raid1: raid set md0 active with 2 out of  
2 mirrors
Oct 20 13:49:00 infra kernel: md: resync of RAID array md0
Oct 20 13:49:00 infra kernel: md: minimum _guaranteed_  speed: 1000 KB/ 
sec/disk.
Oct 20 13:49:00 infra kernel: md: using maximum available idle IO  
bandwidth (but not more than 200000 KB/sec) for resync.
Oct 20 13:49:00 infra kernel: md: using 128k window, over a total of  
244195904 blocks.
Oct 20 13:50:37 infra kernel:          res 41/40:00:2e:1c:a1/9d: 
01:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:37 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:37 infra kernel: ata4: EH complete
Oct 20 13:50:37 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:37 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:37 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:37 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:37 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:37 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:37 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:37 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:37 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:37 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:37 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:37 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:41 infra kernel:          res 41/40:00:22:22:a1/df: 
01:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:41 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:41 infra kernel: ata4: EH complete
Oct 20 13:50:41 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:41 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:41 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:41 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:41 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:41 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:41 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:41 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:41 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:41 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:41 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:41 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:44 infra kernel:          res 41/40:00:2e:1c:a1/9d: 
01:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:44 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:44 infra kernel: ata4: EH complete
Oct 20 13:50:44 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:44 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:44 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:44 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:44 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:44 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:44 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:44 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:44 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:44 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:44 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:44 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:47 infra kernel:          res 41/40:80:19:28:a1/0f: 
03:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:47 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:47 infra kernel: ata4: EH complete
Oct 20 13:50:47 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:47 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:47 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:47 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:47 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:47 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:47 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:47 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:47 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:47 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:47 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:47 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:51 infra kernel:          res 41/40:00:2e:1c:a1/0f: 
01:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:51 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:51 infra kernel: ata4: EH complete
Oct 20 13:50:51 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:51 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:51 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:51 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:51 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:51 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:51 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:51 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:51 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:51 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:51 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:51 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:54 infra kernel:          res 41/40:80:19:28:a1/df: 
03:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:54 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:54 infra kernel: ata4: EH complete
Oct 20 13:50:54 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:54 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:54 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:54 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:54 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:54 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:54 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:54 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:54 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:54 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:54 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:54 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:57 infra kernel:          res 41/40:80:02:34:a1/0f: 
01:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:50:57 infra kernel: ata4.00: configured for UDMA/100
Oct 20 13:50:57 infra kernel: ata4: EH complete
Oct 20 13:50:57 infra kernel: sd 3:0:0:0: [sda] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:57 infra kernel: sd 3:0:0:0: [sda] Write Protect is off
Oct 20 13:50:57 infra kernel: sd 3:0:0:0: [sda] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:57 infra kernel: sd 3:1:0:0: [sdb] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:57 infra kernel: sd 3:1:0:0: [sdb] Write Protect is off
Oct 20 13:50:57 infra kernel: sd 3:1:0:0: [sdb] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:57 infra kernel: sd 3:2:0:0: [sdc] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:57 infra kernel: sd 3:2:0:0: [sdc] Write Protect is off
Oct 20 13:50:57 infra kernel: sd 3:2:0:0: [sdc] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:50:57 infra kernel: sd 3:3:0:0: [sdd] 488397168 512-byte  
hardware sectors (250059 MB)
Oct 20 13:50:57 infra kernel: sd 3:3:0:0: [sdd] Write Protect is off
Oct 20 13:50:57 infra kernel: sd 3:3:0:0: [sdd] Write cache: enabled,  
read cache: enabled, doesn't support DPO or FUA
Oct 20 13:51:01 infra kernel:          res 41/40:80:02:34:a1/0f: 
01:00:00:00/40 Emask 0x409 (media error) <F>
Oct 20 13:51:01 infra kernel: ata4.00: configured for UDMA/100


-didde


--
Didde Brockman, Illianced AB
Luntmakargatan 52, 113 58 Stockholm
Tel +46 (0)8 503 131 17
didde.brockman@illianced.com
http://illianced.com/
