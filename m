From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] Prevent warning during PMP error recovery
Date: Fri, 22 Jul 2011 13:48:32 -0700
Message-ID: <1311367712-15331-1-git-send-email-gwendal@google.com>
References: <20110721072530.GX3455@htj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:13828 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067Ab1GVUtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jul 2011 16:49:32 -0400
In-Reply-To: <20110721072530.GX3455@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: tj@kernel.org, mlord@pobox.com, linux-ide@vger.kernel.org, lil@marvell.com, hbailey@marvell.com, marc@merlins.org, Gwendal Grignou <gwendal@google.com>

Cleanup sff_pio_task_link when a command is cancel while the
pio_task thread has been scheduled.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
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

