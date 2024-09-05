Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B6195803;
	Thu,  5 Sep 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528360; cv=none; b=Qh0nBa6TR9Wmw83Kdfy5GXjZEGUy+vh0bfWOAEr9sz6fYhAatCJgpN9ffrBFq83bwop8djpB9vIFEKACX8m+oe+nIfzCZqHICBq+ueqlZKXeFqHTECrgVZ/bximF3MknqcXxORs78UMFZWTABgA8LP5/9p8yuqxflWXHzwCan5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528360; c=relaxed/simple;
	bh=ICkek0DcVkkKx78wOg605n+MZx7jsTDeHkHJAKMsUME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puyupJcSMLbU0JBGvTBHvj6EUidEimvXihLWqq2ibqOmqp5UmLV2mG7KzLb1barUa+dr4oRIX8gHr0Ob3IDPFfNUZouYz8IIrmRdv/DUyOpjIEUYQQRKGMeQhUR8vtnsjCFNtcWnUCBPVhk1ONU5FmlC/IJ/q6S+KvAbxl7VcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5wx49LL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5wx49LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FACC4CEC3;
	Thu,  5 Sep 2024 09:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725528360;
	bh=ICkek0DcVkkKx78wOg605n+MZx7jsTDeHkHJAKMsUME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5wx49LLPUcyurOBwBrkVoH4BH7EYFTpdyYe2sOXFr7VbZ0b4Cci1PMkdElW9Jhwg
	 F5SKvkgREsFvVMYrPyTf3mU5kH96FeHTgnVXhXXdEhFFCkuIBm+pmrZWMs2vVAZ0IU
	 w4T7udwvPFfjUbqgkV/I9JgSnlXptODTFi1XJPOi31Q14CKrW6KE6qCfHTRUi2DPuW
	 DjSMlK3mTk+IJ4hLlvSGSaO03b3ZE3uPDVFMM8zyBLEISBLffx0NQW2u4ejRibo+OH
	 wNUnCrlbaoGUos43V1pCd2ud607MjhDdp+s50OVK8jHWZfJz8qD+TsLYKYDWJGBhcJ
	 CTzZFsQTmxjCQ==
Date: Thu, 5 Sep 2024 11:25:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Clear scsicmd->result when setting
 SAM_STAT_CHECK_CONDITION
Message-ID: <Ztl5I1Kz53MOEtF4@ryzen.lan>
References: <20240904223727.1149294-1-ipylypiv@google.com>
 <Ztls4mim6Jky7E0S@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztls4mim6Jky7E0S@ryzen.lan>

On Thu, Sep 05, 2024 at 10:33:38AM +0200, Niklas Cassel wrote:
> There are many different paths a QC can take via EH, e.g. policy 0xD NCQ
> commands will not fetch sense data via ata_eh_request_sense(), so clearing
> the host byte in ata_scsi_qc_complete() should be fine, otherwise we need
> to do a similar change to yours in all the different code paths that sets
> sense data ...which might actually be something that makes sense, but then
> I would expect a patch series that changes all the locations where we set
> sense data, not just in ata_eh_analyze_tf(), and then drops the clearing in
> ata_scsi_qc_complete() (which was introduced in commit 7574a8377c7a ("ata:
> libata-scsi: do not overwrite SCSI ML and status bytes")).

I tried to implement the suggestion above, it looks like this:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e4023fc288ac..ff4945a8f647 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4824,6 +4824,14 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 		qc->tag = ATA_TAG_POISON;
 }
 
+void ata_qc_set_sense_valid_flag(struct ata_queued_cmd *qc)
+{
+	qc->flags |= ATA_QCFLAG_SENSE_VALID;
+
+	/* Keep the SCSI ML and status byte, clear host byte. */
+	qc->scsicmd->result &= 0x0000ffff;
+}
+
 void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7de97ee8e78b..df83251601dc 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1482,7 +1482,8 @@ static bool ata_eh_request_sense(struct ata_queued_cmd *qc)
 			scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
 						cmd->sense_buffer, tf.lbah,
 						tf.lbam, tf.lbal);
-			qc->flags |= ATA_QCFLAG_SENSE_VALID;
+			ata_qc_set_sense_valid_flag(qc);
+
 			return true;
 		}
 	} else {
@@ -1657,7 +1658,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
 						qc->scsicmd->sense_buffer,
 						qc->result_tf.error >> 4);
 			if (!tmp)
-				qc->flags |= ATA_QCFLAG_SENSE_VALID;
+				ata_qc_set_sense_valid_flag(qc);
 			else
 				qc->err_mask |= tmp;
 		}
@@ -2049,7 +2050,7 @@ static void ata_eh_get_success_sense(struct ata_link *link)
 
 		/* This success command had sense data, but we failed to get. */
 		ata_scsi_set_sense(dev, qc->scsicmd, ABORTED_COMMAND, 0, 0);
-		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+		ata_qc_set_sense_valid_flag(qc);
 	}
 	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
 }
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index ea6126c139af..c3bbe8877376 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1452,7 +1452,7 @@ int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
 		scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
 					qc->scsicmd->sense_buffer, sk,
 					asc, ascq);
-		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+		ata_qc_set_sense_valid_flag(qc);
 
 		/*
 		 * No point in checking the return value, since the command has
@@ -1539,7 +1539,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 					   ascq);
 			ata_scsi_set_sense_information(dev, qc->scsicmd,
 						       &qc->result_tf);
-			qc->flags |= ATA_QCFLAG_SENSE_VALID;
+			ata_qc_set_sense_valid_flag(qc);
 		}
 	}
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3a442f564b0d..6a90062c8b55 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
 	} else if (is_error && !have_sense) {
 		ata_gen_ata_sense(qc);
-	} else {
-		/* Keep the SCSI ML and status byte, clear host byte. */
-		cmd->result &= 0x0000ffff;
 	}
 
 	ata_qc_done(qc);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ab4bd44ba17c..85d19d6edcea 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -70,6 +70,7 @@ extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
+extern void ata_qc_set_sense_valid_flag(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);



I guess the obvious advantage that I can see is that we would do the
right thing regardless of qc->complete_fn.

qc->complete_fn can be any of:
ata_qc_complete_internal()
ata_scsi_qc_complete()
atapi_qc_complete()
ata_scsi_report_zones_complete()

Instead of only doing the right thing if:
qc->complete_fn == ata_scsi_qc_complete().

Thoughts?


Kind regards,
Niklas
