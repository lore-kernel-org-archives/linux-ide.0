From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] sata_sil24: add PMP related constants
Date: Sat, 8 Jul 2006 14:58:08 +0900
Message-ID: <1152338288109-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:8053 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964803AbWGHF5U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:20 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484772wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:20 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PMP related constants.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

e5690641aac1962a11a64b81d78b769a35f6d278
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 958038a..370fc6d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -104,6 +104,10 @@ enum {
 	PORT_LRAM_SLOT_SZ	= 0x0080, /* 32 bytes PRB + 2 SGE, ACT... */
 
 	PORT_PMP		= 0x0f80, /* 8 bytes PMP * 16 (128 bytes) */
+	PORT_PMP_STATUS		= 0x0000, /* port device status offset */
+	PORT_PMP_QACTIVE	= 0x0004, /* port device QActive offset */
+	PORT_PMP_SIZE		= 0x0008, /* 8 bytes per PMP */
+
 		/* 32 bit regs */
 	PORT_CTRL_STAT		= 0x1000, /* write: ctrl-set, read: stat */
 	PORT_CTRL_CLR		= 0x1004, /* write: ctrl-clear */
@@ -126,6 +130,7 @@ enum {
 	PORT_PHY_CFG		= 0x1050,
 	PORT_SLOT_STAT		= 0x1800,
 	PORT_CMD_ACTIVATE	= 0x1c00, /* 64 bit cmd activate * 31 (248 bytes) */
+	PORT_CONTEXT		= 0x1e04,
 	PORT_EXEC_DIAG		= 0x1e00, /* 32bit exec diag * 16 (64 bytes, 0-10 used on 3124) */
 	PORT_PSD_DIAG		= 0x1e40, /* 32bit psd diag * 16 (64 bytes, 0-8 used on 3124) */
 	PORT_SCONTROL		= 0x1f00,
-- 
1.3.2


