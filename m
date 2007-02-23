From: "Thue Janus Kristensen" <thuejk@gmail.com>
Subject: hdb: irq timeout: status=0xd0 { Busy }
Date: Fri, 23 Feb 2007 14:19:16 +0100
Message-ID: <2fa647f60702230519u4dc178b8s6c28948cd824272d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:34061 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbXBWNTS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 08:19:18 -0500
Received: by nf-out-0910.google.com with SMTP id o25so853161nfa
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 05:19:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

(Please tell me if I have sent this bug report to the wrong list)

I am getting this very annoying error regularly, several times a week.
Linux seems to get into an infinite loop. While programs still seem to
run, and I am able to sort of normally reboot the computer from the
console, it is totally unusably slow.

I can see no system in when the bug occurs. I am not using the DVD
drive (hdb) when the bug occurs. I know it has happened when I have
not used hdb after the last reboot, and I *think* it has also happened
when I have not used the DVD since the last time the computer was cold
booted. I *think* it tends to happen when hda is being used for
program loading/swapping.

I get the following error messages written to kern.log, starting from
the first error message:

Feb 20 23:15:17 localhost kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown
Feb 20 23:15:27 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown
Feb 20 23:15:27 localhost kernel: hdb: drive not ready for command
Feb 20 23:15:27 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown
Feb 20 23:15:27 localhost kernel: hdb: drive not ready for command
Feb 20 23:15:33 localhost kernel: hdb: status timeout: status=0xd0 { Busy }

The lines
Feb 20 23:17:30 localhost kernel: ide: failed opcode was: unknown
Feb 20 23:17:30 localhost kernel: hdb: drive not ready for command
Feb 20 23:17:36 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
repeats infinitely.

My computer is a laptop with the hard disk (hda) and DVD-RW drive
(hdb) on the same IDE channel, so I am guessing that the traffic of
hdb errors is choking off access over the shared channel to hda,
causing the slowness.

I got the error in 2.6.19 and 2.6.20. I am not sure which older
kernels gave me the error, but I think it is a relatively new thing. I
am currently running 2.6.16.41 to see if I get the error there, but so
far after 3 days I have not encountered the error again (not long
enough to be certain).

The computer is an ACER Aspire 3613WLMi laptop.

lspci says I have the following ide controller:
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03)

The laptop has a hard disk and a DVD-rw on a single IDE controller.
R@h /proc/ide/ide0> cat hda/model
HTS424040M9AT00
R@h /proc/ide/ide0> cat hdb/model
Slimtype DVDRW SOSW-833S

R@h ~> hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 16383/255/63, sectors = 78140160, start = 0
R@h ~> hdparm /dev/hdb

/dev/hdb:
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Inappropriate ioctl for device
R@h ~>

Please say if you need any further information, or if I can do
anything to track the problem down.

Regards, Thue

Pleace CC me, I am not on this list.
