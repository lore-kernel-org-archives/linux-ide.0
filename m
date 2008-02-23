From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: [PATCH 06/10] IDE: Coding Style fixes to
 drivers/ide/legacy/ide-4drives.c
Date: Sat, 23 Feb 2008 15:05:32 +0100
Message-ID: <20080223150532.7b33250c@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:33567 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbYBWOFh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 09:05:37 -0500
Received: by fg-out-1718.google.com with SMTP id e21so582555fga.17
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 06:05:36 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

File is now error and warning free.
Compile tested.


Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 drivers/ide/legacy/ide-4drives.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/legacy/ide-4drives.c b/drivers/ide/legacy/ide-4drives.c
index d7bc94f..c352f12 100644
--- a/drivers/ide/legacy/ide-4drives.c
+++ b/drivers/ide/legacy/ide-4drives.c
@@ -4,7 +4,7 @@
 #include <linux/module.h>
 #include <linux/ide.h>
 
-int probe_4drives = 0;
+int probe_4drives;
 
 module_param_named(probe, probe_4drives, bool, 0);
 MODULE_PARM_DESC(probe, "probe for generic IDE chipset with 4 drives/port");
-- 
1.5.4.2.316.gf7a7

