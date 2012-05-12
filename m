From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 6883] ide-probe.c attempts to use polling designed for ancient
 Seagate drives on some compact flash disks
Date: Sat, 12 May 2012 01:39:22 +0000 (UTC)
Message-ID: <20120512013922.7A6E111FCE1@bugzilla.kernel.org>
References: <bug-6883-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55694 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758122Ab2ELBj0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2012 21:39:26 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3FFFE202DC
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2012 01:39:25 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.204])
	by mail.kernel.org (Postfix) with ESMTP id 807A2202E5
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2012 01:39:22 +0000 (UTC)
In-Reply-To: <bug-6883-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=6883


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED




-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
