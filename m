From: Tejun Heo <htejun@gmail.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Wed, 14 Mar 2007 13:11:55 +0900
Message-ID: <45F7760B.10102@gmail.com>
References: <45F631F7.6020106@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050202050307050308030609"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:61013 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbXCNEMB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 00:12:01 -0400
Received: by wr-out-0506.google.com with SMTP id i28so37850wra
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 21:12:00 -0700 (PDT)
In-Reply-To: <45F631F7.6020106@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050202050307050308030609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vlad Codrea wrote:
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x25)
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>         res 58/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177

Okay, now that you're on libata driver, it's easier for me to debug.
Can you apply the attached patch over 2.6.20 and report what the kernel
says? (the patch will apply with some noise, it's okay)

Thanks.

-- 
tejun

--------------050202050307050308030609
Content-Type: text/x-patch;
 name="hsm-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hsm-debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14629a3..387235f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4453,9 +4453,13 @@ fsm_start:
 			if (likely(status & (ATA_ERR | ATA_DF)))
 				/* device stops HSM for abort/error */
 				qc->err_mask |= AC_ERR_DEV;
-			else
+			else {
 				/* HSM violation. Let EH handle this */
+				ata_port_printk(ap, KERN_WARNING,
+						"!DRQ on HSM_ST_FIRST (0x%x)\n",
+						status);
 				qc->err_mask |= AC_ERR_HSM;
+			}
 
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
@@ -4547,13 +4551,17 @@ fsm_start:
 				if (likely(status & (ATA_ERR | ATA_DF)))
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
-				else
+				else {
+					ata_port_printk(ap, KERN_WARNING,
+						"!DRQ on HSM_ST (0x%x)\n",
+						status);
 					/* HSM violation. Let EH handle this.
 					 * Phantom devices also trigger this
 					 * condition.  Mark hint.
 					 */
 					qc->err_mask |= AC_ERR_HSM |
 							AC_ERR_NODEV_HINT;
+				}
 
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -4579,8 +4587,12 @@ fsm_start:
 					status = ata_wait_idle(ap);
 				}
 
-				if (status & (ATA_BUSY | ATA_DRQ))
+				if (status & (ATA_BUSY | ATA_DRQ)) {
+					ata_port_printk(ap, KERN_WARNING,
+						"BUSY|DRQ on ERR|DF (0x%x)\n",
+						status);
 					qc->err_mask |= AC_ERR_HSM;
+				}
 
 				/* ata_pio_sectors() might change the
 				 * state to HSM_ST_LAST. so, the state

--------------050202050307050308030609--
