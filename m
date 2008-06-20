From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] New: machine doesn't shutdown when ahci sata driver is compiled as module
Date: Fri, 20 Jun 2008 13:47:59 -0700 (PDT)
Message-ID: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44483 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933748AbYFTUst (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 16:48:49 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5KKm1bu028742
	for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 13:48:02 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943

           Summary: machine doesn't shutdown when ahci sata driver is
                    compiled as module
           Product: Drivers
           Version: 2.5
     KernelVersion: 2.6.24
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
        AssignedTo: drivers_other@kernel-bugs.osdl.org
        ReportedBy: gfpadovan@gmail.com
                CC: jgarzik@pobox.com, linux-ide@vger.kernel.org


Latest working kernel version: I don't know
Earliest failing kernel version: I don't know
Distribution: Gentoo
Hardware Environment:
lspci output:
00:00.0 Host bridge [0600]: Intel Corporation Mobile PM965/GM965/GL960 Memory
Controller Hub [8086:2a00] (rev 03)
00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile GM965/GL960
Integrated Graphics Controller [8086:2a02] (rev 03)
00:02.1 Display controller [0380]: Intel Corporation Mobile GM965/GL960
Integrated Graphics Controller [8086:2a03] (rev 03)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #4 [8086:2834] (rev 03)
00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #5 [8086:2835] (rev 03)
00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
Controller #2 [8086:283a] (rev 03)
00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller [8086:284b] (rev 03)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 1 [8086:283f] (rev 03)
00:1c.5 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 6 [8086:2849] (rev 03)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #1 [8086:2830] (rev 03)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #2 [8086:2831] (rev 03)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #3 [8086:2832] (rev 03)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2 EHCI
Controller #1 [8086:2836] (rev 03)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev f3)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801HEM (ICH8M) LPC Interface
Controller [8086:2815] (rev 03)
00:1f.1 IDE interface [0101]: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E)
IDE Controller [8086:2850] (rev 03)
00:1f.2 SATA controller [0106]: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E)
SATA AHCI Controller [8086:2829] (rev 03)
00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus Controller
[8086:283e] (rev 03)
04:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8055 PCI-E
Gigabit Ethernet Controller [11ab:4363] (rev 13)

Problem Description: The machine doesn't shutdown when the driver ahci is
compiled as module.
Steps to reproduce: Compile ahci driver as module.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
