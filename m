From: "Buehl, Reiner" <reiner.buehl@hp.com>
Subject: RE: ext3 filesystem corruption on md RAID1 device
Date: Thu, 20 May 2010 11:10:52 +0000
Message-ID: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DDA7@GVW1115EXC.americas.hpqcorp.net>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
 <877hmy264p.fsf@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:17040 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab0ETLMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 07:12:52 -0400
In-Reply-To: <877hmy264p.fsf@openvz.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

Hi Dimitry,

> How does it happen? Do you remember any power failures happened
> previously?

I had no power failures. The first such error appears always approx. 2 minutes after booting the system. This behavior started after I moved the md RAID from two smaller Seagate disks to the currently used 1TB disks. There for my first thought was a failed disk or memory but they seem to be ok based on the SMART and memtest results.

> What mount options do you used? Probably you use default options
> which means that fs was mounted w/o barrier support. Even if was
> mounted
> with barriers, your raid driver may simply ignore it.

I use default options and software raid (mdadm). Does mdadm handle barriers correct?

> Can you please post following info:
> 1) mount options  and cat /proc/mount

/dev/md1        /               ext3            defaults                        01

bilbo:~# cat /proc/mounts 
rootfs / rootfs rw 0 0
none /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
none /proc proc rw,nosuid,nodev,noexec,relatime 0 0
udev /dev tmpfs rw,relatime,size=10240k,mode=755 0 0
/dev/disk/by-uuid/a059fdf2-4ff6-4c30-ba7f-77c85e7f5d1b / ext3 rw,relatime,errors=continue,data=ordered 0 0
tmpfs /lib/init/rw tmpfs rw,nosuid,relatime,mode=755 0 0
usbfs /proc/bus/usb usbfs rw,nosuid,nodev,noexec,relatime 0 0
tmpfs /dev/shm tmpfs rw,nosuid,nodev,relatime 0 0
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000 0 0
/dev/mapper/vg_data-lv_video /video ext3 rw,relatime,errors=continue,data=ordered 0 0
/dev/mapper/vg_data-lv_mpg /video/film/mpg ext3 rw,relatime,errors=continue,data=ordered 0 0
rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs rw,relatime 0 0
automount(pid3007) /mnt/auto autofs rw,relatime,fd=4,pgrp=3007,timeout=120,minproto=2,maxproto=4,indirect 0 0
automount(pid2964) /mnt/usb autofs rw,relatime,fd=4,pgrp=2964,timeout=2,minproto=2,maxproto=4,indirect 0 0
automount(pid3062) /net autofs rw,relatime,fd=4,pgrp=3062,timeout=300,minproto=2,maxproto=4,indirect 0 0
nfsd /proc/fs/nfsd nfsd rw,relatime 0 0


> 2) Write something to your fs and sync;
>    like follows "echo test > /path_to_your_mnt/test ; sync"

Done.

> 3) dmesg log after stage(2)

Nothing got written to dmesg during step 2.

I currently have 2 of the EXT3-fs errors in dmesg but writing and syncing did not produce another one. 

Best regards,
Reiner.
