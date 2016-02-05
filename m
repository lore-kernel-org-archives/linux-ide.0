From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111901] Pre-2008 boards may show errors in pata_amd | pata_acpi
 unless CRS is turned off by pci=nocrs
Date: Fri, 05 Feb 2016 18:53:27 +0000
Message-ID: <bug-111901-11633-Plu2uS4hwt@https.bugzilla.kernel.org/>
References: <bug-111901-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35941 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbcBESxb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Feb 2016 13:53:31 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 53A36202A1
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 18:53:30 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id CD78A20384
	for <linux-ide@vger.kernel.org>; Fri,  5 Feb 2016 18:53:27 +0000 (UTC)
In-Reply-To: <bug-111901-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111901

Oleg Blashchuk <2contras@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |2contras@gmail.com

--- Comment #3 from Oleg Blashchuk <2contras@gmail.com> ---
(In reply to Alan from comment #2)
> Not Intel - AMD 8)

Actually, it's not because of AMD, but seems to be the problem of nVidia
nForce2 Ultra 400 chipset. I've got plenty of legacy AMD-based computers,
mainly on different VIA chipsets - they all are not touched by this issue. Even
computers with nVidia nForce2 IGP chipset works fine. Seems that Ultra 400
claims to support address ranges above 4GB, but IDE controller on the
corresponding south-bridge actually does not support working in that area.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
