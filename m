From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14438] [PATCH] IDE Probe fails to find CD drive
Date: Wed, 13 Jun 2012 20:27:09 +0000 (UTC)
Message-ID: <20120613202709.8C2C812060F@bugzilla.kernel.org>
References: <bug-14438-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46040 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab2FMU1N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Jun 2012 16:27:13 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1028D20485
	for <linux-ide@vger.kernel.org>; Wed, 13 Jun 2012 20:27:12 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.204])
	by mail.kernel.org (Postfix) with ESMTP id 742A720484
	for <linux-ide@vger.kernel.org>; Wed, 13 Jun 2012 20:27:10 +0000 (UTC)
In-Reply-To: <bug-14438-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14438


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |CODE_FIX




--- Comment #13 from Thomas Jarosch <thomas.jarosch@intra2net.com>  2010-05-07 09:29:13 ---
The 2.6.33 code looked fixed to me and I just verified it works again with
2.6.33.2 and VMware server 1.0.8.

This issue is resolved in 2.6.33, please close it.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
