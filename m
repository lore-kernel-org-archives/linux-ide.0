From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv query
Date: Tue, 07 Aug 2012 14:20:48 -0400
Message-ID: <50215C80.8080601@teksavvy.com>
References: <006c01cd74ac$a06edf30$e14c9d90$@sturgeon@perpetual-data.com> <50214D56.9090907@teksavvy.com> <50215BC9.2020709@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050308030001050803010407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:38027 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016Ab2HGSUt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2012 14:20:49 -0400
In-Reply-To: <50215BC9.2020709@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Barry J Sturgeon <barry.sturgeon@perpetual-data.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050308030001050803010407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12-08-07 02:17 PM, Mark Lord wrote:
..
> Say, here's a thought:  We could get rid of (or relocate to upper layers)
> the busy-wait by having something similar get called from ata_qc_defer().
> 
> If you are feeling adventurous, here is a 100% untested patch to do just that.
> It looks correct to me, it compiles, but that's all I can say.

Whoops.. return codes were reversed.
Here's the corrected patch.

The attached copy is the better one to use -- my mailer mangles inline patches.

--- linux-3.4.4/drivers/ata/sata_mv.c	2012-06-22 14:37:50.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2012-08-07 14:14:43.554503157 -0400
@@ -1388,6 +1388,17 @@
 	}
 }

+static int mv_check_for_edma_empty_idle(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	const u32 empty_idle = (EDMA_STATUS_CACHE_EMPTY | EDMA_STATUS_IDLE);
+
+	u32 edma_stat = readl(port_mmio + EDMA_STATUS);
+	if ((edma_stat & empty_idle) == empty_idle)
+		return 0;
+	return ATA_DEFER_PORT;
+}
+
 static int mv_qc_defer(struct ata_queued_cmd *qc)
 {
 	struct ata_link *link = qc->dev->link;
@@ -1423,7 +1434,7 @@
 	 * If the port is completely idle, then allow the new qc.
 	 */
 	if (ap->nr_active_links == 0)
-		return 0;
+		return mv_check_for_edma_empty_idle(ap);

 	/*
 	 * The port is operating in host queuing mode (EDMA) with NCQ

--------------050308030001050803010407
Content-Type: text/x-patch;
 name="xx_sata_mv_move_busywait.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xx_sata_mv_move_busywait.patch"

--- linux-3.4.4/drivers/ata/sata_mv.c	2012-06-22 14:37:50.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2012-08-07 14:14:43.554503157 -0400
@@ -1388,6 +1388,17 @@
 	}
 }
 
+static int mv_check_for_edma_empty_idle(struct ata_port *ap)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	const u32 empty_idle = (EDMA_STATUS_CACHE_EMPTY | EDMA_STATUS_IDLE);
+
+	u32 edma_stat = readl(port_mmio + EDMA_STATUS);
+	if ((edma_stat & empty_idle) == empty_idle)
+		return 0;
+	return ATA_DEFER_PORT;
+}
+
 static int mv_qc_defer(struct ata_queued_cmd *qc)
 {
 	struct ata_link *link = qc->dev->link;
@@ -1423,7 +1434,7 @@
 	 * If the port is completely idle, then allow the new qc.
 	 */
 	if (ap->nr_active_links == 0)
-		return 0;
+		return mv_check_for_edma_empty_idle(ap);
 
 	/*
 	 * The port is operating in host queuing mode (EDMA) with NCQ

--------------050308030001050803010407--
