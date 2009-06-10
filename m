From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Wed, 10 Jun 2009 14:34:07 GMT
Message-ID: <200906101434.n5AEY7Kl006010@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39519 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbZFJOeF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jun 2009 10:34:05 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5AEY7YJ006011
	for <linux-ide@vger.kernel.org>; Wed, 10 Jun 2009 14:34:07 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #17 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-10 14:34:06 ---
> Could it be bug #13399 instead of this one?
> 
> [ This one should really be already fixed. ]

It could well be, by the symptoms. I can't tell the difference. It's not fixed
for that old drive of mine though. :)

A different problem with the dvd-rom drives was fixed between rc7 and rc8.
Anything accessing my newer drive would freeze in an uninteruptable wait for IO
under rc7, but works fine with rc8.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
