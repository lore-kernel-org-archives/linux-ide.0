From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Wed, 19 Aug 2009 20:46:14 GMT
Message-ID: <200908192046.n7JKkEe5012468@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34584 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZHSUqM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Aug 2009 16:46:12 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n7JKkEIj012469
	for <linux-ide@vger.kernel.org>; Wed, 19 Aug 2009 20:46:14 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #35 from Mark de Wever <koraq@xs4all.nl>  2009-08-19 20:46:10 ---
Hi Boris,

I tried your patch and it makes no difference, the files are still truncated at
the same length.

Regards,
Mark

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
