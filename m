From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sat,  3 Nov 2012 07:37:05 +0000 (UTC)
Message-ID: <20121103073705.85A0411FB82@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50439 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab2KCHhJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2012 03:37:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B9B4D20212
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 07:37:07 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id CF0042020B
	for <linux-ide@vger.kernel.org>; Sat,  3 Nov 2012 07:37:06 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #34 from Roland Bogner <geist1@sms.at>  2012-11-03 07:37:04 ---
(In reply to comment #32)
> You could try enabling the platform-specific pata driver for your system and
> don't compile pata_acpi at all. Until libata folks fix this properly, that
> is...
> 
> Thanks.

well for me it is not a big problem without IDE, since my system runs completly
on SATA and this still works fine with the kernel.

Unfortunatly distribution dudes will have big problems when they release the
kernel for the masses, they can't just disable IDE support at all.

Why this problems appeaers now in the kernel, previous ones worked pretty fine.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
