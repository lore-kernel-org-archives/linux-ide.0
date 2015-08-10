From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] libata: fix libata-core.c kernel-doc warning
Date: Sun, 9 Aug 2015 18:37:36 -0700
Message-ID: <55C80060.8030308@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in libata-core.c:

Warning(..//drivers/ata/libata-core.c:4763): No description found for parameter 'tag'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-42-rc6.orig/drivers/ata/libata-core.c
+++ lnx-42-rc6/drivers/ata/libata-core.c
@@ -4769,6 +4769,7 @@ void swap_buf_le16(u16 *buf, unsigned in
 /**
  *	ata_qc_new_init - Request an available ATA command, and initialize it
  *	@dev: Device from whom we request an available command structure
+ *	@tag: tag
  *
  *	LOCKING:
  *	None.
