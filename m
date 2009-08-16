From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4 #upstream] ahci: Gigabyte GA-MA69VM-S2 can't do 64bit
 DMA
Date: Sun, 16 Aug 2009 21:06:57 +0900
Message-ID: <4A87F661.5050801@gmail.com>
References: <4A87F512.3080802@kernel.org> <4A87F55C.3020103@gmail.com> <4A87F5AD.7040508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f196.google.com ([209.85.216.196]:55020 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbZHPMHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Aug 2009 08:07:16 -0400
Received: by pxi34 with SMTP id 34so843716pxi.4
        for <linux-ide@vger.kernel.org>; Sun, 16 Aug 2009 05:07:17 -0700 (PDT)
In-Reply-To: <4A87F5AD.7040508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandor Bodo-Merle <sbodomerle@gmail.com>, "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

Gigabyte GA-MA69VM-S2 can't do 64bit DMA either.  It's yet unknown
whether recent BIOS fixes the problem.  Blacklist regardless of BIOS
revisions for now.

Sandor Bodo-Merle reported and provided the initial patch for this
issue.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc: Shane Huang <shane.huang@amd.com>
---
Sandor, sorry that I ended up redoing this series but without proper
dmi_get_date() it was too ugly.  Your second patch was fine but it
just didn't look right with the manual date parsing callback.

Thanks.

 drivers/ata/ahci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: ata/drivers/ata/ahci.c
===================================================================
--- ata.orig/drivers/ata/ahci.c
+++ ata/drivers/ata/ahci.c
@@ -2624,6 +2624,22 @@ static bool ahci_sb600_32bit_only(struct
 			},
 			.driver_data = "20071026",	/* yyyymmdd */
 		},
+		/*
+		 * It's yet unknown whether more recent BIOS fixes the
+		 * problem.  Blacklist the whole board for the time
+		 * being.  Please read the following thread for more
+		 * info.
+		 *
+		 * http://thread.gmane.org/gmane.linux.ide/42326
+		 */
+		{
+			.ident = "Gigabyte GA-MA69VM-S2",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "Gigabyte Technology Co., Ltd."),
+				DMI_MATCH(DMI_BOARD_NAME, "GA-MA69VM-S2"),
+			},
+		},
 		{ }
 	};
 	const struct dmi_system_id *match;
