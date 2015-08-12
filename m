From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 102741] pata_hpt37x driver refuses to operate with Adaptec
 1200A at UDMA/100
Date: Wed, 12 Aug 2015 19:38:46 +0000
Message-ID: <bug-102741-11633-FUs58pgQ6S@https.bugzilla.kernel.org/>
References: <bug-102741-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45700 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbbHLTis (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2015 15:38:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BF061206A0
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 19:38:47 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 5B27F20670
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 19:38:46 +0000 (UTC)
In-Reply-To: <bug-102741-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102741

--- Comment #2 from Andreas E <andi3@gmx.net> ---
NAH!!! I can't believe it. This thing can do UDMA/100 but it was limited
artificially to /66. 
In any case, I think the driver messages should *inform* the user about this
being not their HDD(s) at fault, but forced to this speed by the driver itself.
Because every user would initially think that it's their fault, not the
driver's.

Is there any way I can force it to operate at UDMA/100? 
Some #define, anything? 

>2) UDMA/66 showed much better figures than UDMA/100 on HPT370 I was testing on.

Yes, that happened on the HPT370 *you* were testing on! But you shouldn't
project your results on everyone else's, IMHO. 
I'd definitely want to test it on *my* card first, before I believe you. Sorry
'bout that. :)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
