From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Tue, 10 Nov 2009 06:38:40 GMT
Message-ID: <200911100638.nAA6cejP009075@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41575 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbZKJGie (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 01:38:34 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAA6ceiq009076
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2009 06:38:40 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515





--- Comment #8 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-10 06:38:36 ---
O.K., it would appear then that this is not related to Ubuntu bug #445852,
since the machines in this bug report don't have cdrom drives.

Trying "hal-disable-polling --device /dev/sr0", just gives an error.

Should I open a different bug report?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
