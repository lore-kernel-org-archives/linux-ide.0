From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 22 Oct 2012 21:06:26 +0000 (UTC)
Message-ID: <20121022210626.83E5211FAE1@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:45496 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157Ab2JVVGd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2012 17:06:33 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 522E4203D5
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 21:06:32 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 8BF70203E4
	for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2012 21:06:31 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #12 from Borislav Petkov <bp@alien8.de>  2012-10-22 21:06:26 ---
... and pata_amd should be supporting your IDE interface.

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
