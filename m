From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 12/17] ide-tape: remove pipelined mode parameters
Date: Mon, 17 Mar 2008 07:41:25 +0100
Message-ID: <1205736090-4435-13-git-send-email-petkovbb@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757284AbYCQGoo@vger.kernel.org>
In-Reply-To: <1205736090-4435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 0056a26..5535356 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -72,23 +72,6 @@ enum {
 #endif
 
 /**************************** Tunable parameters *****************************/
-
-
-/*
- * Pipelined mode parameters.
- *
- * We try to use the minimum number of stages which is enough to keep the tape
- * constantly streaming. To accomplish that, we implement a feedback loop around
- * the maximum number of stages:
- *
- * We start from MIN maximum stages (we will not even use MIN stages if we don't
- * need them), increment it by RATE*(MAX-MIN) whenever we sense that the
- * pipeline is empty, until we reach the optimum value or until we reach MAX.
- */
-#define IDETAPE_MIN_PIPELINE_STAGES	  1
-#define IDETAPE_MAX_PIPELINE_STAGES	400
-#define IDETAPE_INCREASE_STAGES_RATE	 20
-
 /*
  * After each failed packet command we issue a request sense command and retry
  * the packet command IDETAPE_MAX_PC_RETRIES times.
-- 
1.5.4.1
