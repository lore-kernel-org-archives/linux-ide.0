From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 52821] ata_piix ATA_HOST_IGNORE_ATA for Hyper-V also affects
 Virtual PC 7
Date: Wed, 30 Jan 2013 22:19:21 +0000 (UTC)
Message-ID: <20130130221921.89F9111FF01@bugzilla.kernel.org>
References: <bug-52821-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42140 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304Ab3A3WTZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2013 17:19:25 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id CA472203AA
	for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2013 22:19:24 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id E20E920386
	for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2013 22:19:22 +0000 (UTC)
In-Reply-To: <bug-52821-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=52821


Andreas <linuxuser330250@gmx.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |PATCH_ALREADY_AVAILABLE




--- Comment #2 from Andreas <linuxuser330250@gmx.net>  2013-01-30 22:19:21 ---
First appearance:
https://bugzilla.novell.com/show_bug.cgi?id=737532
Patch:
https://lkml.org/lkml/2012/9/18/306

Since I discovered the bug in a recent version of a bootable ISO, I assume a
lot of recent distros are still affected.
Anyway, future releases should be fixed. Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
