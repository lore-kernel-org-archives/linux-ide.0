From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Wed, 13 Jul 2011 16:39:36 +0200
Message-ID: <20110713143936.GQ2872@htj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39819 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab1GMOjl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2011 10:39:41 -0400
Received: by ewy4 with SMTP id 4so2167484ewy.19
        for <linux-ide@vger.kernel.org>; Wed, 13 Jul 2011 07:39:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110713133425.GP2872@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, again.

On Wed, Jul 13, 2011 at 03:34:25PM +0200, tj@kernel.org wrote:
> I see.  Yeah, it doesn't seem to be PHY flickering.  It looks like
> IDENTIFY is failing before disk finishes spinning up, which isn't the
> correct behavior.  SRST is supposed to wait for disk spin up
> completion.  I don't know why sil24 softreset is failing without
> waiting for spinup.  I'll see whether I can reproduce the problem
> here.

I played with it a bit but couldn't reproduce the problem; however,
PMP EH does lack per-device retry back-off.  On host ports, when
reset/identification fails for whatever reason, retry is backed off
such that even if controller/device interaction is faulty during spin
up, EH always retries after sufficient time is given to the device.
With PMP EH, this logic is missing partly because PMP EH sometimes
already takes too long and partly because tracking the timestamps
seemed a bit complex during the initial implementation.

So, this definitely contributes to why PMP EH fails to work around the
misinteraction between the drive and port and should probably be
improved, but let's also find out why the controller isn't waiting for
the drive after issuing IDENTIFY.  Can you please apply the following
patch, reproduce the problem and report the kernel log?

Thank you.

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 06c564e..cbd3475 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -896,6 +896,9 @@ static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 	dma_addr_t paddr;
 	void __iomem *activate;
 
+	if (qc->tf.command == ATA_CMD_ID_ATA)
+		ata_dev_printk(qc->dev, KERN_INFO, "issuing IDENTIFY\n");
+
 	paddr = pp->cmd_block_dma + tag * sizeof(*pp->cmd_block);
 	activate = port + PORT_CMD_ACTIVATE + tag * 8;
 
@@ -1081,9 +1084,12 @@ static void sil24_error_intr(struct ata_port *ap)
 		}
 
 		/* record error info */
-		if (qc)
+		if (qc) {
+			if (qc->tf.command == ATA_CMD_ID_ATA)
+				ata_dev_printk(qc->dev, KERN_INFO, "IDENTIFY failed, irq_stat=%#0x cerr=%u\n",
+					       irq_stat, cerr);
 			qc->err_mask |= err_mask;
-		else
+		} else
 			ehi->err_mask |= err_mask;
 
 		ehi->action |= action;
