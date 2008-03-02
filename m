From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] New: DMA crash with via82cxxx module
Date: Sun,  2 Mar 2008 04:58:16 -0800 (PST)
Message-ID: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37201 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752435AbYCBNH6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 08:07:58 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m22CwKVf011079
	for <linux-ide@vger.kernel.org>; Sun, 2 Mar 2008 04:58:21 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142

           Summary: DMA crash with via82cxxx module
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.*
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: qrees@poczta.fm


Latest working kernel version: all without via82cxxx module
Earliest failing kernel version: all with via82cxxx module
Distribution: all
Hardware Environment: via8233 chipset
Software Environment: any
Problem Description: System crashes when DMA is on. The problem is via82cxxx 
module. When it's disabled system doesn't crash. The problem is that, when is
disabled there is no DMA, so performance is just horrible... Due to this it's
not even possible to find anything in system logs.

Steps to reproduce: Make sure DMA is on. Copy big file (so it takes longer than
few seconds ;) ) and play music at the same time (or anything that involves
disk use).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
