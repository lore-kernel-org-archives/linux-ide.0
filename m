Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C5285CBA
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384866; cv=none; b=gjx8hnlsbUssOOGEjK1j/2roHj0AomOOADFPE3EeFJLRYTuf7rTTVQHOGyv1+2vck1GsDoxLddSpLXFJKSOe3bSyCm2+jMnLZhqMrVLCFL5fBfpRrvGzJX4SfmY+AJEFfGtwP3vzv8MUowwJhK65mwU6gRjs9YOHVEOpPUliQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384866; c=relaxed/simple;
	bh=tklO9FsE0loouY28OXZP5QIvV9cmc/zl4EyJ2x/4zPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joWRM44lrJCDitNcUErFgAi0yGydeJ6Q7hxRukdW05x60XYJuDl8Fz/mDlEPVopKihYG3UcUyPj/cwwy0HPuzE4Xid1AXTIUM3eQQthhGbX6zpazm6TpxGPCnTQtzlSMfRuvowf49AdyZWG3ileQMCR20WlO/OqjlpzqQjUUmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KH9AsJFp; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KH9AsJFp"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWj0plmz1XM0p8;
	Thu, 21 May 2026 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384855; x=1781976856; bh=ux2H5
	2LX+v2g9CPYfzwXREG16/MWgvwqYDeVoe2tiLs=; b=KH9AsJFp7NkUuvSHsi4yA
	H/JF6icQ3Mq7ue520vzJAiROf+ruSLZmcORLmAFphrOjrBl3eDUJvtBj6GyrK9ky
	GpcJ1dEqbMSXPUZ5wZyiUVSyHXTd452YRfR0dZi823LOfOS7gIuPEoBaY/8fXQie
	mh0oysUQQO7tc54vADU3M1tYD/AHWoGX4DMhGU9VcKQO6Geij7cJcuCAsEdXAdq0
	RVnjVc1w4LVXnVBa49G8Rg6i2Cz3TD7opK4XyFR/cLHKD/8ksvFpDbvNUDb/ASc3
	+l78sbzlc5oJFhsXyg+pVSHU9zldpWSH5Rs7C321Rntu9OhXVUCE7iC7+igbfP4i
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y67utDITJL69; Thu, 21 May 2026 17:34:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWT4Fqrz1XM0ns;
	Thu, 21 May 2026 17:34:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	John Garry <john.g.garry@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 7/9] ata: libata: Pass the ATA port argument directly to ata_link_abort()
Date: Thu, 21 May 2026 10:33:35 -0700
Message-ID: <20260521173347.2079560-8-bvanassche@acm.org>
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
 drivers/ata/libahci.c         | 2 +-
 drivers/ata/libata-core.c     | 2 +-
 drivers/ata/libata-eh.c       | 4 ++--
 drivers/ata/sata_fsl.c        | 2 +-
 drivers/ata/sata_mv.c         | 4 ++--
 drivers/ata/sata_sil24.c      | 2 +-
 drivers/scsi/libsas/sas_ata.c | 2 +-
 include/linux/libata.h        | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0c5e5b29bce4..2f685ab5ba78 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1853,7 +1853,7 @@ static void ahci_error_intr(struct ata_port *ap, u3=
2 irq_stat)
 	if (irq_stat & PORT_IRQ_FREEZE)
 		ata_port_freeze(ap);
 	else if (fbs_need_dec) {
-		ata_link_abort(link);
+		ata_link_abort(ap, link);
 		ahci_fbs_dec_intr(ap);
 	} else
 		ata_port_abort(ap);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 96f7706d6eb8..f96e077514f9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5208,7 +5208,7 @@ void ata_qc_issue(struct ata_port *ap, struct ata_q=
ueued_cmd *qc)
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
 		link->eh_info.action |=3D ATA_EH_RESET;
 		ata_ehi_push_desc(&link->eh_info, "waking up from sleep");
-		ata_link_abort(link);
+		ata_link_abort(ap, link);
 		return;
 	}
=20
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b9f1af9e1955..66ea590fad58 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1081,9 +1081,9 @@ static int ata_do_link_abort(struct ata_port *ap, s=
truct ata_link *link)
  *	RETURNS:
  *	Number of aborted qc's.
  */
-int ata_link_abort(struct ata_link *link)
+int ata_link_abort(struct ata_port *ap, struct ata_link *link)
 {
-	return ata_do_link_abort(link->ap, link);
+	return ata_do_link_abort(ap, link);
 }
 EXPORT_SYMBOL_GPL(ata_link_abort);
=20
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ce6f50b8e38c..fc17e0c3e2f9 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1170,7 +1170,7 @@ static void sata_fsl_error_intr(struct ata_port *ap=
)
 		ata_port_freeze(ap);
 	else if (abort) {
 		if (qc)
-			ata_link_abort(qc->dev->link);
+			ata_link_abort(ap, qc->dev->link);
 		else
 			ata_port_abort(ap);
 	}
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ffb396f61731..84c1abd4d0ac 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2449,7 +2449,7 @@ static void mv_pmp_eh_prep(struct ata_port *ap, uns=
igned int pmp_map)
 			ata_ehi_push_desc(ehi, "dev err");
 			ehi->err_mask |=3D AC_ERR_DEV;
 			ehi->action |=3D ATA_EH_RESET;
-			ata_link_abort(link);
+			ata_link_abort(ap, link);
 		}
 	}
 }
@@ -2728,7 +2728,7 @@ static void mv_err_intr(struct ata_port *ap)
=20
 	if (abort) {
 		if (qc)
-			ata_link_abort(qc->dev->link);
+			ata_link_abort(ap, qc->dev->link);
 		else
 			ata_port_abort(ap);
 	}
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index d642ece9f07a..ab27559667b6 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1086,7 +1086,7 @@ static void sil24_error_intr(struct ata_port *ap)
 		ata_port_freeze(ap);
 	else if (abort) {
 		if (qc)
-			ata_link_abort(qc->dev->link);
+			ata_link_abort(ap, qc->dev->link);
 		else
 			ata_port_abort(ap);
 	}
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.=
c
index eb69d2c7f4b6..d6823d8ac876 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -943,7 +943,7 @@ void sas_ata_device_link_abort(struct domain_device *=
device, bool force_reset)
 	link->eh_info.err_mask |=3D AC_ERR_DEV;
 	if (force_reset)
 		link->eh_info.action |=3D ATA_EH_RESET;
-	ata_link_abort(link);
+	ata_link_abort(ap, link);
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2cfd8f79ac2b..e953a9c8e660 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1408,7 +1408,7 @@ static inline int ata_acpi_cbl_pata_type(struct ata=
_port *ap)
  */
 extern void ata_port_schedule_eh(struct ata_port *ap);
 extern void ata_port_wait_eh(struct ata_port *ap);
-extern int ata_link_abort(struct ata_link *link);
+extern int ata_link_abort(struct ata_port *ap, struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
=20
