From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 102741] pata_hpt37x driver refuses to operate with Adaptec
 1200A at UDMA/100
Date: Wed, 12 Aug 2015 21:41:28 +0000
Message-ID: <bug-102741-11633-gOCkiVw2cs@https.bugzilla.kernel.org/>
References: <bug-102741-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50944 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbbHLVlb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2015 17:41:31 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 97D8D2070E
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 21:41:30 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 303FA20713
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2015 21:41:29 +0000 (UTC)
In-Reply-To: <bug-102741-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102741

--- Comment #4 from Andreas E <andi3@gmx.net> ---
Thanks! It's a butt-ugly hack, but better than nothing for the time being! And
yes, I know Alan was the author. (hence my modinfo output)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
