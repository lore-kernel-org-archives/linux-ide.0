Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E235C180
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384858; cv=none; b=LFbCDaa/P4UrkAdKUxkiFrhAWUxRftfQ/9qgISucJWmyVJX8V3uqRzQAD12PpmE/Qiief9azctAW09Sxasp2Monxuw40xOUoFTCAaeZD6mCkjtFf+VmsPJyEDWb0cO/hbHS8WkeIGDbpZSEZpFOO7XhlICyNK3aLnOdhs3iQp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384858; c=relaxed/simple;
	bh=QAM5xAX4sLld+cEfsH92sK2jfoaDfwkoAmbSSuWQH8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDZE8YLW8U92gs7oiOnOgQleomMCw+sjzoAIggmtTY5plyGHXfkqU54meeY/qQVM4tyjNyHU6YTGx+79VE4yXfbNrDmHA5LR5nKz3g722I+Z4+WtetTk2SFbn3qQFLQg2X4MY5o5Zhqpuivm5UxAXDfr6/MVRdZrhTV2rifyyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RmiiCLTL; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RmiiCLTL"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWX6mNLz1XM0pD;
	Thu, 21 May 2026 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384853; x=1781976854; bh=GUd0y
	iUPHDBnYGpALZXI67e/DwmGDSUpr5OMNi/X/X4=; b=RmiiCLTLF/1plpa+V63ap
	dYl91h4HMZyOXkU2ZcECYRjTfH094Oq3x2j51FMuTQw0DcxDlJedS2ee3vilWyKv
	8QSGIas0HRLMGj8J7lKyhtl+r/7DTVZkQku6b8ug1lIxsGj0IJzHD9JAboC0b2kg
	yOrcvNSHNElK0fBug8zMCL7p/4pxbr2KaDBc6cVMvoTHDc94ObuGCqtExnkPxtxn
	Pa5XLrwaj9B8Yt1du3f73I7pHXB0HShP+iiy51s5hPXCKy8scfrj8lvGKUiEeHh2
	xUHxfXPchIsnDP2ANKBdnP+UR17yYZdfPQLG1ojmsDjxAduX+Vr/UoWBTAYqHEBA
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Go8y3Jo9jm7H; Thu, 21 May 2026 17:34:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWP6YStz1XM0p0;
	Thu, 21 May 2026 17:34:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 6/9] ata: libata: Pass the ATA port argument directly to __ata_qc_complete()
Date: Thu, 21 May 2026 10:33:34 -0700
Message-ID: <20260521173347.2079560-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260521173347.2079560-1-bvanassche@acm.org>
References: <20260521173347.2079560-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for adding lock context annotations that refer to the ATA port
argument (ap). No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libata-core.c | 8 +++-----
 drivers/ata/libata-eh.c   | 2 +-
 drivers/ata/libata.h      | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5f0c2ee8846b..96f7706d6eb8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4939,15 +4939,13 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 		qc->tag =3D ATA_TAG_POISON;
 }
=20
-void __ata_qc_complete(struct ata_queued_cmd *qc)
+void __ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap;
 	struct ata_link *link;
=20
 	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_ACTIVE)))
 		return;
=20
-	ap =3D qc->ap;
 	link =3D qc->dev->link;
=20
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
@@ -5050,7 +5048,7 @@ void ata_qc_complete(struct ata_port *ap, struct at=
a_queued_cmd *qc)
 	if (unlikely(ata_tag_internal(qc->tag))) {
 		fill_result_tf(qc);
 		trace_ata_qc_complete_internal(qc);
-		__ata_qc_complete(qc);
+		__ata_qc_complete(ap, qc);
 		return;
 	}
=20
@@ -5119,7 +5117,7 @@ void ata_qc_complete(struct ata_port *ap, struct at=
a_queued_cmd *qc)
 	if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
 		ata_verify_xfer(qc);
=20
-	__ata_qc_complete(qc);
+	__ata_qc_complete(ap, qc);
 }
 EXPORT_SYMBOL_GPL(ata_qc_complete);
=20
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ed724bd45529..b9f1af9e1955 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1212,7 +1212,7 @@ static void __ata_eh_qc_complete(struct ata_queued_=
cmd *qc)
=20
 	spin_lock_irqsave(ap->lock, flags);
 	qc->scsidone =3D ata_eh_scsidone;
-	__ata_qc_complete(qc);
+	__ata_qc_complete(ap, qc);
 	WARN_ON(ata_tag_valid(qc->tag));
 	spin_unlock_irqrestore(ap->lock, flags);
=20
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5a8ee6f262de..5cdcb71f47b3 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -89,7 +89,7 @@ extern unsigned int ata_dev_set_feature(struct ata_devi=
ce *dev,
 					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)=
;
-extern void __ata_qc_complete(struct ata_queued_cmd *qc);
+extern void __ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd=
 *qc);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern bool ata_phys_link_online(struct ata_link *link);
