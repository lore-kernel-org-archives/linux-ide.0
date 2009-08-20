From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Thu, 20 Aug 2009 06:41:11 GMT
Message-ID: <200908200641.n7K6fBVF008669@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36399 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbZHTGlJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Aug 2009 02:41:09 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n7K6fBOW008670
	for <linux-ide@vger.kernel.org>; Thu, 20 Aug 2009 06:41:11 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #37 from Borislav Petkov <bbpetkov@yahoo.de>  2009-08-20 06:41:10 ---
Hi Mark,

ok, we have to wheel out the heavy guns. In ide-next I've got an
ide-tape debugging patch for the whole driver. Get the tree at
git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide-next-2.6.git and
apply the patch at http://bugzilla.kernel.org/attachment.cgi?id=22782
and catch the _whole_ output while doing only one filesize, let's say:

cat /tmp/32 >/dev/ht0
cat /dev/ht0 > /tmp/32.copy


Try setting log_buf_len=10M kernel parameter in case the output gets
truncated since it is quite a lot.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
