From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14708] New: Option remap63 for OnTrack diskmanager not work -
 kernel panic, unable to mount root filesystem
Date: Tue, 1 Dec 2009 00:22:58 GMT
Message-ID: <bug-14708-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50924 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbZLAAWw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Nov 2009 19:22:52 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nB10MwqK020425
	for <linux-ide@vger.kernel.org>; Tue, 1 Dec 2009 00:22:58 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14708

           Summary: Option remap63 for OnTrack diskmanager not work -
                    kernel panic, unable to mount root filesystem
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.31
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: sachse@gmx.net
        Regression: No


2.4.x has recognized OnTrack Diskmanager automaticaly.
2.6.0 - 2.6.21 supports option "hda=remap63".
2.6.31 ignore this option.
2.6.22 - 2.6.30 not testet.


system configuration
--------------------

livecd ~ # uname -a
Linux livecd 2.6.19-gentoo-r5 #1 SMP Tue Apr 3 01:19:22 UTC 2007 i586 Pentium
75 - 200 GenuineIntel GNU/Linux
------------
livecd ~ # fdisk -l

Disk /dev/hda: 100.0 GB, 100030210560 bytes
255 heads, 63 sectors/track, 12161 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1         261     2096451    6  FAT16
/dev/hda2             262         759     4000153+   7  HPFS/NTFS
/dev/hda3             760         761       16033+  83  Linux
/dev/hda4             762       12161    91570500    5  Extended
/dev/hda5             762         824      506016   82  Linux swap / Solaris
/dev/hda6             825        9579    70324506   83  Linux
/dev/hda7            9580       12161    20739883+   7  HPFS/NTFS

NOTE:
This fdisk output is with hda=remap63
-----------
livecd ~ # cat /mnt/gentoo/etc/lilo.conf
boot = /fs/lwc/bootsect.lin
map = /boot/.map
lba32

# Here you can select the secondary loader to install.  A few
# examples is:
#
#    boot-text.b
#    boot-menu.b
#    boot-bmp.b
#
install = /boot/boot-bmp.b   # Note that for lilo-22.5.5 or later you
                              # do not need boot-{text,menu,bmp}.b in
                              # /boot, as they are linked into the lilo
                              # binary.


bitmap=/boot/ccc-logo.bmp
bmp-table=30,4,,,,
bmp-timer=67,5,,,

prompt
timeout=50
vga = 791

image = /boot/bzImage-2.6.31-r3
        root = /dev/hda6
        append = "hda=remap63 resume=/dev/hda5"   #need for ontrack - panic
        label = Linux-2.6.31-r3

image = /boot/bzImage-2.6.21-r4
        root = /dev/hda6
        append = "hda=remap63 resume=/dev/hda5"   #need for ontrack
        label = Linux-2.6.21-r4

image = /boot/bzImage-2.6.18-r4
        root = /dev/hda6
        append = "hda=remap63 resume=/dev/hda5"   #need for ontrack
        label = Linux-2.6.18-r4

image = /boot/bzImage-2.6.15-r1
        root = /dev/hda6
        append = "hda=remap63 resume=/dev/hda5"   #need for ontrack
        label = Linux-2.6.15-r1


image = /boot/memtest
        label = memtest

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
