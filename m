From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13921] No CD-ROM ATAPI driver on kernels higher than 2.6.24.x
Date: Thu, 6 Aug 2009 12:11:32 GMT
Message-ID: <200908061211.n76CBWwS008598@demeter.kernel.org>
References: <bug-13921-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:49019 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbZHFMLb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 08:11:31 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n76CBWwT008599
	for <linux-ide@vger.kernel.org>; Thu, 6 Aug 2009 12:11:32 GMT
In-Reply-To: <bug-13921-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13921





--- Comment #8 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-08-06 12:11:31 ---
Ubuntu uses libata (Debian still uses IDE BTW).

pata_atiixp have blatant bugs which were never present in atiixp (I happen to
be co-author of the original driver)..  I'll send a fix later today..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
