From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sat,  3 Nov 2012 04:23:21 +0000 (UTC)
Message-ID: <20121103042321.8F5B111FB82@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:48147 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab2KCEXZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2012 00:23:25 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1356B2021B
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 04:23:24 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 2374320215
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 04:23:23 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #32 from Borislav Petkov <bp@alien8.de>  2012-11-03 04:23:21 ---
You could try enabling the platform-specific pata driver for your system and
don't compile pata_acpi at all. Until libata folks fix this properly, that
is...

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
