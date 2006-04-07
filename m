From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] sata_sil24: add more constants
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <11443978131840-git-send-email-htejun@gmail.com>
References: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:30944 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932373AbWDGIRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:17:00 -0400
Received: by xproxy.gmail.com with SMTP id t10so260172wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:17:00 -0700 (PDT)
In-Reply-To: <114439781363-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

Add HOST_CTRL_* and more PORT_IRQ_* bits.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

c5ccb983c5240ef095501f9e4558233904a39f42
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index c581d9f..4434cf2 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -86,6 +86,13 @@ enum {
 	/* HOST_SLOT_STAT bits */
 	HOST_SSTAT_ATTN		= (1 << 31),
 
+	/* HOST_CTRL bits */
+	HOST_CTRL_M66EN		= (1 << 16), /* M66EN PCI bus signal */
+	HOST_CTRL_TRDY		= (1 << 17), /* latched PCI TRDY */
+	HOST_CTRL_STOP		= (1 << 18), /* latched PCI STOP */
+	HOST_CTRL_DEVSEL	= (1 << 19), /* latched PCI DEVSEL */
+	HOST_CTRL_REQ64		= (1 << 20), /* latched PCI REQ64 */
+
 	/*
 	 * Port registers
 	 * (8192 bytes @ +0x0000, +0x2000, +0x4000 and +0x6000 @ BAR2)
@@ -142,7 +149,11 @@ enum {
 	PORT_IRQ_PWR_CHG	= (1 << 3), /* power management change */
 	PORT_IRQ_PHYRDY_CHG	= (1 << 4), /* PHY ready change */
 	PORT_IRQ_COMWAKE	= (1 << 5), /* COMWAKE received */
-	PORT_IRQ_UNK_FIS	= (1 << 6), /* Unknown FIS received */
+	PORT_IRQ_UNK_FIS	= (1 << 6), /* unknown FIS received */
+	PORT_IRQ_DEV_XCHG	= (1 << 7), /* device exchanged */
+	PORT_IRQ_8B10B		= (1 << 8), /* 8b/10b decode error threshold */
+	PORT_IRQ_CRC		= (1 << 9), /* CRC error threshold */
+	PORT_IRQ_HANDSHAKE	= (1 << 10), /* handshake error threshold */
 	PORT_IRQ_SDB_NOTIFY	= (1 << 11), /* SDB notify received */
 
 	/* bits[27:16] are unmasked (raw) */
-- 
1.2.4


