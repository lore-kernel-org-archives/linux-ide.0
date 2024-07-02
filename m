Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21647F45
	for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2024 02:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888470; cv=none; b=NqiRrhL8kzOi6bHpEBYDOCUKfAb6ilzm/MFoZntht6/kjDmnIlr1td5kMvJ/szcG0BqVyLKgzEajXpeaL7MM6KaiJrbGzxwcpznejCsHq7+3nPAbyz9Su1l6txUvr6C8dWluTIqH+VDMgULCLjhINGq4N/ZPKR++eZ/CUoRNOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888470; c=relaxed/simple;
	bh=6q2XtXMfjJDSePaQ2bcHelVvF3WWc13ttlQWb34qK9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QF6HNmqDV2nPwJc20gzm4eeTxzBwWoZ4A976dqkpx0YKoKpFPR0AQ2K2sQUjxgZp/VCMhOn2V85PX4qyXOpG2Z0afq01/wH8lxCyr2mx4NPUZTuEMigRUzbDRqHEUvtd/IlEDYHxJ43Ny5vyWQr1+y1WKB2BMmpc5vsAIan4ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FO6mIwiX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FO6mIwiX"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035f7f715cso3684807276.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 19:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888468; x=1720493268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnHqVDC7cuQpLJUncoQ6Ep2IcWycGGYxv6pv9bVVUIw=;
        b=FO6mIwiXsrRJ98UYgS22BYCUAIrahYfdjh9wlDL8uHwe95r4lriQIzfpbJr/YwuoBV
         gN1X57PuoOSqRX4gz++zOREuqTpWQRTIKGWnMeCepk6OK+l9o3YtiTDYru5zJ6pXjl7x
         TPOXRDF61KSUf0pez/frw0QDsR6gB7PQU3ckRXwUtF7oX5vUENwif46XXC/Jxq0NzTna
         yKvEtb9equ6KO+ZjqRFPdDJUC70PatIf6/VUFm8D2g6fbaTboQZAzi0bT7oWk9peXG9N
         LEpQd/VeXXZ07iy1w28Q8AwJhC11gPwoM8+8GnoxzXvcnzAiD7Nn9iY0AFESLZnz3Qdv
         8tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888468; x=1720493268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnHqVDC7cuQpLJUncoQ6Ep2IcWycGGYxv6pv9bVVUIw=;
        b=g72/RyVNGoF2keNZ/mtt79chrw67iacz+QajVffC0kdClfOfKFO/cMMJzDPf5Fn1lf
         zk+kJp4EUpYHWrtO/Qc0dcHkI2Gxprvek4T3cVpRn30o0fx1qq/To3JFKe56fMLq0fGK
         hk6Q/eynMq95B+m9k1A4l8yiqUS8D2ZdlspOiFizDolDhuIvHBUaJtbI3+iVcr7PHRj1
         VIyc158M710iXInhizRV1TYW9tAO/LGJcgT47yaJj1iiRS2U4MpmOOkdLOEHIOrlW1yD
         GnPIx5b4dpUC9xip3fbjHpty9EoNbrMVf89tE6MSz57fFsVarBxp5AS1yMeC+TondFZw
         +E+A==
X-Forwarded-Encrypted: i=1; AJvYcCUDDscezOe2CTOAPPo6/CLP49sEsCL7HsCQEs66lq2e/6d4xpouilAerDHqnWe1y7ewnhXcbhq77XRsfLhsHG9BBcf4nqAhdlft
X-Gm-Message-State: AOJu0YxWp1O78AP7qRrpBlrPWDJGbKlra14frenHGVex9MBkx0Lv2RIu
	z8aaLrr/uCpwGJJqBTqYV0wqDTkuys2+15ZKU23R/uqtx3Fjmg1l/r7NVd5lTOVVWRzhu34IVTy
	TE6Xy1Y2T8w==
X-Google-Smtp-Source: AGHT+IE8BuvEAubldm7affIT7w5nUKEMKVB8uiyHBceDURelDM4xrZugLTZA2bjl0xdR+Tk5nDY+2O8OWgfkmA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:f12:b0:e03:5e58:489b with SMTP
 id 3f1490d57ef6-e035e585039mr152667276.3.1719888468352; Mon, 01 Jul 2024
 19:47:48 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:33 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-6-ipylypiv@google.com>
Subject: [PATCH v5 5/7] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 145319874c1a..226a36c9504b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -785,7 +785,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -799,8 +798,8 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
-			       u8 *asc, u8 *ascq)
+static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
+			       u8 *ascq)
 {
 	int i;
 
@@ -934,7 +933,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -973,7 +972,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
-- 
2.45.2.803.g4e1b14247a-goog

