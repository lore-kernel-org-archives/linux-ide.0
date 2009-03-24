From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/14] ide kill unused ide_cmd->special
Date: Wed, 25 Mar 2009 01:06:08 +0900
Message-ID: <1237910776-10983-7-git-send-email-tj@kernel.org>
References: <1237910776-10983-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41822 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762197AbZCXQGg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 12:06:36 -0400
In-Reply-To: <1237910776-10983-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: removal of unused field

No one uses ide_cmd->special anymore.  Kill it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/ide.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index ccaf372..662ea26 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -362,7 +362,6 @@ struct ide_cmd {
 	unsigned int		cursg_ofs;
 
 	struct request		*rq;		/* copy of request */
-	void			*special;	/* valid_t generally */
 };
 
 /* ATAPI packet command flags */
-- 
1.6.0.2

