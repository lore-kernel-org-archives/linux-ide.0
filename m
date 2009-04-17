From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/15] ide kill unused ide_cmd->special
Date: Fri, 17 Apr 2009 18:33:12 +0900
Message-ID: <1239960802-31978-6-git-send-email-tj@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39983 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083AbZDQJdn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:43 -0400
In-Reply-To: <1239960802-31978-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: removal of unused field

No one uses ide_cmd->special anymore.  Kill it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/ide.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index ff65fff..846a1e1 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -324,7 +324,6 @@ struct ide_cmd {
 	unsigned int		cursg_ofs;
 
 	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
 };
 
 /* ATAPI packet command flags */
-- 
1.6.0.2

