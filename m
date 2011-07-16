From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] Prevent warning during PMP error recovery
Date: Fri, 15 Jul 2011 17:32:02 -0700
Message-ID: <1310776322-12911-1-git-send-email-gwendal@google.com>
References: <20110715155520.GB25319@merlins.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:20603 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1GPAc6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jul 2011 20:32:58 -0400
In-Reply-To: <20110715155520.GB25319@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: mlord@pobox.com, linux-ide@vger.kernel.org, lil@marvell.com, hbailey@marvell.com, marc@merlins.org, Gwendal Grignou <gwendal@google.com>

Cleanup sff_pio_task_link when a command is cancel while the
pio_task thread has been scheduled.

Change-Id: I4397bed3ee0878d92933d4897eed025ffaf3a9bd

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-sff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 996a7a5..c24127d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1333,6 +1333,7 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
 
 	cancel_delayed_work_sync(&ap->sff_pio_task);
 	ap->hsm_task_state = HSM_ST_IDLE;
+	ap->sff_pio_task_link = NULL;
 
 	if (ata_msg_ctl(ap))
 		ata_port_dbg(ap, "%s: EXIT\n", __func__);
-- 
1.7.3.1

