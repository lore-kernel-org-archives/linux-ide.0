From: Connor Hansen <cmdkhh@gmail.com>
Subject: [PATCH] ide-cd: signedness warning fix again
Date: Wed,  1 Jun 2011 22:52:05 -0700
Message-ID: <1306993925-26044-1-git-send-email-cmdkhh@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:60574 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab1FBFwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jun 2011 01:52:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: bp@alien8.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Connor Hansen <cmdkhh@gmail.com>

One of the legit warnings 'make W=3 drivers/ide/ide-cd.c'
generates is:
drivers/ide/ide-cd.c: In function ide_cd_do_request
drivers/ide/ide-cd.c:828:2: warning: conversion to int from \
unsigned int may change the sign of the result
drivers/ide/ide-cd.c:833:2: warning: conversion to int from \
unsigned int may change the sign of the result

nsectors is declared int, should be unsigned int.

blk_rq-sectors() returns unsigned int, and ide_complete_rq
expects unsigned int as well.  Fixes both warnings.

Signed-off-by: Connor Hansen <cmdkhh@gmail.com>
---
 drivers/ide/ide-cd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 5d17ab4..0a61f63 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -778,7 +778,8 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 					sector_t block)
 {
 	struct ide_cmd cmd;
-	int uptodate = 0, nsectors;
+	int uptodate = 0;
+	unsigned int nsectors;
 
 	ide_debug_log(IDE_DBG_RQ, "cmd: 0x%x, block: %llu",
 				  rq->cmd[0], (unsigned long long)block);
-- 
1.7.4.4

