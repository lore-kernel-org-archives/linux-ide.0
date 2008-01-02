From: Tejun Heo <htejun@gmail.com>
Subject: Re: commit a258f183ee4e48e9352b408e8448467eebdc6cd2
Date: Wed, 02 Jan 2008 23:24:30 +0900
Message-ID: <477B9E9E.3000104@gmail.com>
References: <477B5AAE.7070008@gmail.com> <20080102134859.17e75789@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050700020106020608040405"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.154]:52515 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYABOYh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 09:24:37 -0500
Received: by po-out-1718.google.com with SMTP id c31so4018611poi.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 06:24:36 -0800 (PST)
In-Reply-To: <20080102134859.17e75789@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050700020106020608040405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Wed, 02 Jan 2008 18:34:38 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Happy new year, Jeff, Alan.
>>
>> I'm curious why commit a258f183 got in?  
> 
> Whats that commit in real code ?

The attached one.

-- 
tejun

--------------050700020106020608040405
Content-Type: text/x-patch;
 name="0001-libata-fix-hopefully-all-the-remaining-problems-w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-libata-fix-hopefully-all-the-remaining-problems-w.patch"

>From a258f183ee4e48e9352b408e8448467eebdc6cd2 Mon Sep 17 00:00:00 2001
From: Alan <alan@lxorguk.ukuu.org.uk>
Date: Tue, 2 Oct 2007 13:53:05 -0700
Subject: [PATCH] libata: fix (hopefully) all the remaining problems with devices failing setup/identify

Two fixes in this test patch.  One of them allows old CF cards to refuse
pio mode setting, and one to wait for the drive to settle after a set
features changes the speed settings, which is based upon the workarounds
used by drivers/ide.

Please test and report back if you have an afflicted system.  This patch
isn't for merging just testing.

The CF card fix will still display errors when the card works (got fixes
for that once I know the cure works) but should then be found/usable.

Not signed off by anyone, not for merging

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/ata/libata-core.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c2f37e..2b24041 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6134,6 +6134,7 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u8 status, host_stat = 0;
+	int i;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
@@ -6190,6 +6191,20 @@ inline unsigned int ata_host_intr(struct ata_port *ap,
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
+	if (unlikely(qc->tf.command == ATA_CMD_SET_FEATURES &&
+			qc->tf.feature == SETFEATURES_XFER)) {
+		/* Let the timings change settle and the drive catch up as
+		   some hardware needs up to 10uS to get its brain back in
+		   gear. Taken from the workarounds in drivers/ide done by
+		   Matthew Faupel/Niccolo Rigacci */
+		for (i = 0; i < 10; i++) {
+			if ((status & (ATA_BUSY | ATA_DRQ | ATA_ERR)) == 0)
+				break;
+			udelay(1);
+			status = ata_chk_status(ap);
+		}
+	}
+
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
-- 
1.5.2.4


--------------050700020106020608040405--
