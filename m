From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 12:54:17 +0000 (UTC)
Message-ID: <20121023125417.450B711FB3D@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39604 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab2JWMyT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 08:54:19 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3C94720326
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 12:54:18 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 4837F20317
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 12:54:17 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #16 from Anton Boyarshinov <boyarsh@altlinux.org>  2012-10-23 12:54:17 ---

> +        pr_err("%s: ata_timing_find_mode gives NULL; adev->dma_mode: 0x%x\n",
> +               __func__, adev->dma_mode);

pacpi_set_dmamode: ata_timing_find_mode gives NULL; adev->dma_mode: 0x0

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
