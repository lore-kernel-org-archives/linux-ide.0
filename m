From: Elias Oltmanns <eo@nebensachen.de>
Subject: Disk shock protection in libata
Date: Fri, 19 Sep 2008 23:41:08 +0200
Message-ID: <87tzcb7r0r.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:54726 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbYISVlt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Sep 2008 17:41:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Hi all,

since Bart has already added patches #1, #3 and #4 of my previous series
to his pata tree, I'm now going to resend only patches #1 and #2. There
are no changes to the first one, it is just that the second depends on
it. The crucial difference between the provious and the new version of
the second patch is that we now use completion rather than simple wait
queues and wake up calls, so as not to interfere with msleep() during
command execution in ata_eh_park_issue_cmd(). The patches have been
rebased to next-20080919.

Regards,

Elias
