From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9898] New: libata fails for ALi Corporation M5229 IDE
Date: Wed,  6 Feb 2008 03:09:36 -0800 (PST)
Message-ID: <bug-9898-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45555 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147AbYBFLJi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 06:09:38 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16B9b4p021723
	for <linux-ide@vger.kernel.org>; Wed, 6 Feb 2008 03:09:38 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9898

           Summary: libata fails for ALi Corporation M5229 IDE
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: hathe@sidux.com


Latest working kernel version: 2.6.23.14 (with blkdev)
Earliest failing kernel version: 2.6.24 (with libata)
Distribution: sidux
Hardware Environment: Acer Travelmate 632XV 
Software Environment:
Problem Description: System boots fine, but after some minutes complete system
freeze. Nothing is mentioned in the logfiles. 

System informations:
lspci -nn | grep IDE
00:10.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c4)

Steps to reproduce: reboot and wait some minutes (<10)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
