From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 51841] sata_sil falls off some time after boot
Date: Wed,  2 Jan 2013 14:30:34 +0000 (UTC)
Message-ID: <20130102143034.8164B11FF04@bugzilla.kernel.org>
References: <bug-51841-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33888 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab3ABOal (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jan 2013 09:30:41 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B5AEA202BE
	for <linux-ide@vger.kernel.org>; Wed,  2 Jan 2013 14:30:39 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id B67BF202F2
	for <linux-ide@vger.kernel.org>; Wed,  2 Jan 2013 14:30:38 +0000 (UTC)
In-Reply-To: <bug-51841-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=51841


Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk
          Component|IDE                         |Serial ATA
         AssignedTo|io_ide@kernel-bugs.osdl.org |jgarzik@pobox.com




--- Comment #1 from Alan <alan@lxorguk.ukuu.org.uk>  2013-01-02 14:30:34 ---
>From the errors it looks like you may have a hardware problem - inadequate
power/bad cable or similar.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
