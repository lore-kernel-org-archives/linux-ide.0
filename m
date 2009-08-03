From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] Cannot read CD: "Logical unit communication CRC error"
Date: Mon, 3 Aug 2009 21:49:32 GMT
Message-ID: <200908032149.n73LnWjd010491@demeter.kernel.org>
References: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35165 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbZHCVtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2009 17:49:32 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n73LnWRu010492
	for <linux-ide@vger.kernel.org>; Mon, 3 Aug 2009 21:49:32 GMT
In-Reply-To: <bug-13882-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882





--- Comment #19 from Alan <alan@lxorguk.ukuu.org.uk>  2009-08-03 21:49:31 ---
2.6.24 has various differences, without knowing exactly what path is taken it's
hard to tell. Most likely the fact the old code erroneously also checked drvie
detect on VIA (which broke lots of systems) happened by luck to make yours
work.

One way to test that would be to make the cases which return ATA_CBL_PATA80 in
the pata_via driver return ATA_CBL_PATA_UNK and see if that helps you. If it
does we are probably going to have to special case some boards by PCI svid/sdid
8(

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
