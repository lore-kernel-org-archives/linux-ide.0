From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12279] 2.6.28 suspend regression - HP 2510p
Date: Sun, 11 Jan 2009 07:59:36 -0800 (PST)
Message-ID: <20090111155936.E3700108043@picon.linux-foundation.org>
References: <bug-12279-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33694 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbZAKQAI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 11:00:08 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0BFxbfF002698
	for <linux-ide@vger.kernel.org>; Sun, 11 Jan 2009 07:59:38 -0800
In-Reply-To: <bug-12279-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12279





------- Comment #13 from bzolnier@gmail.com  2009-01-11 07:59 -------
The fix went in the first IDE updates pull for 2.6.29:

commit 0e63a588fc3d6a5e6bb66bacaeb11cd9093141f8
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Mon Dec 29 20:27:29 2008 +0100

    ide: fix IDE ACPI regression breaking suspend
...

The bug can be closed now.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
