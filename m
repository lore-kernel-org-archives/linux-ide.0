From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13921] No CD-ROM ATAPI driver on kernels higher than 2.6.24.x
Date: Thu, 6 Aug 2009 04:29:38 GMT
Message-ID: <200908060429.n764Tc3B008082@demeter.kernel.org>
References: <bug-13921-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54617 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbZHFE3h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Aug 2009 00:29:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n764TcIL008083
	for <linux-ide@vger.kernel.org>; Thu, 6 Aug 2009 04:29:38 GMT
In-Reply-To: <bug-13921-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13921





--- Comment #6 from Robert Hancock <hancockrwd@gmail.com>  2009-08-06 04:29:36 ---
Well, not too much exciting there, it's using the pata_atiixp driver, except
that it's limiting the transfer speed to ATA/33 because of a 40-wire cable
detection.

Can you boot up with a newer distro install disc and get to a command shell
somehow to get at the dmesg output?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
