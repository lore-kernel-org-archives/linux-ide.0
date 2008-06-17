From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10933] New: pata_jmicron doesn't assign any device to my dvd-burner (jmicron does!)
Date: Tue, 17 Jun 2008 14:10:47 -0700 (PDT)
Message-ID: <bug-10933-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45830 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754108AbYFQVKt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2008 17:10:49 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5HLAlqQ020338
	for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2008 14:10:48 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10933

           Summary: pata_jmicron doesn't assign any device to my dvd-burner
                    (jmicron does!)
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25-ARCH
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: dezzadk@gmail.com


Latest working kernel version: 2.6.24
Earliest failing kernel version: 2.6.24.2
Distribution: ArchLinux
Hardware Environment: Motherboard: GA-P965-DQ6 (Gigabyte)
Software Environment: ArchLinux, kernel 2.6.25
Problem Description:
pata_jmicron doesn't assign any device to my dvd-burner (jmicron does!)
Read dmesg:
Line 379-382: http://rafb.net/p/neUqcI45.html
Line 517-519: http://rafb.net/p/Lov5gC91.html

Other threads related:
http://bugs.archlinux.org/task/9659

Steps to reproduce:
Boot your kernel and ls /dev or dmesg | grep LITE-ON


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
