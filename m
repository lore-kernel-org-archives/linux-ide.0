From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 20/24] ide-tape: remove pipelined mode tape control flags
Date: Sat,  1 Mar 2008 09:58:44 +0100
Message-ID: <1204361928-30229-21-git-send-email-petkovbb@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:55344 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbYCAI7E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Mar 2008 03:59:04 -0500
Received: by mu-out-0910.google.com with SMTP id i10so7533564mue.5
        for <linux-ide@vger.kernel.org>; Sat, 01 Mar 2008 00:59:03 -0800 (PST)
In-Reply-To: <1204361928-30229-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index a5f29ea..68c9c09 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -206,19 +206,15 @@ enum {
 	/* 0 When the tape position is unknown */
 	IDETAPE_FLAG_ADDRESS_VALID	= (1 <<	1),
 	/* Device already opened */
-	IDETAPE_FLAG_BUSY			= (1 << 2),
-	/* Error detected in a pipeline stage */
-	IDETAPE_FLAG_PIPELINE_ERR	= (1 <<	3),
+	IDETAPE_FLAG_BUSY		= (1 << 2),
 	/* Attempt to auto-detect the current user block size */
-	IDETAPE_FLAG_DETECT_BS		= (1 << 4),
+	IDETAPE_FLAG_DETECT_BS		= (1 << 3),
 	/* Currently on a filemark */
-	IDETAPE_FLAG_FILEMARK		= (1 << 5),
+	IDETAPE_FLAG_FILEMARK		= (1 << 4),
 	/* DRQ interrupt device */
-	IDETAPE_FLAG_DRQ_INTERRUPT	= (1 << 6),
-	/* pipeline active */
-	IDETAPE_FLAG_PIPELINE_ACTIVE	= (1 << 7),
+	IDETAPE_FLAG_DRQ_INTERRUPT	= (1 << 5),
 	/* 0 = no tape is loaded, so we don't rewind after ejecting */
-	IDETAPE_FLAG_MEDIUM_PRESENT	= (1 << 8),
+	IDETAPE_FLAG_MEDIUM_PRESENT	= (1 << 6),
 };
 
 /* A pipeline stage. */
-- 
1.5.4.1

