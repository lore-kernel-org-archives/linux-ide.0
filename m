From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 18 Dec 2012 07:26:51 +0000 (UTC)
Message-ID: <20121218072651.7AD4F11FF10@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49986 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab2LRH0z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2012 02:26:55 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B8D102030F
	for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 07:26:54 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id B68C720307
	for <linux-ide@vger.kernel.org>; Tue, 18 Dec 2012 07:26:53 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #53 from Aaron Lu <aaron.lu@intel.com>  2012-12-18 07:26:50 ---
No I'm afraid. But it already arrived in Linus' tree so should appear in 3.7
stable tree some time later.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
