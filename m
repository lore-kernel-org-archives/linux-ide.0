From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] [pata_amd][pata_acpi] Internal base address register
 error prevents initialization of PATA drive
Date: Sat, 23 Jan 2016 11:43:55 +0000
Message-ID: <bug-111151-11633-LRxuUTFp1D@https.bugzilla.kernel.org/>
References: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51725 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbcAWLn6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Jan 2016 06:43:58 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 784EF20462
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 11:43:57 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id F370D20483
	for <linux-ide@vger.kernel.org>; Sat, 23 Jan 2016 11:43:55 +0000 (UTC)
In-Reply-To: <bug-111151-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #4 from Alan <alan@lxorguk.ukuu.org.uk> ---
Helpful to know - if you can attach an lspci -vvxxx from both the failing and
working cases then we have a good chance of pinning down what is going on.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
