From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata via probe fix
Date: Wed, 8 Nov 2006 07:48:27 -0500
Message-ID: <20061108124827.GA7348@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:5565 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965593AbWKHMse (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 07:48:34 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/sata_via.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Jeff Garzik:
      [libata] sata_via: fix obvious typo

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f4455a1..1c7f19a 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -230,7 +230,7 @@ static int vt6420_prereset(struct ata_po
 	int online;
 
 	/* don't do any SCR stuff if we're not loading */
-	if (!ATA_PFLAG_LOADING)
+	if (!(ap->pflags & ATA_PFLAG_LOADING))
 		goto skip_scr;
 
 	/* Resume phy.  This is the old resume sequence from
