From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/10] sata_sil24: add PM related constants
Date: Fri, 12 May 2006 01:43:42 +0900
Message-ID: <11473658221118-git-send-email-htejun@gmail.com>
References: <11473658222012-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:21914 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030345AbWEKQny (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:43:54 -0400
Received: by wr-out-0506.google.com with SMTP id i12so408534wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:43:54 -0700 (PDT)
In-Reply-To: <11473658222012-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PM related constants.

---

 drivers/scsi/sata_sil24.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

f7d8e76d5f80de240710b14018ea6372764bc8eb
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index e38e1fc..dfbe750 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -103,6 +103,10 @@ enum {
 	PORT_LRAM_SLOT_SZ	= 0x0080, /* 32 bytes PRB + 2 SGE, ACT... */
 
 	PORT_PM			= 0x0f80, /* 8 bytes PM * 16 (128 bytes) */
+	PORT_PM_STATUS		= 0x0000, /* port device status offset */
+	PORT_PM_QACTIVE		= 0x0004, /* port device QActive offset */
+	PORT_PM_SIZE		= 0x0008, /* 8 bytes per PM */
+
 		/* 32 bit regs */
 	PORT_CTRL_STAT		= 0x1000, /* write: ctrl-set, read: stat */
 	PORT_CTRL_CLR		= 0x1004, /* write: ctrl-clear */
@@ -125,6 +129,7 @@ enum {
 	PORT_PHY_CFG		= 0x1050,
 	PORT_SLOT_STAT		= 0x1800,
 	PORT_CMD_ACTIVATE	= 0x1c00, /* 64 bit cmd activate * 31 (248 bytes) */
+	PORT_CONTEXT		= 0x1e04,
 	PORT_EXEC_DIAG		= 0x1e00, /* 32bit exec diag * 16 (64 bytes, 0-10 used on 3124) */
 	PORT_PSD_DIAG		= 0x1e40, /* 32bit psd diag * 16 (64 bytes, 0-8 used on 3124) */
 	PORT_SCONTROL		= 0x1f00,
-- 
1.2.4


