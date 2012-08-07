From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_mv query
Date: Tue, 07 Aug 2012 14:17:45 -0400
Message-ID: <50215BC9.2020709@teksavvy.com>
References: <006c01cd74ac$a06edf30$e14c9d90$@sturgeon@perpetual-data.com> <50214D56.9090907@teksavvy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010208020402090105050504"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:12945 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016Ab2HGSRr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2012 14:17:47 -0400
In-Reply-To: <50214D56.9090907@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Barry J Sturgeon <barry.sturgeon@perpetual-data.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208020402090105050504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12-08-07 01:16 PM, Mark Lord wrote:
..
> mv_wait_for_edma_empty_idle() is called from mv_stop_edma(),
> which happens whenever we transition between sending NCQ commands
> (eg. read/write) and non-NCQ commands (eg. flush cache).
> 
> The mv_qc_defer() function is supposed to ensure that things are
> more or less idle before it even gets to mv_stop_edma().
> So we'd expect the mv_wait_for_edma_empty_idle() function to be quick,
> which is a big part of why we're willing to tolerate an inline busy-wait.
> 
> But here it seems to be waiting MUCH longer, as if it has to wait for
> some IO-in-progress to complete before continuing.  Which means that
> the mv_qc_defer() function isn't being as effective as it should be.
> 
> The idea is, before any new command is queued, libata invokes the defer
> function to see if the driver is ready to accept the new command.
> The sata_mv driver normally says "yes" (go ahead) for a new NCQ command
> whenever it currently has existing NCQ commands in-flight.
> Otherwise it always says "no" (please defer) unless completely idle.
> That's how mv_qc_defer() is supposed to work, and that should minimize
> the time spent inside mv_wait_for_edma_empty_idle() by ensuring the
> edma engine is already idle whenever that gets called.

Say, here's a thought:  We could get rid of (or relocate to upper layers)
the busy-wait by having something similar get called from ata_qc_defer().

If you are feeling adventurous, here is a 100% untested patch to do just that.
It looks correct to me, it compiles, but that's all I can say.

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
+		return ATA_DEFER_PORT;
+	return 0;
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

--------------010208020402090105050504
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
+		return ATA_DEFER_PORT;
+	return 0;
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

--------------010208020402090105050504--
