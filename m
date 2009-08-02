From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Sun, 2 Aug 2009 10:53:02 GMT
Message-ID: <200908021053.n72Ar2NA023682@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54767 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbZHBKxC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Aug 2009 06:53:02 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n72Ar2Cr023683
	for <linux-ide@vger.kernel.org>; Sun, 2 Aug 2009 10:53:02 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #17 from Alan <alan@lxorguk.ukuu.org.uk>  2009-08-02 10:53:01 ---
Because someone didn't bother fitting a suitable capacitor I would imagine (ATA
5 AnnexB). It may also be the boot process before Linux runs (eg ACPI) samples
and confuses stuff. Neither the VIA nor the Nvidia reliabily support drive side
detect and Nvidia in fact specify the use of ACPI for detection purposes should
always be done.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
