From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ext3 filesystem corruption on md RAID1 device
Date: Thu, 20 May 2010 22:40:25 -0600
Message-ID: <4BF60EB9.3090607@gmail.com>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Buehl, Reiner" <reiner.buehl@hp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 05/20/2010 04:08 AM, Buehl, Reiner wrote:
> Hi,
>
> I keep getting ext3 filesystem corruptions on one of my md RAID1 arrays. Shortly after booting, I get messages like the following one:
>
> EXT3-fs error (device md1): htree_dirblock_to_tree: bad entry in directory #17269110: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
>
> This forces an automatic fsck at the next reboot that fails. The manual fsck.ext3 -y /dev/md1 takes a long time but manages to get a clean FS again. After the reboot, it takes just a few minutes until the first of these messages appear again.
>
> The two disks used in the RAID1 md device are both Seagate ST31000528AS that show no errors in long and short SMART test and Seatools. Memtest shows no memory problems. Two other RAID1 systems connected to the same Intel Ibex Peak 6 port SATA AHCI Controller (rev 06) show no such problems. A RAID5 with 4 Seagate ST3750640AS on a Promise PDC40718 (SATA 300 TX4) also works without problems in the same system.
>
> I saw that sata_sil.c has a blacklist that includes mainly Seagate drives but do not know if this is related to my problem since I my system uses an Intel SATA controller.

No, that blacklist relates to problems with the combinations of those 
older Seagate drives and Silicon Image 311x controllers.
