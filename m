From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream] libata: leave port thawed after reset failure
Date: Wed, 25 May 2011 12:23:56 +0200
Message-ID: <20110525102356.GH10146@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42749 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1EYKYC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2011 06:24:02 -0400
Received: by wwa36 with SMTP id 36so8310022wwa.1
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2011 03:24:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Reartes Guillermo <rtguille@gmail.com>, Bruce Stenning <b.stenning@indigovision.com>

libata EH intentionally left a port frozen if it failed
ata_eh_reset().  The intention was avoiding continuous loop of resets
when the controller or attached device is flaky and reporting spurious
hotplug events.  Once port enters this state, it can be recovered with
manual rescan, which seemed reasonable.

However, outside of my convoluted test setup, there have been very few
reports justifying this choice while there have been more cases where
the automatic freezing of the port after hotplug attempt of a faulty
device caused confusion and led to unnecessary resets.

This patch changes the behavior so that the port is thawed after reset
failure.  This change doesn't necessarily solve but makes it easier
and more intuitive to work around hotplug related problems
(ie. re-pluggin or power cycling the device) as reported in the
followings.

  https://bugzilla.kernel.org/show_bug.cgi?id=34712
  http://thread.gmane.org/gmane.linux.kernel/1123265/focus=49548

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Reartes Guillermo <rtguille@gmail.com>
Reported-by: Bruce Stenning <b.stenning@indigovision.com>
---
 drivers/ata/libata-eh.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index dfb6e9d..05797fe 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2885,8 +2885,17 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	    sata_scr_read(link, SCR_STATUS, &sstatus))
 		rc = -ERESTART;
 
-	if (rc == -ERESTART || try >= max_tries)
+	if (rc == -ERESTART || try >= max_tries) {
+		/*
+		 * Thaw host port even if reset failed, so that the port
+		 * can be retried on the next phy event.  This risks
+		 * repeated EH runs but seems to be a better tradeoff than
+		 * shutting down a port after a botched hotplug attempt.
+		 */
+		if (ata_is_host_link(link))
+			ata_eh_thaw_port(ap);
 		goto out;
+	}
 
 	now = jiffies;
 	if (time_before(now, deadline)) {
