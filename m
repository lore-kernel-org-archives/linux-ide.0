From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 47781] ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050002
 action 0xe frozen
Date: Sun, 23 Sep 2012 21:07:26 +0000 (UTC)
Message-ID: <20120923210726.A8A4811FB24@bugzilla.kernel.org>
References: <bug-47781-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37630 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab2IWVH3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Sep 2012 17:07:29 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3FD63202B6
	for <linux-ide@vger.kernel.org>; Sun, 23 Sep 2012 21:07:28 +0000 (UTC)
Received: from bugzilla.kernel.org (unknown [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 29462202A6
	for <linux-ide@vger.kernel.org>; Sun, 23 Sep 2012 21:07:27 +0000 (UTC)
In-Reply-To: <bug-47781-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=47781


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk




--- Comment #4 from Alan <alan@lxorguk.ukuu.org.uk>  2012-09-23 21:07:26 ---
It's reporting a cable or device change. Are all the disks and CDROMs correctly
seen ?

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
