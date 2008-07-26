From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/10] ide: remove unused _IDE_C and _IDE_DISK defines
Date: Sat, 26 Jul 2008 15:40:44 +0200
Message-ID: <20080726134044.10589.63581.sendpatchset@localhost.localdomain>
References: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:59814 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbYGZNms (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 09:42:48 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3564304mue.1
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 06:42:47 -0700 (PDT)
In-Reply-To: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    3 ---
 drivers/ide/ide.c      |    2 --
 2 files changed, 5 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -30,9 +30,6 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/leds.h>
-
-#define _IDE_DISK
-
 #include <linux/ide.h>
 
 #include <asm/byteorder.h>
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -44,8 +44,6 @@
  *  inspiration from lots of linux users, esp.  hamish@zot.apana.org.au
  */
 
-#define _IDE_C			/* Tell ide.h it's really us */
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/string.h>
