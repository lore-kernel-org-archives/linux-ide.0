From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Thu, 29 Nov 2012 02:22:12 +0000 (UTC)
Message-ID: <20121129022212.081ED11FED7@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:45996 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925Ab2K2CWQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2012 21:22:16 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id ADEBB20441
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2012 02:22:15 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 48B952044E
	for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2012 02:22:14 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #45 from Aaron Lu <aaron.lu@intel.com>  2012-11-29 02:22:11 ---
Created an attachment (id=87661)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=87661)
Fix ata_dma_enabled

Hi all,

After another thought, 0 is actually not a valid dma mode either, so probably
we should fix ata_dma_enabled instead of setting 0xff beforehand.

Attached a new patch for test, sorry for the trouble.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
