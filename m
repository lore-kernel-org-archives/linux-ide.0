From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 86611] USB TO IDE Bridge stopped to work properly after kernel
 upgrade linux-3.12.21 -> linux-3.14.14
Date: Mon, 20 Oct 2014 23:05:37 +0000
Message-ID: <bug-86611-11633-RIdX1gcVqa@https.bugzilla.kernel.org/>
References: <bug-86611-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49866 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbaJTXFm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Oct 2014 19:05:42 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 23F6820221
	for <linux-ide@vger.kernel.org>; Mon, 20 Oct 2014 23:05:40 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 494E02021B
	for <linux-ide@vger.kernel.org>; Mon, 20 Oct 2014 23:05:39 +0000 (UTC)
In-Reply-To: <bug-86611-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=86611

Alan <alan@lxorguk.ukuu.org.uk> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|IDE                         |USB
           Assignee|io_ide@kernel-bugs.osdl.org |greg@kroah.com
            Product|IO/Storage                  |Drivers

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
