From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Tue, 10 Nov 2009 00:41:40 GMT
Message-ID: <200911100041.nAA0feFH022845@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58088 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZKJAle (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2009 19:41:34 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAA0feg1022846
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2009 00:41:40 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515





--- Comment #7 from Tejun Heo <tj@kernel.org>  2009-11-10 00:41:38 ---
TUR is coming from open and I have patches to implement in-kernel polling so
that polling doesn't have to go through open but it depends on workqueue
patches which are yet to be merged.  I think I can pull it for 2.6.34 but I
might be too optimistic.  :-P

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
