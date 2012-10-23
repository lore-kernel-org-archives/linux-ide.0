From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 20:11:07 +0000 (UTC)
Message-ID: <20121023201107.D691511FC25@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55296 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933220Ab2JWULK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 16:11:10 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5E98E204D1
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 20:11:09 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 3AA32204CF
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 20:11:08 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #19 from Borislav Petkov <bp@alien8.de>  2012-10-23 20:11:07 ---
(In reply to comment #18)
> Hi,
> 
> I see this crash on pc with ASUS A8N-E board (about half of boot attempts).
> 
> But only if both pata_acpi and pata_amd are loaded... I've disabled pata_amd
> and I'm not able to reproduce this (tried 10 reboots) if only pata_acpi is
> used.

Can you catch the oops and upload it, a readable photo from a digicam
suffices too, as long as the oops is complete.

Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
