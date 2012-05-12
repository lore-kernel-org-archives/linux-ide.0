From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 6883] ide-probe.c attempts to use polling designed for ancient
 Seagate drives on some compact flash disks
Date: Sat, 12 May 2012 01:39:15 +0000 (UTC)
Message-ID: <20120512013915.DF67C11FCE1@bugzilla.kernel.org>
References: <bug-6883-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55647 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757039Ab2ELBjS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2012 21:39:18 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 687FE202EB
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2012 01:39:17 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.204])
	by mail.kernel.org (Postfix) with ESMTP id E5832202E4
	for <linux-ide@vger.kernel.org>; Sat, 12 May 2012 01:39:15 +0000 (UTC)
In-Reply-To: <bug-6883-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=6883


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|                            |OBSOLETE




-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
