From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.23-rc1] ata_piix: EH pending after completion, repeating
 EH (cnt=4)
Date: Mon, 30 Jul 2007 16:52:01 +0900
Message-ID: <46AD98A1.2090709@gmail.com>
References: <200707261545.l6QFjPDZ027738@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080105080607020204050100"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:19442 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXG3HwI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jul 2007 03:52:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so349212rvb
        for <linux-ide@vger.kernel.org>; Mon, 30 Jul 2007 00:52:07 -0700 (PDT)
In-Reply-To: <200707261545.l6QFjPDZ027738@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105080607020204050100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mikael Pettersson wrote:
> Sure, here are the boot messages with the newer debug patch:

Of course I missed again.  Here's yet another debug patch.  Sorry about
the trouble.

-- 
tejun

--------------080105080607020204050100
Content-Type: text/x-patch;
 name="debug-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug-2.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6001aae..0b03a6f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6425,7 +6425,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 
 			ehi->probe_mask = (1 << ATA_MAX_DEVICES) - 1;
 			ehi->action |= ATA_EH_SOFTRESET;
-			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
+			ehi->flags |= ATA_EHI_NO_AUTOPSY/* | ATA_EHI_QUIET*/;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
 			ap->pflags |= ATA_PFLAG_LOADING;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ac6ceed..188cb95 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -693,6 +693,12 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	 * this function completes.
 	 */
 	scsi_req_abort_cmd(qc->scsicmd);
+
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		printk("EH scheduled with LOADING set cmd=%02x cdb=%02x emask=%02x\n",
+		       qc->tf.command, qc->cdb[0], qc->err_mask);
+		dump_stack();
+	}
 }
 
 /**
@@ -715,6 +721,11 @@ void ata_port_schedule_eh(struct ata_port *ap)
 	ata_eh_set_pending(ap, 1);
 	scsi_schedule_eh(ap->scsi_host);
 
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		printk("EH scheduled with LOADING set\n");
+		dump_stack();
+	}
+
 	DPRINTK("port EH scheduled\n");
 }
 
@@ -739,6 +750,11 @@ int ata_port_abort(struct ata_port *ap)
 	/* we're gonna abort all commands, no need for fast drain */
 	ata_eh_set_pending(ap, 0);
 
+	if (ap->pflags & ATA_PFLAG_LOADING) {
+		printk("EH port aborted while LOADING set\n");
+		dump_stack();
+	}
+
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
 

--------------080105080607020204050100--
