From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Thu, 15 Nov 2012 18:07:32 +0000 (UTC)
Message-ID: <20121115180732.2888F11FEDC@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:45132 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768597Ab2KOSHj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2012 13:07:39 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 1B87E2033B
	for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2012 18:07:38 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 851EB2034C
	for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2012 18:07:33 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #38 from Szymon Janc <szymon@janc.net.pl>  2012-11-15 18:07:31 ---
Created an attachment (id=86441)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=86441)
dmesg

dmesg on A8N-E with some extra prints

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
