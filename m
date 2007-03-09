From: "Guido Diepen" <guido@jcwodan.nl>
Subject: Re: Again problems with PDC20268 and vol_id
Date: Fri, 9 Mar 2007 17:51:25 +0100 (CET)
Message-ID: <2144.131.211.80.61.1173459085.squirrel@hammerhead.dyndns.org>
References: <4964.131.211.80.61.1173446203.squirrel@hammerhead.dyndns.org>
	<20070309190856.c86efd73.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070309190856.c86efd73.vsu@altlinux.ru>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-hotplug-devel>
List-Post: <mailto:linux-hotplug-devel@lists.sourceforge.net>
List-Help: <mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-hotplug-devel>,
	<mailto:linux-hotplug-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-hotplug-devel-bounces@lists.sourceforge.net
Errors-To: linux-hotplug-devel-bounces@lists.sourceforge.net
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-ide@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org


Sergey Vlasov wrote:
>
> However, that value is important - together with the kernel messages
> printed during detection of drivers.  Most likely the sector number is
> out of range for your disk, and the disk replies to such access with
> the SectorIdNotFound error.

Unfortunately it means I will have to crash my system once more :) I will
do that this weekend, after unmounting everything.

>
> Just provide the full dmesg output if you are unsure which lines are
> relevant for the problem.

Relevant dmesg output:
...
Probing IDE interface ide3...
hdg: Maxtor 4G120J6, ATA DISK drive
...
hdg: max request size: 512KiB
hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(100)
hdg: cache flushes not supported
 hdg: hdg1 hdg2




>
> Please provide also the "fdisk -l -u /dev/hdg" output.

cartman:/home/guido# fdisk -l -u /dev/hdg

Disk /dev/hdg: 122.9 GB, 122942324736 bytes
16 heads, 63 sectors/track, 238216 cylinders, total 240121728 sectors
Units = sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdg1   *          63   120060863    60030400+  83  Linux
/dev/hdg2       120060896   240121759    60030432   83  Linux


>
> Is the partition table correct?  Maybe the partition extends beyond
> the end of physical disk for some reason, and when the kernel tries to
> access last blocks of the partition, it actually tries to read sectors
> beyond the actual drive capacity, which fails and exposes broken error
> handling in the Promise IDE driver.

I don't know how to verify that the partition table is correct, hopefully
you can extract this from the supplied data. (If partition table is not
correct, would I be able to update that dynamically, or must I move all
data to different disks, reset the partition table and copy data back?)


>
> I have added the linux-ide mailing list to Cc: - problems related to
> IDE/ATA drivers (both old IDE, which you are using currently, and
> newer libata) should be discussed there.
>
>> I started looking more into the problem and found out that the vol_id
>> program would only crash IF it was looking for raid. If I rain the
>> vol_id
>> program with the option --skip-raid, everything worked flawless.
>
> With --skip-raid vol_id does not look for Linux software RAID
> superblocks, which are located at the end of device.

Ok, now that part is clear to me also :)

Hope you have enough of info with this, if not, I can crash my system this
weekend again and supply you with more relevant data :)

Regards,

Guido Diepen




-- 
Aviation is proof that given the will, we have the capacity to achieve
the impossible.
          --Eddie Rickenbacker



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
