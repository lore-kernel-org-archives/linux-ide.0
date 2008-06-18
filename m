From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Wed, 18 Jun 2008 16:00:39 -0700 (PDT)
Message-ID: <20080618230039.438E010800B@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54704 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400AbYFRXBK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 19:01:10 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IN0dgP019550
	for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2008 16:00:40 -0700
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #1 from bzolnier@gmail.com  2008-06-18 16:00 -------
Could you try some newer kernel (2.6.25 or 2.6.26-rc6), there has been a lot of
fixes for ATA/ATAPI support since 2.6.24.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
