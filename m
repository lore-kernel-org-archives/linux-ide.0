From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may show errors in pata_amd | pata_acpi
 unless CRS is turned off by pci=nocrs
Date: Fri, 05 Feb 2016 21:12:51 +0000
Message-ID: <bug-111901-11633-2b8MV2dajT@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42994 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757272AbcBEVMz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 16:12:55 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 798B8201EC
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 21:12:54 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 170B3203AC
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 21:12:52 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

--- Comment #6 from Andreas E <andi3@gmx.net> ---
and to comment 3:

FYI, I've got a DFI nfII Ultra-AL here, which, tadaa, indeed got a NForce2
Ultra _400_ chipset (+nForce2 MCP (Master Control Program). So your assumption
seems spot-on.

End Of Line.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
