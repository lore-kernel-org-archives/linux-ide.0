From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: 31 May 2004 10:09:39 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086019779.3144.6.camel@patibmrh9>
References: <068F5E91-B237-11D8-819C-000393A22C62@ieee.org><1085930101.3135.
	4.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:62958 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264683AbUEaQJk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 May 2004 12:09:40 -0400
Received: from royntex01.iomegacorp.com (franklin [10.1.1.83])
	by email.iomega.com (Postfix) with ESMTP id C792A18B8
	for <linux-ide@vger.kernel.org>; Mon, 31 May 2004 10:09:39 -0600 (MDT)
In-Reply-To: <1085930101.3135.4.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> > we have NOT yet explained
> > how to insert an ATA op x00 "NOP" ...
> > Instead, my kernel goes down during modprobe ata-piix if I try ...

Just to be complete,

I also tried inserting the ATA op x00 only after the first few commands
passed thru.  That also took my kernel down with the same old dmesg:

atapi_error: err x00
atapi_error: ata_tf_to_host
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec: ata2: cmd 0x0

I think I'll also again try more direct access thru iopl(3), but I won't
discuss that further here unless I succeed.

Pat LaVarre

--- o/drivers/scsi/libata-core.c	2004-05-30 08:53:41.000000000 -0600
+++ linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c	2004-05-31 09:57:24.000000000 -0600
@@ -2294,6 +2294,44 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
+static void atapi_error(struct ata_queued_cmd *qc)
...
@@ -2324,6 +2362,13 @@ void ata_qc_complete(struct ata_queued_c
 		} else {
 			cmd->result = SAM_STAT_GOOD;
 		}
+		do {
+			static int pel_trigger = 0;
+			++pel_trigger;
+			DPRINTK("pel_trigger: %d\n", pel_trigger);
+			if (5 <= pel_trigger) {
+				atapi_error(qc);
+			}
+		} while (0);
 
 		qc->scsidone(cmd);
 	}


