Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D42171676
	for <linux-ide@vger.kernel.org>; Mon,  1 Jul 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863895; cv=none; b=LOPS03XEGRCHgOu8d3+TNgUdMhN/GeFVuUtPQVGuU6dNEgwX0WMrsVjYP89m0U0TuPccVO1DWk7TAtnBNPtmfw4dO7WLFq/GGGMepzMuZi6nIdi55ZkIiVW+1iOhKsp/rP+d+DITRMQQ0vZdhHssCHBPShvBCCzAYDST3rHXcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863895; c=relaxed/simple;
	bh=7GLjsJebG0QqRDF4wDvrP0SWART+au2lQFNxr/q73XA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IlczL8qfDosUiTe4o6AzA4OG2ANV7SOKRFtjuOR3qeEPeDQwou0DRsAUn8VMdIvM9v1TeCF1YbeBgdPz//o5+Npp8B0GClOYlMVx0c6ELa4JRGhfNNpU0RQkqSmjK0r1xWsrPhtkclEnakVxbkUZNRy0srV5/lIMB9ZLqRGlRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qpno7nQs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpno7nQs"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c7d46d273cso2741636a91.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863893; x=1720468693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOewcSvCbExIuuMYZcC7TibLRcnuMMvd64eAILBEvyc=;
        b=Qpno7nQsAARmXwMAoIgar9fPByTne+TBh8pEc7aHkd/I87vDI72+0BkNgLt2Y30moX
         hxuMYreIRPaTrR25PT5Lk5mNpWVhHxnM3K6tGVjDIkKIKggk8VfY9yR6A4cUE2JvzhWW
         cOIDl5HLkjF8BHE1indDaVENCM+CHayDyjNOGGKkVsy47PhV/C5J3eWZFM125oAW7Osb
         jxjpdPZEhtIsHtkU9lQ5SWyuS6kPGWxMSkBdh4y8nXkU57VdHpoYWWPc9lU9qheFRB0j
         QZys7ouoho03Gi/PIyxfdrMq6FXjsvnviUV/rTj+e6pciBT09uIpWK32UZjlxwCxOOP2
         XG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863893; x=1720468693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOewcSvCbExIuuMYZcC7TibLRcnuMMvd64eAILBEvyc=;
        b=p3bh32/BAbXHDdPR/VNUqJN19OGKwFY7H72qZ6RG4cNBtKMVIUhqkHITtPWGkHtNN/
         FaqM9kxlKs0r8wp2uGKX5qWjt+s1iQqX43ojVRukRZWWS+gjix93SDJvuuYMxd6ZxH6r
         mC+MNS+MYpwrBhAUgF3BK8XAJqds+mnYYLj/9hq2UxJ8B4ch8YqEOZzct0+b4V5BQ6yZ
         4LtCVPBfaH9PysCndmRcQqm72b3QyePO7WxOMVu3ls6FL7XlOXktRBvtdEF6qgYfhdHU
         JlxXSaSkfQlDjleB+uBmmmldxjvTbL6aiJ2Ojk6BL0mVQDZp4tSB0NDfJtwTrloLx4Ke
         0Jlw==
X-Forwarded-Encrypted: i=1; AJvYcCW8ScOS3oPPPr/v3syAq2Xktd+d64HJEc68VGJooercoioayEDu3wS+I/0z6CKNPtnPrxOwXBB2PEHvuQGc5+A+Xwfg7n2HaZGU
X-Gm-Message-State: AOJu0YxhzBezlOc1nG9IjYzUZMlKgVjbW4H5j4YJrNLMZk6VKjB7IvcE
	tI2by9qAC0OqKG8RjRKsA6iWPFObJ2MEFKgPLkGkF9osgetHIlCKJAivyGU7rET7xrF0rkRxfKS
	N/MpXl/mlhg==
X-Google-Smtp-Source: AGHT+IHpFXS1KDK85fnPVcZoeeQnujmrZ567T9Vva1yNGkEdWyBDg0ywNSYuztiQHIu/rbX9opCql6t0Orb7MQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:90a:ea17:b0:2c8:3c85:3d1f with SMTP
 id 98e67ed59e1d1-2c9271558bcmr63919a91.0.1719863892611; Mon, 01 Jul 2024
 12:58:12 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:55 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-6-ipylypiv@google.com>
Subject: [PATCH v4 5/8] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c11ae77d3ca6..92d75780fc3b 100644
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

