From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Sat, 20 Oct 2012 10:33:09 +0000 (UTC)
Message-ID: <20121020103309.CF05B11FC39@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39488 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843Ab2JTKdL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2012 06:33:11 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AA0B520199
	for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2012 10:33:10 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id D7DD120193
	for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2012 10:33:09 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #2 from Phillip Wood <phillip.wood@dunelm.org.uk>  2012-10-20 10:33:09 ---
Created an attachment (id=84111)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=84111)
First page of backtrace

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
