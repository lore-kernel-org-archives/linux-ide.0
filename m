From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Sun, 19 Jul 2009 13:21:55 GMT
Message-ID: <200907191321.n6JDLtPj004100@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37042 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbZGSNV4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jul 2009 09:21:56 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n6JDLtFZ004101
	for <linux-ide@vger.kernel.org>; Sun, 19 Jul 2009 13:21:55 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #29 from Mark de Wever <koraq@xs4all.nl>  2009-07-19 13:21:54 ---
I just did some more testing by writing files of different sizes to the
streamer and reading them back. With the 2.6.24-debian kernel the files had the
same size before and after writing. With 2.6.31-rc3 they all return smaller as
written. I did three runs on 2.6.31-rc3 which all produced the same results.
The output of the attached script was:
0    30.copy
0    32.copy
30720    30
32768    32
55296    60.copy
55296    64.copy
61440    60
65536    64
110592    120.copy
110592    128.copy
122880    120
131072    128
221184    240.copy
221184    256.copy
245760    240
262144    256
442368    480.copy
491520    480
497664    512.copy
524288    512
940032    960.copy
983040    960
995328    1024.copy
1048576    1024

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
