From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 19/24] ide-tape: remove pipelined mode parameters
Date: Sat,  1 Mar 2008 09:58:43 +0100
Message-ID: <1204361928-30229-20-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:64804 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774AbYCAI70 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:26 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2626779nfb.21
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:25 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 2718006..a5f29ea 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -75,24 +75,6 @@ enum {
 
 
 /*
- * Pipelined mode parameters.
- *
- * We try to use the minimum number of stages which is enough to keep the tape
- * constantly streaming. To accomplish that, we implement a feedback loop around
- * the maximum number of stages:
- *
- * We start from MIN maximum stages (we will not even use MIN stages if we don't
- * need them), increment it by RATE*(MAX-MIN) whenever we sense that the
- * pipeline is empty, until we reach the optimum value or until we reach MAX.
- *
- * Setting the following parameter to 0 is illegal: the pipelined mode cannot be
- * disabled (idetape_calculate_speeds() divides by tape->max_stages.)
- */
-#define IDETAPE_MIN_PIPELINE_STAGES	  1
-#define IDETAPE_MAX_PIPELINE_STAGES	400
-#define IDETAPE_INCREASE_STAGES_RATE	 20
-
-/*
  * After each failed packet command we issue a request sense command and retry
  * the packet command IDETAPE_MAX_PC_RETRIES times.
  *
-- 
1.5.4.1

