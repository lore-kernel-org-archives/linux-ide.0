From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Thu, 21 May 2009 07:27:03 GMT
Message-ID: <200905210727.n4L7R3Eq014764@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52398 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbZEUH1C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 03:27:02 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4L7R3si014765
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 07:27:03 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #7 from Borislav Petkov <bbpetkov@yahoo.de>  2009-05-21 07:27:02 ---
Can you send us the dmesg of the working kernel, I'd like to see what is the
drive model exactly when it gets identified. Also, are you using 40 or 80 wires
IDE cable? You can recognize the 80 wires cable by the blue connector on the
host side (the end that goes into the motherboard).

@Bart: presumably, this sounds like another one b0rked drive-side cable
detection, from what I've seen so far and looking at Martin's error messages.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
