From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Thu, 17 Sep 2009 06:47:00 GMT
Message-ID: <200909170647.n8H6l0lK023098@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:45895 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbZIQGq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2009 02:46:56 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8H6l0fl023099
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2009 06:47:00 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #55 from Borislav Petkov <bbpetkov@yahoo.de>  2009-09-17 06:46:57 ---
(In reply to comment #53)

Hi David,

sorry for the delay but I was very busy at work.

> Created an attachment (id=23073)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=23073) [details]
> dmesg
> 
> That patch still lets drive->debug_mask get overridden from the module
> parameter, shortly after you manually set it to 0xffffffff. With that fixed,
> here's the output.

Yeah, this _was_ work in progress and is not the final ide stage we
aimed at but since we're not allowed to hack on it anymore, we'll have
to live with that, sorry.

Ok, if I'm not mistaken, it seems that your drive gets a bunch
of ioctls fired at it and it cannot exec even one command
successfully and slaps a sense request after each one. At oops
time, the sense request itself fails and it gets completed twice
therefore the hwif->rq being NULL. Can you try the testfix1
(http://bugzilla.kernel.org/attachment.cgi?id=23110) above to see
whether this fixes it?

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
