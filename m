From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/12] sata_sil24: add PMP related constants
Date: Mon, 16 Oct 2006 08:47:18 +0900
Message-ID: <1160956038817-git-send-email-htejun@gmail.com>
References: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:9360 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932226AbWJOXrb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:31 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636809nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:30 -0700 (PDT)
In-Reply-To: <11609560371552-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add PMP related constants.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil24.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 0a6306d..866f84b 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
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
1.4.2.3


