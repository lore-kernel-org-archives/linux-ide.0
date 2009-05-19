From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Tue, 19 May 2009 21:43:34 GMT
Message-ID: <200905192143.n4JLhYKI031285@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37574 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZESVnd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 17:43:33 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4JLhYR3031286
	for <linux-ide@vger.kernel.org>; Tue, 19 May 2009 21:43:34 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #1 from Modestas Vainius <modestas@vainius.eu>  2009-05-19 21:43:34 ---
Created an attachment (id=21440)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21440)
Some information about my system/kernel configuration

uname -a
lsmod
lspci -vv

and kernel config

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
