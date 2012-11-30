From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Fri, 30 Nov 2012 17:10:35 +0000 (UTC)
Message-ID: <20121130171035.51B2311FEB6@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54848 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031251Ab2K3RKm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2012 12:10:42 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0ED922054D
	for <linux-ide@vger.kernel.org>; Fri, 30 Nov 2012 17:10:41 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id AD2152055F
	for <linux-ide@vger.kernel.org>; Fri, 30 Nov 2012 17:10:38 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #47 from Bernd Buschinski <b.buschinski@googlemail.com>  2012-11-30 17:10:34 ---
Also boots fine here, thx :)
That makes the first bootable 3.6 kernel(with patch) for me, I hope this patch
gets upstream soon

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
