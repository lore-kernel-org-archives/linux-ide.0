Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A79172BAB
	for <linux-ide@vger.kernel.org>; Mon,  1 Jul 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863897; cv=none; b=rJyRySbX6/LRyYUY/8+ABtRv90cieeVIn93qXQDPaS+3LTlhE3F/7CbIxZmyIrSsRQoByKWfpFNlylfAufT69DB1G0QeTF7yFGQU/pCOD+9mhzMU9Ji80nNKfg9WGrx3neQV+ZfbAtNRDHhQOQRkstuyfoB7kYd9jva6SoruFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863897; c=relaxed/simple;
	bh=jp/EJgN5EJlygiYPMBnOCCu6H23x0pk/OIZFHXKB2ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QOit5LrKA6ohzMQP5sgvTfZdOzAnUqokHtOUywM30VCLmcggVKQVKy+uPX7O6e2oWQBAizOGmQvxz6ldDDFTezOwikVv0jWkhlcuRxw9FxOInb0CiYc17KJ86e81oG7f2DTNo+SpvDEjozVxbdG5/n9Qorc231zFUqpwxm26UGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dP0eY8qm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dP0eY8qm"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c7d46d273cso2741658a91.1
        for <linux-ide@vger.kernel.org>; Mon, 01 Jul 2024 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863895; x=1720468695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBcCivyF1P8rhgIjZ2/cBXkYOTDbZ96Cj7XNFUz4SOg=;
        b=dP0eY8qmyX0zBoQqbeaC1XpDKyeKn+jl6foQ8tPnjM9pt7MVvhy7Eak/7KLOPLcOJB
         PBDjS5mECuEcIw0lRzF/GZZwVcJldiQs12dfdBQxyJ3pogHvfvivE9NYwipDGayQaHE7
         P+0u7d7SoLv1yMZmKnn9xUso+8tC8QrD9XPszVji3nYkpQqHBbKtW7Om93+GKDpNyrMn
         PtZhCJMS1nBX7KUoiu2n7bO2KSMt1ywwqw2wOs7oBf0RjzApjAHUN4muS+AYIlwvr3ko
         gmiJdMWHOwd3G3kkH2Gkj6mh0wYb5+9gtT/GfFpkw0zOFNQHkOygGgdtqcaPZcFq2Bk3
         X98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863895; x=1720468695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBcCivyF1P8rhgIjZ2/cBXkYOTDbZ96Cj7XNFUz4SOg=;
        b=l4Z82DkTYZloyHAKGETRS5JMreDYxbt0UD1R9g2AwVJiS8iQq1pNjN0dBE2lBrqmEm
         vhIlfJBR1uLnXKhJi0mg5mfbxKsVItoRPVS/QwxSoihSXqPuEpceCOrTgj5EpewuIQim
         rUJ2vJRwDgfEerSRJ9vTvIAJJ7orN78gj1xvFO3KYep281gSyjnYGl2K90rLfVufZc6R
         yCjWdHM0dCKrjgPU5mgtNevrf78e5TEnCRj6jyhNZ/njiqk4oW2grvaXcPmgjvD5kzvl
         uPoUCMwrTv8O8IAGWBJ3yE5fqh+WCaH29UCkFxTGT0rzBl1YoUUBZzGz0Vrcbhcy3Svq
         HzuA==
X-Forwarded-Encrypted: i=1; AJvYcCXo6AiD5y03AgLma4o/sa+/16y/2rSIMg4j+buJarWTGjFwBW/l3Wd+WzH96tpHI/E8syKbpJfDTGJPMwDPn/5JZNy5bD91HDo+
X-Gm-Message-State: AOJu0YwaoK0Lx2QoJ2wzlzydhai7GgKRBorkWKU7CV6fwfRfUykDkqOW
	/O0PisVSrAI2uN1tgIh8dKtKVVnQEEvRYMRsM9RY65DbqpVL6IV6YTFjqEgyhNy0xtxG0XxmiS+
	4b6qVt3ks4w==
X-Google-Smtp-Source: AGHT+IEAmoCDVb1CCwTLs+zWio2dwxCB3f8jcfxMQ9ve8CmB/yMJcLgXLwiLFKAR65sY8QS/BAMdzTKNJ5TLng==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:90a:1543:b0:2c7:471d:172b with SMTP
 id 98e67ed59e1d1-2c92804c405mr63658a91.2.1719863894361; Mon, 01 Jul 2024
 12:58:14 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:56 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-7-ipylypiv@google.com>
Subject: [PATCH v4 6/8] ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
to check if qc->result_tf contains valid data.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libahci.c     | 12 ++----------
 drivers/ata/libata-core.c |  8 ++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..fdfa7b266218 100644
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
@@ -2158,6 +2148,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
 			if (qc && ata_is_ncq(qc->tf.protocol)) {
 				qc->result_tf.status = status;
 				qc->result_tf.error = error;
+				qc->result_tf.flags = qc->tf.flags;
 				qc->flags |= ATA_QCFLAG_RTF_FILLED;
 			}
 			done_mask &= ~(1ULL << tag);
@@ -2182,6 +2173,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
 			fis += RX_FIS_SDB;
 			qc->result_tf.status = fis[2];
 			qc->result_tf.error = fis[3];
+			qc->result_tf.flags = qc->tf.flags;
 			qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		}
 		done_mask &= ~(1ULL << tag);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 74b59b78d278..949662bc50e4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4800,8 +4800,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
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
2.45.2.803.g4e1b14247a-goog

