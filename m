From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 20:41:39 +0000 (UTC)
Message-ID: <20121023204139.7134D11FC3E@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56873 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933821Ab2JWUln (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 16:41:43 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D5F1B205AA
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 20:41:42 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 146EF205A7
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 20:41:42 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #20 from Szymon Janc <szymon@janc.net.pl>  2012-10-23 20:41:38 ---
Created an attachment (id=84521)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=84521)
crash on A8N-E

not scaled image (~2MiB) available at http://janc.net.pl/DSC_1062.jpg

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
