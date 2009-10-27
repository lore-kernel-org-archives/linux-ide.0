From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0 hang
Date: Tue, 27 Oct 2009 08:35:27 GMT
Message-ID: <200910270835.n9R8ZRB2007651@demeter.kernel.org>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:40112 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbZJ0IfX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2009 04:35:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9R8ZRoT007652
	for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2009 08:35:27 GMT
In-Reply-To: <bug-14310-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14310





--- Comment #6 from Jiri Bohac <jbohac@jikos.cz>  2009-10-27 08:35:25 ---
(In reply to comment #5)
> Jiri, please try the patch from
> 
> http://bugzilla.kernel.org/attachment.cgi?id=23513

Great, this patch, applied on 2.6.31.5, fixes the problem for me.

Out of curiosity, I also tried to revert the original fix
(e13ee546bb06453939014c7b854e77fb643fd6f1) and, with the debug patch still
applied, it still worked.

So maybe 6029336426a2b43e4bc6f4a84be8789a047d139e causes two independent
problems in sis5513? One fixed with e13ee546bb06453939014c7b854e77fb643fd6f1
and one fixed with this debug patch?

It would be great if this patch could be added to the stable tree. Thanks!

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
