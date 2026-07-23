Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF1542A96
	for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2026 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765536; cv=none; b=C8Hn86ic35TVKbhRE16Xlg3FjAJN/4uh/6JD+PugsaWEA3m5qFczW8zyKE7QemfzW6AfgNQyCCBuCqHskYx3Ip9wV0HvVZV2fkdT/85Zelt98zpltcktMnoxR2kihQPgJgdZv8d14qGiIXx17s4tvgDewWPdj8InP7EW71bJrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765536; c=relaxed/simple;
	bh=zxRUk15QyHPFIW7BYoJeqVqYzLOlUGbNStHDtvvRUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoffKgiv9w+0TLGNca+HPp7N88NBphdHC1dziSw2AwixhnM+26N4dJN3hM7srega760fgMJ7sngqu840C1D82kLexCaPXVzvMwWCftWNCWovXRy8jIloEbPEQjvZ1DD6FzwxjKr4+zFAzYv3HZbUT3GBw+ztVKTAZeq89Y8G7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzsRurnk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzsRurnk"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so35683b3a.3
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2026 17:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784765534; x=1785370334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAzbfKn4mKCc6pS6016P2/PNkoC0SU+3zIwIGVc8iJo=;
        b=YzsRurnkln2k3NoKl7Ct7kpqM6+bdz/bwyfvgy5yu3U35CBmpVW6L8MIc/ByK0UN9x
         RNpj6INYRUtZ6vh2rFCR9BFbbCwkXxKNq4ktQzQlE3arp6k6SW9y/afNAiI9txhNw9oV
         bLidmaNkItyxuZzh5ezMDKH8LqCqanSLF9b2lLhsUrv+Pri9WjdcPC0EXTi5Xjajx4GC
         nDi5/cHrYXt87vTKTfBpdjcTBNmU7cuYfwJGAptw200eSwwf8KqObrYJVyXeFgBvR3b9
         2EEQh6E/aCdob1++R2Tddc4+BDwAN2OUXtjFA1Z7EX2PXVgNQGciTRYIMT9a0F5SFrVQ
         lYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784765534; x=1785370334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oAzbfKn4mKCc6pS6016P2/PNkoC0SU+3zIwIGVc8iJo=;
        b=cOVF9bFMWymd9pJx/n8E0hf6qTZfP+t71d6QJhEc+ekO8/JdYSpm5d6p0I9RxSHG1k
         HWq1424jghf6bua8j0VdWJT4nhm2B4KrAuR3V2wUCpccf9REmHw5NbO0JUHK0oNXU4Tc
         Oa3Hs3RDesa2wKx+/Yw0icYwJaikEJn44yJxLPzieYXbrIaFMhN/H02xHTcgnwy6Tgsn
         G3SoipundTqQKDLJmi5+IGyXyNvIDNP9vHZmEJ2IEukvv1a8hfZTFw7e2v3eAaxEi9CA
         AWO8kdYCJzpcE5zRMvQJwmSuO7JscbxWvZsPQ13g2j6JwbyhlVaFqEj0FrZvvPzuRdCX
         ekDQ==
X-Gm-Message-State: AOJu0YweWYcgAjWWbFc25FLFv7EOnbfV1Nvx0iynCkj7qMfeP/4v3AiH
	ExVr9HhOIfq5kkvH5vJ3dmp71nx0qDNgozckOlB/nGQvd+YyFNnp21c7Xv/VPQ==
