From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13696] New: Reading a DVD crashes the kernel
Date: Thu, 2 Jul 2009 16:46:48 GMT
Message-ID: <bug-13696-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:44209 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZGBQqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jul 2009 12:46:44 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n62Gkmu8029855
	for <linux-ide@vger.kernel.org>; Thu, 2 Jul 2009 16:46:48 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13696

           Summary: Reading a DVD crashes the kernel
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.30
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: dibbex@gmail.com
        Regression: No


Created an attachment (id=22177)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=22177)
Kernel output

Whenever I insert a DVD in the DVD-ROM drive (/dev/hdc) and try to read it
(e.g., mount, dd) the kernel crashes.  The DVD-RW drive works fine.
Attached is the complete kernel output as captured by netconsole, with info
about the hardware and the oops dump.

As I'm using Debian, I compiled the vanilla 2.6.30 source using the Debian
configuration to make sure the bug doesn't depend on Debian patches.  Kernel
2.6.29 apparently works fine.

If you need any other information, please ask.

Best regards,
Bernardo

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
