From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 49151] NULL pointer dereference in pata_acpi
Date: Tue, 23 Oct 2012 10:01:08 +0000 (UTC)
Message-ID: <20121023100108.399E611FB3D@bugzilla.kernel.org>
References: <bug-49151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34453 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756703Ab2JWKBP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2012 06:01:15 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0396720363
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 10:01:14 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 433FB20366
	for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2012 10:01:08 +0000 (UTC)
In-Reply-To: <bug-49151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=49151





--- Comment #13 from Alan <alan@lxorguk.ukuu.org.uk>  2012-10-23 10:01:07 ---
> So yes, blacklisting it and verifying that your system still operates
> normally would be something to do. If it does, you could also build a
> kernel with pata_acpi disabled (that is, provided you build your own
> kernels).

The crash is still a bug. It needs chasing down.

Alan

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
