From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Wed, 24 Oct 2012 15:25:34 +0000 (UTC)
Message-ID: <20121024152534.A5E8611FC43@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57621 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933729Ab2JXPZm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2012 11:25:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B37682037D
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 15:25:37 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 064C42035E
	for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2012 15:25:36 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #26 from Szymon Janc <szymon@janc.net.pl>  2012-10-24 15:25:34 ---
just to confirm..

[    5.004024] pacpi_set_dmamode: ata_timing_find_mode gives NULL;
adev->dma_mode: 0x0
[    5.770251] pacpi_set_dmamode: ata_timing_find_mode gives NULL;
adev->dma_mode: 0x0

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
