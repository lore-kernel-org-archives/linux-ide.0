From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 9 Dec 2009 06:29:55 GMT
Message-ID: <200912090629.nB96TtnF005098@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54955 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbZLIG3t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Dec 2009 01:29:49 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nB96TtiG005099
	for <linux-ide@vger.kernel.org>; Wed, 9 Dec 2009 06:29:55 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #26 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-12-09 06:29:53 ---
Thanks. I'm not a kernel developer, but I get the general gist of that. 
However, there are several reasons that I don't think this is necessarily a bug
in the SSD device.

Firstly, it affects a range of SSD devices from different manufacturers and
different production dates.  I guess they could share common firmware (and
hence the same bug), but that has to be rather remote possibility.

Secondly, the SSD devices are performing without issue on 2.6.28 (and one
report of 2.6.30), but the same machines fail on 2.6.31/2.6.32.  This suggests
something changed in the kernel that affects the SSD between 2.6.30 and 2.6.31.

Thirdly, these machines were often sold with factory installed Linux.  O.K., so
it was an earlier kernel, but the SSD has clearly worked enough to met the
manufacturer's satisfaction.

Fourthly, (and this where I show I'm not a developer), we are only seeing the
end result of the transaction (the HSM violation).  Could there have been
several erroneous - but not out-of-band - command/response exchanges leading up
to the HSM violation?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
