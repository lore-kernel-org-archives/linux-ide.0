From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10803] New: Kernel freeze on accesing CD-ROM or HDD
Date: Tue, 27 May 2008 03:06:58 -0700 (PDT)
Message-ID: <bug-10803-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53394 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755066AbYE0KH3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 May 2008 06:07:29 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4RA6wdI021729
	for <linux-ide@vger.kernel.org>; Tue, 27 May 2008 03:06:59 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10803

           Summary: Kernel freeze on accesing CD-ROM or HDD
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24-16
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: nitanovidiu@gmail.com


Latest working kernel version: 2.6.22-14-generic
Earliest failing kernel version: 2.6.24-16-generic
Distribution: Ubuntu (also tested on Sabayon)
Hardware Environment: Chipset VIA KM266, AMD Duron 1,6 Ghz CPU, 768 MB RAM
memory, HDD Seagate ST340014A, GPU Nvidia GeForce FX 5200
Software Environment: Ubuntu Linux 8.04, Gnome 2.22.1
Problem Description: My PC freeze when I try to access a storage device
connected on secondary IDE cable. This is happening after a few seconds of
reading the disk. This problem doesn't appear when I write data on a CD-RW or
DVD-RW medium. This seems to not be a hardware problem because when I start
Linux using kernel 2.6.22-14-generic this problem doesn't appear. I also tried
to change the IDE connections, but this problem appears on every device
connected on secondary IDE.

Steps to reproduce:
Load a CD on tray, access it, read some data (for example a movie) and... it
locks. 

I have read a CD using the tty1 console interface, and I made a snapshot with
my phone on what's happening when my PC is freezing. You can see it at
http://www.picoodle.com/view.php?img=/4/5/12/f_Ovi021m_d5e9d68.jpg&srv=img37


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
