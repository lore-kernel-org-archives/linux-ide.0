Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3E1A2FA1
	for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267161; cv=none; b=bTwW+/S5t9PDgB+N2lgkbMpj56nhPDxErPsMrOYlD/WKf8sMLFFZjptX2zoyhHLhj+p1rnlVP4hBqaBt6d/puAiaPbUjzfXgrt5d5C5nNtAThLnH3r0YyEaO3oV39j2SLyhqseGtQ4bLFYtgkg5C9VVfq2BuIsv24lF6RYQ1FH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267161; c=relaxed/simple;
	bh=QwejxdxJmtTRHtoUQvB6POU7Ble7ol1nMg9swXRXC+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V3rHLt8su8gsW977M7D1mXSYSA6DbsKUUlSzj2iMsiCJkmH1nxcMI+TxxFI7NkQcQvg7rKqiitbjK9XF8sW5y/W9kfrRJs9x1tixW+NtfcvDE6dKw+m/mUSqr8Qb3ozUgPBAmNSoTmoYRhDDBbjnp8p2AQeqeHhPbesm12jXHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBLprWoF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBLprWoF"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7163489149fso4927565a12.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2024 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267159; x=1719871959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4QNMMnwiVz3ILaswEcfqdDsU4n3tKsCQ2BCKeXeiW4=;
        b=dBLprWoFTRfE/u7AyClzxqw+HEIsyhK7XguQWzM8mmA1zzqgcFuoJpcjShmQw8csA/
         ptns9y4W9s4nzOYMNzaXizZ9GdVu74XSXeRgt8TrUaCbqS53wHkzMIAYIAtycXv96hej
         sJP6QlDoAoycuVy5VJv6Y9QXKKuvmACTZ5Y6LV+M4hyCgeZ7kzrQDQPc+iZLqVlFlE+d
         E+zDwYb2Awagp34b+VpWGGE1UnlvlMW052mGmUQPMnsqCYmiwE0WNpKRXQHp+s2LocOz
         lX2eJxRF32MXulRL3boQmvOGDraRMt36tgpPoDraefsPWdkq47b4Pw63sXRgaZdbWSpH
         7cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267159; x=1719871959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4QNMMnwiVz3ILaswEcfqdDsU4n3tKsCQ2BCKeXeiW4=;
        b=hTAEmSVXf2XlznQYIjUE5p1JLMZT9HysNVknCdMdvMZQS+9GLE1exV7N1e+G0ifCYm
         9h2bVRGRTYQVHMoFny/f3U0AreSqBkwnBRMx86JyQFZFj32MjrATiILXcF/pjfXDCTxd
         TAIB7cvh8jiODZe8C0WD/N0WLFcqUinGMyV/3WSAU1NG/cJjgJ8+BvcY5TTWdUV0hFoZ
         rw+ouSrwg20oZYrCWkUpPA/yoCXrFtkbSvGuHekHUpBH7NK8F9U1IKNSkCTpH7O0hBMI
         nZ24TRGmEec9d9U4zwRX2uXJn3WLEVBSbBHdI33tEz+weTPIJ0UWoroIjju6Xkqg1bFn
         H2LA==
X-Forwarded-Encrypted: i=1; AJvYcCX75nL2BF04l951+UHPhjBBwQJe5rD6k3te5j2aPLs2ijPEkU/W3FQO18z1zetdoo4HJ2M/EeT1Mp9V+p9ZQyrDUcGjXbGYu5aj
X-Gm-Message-State: AOJu0Yzpor98bg6ANnj+IDCz44voyPNIHpzILQ9jm8ya/s0PPMz9CJCV
	6JuMaK/aVXDOy7jSwfhG8/l2V0Jhvf+vH/troBl14vzaKa5Se8aIhSoLkBPLKBg8VL34DJH86SS
	XxThXtzlILw==
X-Google-Smtp-Source: AGHT+IFflA1G3grpNjsfx2ZiWo2J8fKoDLM8TXPiJruY4xgfYztBbpyEDlvAdfgXscHbWYR37+52a/UFOGMXLQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:f646:b0:1fa:2b89:f558 with SMTP
 id d9443c01a7336-1fa2b89f864mr6066495ad.7.1719267158936; Mon, 24 Jun 2024
 15:12:38 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:09 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-6-ipylypiv@google.com>
Subject: [PATCH v2 5/6] ata: libata: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
to check if qc->result_tf contains valid data.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libahci.c     | 10 ----------
 drivers/ata/libata-core.c |  8 ++++++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..0728d445e531 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2075,13 +2075,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	u8 *rx_fis = pp->rx_fis;
 
-	/*
-	 * rtf may already be filled (e.g. for successful NCQ commands).
-	 * If that is the case, we have nothing to do.
-	 */
-	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
-		return;
-
 	if (pp->fbs_enabled)
 		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
 
@@ -2095,7 +2088,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	    !(qc->flags & ATA_QCFLAG_EH)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
 		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
-		qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		return;
 	}
 
@@ -2118,12 +2110,10 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 		 */
 		qc->result_tf.status = fis[2];
 		qc->result_tf.error = fis[3];
-		qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		return;
 	}
 
 	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
-	qc->flags |= ATA_QCFLAG_RTF_FILLED;
 }
 
 static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e1bf8a19b3c8..a9fc3ec9300f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4801,8 +4801,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
+	/*
+	 * rtf may already be filled (e.g. for successful NCQ commands).
+	 * If that is the case, we have nothing to do.
+	 */
+	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
+		return;
+
 	qc->result_tf.flags = qc->tf.flags;
 	ap->ops->qc_fill_rtf(qc);
+	qc->flags |= ATA_QCFLAG_RTF_FILLED;
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
-- 
2.45.2.741.gdbec12cfda-goog

