From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 22/22] ide-tape: schedule driver for removal after 6 months in case it turns out
Date: Mon,  4 Feb 2008 14:40:40 +0100
Message-ID: <1202132440-26648-23-git-send-email-petkovbb@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:21630 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197AbYBDNm6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:42:58 -0500
Received: by ik-out-1112.google.com with SMTP id c28so120621ika.5
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:42:49 -0800 (PST)
In-Reply-To: <1202132440-26648-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 Documentation/feature-removal-schedule.txt |   14 ++++++++++++--
 drivers/ide/ide-tape.c                     |    5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index a7d9d17..147bb63 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -264,8 +264,6 @@ Who:	Thomas Gleixner <tglx@linutronix.de>
 
 ---------------------------
 
----------------------------
-
 What:	i2c-i810, i2c-prosavage and i2c-savage4
 When:	May 2008
 Why:	These drivers are superseded by i810fb, intelfb and savagefb.
@@ -338,3 +336,15 @@ Why:	The support code for the old firmware hurts code readability/maintainabilit
 	and slightly hurts runtime performance. Bugfixes for the old firmware
 	are not provided by Broadcom anymore.
 Who:	Michael Buesch <mb@bu3sch.de>
+
+---------------------------
+
+What:	ide-tape driver
+When:	July 2008
+Files:	drivers/ide/ide-tape.c
+Why:	This driver might not have any users anymore and maintaining it for no
+	reason is an effort no one wants to make.
+Who:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov
+	<petkovbb@googlemail.com>
+
+---------------------------
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 2e6198f..86f206b 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -3803,6 +3803,11 @@ static int ide_tape_probe(ide_drive_t *drive)
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
 
+	printk(KERN_WARNING "It is possible that this driver does not have any"
+		" users anymore and, as a result, it will be REMOVED soon."
+		" Please notify Bart <bzolnier@gmail.com> or Boris"
+		" <petkovbb@gmail.com> in case you still need it.\n");
+
 	return 0;
 
 out_free_tape:
-- 
1.5.3.7

