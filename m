From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 102741] pata_hpt37x driver refuses to operate with Adaptec
 1200A at UDMA/100
Date: Fri, 14 Aug 2015 10:48:13 +0000
Message-ID: <bug-102741-11633-VuuAHSpRkN@https.bugzilla.kernel.org/>
References: <bug-102741-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39280 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752744AbbHNKsQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Aug 2015 06:48:16 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6E26E205BB
	for <linux-ide@vger.kernel.org>; Fri, 14 Aug 2015 10:48:15 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 8A1CF20575
	for <linux-ide@vger.kernel.org>; Fri, 14 Aug 2015 10:48:13 +0000 (UTC)
In-Reply-To: <bug-102741-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102741

--- Comment #5 from Sergei Shtylyov <headless@email.ru> ---
(In reply to Andreas E from comment #4)

> Thanks! It's a butt-ugly hack, but better than nothing for the time being!

Please report your test results with and without the hack; running 'hdparm -t
/dev/sda' should be enough, probably.

> And yes, I know Alan was the author. (hence my modinfo output)

I have hacked on this driver a bit as well...

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
