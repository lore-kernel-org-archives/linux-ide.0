From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-sff: fix incorrect EH message
Date: Fri, 23 Jan 2009 14:12:59 +0900
Message-ID: <497951DB.1020500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47432 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbZAWFNB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 00:13:01 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

The EH message for NODEV_HINT path was describing the opposite
condition.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/clock.h b/arch/arm/mach-integrator/clock.h
deleted file mode 100644
index e69de29..0000000
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index c59ad76..55781a4 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1319,7 +1319,7 @@ fsm_start:
 					 * condition.  Mark hint.
 					 */
 					ata_ehi_push_desc(ehi, "ST-ATA: "
-						"DRQ=1 with device error, "
+						"DRQ=0 without device error, "
 						"dev_stat 0x%X", status);
 					qc->err_mask |= AC_ERR_HSM |
 							AC_ERR_NODEV_HINT;
