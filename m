From: Jeff Garzik <jeff@garzik.org>
Subject: [git patch] libata fix
Date: Thu, 9 Jun 2011 21:59:14 -0400
Message-ID: <20110610015914.GA10855@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:41631 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897Ab1FJB73 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Jun 2011 21:59:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/libata-eh.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

Tejun Heo (1):
      libata: fix unexpectedly frozen port after ata_eh_reset()

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index dfb6e9d..7f099d6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2802,10 +2802,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	}
 
 	/*
-	 * Some controllers can't be frozen very well and may set
-	 * spuruious error conditions during reset.  Clear accumulated
-	 * error information.  As reset is the final recovery action,
-	 * nothing is lost by doing this.
+	 * Some controllers can't be frozen very well and may set spurious
+	 * error conditions during reset.  Clear accumulated error
+	 * information and re-thaw the port if frozen.  As reset is the
+	 * final recovery action and we cross check link onlineness against
+	 * device classification later, no hotplug event is lost by this.
 	 */
 	spin_lock_irqsave(link->ap->lock, flags);
 	memset(&link->eh_info, 0, sizeof(link->eh_info));
@@ -2814,6 +2815,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
+	if (ap->pflags & ATA_PFLAG_FROZEN)
+		ata_eh_thaw_port(ap);
+
 	/*
 	 * Make sure onlineness and classification result correspond.
 	 * Hotplug could have happened during reset and some
