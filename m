From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_promise: hardreset is broken
Date: Wed, 19 Mar 2008 14:45:06 +0900
Message-ID: <47E0A862.6070305@gmail.com>
References: <12052371651181-git-send-email-htejun@gmail.com> <47DE63F2.2030404@garzik.org> <47E0A815.80906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.186]:59077 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763270AbYCSUF6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 16:05:58 -0400
Received: by rn-out-0910.google.com with SMTP id v46so533787rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 13:05:57 -0700 (PDT)
In-Reply-To: <47E0A815.80906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com, florian@openwrt.org

PHY events aren't plugged properly over hardresets and cause PHY event
loop mkaing hardreset repeat itself.  Don't use hardreset for now.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_promise.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f251a5f..1af2208 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -675,7 +675,11 @@ static void pdc_pata_error_handler(struct ata_port *ap)
 
 static void pdc_sata_error_handler(struct ata_port *ap)
 {
-	pdc_common_error_handler(ap, sata_std_hardreset);
+	/* FIXME: hardreset is currently broken and causes hotplug
+	 * event loop.  sata_std_hardreset can be used for @hardreset
+	 * once the problem is fixed.
+	 */
+	pdc_common_error_handler(ap, NULL);
 }
 
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
-- 
1.5.2.4

