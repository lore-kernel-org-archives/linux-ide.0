From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13886] Suspend to disk no longer works in 2.6.30.2 with an EIDE
 drive
Date: Sat, 1 Aug 2009 15:13:33 GMT
Message-ID: <200908011513.n71FDXAl032245@demeter.kernel.org>
References: <bug-13886-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41514 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbZHAPNd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Aug 2009 11:13:33 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n71FDXs3032246
	for <linux-ide@vger.kernel.org>; Sat, 1 Aug 2009 15:13:33 GMT
In-Reply-To: <bug-13886-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13886





--- Comment #4 from akwatts@ymail.com  2009-08-01 15:13:32 ---
The fix mentioned above (commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a) does
not address the problem I am encountering (which is present in 2.6.30.2).

There is no e100 hardware present here.

I am more than willing to help with the debugging process from this end.

Might we test by reverting his commit on 2.6.30.2?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
