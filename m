From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sat,  3 Nov 2012 04:26:40 +0000 (UTC)
Message-ID: <20121103042640.4003A11FB83@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:48252 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2KCE0n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2012 00:26:43 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 857DB2020E
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 04:26:42 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id E710020214
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 04:26:40 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #33 from Borislav Petkov <bp@alien8.de>  2012-11-03 04:26:39 ---
On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
> Which is an ATA layer bug - adev->dma_mode should never be called
> without a DMA mode in normal use.

Ok, it looks like this would take a while to fix.

Alan, what is your suggestion for a proper fix, uncomment XFER_PIO_SLOW
and drop to it with a big warning that ACPI is giving botched
information on those chips and people should try using the
platform-specific driver if they want better/optimal speeds?

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
