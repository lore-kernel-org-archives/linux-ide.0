From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Thu, 1 May 2008 14:18:38 +0200
Message-ID: <200805011418.39999.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:25789 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbYEAMC7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 08:02:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so443923nfc.21
        for <linux-ide@vger.kernel.org>; Thu, 01 May 2008 05:02:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Regression fix for some host drivers using MMIO, i.e. siimage
(big thanks to Jeremy Kerr for the detailed bug analysis).


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/ide-probe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


Bartlomiej Zolnierkiewicz (1):
      ide: fix early setup of hwif->host_flags


diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 099a0fe..591deda 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1347,7 +1347,8 @@ static void ide_init_port(ide_hwif_t *hwif, unsigned int port,
 	    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS))
 		hwif->irq = port ? 15 : 14;
 
-	hwif->host_flags = d->host_flags;
+	/* ->host_flags may be set by ->init_iops (or even earlier...) */
+	hwif->host_flags |= d->host_flags;
 	hwif->pio_mask = d->pio_mask;
 
 	/* ->set_pio_mode for DTC2278 is currently limited to port 0 */
