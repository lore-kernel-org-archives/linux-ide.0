From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13308] ide-tape boot kernel panic
Date: Fri, 15 May 2009 09:34:27 GMT
Message-ID: <200905150934.n4F9YRI8025811@demeter.kernel.org>
References: <bug-13308-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:40385 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611AbZEOJe0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 05:34:26 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4F9YRFr025812
	for <linux-ide@vger.kernel.org>; Fri, 15 May 2009 09:34:27 GMT
In-Reply-To: <bug-13308-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13308





--- Comment #6 from Borislav Petkov <bbpetkov@yahoo.de>  2009-05-15 09:34:26 ---
Hi,

can I assume that your drive works fine after applying this patch and there are
no other problems? IOW, can you access the tape and do some data movement
to/from it using ide-tape?

Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
