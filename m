From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176931] New: ata failed to IDENTIFY, suspected regression
Date: Fri, 07 Oct 2016 04:13:33 +0000
Message-ID: <bug-176931-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbcJGENg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 7 Oct 2016 00:13:36 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 1666420397
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2016 04:13:35 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id B474320394
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2016 04:13:33 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176931

            Bug ID: 176931
           Summary: ata failed to IDENTIFY, suspected regression
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 4.8
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: be11f157cd19c4a2ba1e9c70a38b1a74@protonmail.com
        Regression: No

I have a old hard drive that shows up as this in lspci:

IDE Interface: NVIDIA Corporation MCP78S [GeForce 8200] SATA Controller
(non-AHCI mode) (rev a1)

When I try to boot the machine with kernel 4.8, it will tell me that it cannot
mount /dev/sda3 on root, and that the available choices only include sr0. The
output before that says something along the lines of

ata1: failed to IDENTIFY

However, the exact same kernel .config(using default options when `make`
prompts) with kernel 4.7.6 works fine.

I can offer SSH(root) access and type commands manually for you if that
breaks(but I can only type manually during EST non-business hours). SSH is set
to autostart if you need to reboot the machine. I have a live CD on hand. The
machine has no important data on it so you don't have to worry about breaking
something. Send me a public key if you're interested.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
