From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 11 Nov 2009 08:59:36 GMT
Message-ID: <200911110859.nAB8xaEd007187@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:33059 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbZKKI7b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2009 03:59:31 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAB8xb7s007189
	for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2009 08:59:37 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #6 from Tejun Heo <tj@kernel.org>  2009-11-11 08:59:33 ---
Hmmm... it's a CF device which forgets to send interrupt from time to time. 
Does "irqpoll" help?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
