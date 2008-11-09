From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 08:08:55 -0800 (PST)
Message-ID: <20081109160855.E7033108040@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33374 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755208AbYKIQJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:09:26 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9G8tUL007331
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 08:08:57 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #9 from bzolnier@gmail.com  2008-11-09 08:08 -------
Created an attachment (id=18749)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=18749&action=view)
aec62xx: fix AEC6260[R] support on Macintosh


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
