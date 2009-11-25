From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 42/86] pata_it8213: fix it8213_pre_reset() documentation
Date: Wed, 25 Nov 2009 18:07:19 +0100
Message-ID: <20091125170719.5446.53452.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932695AbZKYRIL@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_it8213: fix it8213_pre_reset() documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_it8213.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_it8213.c
===================================================================
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -22,7 +22,7 @@
 #define DRV_VERSION	"0.0.3"
 
 /**
- *	it8213_pre_reset	-	check for 40/80 pin
+ *	it8213_pre_reset	-	probe begin
  *	@link: link
  *	@deadline: deadline jiffies for the operation
  *
