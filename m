From: Alan Cox <alan@redhat.com>
Subject: PATCH: restore raw_taskfile in hwif_restore
Date: Sun, 15 Aug 2004 11:00:52 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040815150052.GA11639@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:25822 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266763AbUHOPBt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 11:01:49 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-12 17:55:05.000000000 +0100
@@ -618,6 +710,7 @@
 	hwif->maskproc			= tmp_hwif->maskproc;
 	hwif->quirkproc			= tmp_hwif->quirkproc;
 	hwif->busproc			= tmp_hwif->busproc;
+	hwif->raw_taskfile		= tmp_hwif->raw_taskfile;
 
 	hwif->ata_input_data		= tmp_hwif->ata_input_data;
 	hwif->ata_output_data		= tmp_hwif->ata_output_data;

Signed-off-by: Alan Cox <alan@redhat.com>

