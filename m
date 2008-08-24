From: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Subject: Problems with ALPM on devices part of raid array
Date: Sun, 24 Aug 2008 18:20:00 +0300
Message-ID: <48B17C20.7020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:6689 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYHXPUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Aug 2008 11:20:05 -0400
Received: by nf-out-0910.google.com with SMTP id d3so559030nfc.21
        for <linux-ide@vger.kernel.org>; Sun, 24 Aug 2008 08:20:03 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi,

I have an AHCI capable chipset now (ICH10), so I tried ALPM[*], by 
echo-ing min_power to:
./class/scsi_host/host0/link_power_management_policy
./class/scsi_host/host5/link_power_management_policy

The 6 SATA2 drives have 3 partitions each, partition 1 is RAID1, 
partition 3 is RAID10.

This soon caused me troubles, as the kernel gave I/O error messages, and 
unmounted my filesystems running
on /dev/md4 (raid10 array). Unfortunately I don't have those messages 
saved to my logs, because my /var filesystem got automatically unmounted.
I had no choice but to reboot, and then md kicked 4 drives out of the 
md4 array (6 total drives), and then refused
to assemble (too few drives). The RAID1 array (md3) got reassembled, and 
resynced successfully.
I had to force the assembly of /dev/md4 [and encountered a mdadm bug 
while doing so: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=496334]

I think ALPM should refuse to set link pm if the device is part of a 
raid array, or the md driver should be aware
of ALPM, and wait a little longer for the device to come back online.
Mentioning this problem somewhere in the sources/docs would be nice.

System info:
Linux debian 2.6.26-1-amd64 #1 SMP Wed Aug 20 12:09:32 UTC 2008 x86_64 
GNU/Linux
0:00.0 Host bridge: Intel Corporation Eaglelake DRAM Controller (rev 02)
00:01.0 PCI bridge: Intel Corporation Eaglelake PCI Express Root Port 
(rev 02)
00:1a.0 USB Controller: Intel Corporation ICH10 USB UHCI Controller #4
00:1a.1 USB Controller: Intel Corporation ICH10 USB UHCI Controller #5
00:1a.2 USB Controller: Intel Corporation ICH10 USB UHCI Controller #6
00:1a.7 USB Controller: Intel Corporation ICH10 USB2 EHCI Controller #2
00:1b.0 Audio device: Intel Corporation ICH10 HD Audio Controller
00:1c.0 PCI bridge: Intel Corporation ICH10 PCI Express Port 1
00:1c.2 PCI bridge: Intel Corporation ICH10 PCI Express Port 3
00:1c.3 PCI bridge: Intel Corporation ICH10 PCI Express Port 4
00:1c.4 PCI bridge: Intel Corporation ICH10 PCI Express Port 5
00:1c.5 PCI bridge: Intel Corporation ICH10 PCI Express Port 6
00:1d.0 USB Controller: Intel Corporation ICH10 USB UHCI Controller #1
00:1d.1 USB Controller: Intel Corporation ICH10 USB UHCI Controller #2
00:1d.2 USB Controller: Intel Corporation ICH10 USB UHCI Controller #3
00:1d.7 USB Controller: Intel Corporation ICH10 USB2 EHCI Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation ICH10 LPC Interface Controller
00:1f.2 SATA controller: Intel Corporation ICH10 6 port SATA AHCI Controller
00:1f.3 SMBus: Intel Corporation ICH10 SMBus Controller
01:00.0 VGA compatible controller: nVidia Corporation NV44 [GeForce 6200 
TurboCache(TM)] (rev a1)
03:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA 
Raid II Controller (rev 01)
04:00.0 IDE interface: JMicron Technologies, Inc. JMB368 IDE controller
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
07:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)

[*]: this is a desktop, not a laptop system, but I have 6 disks, so I 
thought to try some power-management tweaks.
I should have known better not to do that on a raid device!

Best regards,
--Edwin