X-Gm-Gg: AR+sD10GoAO6+K/tzaGTIe/snkh4o5bK6HKMSO5DvPuJe0FO2lX2vpPGfOAWRWrLRyr
	PXtkhCzt8P/0XH86SlazYCOTXsVouXgnRPL7LlWfhni7HPb8uUogGXxQR60TttvS6d9Yf9Qj+3j
	sbRVIoWrn3For/BkQ8HQyY82pms0XavWLSWahb1ECdOfSf377XIQ8VUcabAAuUfmRL/vUhr+Y8r
	FoIQtNzryAyzN0N84tmwDxtJpG4a1WDdbZaFM+ZVF6ZcCC1nUI5B8VTBHMLq1lSbn6ejSfP/IPx
	XIwWBISD9/pjL9oUkgs1Y+m/YVcbpMxCPH1iR93v3ttprOPl8E6RQVIMPxalJl2xMB0Wr8NtYM0
	4dv+qa4RQhydkdZY57AZRqHS0+WZueIOr7DZJJj3U3/5rQma+T0ewibEDEdX5nNz+aV1Ji9N8Sm
	7BZEu1bAcSCpds2pFB7CrO3dlOuxP14WELntekNMRo04DFRwyObNbbGq4fgg3XSULgLYdjkl/Ug
	Cx6KmN3/DklD1yLUqjOQWWom2CXTsMxVKvMvsspGwUI/Yx4HLdqGvhUQXTz3A+K1w==
X-Received: by 2002:a05:6a00:1884:b0:845:c694:5c3d with SMTP id d2e1a72fcca58-84e2b82f716mr1169441b3a.1.1784765534135;
        Wed, 22 Jul 2026 17:12:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e1760025esm2037253b3a.57.2026.07.22.17.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:12:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Mans Rullgard <mans@mansr.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ata: sata_dwc_460ex: preserve sactive_issued state across ISR invocations
Date: Wed, 22 Jul 2026 17:12:08 -0700
Message-ID: <20260723001208.1469323-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723001208.1469323-1-rosenp@gmail.com>
References: <20260723001208.1469323-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zeroing hsdev->sactive_issued on every ISR entry destroys the NCQ tag
tracking that must persist across interrupts.  This field is populated
in the NEWFP (DMA Setup FIS) handler and used in subsequent DMAT (DMA
Transfer Complete) interrupts to determine which tags have completed
via the formula tag_mask = (sactive_issued | sactive) ^ sactive.

With the zeroing in place, sactive_issued is always cleared before a
DMAT interrupt can read it, so the NCQ completion path never identifies
completed tags correctly.  The command completion then falls back to
the non-NCQ path using ap->link.active_tag, which works for a single
outstanding command but produces wrong results when multiple NCQ tags
are in flight.

Remove the spurious zeroing and fix the NCQ/non-NCQ discrimination:
when tag_mask is zero but the active command is NCQ, all tracked tags
are still in SCR_ACTIVE and no completion processing is needed.

Fixes: 2d20da00c324b ("ata: sata_dwc_460ex: get rid of global data")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/ata/sata_dwc_460ex.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 73bacdfd0bd3..025b5d968c78 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -467,7 +467,6 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	struct sata_dwc_device_port *hsdevp;
 
 	spin_lock_irqsave(&host->lock, flags);
-	hsdev->sactive_issued = 0;
 
 	/* Read the interrupt register */
 	intpr = sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);
@@ -517,8 +516,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
 	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
 
-	/* If no sactive issued and tag_mask is zero then this is not NCQ */
-	if (hsdev->sactive_issued == 0 && tag_mask == 0) {
+	/*
+	 * If tag_mask is zero and the active command is not NCQ this is a
+	 * non-NCQ completion.
+	 */
+	if (tag_mask == 0) {
 		if (ap->link.active_tag == ATA_TAG_POISON)
 			tag = 0;
 		else
@@ -534,6 +536,12 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 			handled = 1;
 			goto DONE;
 		}
+		if (ata_is_ncq(qc->tf.protocol)) {
+			/* NCQ commands still in flight; no tag completed. */
+			ap->ops->sff_check_status(ap);
+			handled = 1;
+			goto DONE;
+		}
 		status = ap->ops->sff_check_status(ap);
 
 		qc->ap->link.active_tag = tag;
-- 
2.55.0

