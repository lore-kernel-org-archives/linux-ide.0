From: Linda Walsh <lkml@tlinx.org>
Subject: Port Multiplier access with Sil 3124
Date: Sun, 08 Feb 2009 12:38:14 -0800
Message-ID: <498F42B6.8030607@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:32776 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449AbZBHVIs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Feb 2009 16:08:48 -0500
Received: from [192.168.3.11] (Athena [192.168.3.11])
	by ishtar.tlinx.org (8.14.1/8.12.10/SuSE Linux 0.7) with ESMTP id n18KcFvO015676
	for <linux-ide@vger.kernel.org>; Sun, 8 Feb 2009 12:38:15 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Is there something different, from normal disk-access, that I need to do
to access hard disks beyond '1', on a port-multiplier?

I thought I remembered reading the port multiplier support was
working for many SATA and SATA RAID controller capable chipsets,
including the Sil 3124.

I picked up a 2-Bay external SATA enclosure that I'm trying to access in
(what I thought) was the simplest mode: "JBOD".  However, when I boot,
I am only seeing the first hard disk.

Experimenting, I tried a single hard disk in both positions -- one
position let me see the disk directly (as though it was a direct,
str8-thru connection), the other position showed up detected by
the boot BIOS as a 7MB HD by some unrecognized vendor.   In
linux, I'm able to access and use the hard disk when it appears
'str8-thru', but linux sees nothing concerning the 7MB pseudo HD.

Is my expectation that the driver would simply recognize the
external enclosure by whatever I had the external enclosure set to,
too optimistic?  Do I need to run some special util to setup the disks in
JBOD mode?  I guess I thought I only needed to worry about
'special utils' if I was using the disk-pair in a RAID config (0/1)...

It seems there should be a linux util to manage the "container",
'sil57xx'  --  I take it is not used for RAID-only config?

My ultimate aim is to use it in a RAID-0, mirror config (my luck
with SATA disk drives has been abysmal, of late (*sigh*)).

Anyone with any real-world experience about when the 3Gb SAS
starts to become a bottleneck?  I know that theoretically, it could
support a hair over 350MB/s if there was no overhead, which would
reliably only support 2 hard disks at full speed (assuming ~120MB/s
max linear read speed/disk).  Does that jive with people's real-world 
experience?  I.e. port-multipliers can provide full throughput for
2-HD's but not likely 3? 

Should I be looking for an sil57xx program somewhere (the box contained
a mini-CD, but it looks like a driver for an older kernel (2.6.9).  Not 
so sure about it's usefulness in my setup.

Thanks,
-linda

