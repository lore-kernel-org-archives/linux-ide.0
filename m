From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Sat, 24 Oct 2009 13:38:45 GMT
Message-ID: <200910241338.n9ODcj1M009385@demeter.kernel.org>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48264 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbZJXNil (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Oct 2009 09:38:41 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9ODcjnS009386
	for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2009 13:38:45 GMT
In-Reply-To: <bug-14310-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310





--- Comment #4 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-10-24 13:38:41 ---
Created an attachment (id=23513)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=23513)
debug patch for sis5513 issue

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
