From: Tejun Heo <tj@kernel.org>
Subject: [PATCH UPDATED #upstream-fixes] libata: fix unexpectedly frozen
 port after ata_eh_reset()
Date: Wed, 25 May 2011 13:19:39 +0200
Message-ID: <20110525111939.GI10146@htj.dyndns.org>
References: <20110525100232.GG10146@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43631 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab1EYLTo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2011 07:19:44 -0400
Received: by fxm17 with SMTP id 17so5280046fxm.19
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2011 04:19:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110525100232.GG10146@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Bruce Stenning <b.stenning@indigovision.com>, Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>

To work around controllers which can't properly plug events while
reset, ata_eh_reset() clears error states and ATA_PFLAG_EH_PENDING
after reset but before RESET is marked done.  As reset is the final
recovery action and full verification of devices including onlineness
and classfication match is done afterwards, this shouldn't lead to
lost devices or missed hotplug events.

Unfortunately, it forgot to thaw the port when clearing EH_PENDING, so
if the condition happens after resetting an empty port, the port could
be left frozen and EH will end without thawing it, making the port
unresponsive to further hotplug events.

Thaw if the port is frozen after clearing EH_PENDING.  This problem is
reported by Bruce Stenning in the following thread.

 http://thread.gmane.org/gmane.linux.kernel/1123265

stable: I think we should weather this patch a bit longer in -rcX
	before sending it to -stable.  Please wait at least a month
	after this patch makes upstream.  Thanks.

-v2: Fixed spelling in the comment per Dave Howorth.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Bruce Stenning <b.stenning@indigovision.com>
Cc: stable@kernel.org
Cc: Dave Howorth <dhoworth@mrc-lmb.cam.ac.uk>
---
 drivers/ata/libata-eh.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

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
