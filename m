From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/4] ide-tape: fix debug call
Date: Wed, 15 Jul 2009 17:18:17 +0200
Message-ID: <1247671100-8173-2-git-send-email-petkovbb@gmail.com>
References: <1247671100-8173-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:38534 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZGOPS0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jul 2009 11:18:26 -0400
In-Reply-To: <1247671100-8173-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Mark de Wever <koraq@xs4all.nl>

From: Mark de Wever <koraq@xs4all.nl>

This error only occurs when IDETAPE_DEBUG_LOG is enabled.

Signed-off-by: Mark de Wever <koraq@xs4all.nl>
---
 drivers/ide/ide-tape.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 013dc59..60d5c41 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -583,7 +583,7 @@ static ide_startstop_t idetape_do_request(ide_drive_t *drive,
 	struct ide_cmd cmd;
 	u8 stat;
 
-	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %u\n"
+	debug_log(DBG_SENSE, "sector: %llu, nr_sectors: %u\n",
 		  (unsigned long long)blk_rq_pos(rq), blk_rq_sectors(rq));
 
 	BUG_ON(!(blk_special_request(rq) || blk_sense_request(rq)));
-- 
1.6.3.1

