From: Dan Williams <dan.j.williams@intel.com>
Subject: RE: sata_vsc with iq3124h regression in 2.6.20
Date: Fri, 09 Feb 2007 16:26:49 -0700
Message-ID: <1171063609.29541.6.camel@dwillia2-linux.ch.intel.com>
Reply-To: 45CCF6BD.9020404@garzik.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36074 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbXBIX0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Feb 2007 18:26:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, jeremy@sgi.com, liml@rtr.ca

> As I recall, the 31244 and VSC-7174 always send an interrupt, so the
> driver should account for this.  I thought we had code already in the
> driver to handle this, but perhaps recent changes stomped that.
> 
> It would be good to standardize the way we handle these sorts of
> controllers, because (I think) Mark Lord has the same problem on
> sata_qstor (or pdc_adma?).
> 
> 	Jeff

The error interrupt handling code is still in there and is working.  The
following patch works for me.

---
sata_vsc: handle unexpected interrupts when executing a polled IDENTIFY

From: Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/ata/sata_vsc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 0fa1b89..7425d62 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -258,7 +258,9 @@ static irqreturn_t vsc_sata_interrupt (int irq, void *dev_instance)
 					/* Clear interrupt status */
 					ata_chk_status(ap);
 					handled++;
-				}
+				} else if (qc->tf.command == ATA_CMD_ID_ATA)
+					/* 31244 interrupts on polled IDENTIFY commands */
+					ata_chk_status(ap);
 			}
 		}
 	}
