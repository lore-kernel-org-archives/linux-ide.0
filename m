From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: new reset mechanism, take#2
Date: Tue, 24 Jan 2006 17:05:21 +0900
Message-ID: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.196]:6342 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030352AbWAXIF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:29 -0500
Received: by xproxy.gmail.com with SMTP id s14so770397wxc
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:26 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: htejun@gmail.com


Hello, all.

This is the second take of new reset mechanism patchset and against
upstream-2.6.17 + eh-misc-updates patchset + three ahci update patches
I've sent yesterday.

The goals of new reset mechanism are.

* Do not allow individual reset methods manipulate libata internal
  data structures (e.g. disable port) to give more control to higher
  driving logic (e.g. to allow retries).

* Goes hand-in-hand with above.  Make low level operations easily
  shareable with other uses (probe and EH).

* Minimize code duplications but yet allow flexibility if needed.

Major difference from the first take is that core layer doesn't
directly drive resets anymore.  It just calls ->probe_reset and the
rest is upto the low level driver.  However, as reset driving logic is
identical for most drivers, helper routines are supplied such that low
level drivers only have to implement supported reset operations.

Jeff, I think the above change hopefully resolves your concern about
fixed driving logic.  The other issue was regarding how reset itself
should be performed - resets are event-driven in nature and should be
implemented accordingly as a qc protocol.  I still disagree and don't
really see how it can be done.  My rationales are in the following two
messages.  Can you please share your thoughts in deeper detail?

http://marc.theaimsgroup.com/?l=linux-ide&m=113497224219265&w=2
http://marc.theaimsgroup.com/?l=linux-ide&m=113497644716191&w=2

Thanks.

--
tejun


