From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Mon, 29 Oct 2012 13:36:14 +0000 (UTC)
Message-ID: <20121029133614.8985C11FB81@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50400 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab2J2NgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2012 09:36:21 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B18542037D
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2012 13:36:20 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 0851A20383
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2012 13:36:16 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #29 from cthx <sntmail@gmail.com>  2012-10-29 13:36:13 ---
Created an attachment (id=85211)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=85211)
crash on asus m2n32_sli_deluxe

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
