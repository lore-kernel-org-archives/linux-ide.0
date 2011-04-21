From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] block: don't propagate unlisted DISK_EVENTs to userland
Date: Thu, 21 Apr 2011 19:08:26 +0200
Message-ID: <20110421170826.GC15988@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61267 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab1DURIb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2011 13:08:31 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Neil Brown <neilb@suse.de>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kay.sievers@vrfy.org

DISK_EVENT_MEDIA_CHANGE is used for both userland visible event and
internal event for revalidation of removeable devices.  Some legacy
drivers don't implement proper event detection and continuously
generate events under certain circumstances.  For example, ide-cd
generates media changed continuously if there's no media in the drive,
which can lead to infinite loop of events jumping back and forth
between the driver and userland event handler.

This patch updates disk event infrastructure such that it never
propagates events not listed in disk->events to userland.  Those
events are processed the same for internal purposes but uevent
generation is suppressed.

This also ensures that userland only gets events which are advertised
in the @events sysfs node lowering risk of confusion.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
These two patches fix infinite MEDIA_CHANGE events problem reported w/
ide-cd.  I tried an alternate patch to implement proper check_events()
for ide-cd but given the deprecated status of ide and the existence of
fallback userland event polling, this minimal approach seems better.

Thank you.

 block/genhd.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: work/block/genhd.c
===================================================================
--- work.orig/block/genhd.c
+++ work/block/genhd.c
@@ -1588,9 +1588,13 @@ static void disk_events_workfn(struct wo
 
 	spin_unlock_irq(&ev->lock);
 
-	/* tell userland about new events */
+	/*
+	 * Tell userland about new events.  Only the events listed in
+	 * @disk->events are reported.  Unlisted events are processed the
+	 * same internally but never get reported to userland.
+	 */
 	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
-		if (events & (1 << i))
+		if (events & disk->events & (1 << i))
 			envp[nr_events++] = disk_uevents[i];
 
 	if (nr_events)
