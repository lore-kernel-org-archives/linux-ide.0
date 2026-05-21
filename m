Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79637285CBA
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384854; cv=none; b=iajbt2b9dyFXf0IjRCAJA7qBqzmxwcOmoejz6lQRRBjsW+GnwJINPkc+uCRV14LNefWwiC008SWV5XTEpU2ygoBEAuwVDQKk7MdLmhElKx8U9vkpTLfay6UZuBvU5mhH6HHDZ3kbqWLTfZXoC8BcVxRVN0IuJTVMhG1VAcGtF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384854; c=relaxed/simple;
	bh=tI8aK+3bdEmjzxzdcjDHIhVWpQOq/uURVNa8duupAY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPBD11TP5Ttl1NMhfJanZGr/XimEwppMMSMqG2zw8BenR9lvtEc7bHFECVL/AcmTQ9tA6cd5+JvcnJ5wGbyFqQq0MkdCoKjWQrwapbv+cWowc6i6ySRFPypiPCmE9oBxkJkFyB6A24KdPN4zq5Sp/szPE9Wud7w87Rz/1y3moLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fnoGIQB6; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fnoGIQB6"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWT129Yz1XM0pD;
	Thu, 21 May 2026 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384849; x=1781976850; bh=zS9fx
	qGnqs0xGK0IUDdL7bVgrMfRfxYyKZKq0icAfYM=; b=fnoGIQB6Fq70QSoCFSONx
	kMTjy3Om3JWIfL+F9u6gA3kT/YVDIBIfpEs5SaHJ+CoMtmq7MrcS6LPfn6iyYllc
	2G2sPI4dlB7cH+32G0oSB3i3R0iomPVBgmg3oQStE4lZsAo8IMKqmPclCuz6JbMp
	vSKKrb4fG+qIpUcjmpWOXRx9duCGqZzgPjAbU5OHGvIhhyzXCrvUK2ci1qJjSB2H
	vomkdX9+jd+oB4s5qdFkv6k8YsHFtdL7fNBNu/ZKqzhkke/eEAAkPPPVQlUonzvp
	GTdt8ESLbXs9aawMoJLKPfQjnq3NdljeLWdfqohx1I4V9z9PqOkbHoZuoRALioLs
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eYPhMKcXl_cz; Thu, 21 May 2026 17:34:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWN1bmmz1XM0ns;
	Thu, 21 May 2026 17:34:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 5/9] ata: libata: Pass the ATA port argument directly to ata_qc_issue()
Date: Thu, 21 May 2026 10:33:33 -0700
Message-ID: <20260521173347.2079560-6-bvanassche@acm.org>
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
 drivers/ata/libata-core.c | 5 ++---
 drivers/ata/libata-scsi.c | 4 ++--
 drivers/ata/libata.h      | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 307ab48fe04c..5f0c2ee8846b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1605,7 +1605,7 @@ unsigned int ata_exec_internal(struct ata_device *d=
ev, struct ata_taskfile *tf,
 	qc->private_data =3D &wait;
 	qc->complete_fn =3D ata_qc_complete_internal;
=20
-	ata_qc_issue(qc);
+	ata_qc_issue(ap, qc);
=20
 	spin_unlock_irqrestore(ap->lock, flags);
=20
@@ -5159,9 +5159,8 @@ EXPORT_SYMBOL_GPL(ata_qc_get_active);
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_qc_issue(struct ata_queued_cmd *qc)
+void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap =3D qc->ap;
 	struct ata_link *link =3D qc->dev->link;
 	u8 prot =3D qc->tf.protocol;
=20
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 55380a9d873a..352b9b9e9b6b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1680,7 +1680,7 @@ void ata_scsi_deferred_qc_work(struct work_struct *=
work)
 	if (qc && !ata_port_eh_scheduled(ap)) {
 		WARN_ON_ONCE(ap->ops->qc_defer(qc));
 		ap->deferred_qc =3D NULL;
-		ata_qc_issue(qc);
+		ata_qc_issue(ap, qc);
 	}
=20
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -1815,7 +1815,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, s=
truct ata_queued_cmd *qc)
 	}
=20
 issue:
-	ata_qc_issue(qc);
+	ata_qc_issue(ap, qc);
=20
 	return 0;
 }
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ca04427eb4ff..5a8ee6f262de 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -88,7 +88,7 @@ extern int ata_down_xfermask_limit(struct ata_device *d=
ev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern void ata_qc_issue(struct ata_queued_cmd *qc);
+extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)=
;
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
