From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Tue, 16 Dec 2008 14:02:41 -0800 (PST)
Message-ID: <20081216220241.48E82108042@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33661 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752596AbYLPWCn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 17:02:43 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBGM2fFE028881
	for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 14:02:42 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #18 from bzolnier@gmail.com  2008-12-16 14:02 -------
Thanks.

You're using libata ata_piix driver in 2.6.27.7 and IDE piix one in 2.6.26-1.

To try Borislav's patch you need to use IDE piix host driver and ide-cd device
driver.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
