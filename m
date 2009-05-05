From: Mark de Wever <koraq@xs4all.nl>
Subject: [PATCH] Fix ide-tape compilation error.
Date: Tue, 5 May 2009 23:19:39 +0200
Message-ID: <20090505211939.GA6281@localhost>
References: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com> <20090505211259.GA2723@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:2709 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690AbZEEVXk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2009 17:23:40 -0400
Content-Disposition: inline
In-Reply-To: <20090505211259.GA2723@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: petkovbb@gmail.com, sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, TejunHeo <tj@kernel.org>

This error only occurs when IDETAPE_DEBUG_LOG is enabled.

Signed-off-by: Mark de Wever <koraq@xs4all.nl>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 8dfc688..203bbea 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -617,7 +617,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	struct ide_cmd cmd;
 	u8 stat;
 
-	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu\n"
+	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %lu\n",
 		  (unsigned long long)rq->sector, rq->nr_sectors);
 
 	if (!(blk_special_request(rq) || blk_sense_request(rq))) {
-- 
1.5.6.5

Regards,
Mark de Wever
