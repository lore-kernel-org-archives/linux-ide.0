Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703838331D
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384852; cv=none; b=g/Pv4sXJWf9cDuZgImxHtNz4I1jRygbbdU4UKxZMXNBlwa8HO/MyBi0gYaeJMCaw4QPFgHRiH3KNyWA8MVt367zDanwCgwYY9UZk8U5a+xAMa8dLSyNXbvApaSqFds3ueY/G0N1xkmIae3M02Jf0yS32YQnwu22/jUAu5M8+sKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384852; c=relaxed/simple;
	bh=4fgj9oEiya98UYmuFTZi7gvl9/3xp+e735Hd2BtqgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhLeMd266FP7EC7T+9P1hpG2zJizhFzZVEey7q6//JDEsfbcgjT6E4Tf6mVu5fUrdN9lrV1dPODKkqQdIUCy7hdm7waWDVnMGSJwD9CblzhTFe/eKGbmNX1/m0KcQbwOrtpk9S3PRvxZTqdAIVzgMPGFGv0Z4A5kD6E9qWV2m+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4FkcsZQ+; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4FkcsZQ+"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWK6j6Zz1XM0pS;
	Thu, 21 May 2026 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384842; x=1781976843; bh=f4oUx
	J96fljl+eCxDHvoPgJeILy7BpZUe/yFj4h0OKc=; b=4FkcsZQ+I5y05BZj3lTmq
	ERZgZ2qobYOkTu9zXYlMn1j/UK46icPMquE3Lj6sZG/fn/U0VlK7WLmj6bpNTePW
	aPO1Zv6o3Hd6aBeyaAoO4dJoDGyjmtpiKgwagGZjbhg7TkPkIidXT6kbhDcn0N3M
	sAKwEQ4qo8Re5AQzWZB/UmJIxTFb7DBnpWDNPKlbuoTYtMCaK2+JAYe6N7BIEYrt
	6oiFyjxligafthbkfEYcROzBSoJCdcXRCgYfMBSwJrGJPP5mLYwejDzdR4hV2tN1
	qdmy3DJjSEXOgE/oFSy0K1HquOmbgV8w6u6da/q7OwVDitVQS/pGAu8NYwYKCqYv
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JMbQ9qussuxb; Thu, 21 May 2026 17:34:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWF22bJz1XM0ns;
	Thu, 21 May 2026 17:34:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 3/9] ata: libata: Pass the ATA port argument directly to ata_qc_schedule_eh()
Date: Thu, 21 May 2026 10:33:31 -0700
Message-ID: <20260521173347.2079560-4-bvanassche@acm.org>
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
 drivers/ata/libata-core.c | 4 ++--
 drivers/ata/libata-eh.c   | 4 +---
 drivers/ata/libata.h      | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3d25dec6ac6c..5caae9a2aca3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5059,7 +5059,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 	if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
 		fill_result_tf(qc);
 		trace_ata_qc_complete_failed(qc);
-		ata_qc_schedule_eh(qc);
+		ata_qc_schedule_eh(ap, qc);
 		return;
 	}
=20
@@ -5092,7 +5092,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		 * fast drain, and freeze the port.
 		 */
 		ap->pflags |=3D ATA_PFLAG_EH_PENDING;
-		ata_qc_schedule_eh(qc);
+		ata_qc_schedule_eh(ap, qc);
 		return;
 	}
=20
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6cb79a09423d..7826162bb8db 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -976,10 +976,8 @@ static void ata_eh_set_pending(struct ata_port *ap, =
bool fastdrain)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
+void ata_qc_schedule_eh(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap =3D qc->ap;
-
 	qc->flags |=3D ATA_QCFLAG_EH;
 	ata_eh_set_pending(ap, true);
=20
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 3940dd33efb9..ca04427eb4ff 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -178,7 +178,7 @@ extern void ata_eh_acquire(struct ata_port *ap);
 extern void ata_eh_release(struct ata_port *ap);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_fastdrain_timerfn(struct timer_list *t);
-extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
+extern void ata_qc_schedule_eh(struct ata_port *ap, struct ata_queued_cm=
d *qc);
 extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_eh_detach_dev(struct ata_device *dev);
 extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device =
*dev,
