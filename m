From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 06/15] drivers: ide: ide-tape.c removed duplicated #include
Date: Thu,  5 Aug 2010 15:51:30 +0200
Message-ID: <1281016299-23958-6-git-send-email-andrea.gelmini@gelma.net>
References: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60783 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888Ab0HENwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Aug 2010 09:52:07 -0400
Received: by ewy23 with SMTP id 23so2361126ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 05 Aug 2010 06:52:06 -0700 (PDT)
In-Reply-To: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gelma@gelma.net
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, "David S. Miller" <davem@davemloft.net>, Borislav Petkov <petkovbb@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 drivers/ide/ide-tape.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index b072328..24d0332 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -35,7 +35,6 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/ide.h>
-#include <linux/smp_lock.h>
 #include <linux/completion.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
-- 
1.7.2.1.85.g2d089

