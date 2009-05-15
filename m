From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13308] ide-tape boot kernel panic
Date: Fri, 15 May 2009 06:25:13 GMT
Message-ID: <200905150625.n4F6PDGG010875@demeter.kernel.org>
References: <bug-13308-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43189 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbZEOGZO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 02:25:14 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4F6PDZ3010876
	for <linux-ide@vger.kernel.org>; Fri, 15 May 2009 06:25:13 GMT
In-Reply-To: <bug-13308-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13308





--- Comment #3 from Borislav Petkov <bbpetkov@yahoo.de>  2009-05-15 06:25:12 ---
Created an attachment (id=21364)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21364)
fix oops

Note to self: This is going upstream for 2.6.31. We should backport it to .29
and .30.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
