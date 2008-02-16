From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10004] New: Smartd causes HSM violations on ata_piix
Date: Sat, 16 Feb 2008 10:52:44 -0800 (PST)
Message-ID: <bug-10004-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48017 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662AbYBPSxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 13:53:17 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GIqieZ008338
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 10:52:45 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10004

           Summary: Smartd causes HSM violations on ata_piix
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24.1
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: slava@fizlesh.org.ru


Latest working kernel version:
Earliest failing kernel version:
Distribution: Gentoo
Hardware Environment: IDE interface: Intel Corporation 82801DB (ICH4) IDE
Controller (rev 02)
Software Environment: smartmontools-5.36
Problem Description:

When smartd starts and initializes device parameters, HSM violation errors are
reported. The smartd is configured in the following way:

/dev/sda -d ata -a -o on -R 194 -m root -M daily
(the same parameters for sdb).

When smartd starts, the following is reported to the syslog:

Feb 16 21:39:01 fpfe smartd[10704]: smartd version 5.36 [i686-pc-linux-gnu]
Copyright (C) 2002-6 Bruce Allen
Feb 16 21:39:01 fpfe smartd[10704]: Home page is
http://smartmontools.sourceforge.net/
Feb 16 21:39:01 fpfe smartd[10704]: Opened configuration file /etc/smartd.conf
Feb 16 21:39:01 fpfe smartd[10704]: Configuration file /etc/smartd.conf parsed.
Feb 16 21:39:01 fpfe smartd[10704]: Device: /dev/sda, opened
Feb 16 21:39:01 fpfe smartd[10704]: Device: /dev/sda, found in smartd database.
Feb 16 21:39:02 fpfe ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:02 fpfe ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 pio
126976 in
Feb 16 21:39:02 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
Feb 16 21:39:02 fpfe ata1.00: status: { DRDY }
Feb 16 21:39:02 fpfe ata1: soft resetting link
Feb 16 21:39:02 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1: EH complete
Feb 16 21:39:02 fpfe ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:02 fpfe ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 pio
126976 in
Feb 16 21:39:02 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
Feb 16 21:39:02 fpfe ata1.00: status: { DRDY }
Feb 16 21:39:02 fpfe ata1: soft resetting link
Feb 16 21:39:02 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1: EH complete
Feb 16 21:39:02 fpfe ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:02 fpfe ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 pio
126976 in
Feb 16 21:39:02 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
Feb 16 21:39:02 fpfe ata1.00: status: { DRDY }
Feb 16 21:39:02 fpfe ata1: soft resetting link
Feb 16 21:39:02 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1: EH complete
Feb 16 21:39:02 fpfe ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:02 fpfe ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 pio
126976 in
Feb 16 21:39:02 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
Feb 16 21:39:02 fpfe ata1.00: status: { DRDY }
Feb 16 21:39:02 fpfe ata1: soft resetting link
Feb 16 21:39:02 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:02 fpfe ata1: EH complete
Feb 16 21:39:02 fpfe ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:02 fpfe ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 pio
126976 in
Feb 16 21:39:02 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
Feb 16 21:39:02 fpfe ata1.00: status: { DRDY }
Feb 16 21:39:02 fpfe ata1: soft resetting link
Feb 16 21:39:03 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:03 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:03 fpfe ata1: EH complete
Feb 16 21:39:03 fpfe ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:03 fpfe ata1.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 pio
126976 in
Feb 16 21:39:03 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
violation)
Feb 16 21:39:03 fpfe ata1.00: status: { DRDY }
Feb 16 21:39:03 fpfe ata1: soft resetting link
Feb 16 21:39:03 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:03 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:03 fpfe ata1: EH complete
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] 117302879 512-byte hardware sectors
(60059 MB)
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] Write Protect is off
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors
(250059 MB)
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] Write Protect is off
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] 117302879 512-byte hardware sectors
(60059 MB)
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] Write Protect is off
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb 16 21:39:03 fpfe sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors
(250059 MB)
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] Write Protect is off
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
Feb 16 21:39:03 fpfe sd 0:0:1:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:03 fpfe smartd[10704]: Device: /dev/sda, enable SMART Automatic
Offline Testing failed.
Feb 16 21:39:03 fpfe smartd[10704]: Device: /dev/sda, is SMART capable. Adding
to "monitor" list.
Feb 16 21:39:03 fpfe smartd[10704]: Device: /dev/sdb, opened
Feb 16 21:39:03 fpfe smartd[10704]: Device: /dev/sdb, not found in smartd
database.
Feb 16 21:39:03 fpfe ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:03 fpfe ata1.01: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/10 tag 0 pio
126976 in
Feb 16 21:39:03 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/b0 Emask 0x202 (HSM
violation)
Feb 16 21:39:03 fpfe ata1.01: status: { DRDY }
Feb 16 21:39:03 fpfe ata1: soft resetting link
Feb 16 21:39:04 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1: EH complete
Feb 16 21:39:04 fpfe ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:04 fpfe ata1.01: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/10 tag 0 pio
126976 in
Feb 16 21:39:04 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/b0 Emask 0x202 (HSM
violation)
Feb 16 21:39:04 fpfe ata1.01: status: { DRDY }
Feb 16 21:39:04 fpfe ata1: soft resetting link
Feb 16 21:39:04 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1: EH complete
Feb 16 21:39:04 fpfe sd 0:0:0:0: [sda] 117302879 512-byte hardware sectors
(60059 MB)
Feb 16 21:39:04 fpfe ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:04 fpfe ata1.01: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/10 tag 0 pio
126976 in
Feb 16 21:39:04 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/b0 Emask 0x202 (HSM
violation)
Feb 16 21:39:04 fpfe ata1.01: status: { DRDY }
Feb 16 21:39:04 fpfe ata1: soft resetting link
Feb 16 21:39:04 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1: EH complete
Feb 16 21:39:04 fpfe sd 0:0:0:0: [sda] Write Protect is off
Feb 16 21:39:04 fpfe sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb 16 21:39:04 fpfe ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:04 fpfe ata1.01: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/10 tag 0 pio
126976 in
Feb 16 21:39:04 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/b0 Emask 0x202 (HSM
violation)
Feb 16 21:39:04 fpfe ata1.01: status: { DRDY }
Feb 16 21:39:04 fpfe ata1: soft resetting link
Feb 16 21:39:04 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:04 fpfe ata1: EH complete
Feb 16 21:39:05 fpfe ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:05 fpfe ata1.01: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/10 tag 0 pio
126976 in
Feb 16 21:39:05 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/b0 Emask 0x202 (HSM
violation)
Feb 16 21:39:05 fpfe ata1.01: status: { DRDY }
Feb 16 21:39:05 fpfe ata1: soft resetting link
Feb 16 21:39:05 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:05 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:05 fpfe ata1: EH complete
Feb 16 21:39:05 fpfe sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:05 fpfe ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
frozen
Feb 16 21:39:05 fpfe ata1.01: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/10 tag 0 pio
126976 in
Feb 16 21:39:05 fpfe res 50/00:f8:00:4f:c2/00:00:00:00:00/b0 Emask 0x202 (HSM
violation)
Feb 16 21:39:05 fpfe ata1.01: status: { DRDY }
Feb 16 21:39:05 fpfe ata1: soft resetting link
Feb 16 21:39:05 fpfe ata1.00: configured for UDMA/100
Feb 16 21:39:05 fpfe ata1.01: configured for UDMA/100
Feb 16 21:39:05 fpfe ata1: EH complete
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors
(250059 MB)
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] Write Protect is off
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:05 fpfe sd 0:0:0:0: [sda] 117302879 512-byte hardware sectors
(60059 MB)
Feb 16 21:39:05 fpfe sd 0:0:0:0: [sda] Write Protect is off
Feb 16 21:39:05 fpfe sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb 16 21:39:05 fpfe sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors
(250059 MB)
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] Write Protect is off
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
Feb 16 21:39:05 fpfe sd 0:0:1:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Feb 16 21:39:05 fpfe smartd[10704]: Device: /dev/sdb, enable SMART Automatic
Offline Testing failed.
Feb 16 21:39:05 fpfe smartd[10704]: Device: /dev/sdb, is SMART capable. Adding
to "monitor" list.
Feb 16 21:39:05 fpfe smartd[10704]: Monitoring 2 ATA and 0 SCSI devices
Feb 16 21:39:06 fpfe smartd[10706]: smartd has fork()ed into background mode.
New PID=10706.
Feb 16 21:39:06 fpfe smartd[10706]: file /var/run/smartd.pid written containing
PID 10706

Steps to reproduce:
Configure the kernel to use libata driver ata_piix for IDE, compile and boot
it, then start smartd.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
