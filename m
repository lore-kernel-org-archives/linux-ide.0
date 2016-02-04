From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may show errors in pata_amd | pata_acpi
 unless CRS is turned off by pci=nocrs
Date: Thu, 04 Feb 2016 22:47:36 +0000
Message-ID: <bug-111901-11633-0mnraHWxSF@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58085 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934360AbcBDWrj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Feb 2016 17:47:39 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id CCD9C20357
	for <linux-ide@vger.kernel.org>; Thu,  4 Feb 2016 22:47:37 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0A3D720390
	for <linux-ide@vger.kernel.org>; Thu,  4 Feb 2016 22:47:37 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

--- Comment #1 from Andreas E <andi3@gmx.net> ---
P.S. Above all, it is not sure whether 4.4.x will actually make it into Ubuntu
16.04 (Xenial Xerus) final in April 2016. It may, or it may not...

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
