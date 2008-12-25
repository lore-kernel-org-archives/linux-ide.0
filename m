From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12290] New: hda: ide_cd_check_ireason: wrong transfer direction!
Date: Thu, 25 Dec 2008 04:06:01 -0800 (PST)
Message-ID: <bug-12290-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48887 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbYLYMGd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Dec 2008 07:06:33 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBPC619i028394
	for <linux-ide@vger.kernel.org>; Thu, 25 Dec 2008 04:06:02 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12290

           Summary: hda: ide_cd_check_ireason: wrong transfer direction!
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27.10
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: udovdh@xs4all.nl


Latest working kernel version: unknown
Earliest failing kernel version: 2.6.25 or older
Distribution: Fedora 10
Hardware Environment: VIA Epia EN12000 w/ slimline IDE?ATAPI DVD-rom
Software Environment: Fedora 10, custom kernel config
Problem Description: hda: ide_cd_check_ireason: wrong transfer direction!
occurs in dmesg output. Then `make modules_install install` hangs because it
'checks' various devices. Also `hdparm -i /dev/hda` hangs at such point.
Also hald-addon-stor blocks for more than 120 seconds and gives dumps.

A reboot (!) is necessary to recover and insatll a fresh kernel.


Steps to reproduce:
Boot into kernel. Let system run. It happens sooner (quickly after reboot) or
later.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
