From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 17982] New: Cannot see devices on IDE controller
Date: Tue, 7 Sep 2010 01:37:06 GMT
Message-ID: <bug-17982-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:59391 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab0IGBhI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2010 21:37:08 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id o871b6KE030831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 7 Sep 2010 01:37:06 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=17982

           Summary: Cannot see devices on IDE controller
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.35.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rercola@acm.jhu.edu
        Regression: No


Created an attachment (id=29162)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=29162)
dmesg of system in question

I have an MSI P55A-G55 motherboard, with the attached lspci output.

It has a single IDE port, and 6 SATA ports. One of these SATA ports is cabled
to my root disk, and the IDE port is cabled to a new disk that I wanted to
extract data from.

Said IDE disk is listed in the BIOS as a valid disk, capacity 250 GB, listed in
the list of boot devices, and so on.

Said IDE disk is seen in Windows, albeit as an unknown partition type.

As far as Linux is concerned on this machine, there is nothing attached to the
IDE controller.

This is on Ubuntu 10.04 amd64 - I tried the stock 2.6.32-24-generic kernel (I
was already running a vanilla 2.6.35.3 kernel to test something entirely
orthogonal), as well as 2.6.36-rc3, and they both behaved identically. (dmesg
attached from 2.6.36-rc3).

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
