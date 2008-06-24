From: Adrian Bunk <bunk@kernel.org>
Subject: [2/5] ide/legacy/hd.c: use late_initcall()
Date: Wed, 25 Jun 2008 00:54:21 +0300
Message-ID: <20080624215421.GD18252@cs181140183.pp.htv.fi>
References: <20080609222155.GA1987@cs181133002.pp.htv.fi> <200806101956.15711.bzolnier@gmail.com> <20080622101752.GG27069@cs181133002.pp.htv.fi> <200806221521.33506.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:53716 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670AbYFXV4W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 17:56:22 -0400
Content-Disposition: inline
In-Reply-To: <200806221521.33506.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>

Since the later move to drivers/block/ will break the link order,
the module_init() has to become a late_initcall().

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/ide/Makefile    |    1 -
 drivers/ide/legacy/hd.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

14c4f831bae87b5b268fdf53269b6a6a65b2efe9 diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index f94b679..4c95e0f 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -59,7 +59,6 @@ endif
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= arm/ mips/
 
-# old hd driver must be last
 ifeq ($(CONFIG_BLK_DEV_HD), y)
 	hd-core-y += legacy/hd.o
 	obj-y += hd-core.o
diff --git a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
index abdedf5..00b6956 100644
--- a/drivers/ide/legacy/hd.c
+++ b/drivers/ide/legacy/hd.c
@@ -812,4 +812,4 @@ static int __init parse_hd_setup(char *line)
 }
 __setup("hd=", parse_hd_setup);
 
-module_init(hd_init);
+late_initcall(hd_init);

