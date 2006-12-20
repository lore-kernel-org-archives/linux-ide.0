From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Wed, 20 Dec 2006 09:18:12 +0900
Message-ID: <45888144.9070608@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080201020503070408070005"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:35992 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874AbWLTAST (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 19:18:19 -0500
Received: by nz-out-0506.google.com with SMTP id s1so794195nze
        for <linux-ide@vger.kernel.org>; Tue, 19 Dec 2006 16:18:19 -0800 (PST)
In-Reply-To: <1165253799.16504.37.camel@laundromat.jangutter.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Gutter <jang@lucidview.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080201020503070408070005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Gutter wrote:
> Our company has recently purchased two Acer 5632WSMi laptops and we're
> running Gentoo x86 unstable on them. The most hindering problem that's
> currently plaguing us is the IDE chipset. 
> 
> Without the combined_mode=libata on the command line, DMA is disabled
> and the hard drive just uses PIO. With libata, it hangs up randomly,
> causing the driver to eventually clock down to PIO mode too.
> 
> I'd be willing to test patches (like really INSANE ones), because the
> laptop's not too critical currently. I can post the full dmesg and lspci
> -vvnn if it might be of use. I have no idea whether this problem has
> been solved or reported before.

Please apply the attached patch over 2.6.19 and report what the kernel says.

Thanks.

-- 
tejun

--------------080201020503070408070005
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..bbbec75 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1433,16 +1433,47 @@ static void ata_eh_report(struct ata_port *ap)
 	}
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		static const char *dma_str[] = {
+			[DMA_BIDIRECTIONAL]	= "bidi",
+			[DMA_TO_DEVICE]		= "out",
+			[DMA_FROM_DEVICE]	= "in",
+			[DMA_NONE]		= "",
+		};
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
+		const u8 *c = qc->cdb;
+		unsigned int nbytes;
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
 			continue;
 
-		ata_dev_printk(qc->dev, KERN_ERR, "tag %d cmd 0x%x "
-			       "Emask 0x%x stat 0x%x err 0x%x (%s)\n",
-			       qc->tag, qc->tf.command, qc->err_mask,
-			       qc->result_tf.command, qc->result_tf.feature,
-			       ata_err_string(qc->err_mask));
+		nbytes = qc->nbytes;
+		if (!nbytes)
+			nbytes = qc->nsect << 9;
+
+		ata_dev_printk(qc->dev, KERN_ERR,
+			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
+			"tag %d cdb 0x%x data %u %s\n         "
+			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
+			"Emask 0x%x (%s)\n",
+			cmd->command, cmd->feature, cmd->nsect,
+			cmd->lbal, cmd->lbam, cmd->lbah,
+			cmd->hob_feature, cmd->hob_nsect,
+			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
+			cmd->device, qc->tag, qc->cdb[0], nbytes,
+			dma_str[qc->dma_dir],
+			res->command, res->feature, res->nsect,
+			res->lbal, res->lbam, res->lbah,
+			res->hob_feature, res->hob_nsect,
+			res->hob_lbal, res->hob_lbam, res->hob_lbah,
+			res->device, qc->err_mask, ata_err_string(qc->err_mask));
+
+		ata_dev_printk(qc->dev, KERN_ERR,
+			       "CDB: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
+			       "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x p=%d\n",
+			       c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7],
+			       c[8], c[9], c[10], c[11], c[12], c[13], c[14], c[15],
+			       cmd->protocol);
 	}
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3ac4890..f018e49 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -191,6 +191,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		goto out;
 
 	req->cmd_len = COMMAND_SIZE(cmd[0]);
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sense;
 	req->sense_len = 0;

--------------080201020503070408070005--
