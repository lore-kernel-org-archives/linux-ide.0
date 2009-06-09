From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Tue, 9 Jun 2009 21:24:50 GMT
Message-ID: <200906092124.n59LOomC015271@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52650 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbZFIVYs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jun 2009 17:24:48 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n59LOoS8015272
	for <linux-ide@vger.kernel.org>; Tue, 9 Jun 2009 21:24:50 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #15 from Ethan Grammatikidis <eekee57@fastmail.fm>  2009-06-09 21:24:49 ---
Ah, I can give chipset info:

 $ lspci|grep 'IDE\|SATA'
00:1f.2 IDE interface: Intel Corporation 82801IB (ICH9) 2 port SATA IDE
Controller (rev 02)
00:1f.5 IDE interface: Intel Corporation 82801I (ICH9 Family) 2 port SATA IDE
Controller (rev 02)
03:00.0 SATA controller: JMicron Technologies, Inc. 20360/20363 Serial ATA
Controller (rev 03)
03:00.1 IDE interface: JMicron Technologies, Inc. 20360/20363 Serial ATA
Controller (rev 03)

The cable is 40-wire.

I haven't tried the patch. If I feel like opening up my computer again in a few
days I may try it.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
