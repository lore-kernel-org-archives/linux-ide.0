From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 102741] pata_hpt37x driver refuses to operate with Adaptec
 1200A at UDMA/100
Date: Wed, 12 Aug 2015 20:48:39 +0000
Message-ID: <bug-102741-11633-MZcIlPqfxZ@https.bugzilla.kernel.org/>
References: <bug-102741-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49284 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbbHLUsm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2015 16:48:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6122A2061B
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 20:48:41 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id D71F8206A0
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 20:48:39 +0000 (UTC)
In-Reply-To: <bug-102741-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102741

--- Comment #3 from Sergei Shtylyov <headless@email.ru> ---
(In reply to Andreas E from comment #2)

> NAH!!! I can't believe it. This thing can do UDMA/100

Well, I wouldn't call UDMA/100 with 66 MHz clock real UDMA/100.

> but it was limited artificially to /66.

"Shit happens". :-)

> In any case, I think the driver messages should *inform* the user about this
> being not their HDD(s) at fault, but forced to this speed by the driver
> itself. Because every user would initially think that it's their fault, not
> the driver's.

Makes sense.

> Is there any way I can force it to operate at UDMA/100? 
> Some #define, anything? 

With the IDE driver, there was a #define but that's not the case with the
libata one. Thank Alan Cox for that. :-)
However, it shouldn't be hard to do, just comment out the following lines:

                if (clock_slot < 2 && ppi[0] == &info_hpt370)
                        ppi[0] = &info_hpt370_33;
                if (clock_slot < 2 && ppi[0] == &info_hpt370a)
                        ppi[0] = &info_hpt370a_33;

[the rest skipped]

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
