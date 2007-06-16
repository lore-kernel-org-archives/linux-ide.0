From: Thanos Kyritsis <djart@linux.gr>
Subject: [PROBLEM]: hdparm strange behaviour for 2.6.21 and later
Date: Sat, 16 Jun 2007 19:58:05 +0300
Message-ID: <200706161958.05313.djart@linux.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from igloo.linux.gr ([62.1.205.36]:38818 "EHLO igloo.linux.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbXFPRMK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Jun 2007 13:12:10 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello,

starting with kernel 2.6.21 and up to kernel 2.6.22-rc4, I'm having the 
following problem:

/etc/rc.d/rc.local contains the following:
/usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hda
/usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdb
/usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdc
/usr/sbin/hdparm -q -d1 -q -u1 -q -c1 -q -k1 /dev/hdd

(I'm using Slackware, no Debian-style automated hdparm.conf is running 
during bootup, that's why these are in rc.local)

The above seem to somehow lock up the boot procedure just at the point 
where rc.local gets executed, so the system never reaches login prompt.
All drivers (kernelspace) and system daemons (userspace) before rc.local 
do normally load, but there are no strange messages in the console or in 
the system logs and because I cannot login, I cannot trace it any further. 
I believe the kernel is in running state because the machine responds to 
ICMP pings from the ethernet, but since the login prompt is not up, the 
already running sshd/telnetd do not provide any help.

The strange thing is that if I remove all the quiet options (-q) from the 
above commands, everything works like it should. Furthermore, if I 
comment them out from rc.local, then boot, login, and execute them by 
hand (with -q), again everything works like it should. Lockup only happens if 
I run 2 or more hdparm commands, if I leave only one (doesn't matter 
which one) hdparm command in rc.local (with -q), it works.

This is not happening for kernels up to 2.6.20.14 and I'm using the same 
above hdparm options for over a year while the hardware hasn't changed 
at all. 

Speaking of hardware:
Pentium 4 HT, ICH5 IDE Controller, running on SMP/HT kernel 
(ticks enabled @ 1000 Hz, PREEMPT/low-latency is on, 
CONFIG_BLK_DEV_IDEDMA=y).
hda and hdb are Hard drives.
hdc and hdd are DVD drives (hdc is a recorder).


Can this be regarded as a kernel bug at all ? Can I do something to properly 
debug it and help you out ?

I posted it here because I couldn't help noticing the following inside .21's Changelog:

commit 8799620400b0b1a4729d8be828b5bfb3d2a8db1a
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Mon Mar 26 23:03:19 2007 +0200

    ide: fix locking for manual DMA enable/disable ("hdparm -d")
    
    Since hwif->ide_dma_check and hwif->ide_dma_on never queue any commands
    (ide_config_drive_speed() sets transfer mode using polling and has no error
    recovery) we are safe with setting hwgroup->busy for the time while DMA
    setting for a drive is changed (so it won't race against I/O commands in fly).
    
    I audited briefly all ->ide_dma_check/->ide_dma_on/->tuneproc/->speedproc
    implementations and they all look OK wrt to this change.
    
    This patch finally allowed me to close kernel bugzilla bug #8169
    (once again thanks to Patrick Horn for reporting the issue & testing patches).
    
    Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
    Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>


-- 
Thanos Kyritsis <djart at linux.gr>

- What's your ONE purpose in life ?
- To explode, of course! ;-)
