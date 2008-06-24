From: Adrian Bunk <bunk@kernel.org>
Subject: [5/5] hd.c: remove the #include <linux/mc146818rtc.h>
Date: Wed, 25 Jun 2008 01:05:14 +0300
Message-ID: <20080624220514.GG18252@cs181140183.pp.htv.fi>
References: <20080609222155.GA1987@cs181133002.pp.htv.fi> <200806101956.15711.bzolnier@gmail.com> <20080622101752.GG27069@cs181133002.pp.htv.fi> <200806221521.33506.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:39377 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbYFXWHP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 18:07:15 -0400
Content-Disposition: inline
In-Reply-To: <200806221521.33506.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>

The code that needed this #include was removed one year ago.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
3aec5560128599a446f531ef18b32a21004884dc diff --git a/drivers/block/hd.c b/drivers/block/hd.c
index 00b6956..682243b 100644
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -37,7 +37,6 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/ioport.h>
-#include <linux/mc146818rtc.h> /* CMOS defines */
 #include <linux/init.h>
 #include <linux/blkpg.h>
 #include <linux/hdreg.h>

