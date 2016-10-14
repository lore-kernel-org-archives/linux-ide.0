From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176931] ata failed to IDENTIFY, suspected regression
Date: Fri, 14 Oct 2016 03:15:53 +0000
Message-ID: <bug-176931-11633-6Vfs7eoSxh@https.bugzilla.kernel.org/>
References: <bug-176931-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756473AbcJNDQD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 13 Oct 2016 23:16:03 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0040B203E9
        for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2016 03:15:57 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 2F58F203EB
        for <linux-ide@vger.kernel.org>; Fri, 14 Oct 2016 03:15:54 +0000 (UTC)
In-Reply-To: <bug-176931-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176931

be11f157cd19c4a2ba1e9c70a38b1a74@protonmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #2 from be11f157cd19c4a2ba1e9c70a38b1a74@protonmail.com ---
Thank you for your help, it seems that it works with or without irqpoll on
linux 4.8.1. I'm not sure if 4.8 still matters anymore. Tell me if you still
want to test on 4.8

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
