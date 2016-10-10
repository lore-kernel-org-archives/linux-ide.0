From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176931] ata failed to IDENTIFY, suspected regression
Date: Mon, 10 Oct 2016 13:04:41 +0000
Message-ID: <bug-176931-11633-LJdq2sTmTz@https.bugzilla.kernel.org/>
References: <bug-176931-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbcJJNLW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 10 Oct 2016 09:11:22 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 042B420160
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2016 13:04:45 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 882C72017E
        for <linux-ide@vger.kernel.org>; Mon, 10 Oct 2016 13:04:41 +0000 (UTC)
In-Reply-To: <bug-176931-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176931

Tejun Heo <tj@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tj@kernel.org

--- Comment #1 from Tejun Heo <tj@kernel.org> ---
Does booting with "irqpoll" boot option change anything?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
