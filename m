From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] New: Pre-2008 boards may show errors in pata_amd |
 pata_acpi unless CRS is turned off by pci=nocrs
Date: Thu, 04 Feb 2016 22:44:22 +0000
Message-ID: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57633 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755811AbcBDWoY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Feb 2016 17:44:24 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C54BE20390
	for <linux-ide@vger.kernel.org>; Thu,  4 Feb 2016 22:44:23 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id DFEF320357
	for <linux-ide@vger.kernel.org>; Thu,  4 Feb 2016 22:44:22 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

               URL: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1
                    536397
            Bug ID: 111901
           Summary: Pre-2008 boards may show errors in pata_amd |
                    pata_acpi unless CRS is turned off by pci=nocrs
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 4.4.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: andi3@gmx.net
        Regression: Yes

With a LOT of help from Oleg B. (Launchpad), it could be figured out that bug
111151 was actually a regression, but not a true bug.

Let me copy the error message again from the now-closed report:

pata_amd 0000:00:09.0: can't enable device: BAR 0 [io 0x01f0-0x01f7] not
claimed
pata_amd: probe of 0000:00:09.0 failed with error -22

Actual reason for this is CRS, which has been enabled by default since commit
3d9fecf6bfb8b12bc2f9a4c7109895a2a2bb9436 on 9 June 2015.
Our old machines do not like this at all. :)

The man to come to our rescue was Jiang Liu on commit
4d6b4e69a245e9df4b84dba387596086cb66887d on 14 October 2015.
Of course, it WORKED now, but it still broke all the past kernels.

So I'd call it a regression.

Now the question is: 

Is this supposed to remain like this?
That you guys are simply of the opinion, if you use and old machine, it's only
fair you've got to work around this by pci=nocrs.
Or would you decide otherwise?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
