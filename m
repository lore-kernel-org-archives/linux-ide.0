From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 20:52:57 +0000 (UTC)
Message-ID: <20121023205257.C66FC11FC25@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57514 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964822Ab2JWUxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 16:53:00 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3E03E2060F
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 20:52:59 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id D003C20609
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 20:52:57 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #21 from Borislav Petkov <bp@alien8.de>  2012-10-23 20:52:57 ---
Ok, looks like the same issue. You could try the debugging patch in comment #14
but I'll go ahead and guess that it'll say

pacpi_set_dmamode: ata_timing_find_mode gives NULL; adev->dma_mode: 0x0

on your system too.

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
