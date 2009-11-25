From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 53/86] pata_marvell: fix marvell_pre_reset() documentation
Date: Wed, 25 Nov 2009 18:08:41 +0100
Message-ID: <20091125170841.5446.28051.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933343AbZKYRTn@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_marvell: fix marvell_pre_reset() documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_marvell.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_marvell.c
===================================================================
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -58,7 +58,7 @@ static int marvell_pata_active(struct pc
 }
 
 /**
- *	marvell_pre_reset	-	check for 40/80 pin
+ *	marvell_pre_reset	-	probe begin
  *	@link: link
  *	@deadline: deadline jiffies for the operation
  *
