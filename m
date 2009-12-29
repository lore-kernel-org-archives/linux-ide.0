From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Bug #14909] pata_cmd64x broken in 2.6.33-rc1
Date: Tue, 29 Dec 2009 16:09:59 +0100 (CET)
Message-ID: <NJVdobuNFNK.A.DYH.UnhOLB__8298.79602320052$1262099993$gmane$org@chimera>
References: <LptzGUUXbTK.A.MSF.ymhOLB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38933 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbZL2PNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Dec 2009 10:13:55 -0500
In-Reply-To: <LptzGUUXbTK.A.MSF.ymhOLB@chimera>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Kernel Testers List <kernel-testers@vger.kernel.org>, Alan Cox <alan@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, Jeff Garzik <jgarzik@redhat.com>, "linux-ide@vger.kernel.org"@ogre.sisk.pl, Meelis Roos <mroos@linux.ee>

This message has been generated automatically as a part of a report
of recent regressions.

The following bug entry is on the current list of known regressions
from 2.6.32.  Please verify if it still should be listed and let me know
(either way).


Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=14909
Subject		: pata_cmd64x broken in 2.6.33-rc1
Submitter	: Meelis Roos <mroos@linux.ee>
Date		: 2009-12-19 22:23 (11 days old)
First-Bad-Commit: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d43744390e460dce6626fb8de2c02a24ff650005
References	: http://marc.info/?l=linux-kernel&m=126126142501594&w=4


