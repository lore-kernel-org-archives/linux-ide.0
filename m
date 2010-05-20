From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 18:51:51 GMT
Message-ID: <201005201851.o4KIpp1M032134@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47522 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0ETSvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 14:51:51 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4KIppcC032135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 18:51:51 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #31 from Alan <alan@lxorguk.ukuu.org.uk>  2010-05-20 18:51:27 ---
It's defined by a standard. It's expected behaviour since the 1970s. "I don't
like it" doesn't trump standards, especially given most users *expect* the
current behaviour.

The kernel provides a lot of information including cpu loading per cpu, I/O
loadings and the like. It' up to applications how they display it.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
