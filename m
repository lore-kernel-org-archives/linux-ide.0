From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may show errors in pata_amd | pata_acpi
 unless CRS is turned off by pci=nocrs
Date: Fri, 05 Feb 2016 10:18:45 +0000
Message-ID: <bug-111901-11633-sGkH3k9m7I@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59875 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbcBEKSs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 05:18:48 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 56A63203A5
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 10:18:47 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id C15212039D
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 10:18:45 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk
           Hardware|Intel                       |x86-64

--- Comment #2 from Alan <alan@lxorguk.ukuu.org.uk> ---
Not Intel - AMD 8)

Please email the author of the patch and ask them to submit it to stable citing
the bugs. Don't expect a reply for a couple of weeks if Jiang Liu is in China
as it is Chinese new year.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
