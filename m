From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/7] ide-pmac: bugfix for media-bay support rework
Date: Fri, 13 Jun 2008 01:12:24 +0200
Message-ID: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:25204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241AbYFLXKp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 19:10:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2634644fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 12 Jun 2008 16:10:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org

Fix bug introduced by:

commit 2dde7861afa23cd59db83515cb0b810b92b220aa
Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date:   Fri Apr 18 00:46:23 2008 +0200

    ide: rework PowerMac media-bay support (take 2)
...

[ Yeah, I suck. ]

bay->cd_index shouldn't be changed if IDE devices are not present
or retry operations won't happen.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
first three patches are meant for 2.6.26, the rest for 2.6.27

drivers/macintosh/mediabay.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/macintosh/mediabay.c
===================================================================
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -556,7 +556,8 @@ static void media_bay_step(int i)
 				printk("mediabay %d, registering IDE...\n", i);
 				pmu_suspend();
 				ide_port_scan(bay->cd_port);
-				bay->cd_index = bay->cd_port->index;
+				if (bay->cd_port->present)
+					bay->cd_index = bay->cd_port->index;
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
