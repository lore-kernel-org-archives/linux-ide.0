Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53B38331D
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384849; cv=none; b=BmxXoCcAgwNJSl6M5yKpOYmwrYA+X4xHjiY9ZUk0h5QYO49ew0ywpwq6HsMBdtBVRxHQxIt1Lp682bMGX6wXISPefzCrwf50KVVZ5y7D8VUN9tZTuDEx9QLpf8vuTu62tiQ5tOSgOE90ggOUfQPG9yV5ajQ6AwIb6GusNFNqDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384849; c=relaxed/simple;
	bh=/PMLbBhlW6fjAV247Mig+zobbG4Tr8++wEtnED4bmKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6Ey0dKhiz2Rer5X+ylWgbN4RF59GV4+qtf9OZxdPyg6xdNqmf5PkosZ9pJ+4XPCO+2Risui+vPow7Z264B7/IG9BlWJvQXJmoLaC/79QJEBsKne5eC/f/aJfwDclQgMn+mJ1D3rLEcBB9qHFhn0c62qt/5CBVR0WVDeJCcONhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LouXx67Z; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LouXx67Z"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWJ0pSTz1XM0p0;
	Thu, 21 May 2026 17:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384840; x=1781976841; bh=FOzXL
	5B0Gaqf6c4R3EXkQpGAwMzxxBCloMfpFoIbwV4=; b=LouXx67ZXfzRfmtFwBA8r
	p1tcKC6oQoG0nBvxCXrLwvx5qw5RJeWR/cL5HTZwoACmbmlmAZTj+jNf4kV01PWh
	WPuPGhBgW+ugqGzBn0WSPS5zip1aLRiJ/WULugIidTxOZ45EwDxuone5cla/yFwO
	K89gcnwyJe22C0ZDGD28oE0ZiWOMWsaaquhqagzOdcwd48594OAlJ4xvD3H1rH6B
	jlhIVaRUyO5psB0lMJTVfld/OQpCrURUaTes5IatB5sCZ2SUi1erDCLWR5Qx0NTc
	gsST8THB0+HP0hHMeqxxBku6ZKaE/ivktV/M+goIEZGocARlPT+3OoWjwMrps/2x
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kHklC4xcigsG; Thu, 21 May 2026 17:34:00 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWC1rVDz1XM0p8;
	Thu, 21 May 2026 17:33:58 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly to __ata_scsi_queuecmd()
Date: Thu, 21 May 2026 10:33:30 -0700
Message-ID: <20260521173347.2079560-3-bvanassche@acm.org>
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
 drivers/ata/libata-sata.c | 2 +-
 drivers/ata/libata-scsi.c | 6 +++---
 drivers/ata/libata.h      | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2ee54d60ea4b..5e5be6bbf32a 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1379,7 +1379,7 @@ EXPORT_SYMBOL_GPL(ata_sas_sdev_configure);
 int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
 {
 	if (likely(ata_dev_enabled(ap->link.device)))
-		return __ata_scsi_queuecmd(cmd, ap->link.device);
+		return __ata_scsi_queuecmd(cmd, ap->link.device, ap);
=20
 	cmd->result =3D (DID_BAD_TARGET << 16);
 	scsi_done(cmd);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6733f2b14521..55380a9d873a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4506,9 +4506,9 @@ static void ata_scsi_simulate(struct ata_device *de=
v, struct scsi_cmnd *cmd)
 }
=20
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-					struct ata_device *dev)
+					struct ata_device *dev,
+					struct ata_port *ap)
 {
-	struct ata_port *ap =3D dev->link->ap;
 	u8 scsi_op =3D scmd->cmnd[0];
 	ata_xlat_func_t xlat_func;
=20
@@ -4595,7 +4595,7 @@ enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_H=
ost *shost,
=20
 	dev =3D ata_scsi_find_dev(ap, scsidev);
 	if (likely(dev))
-		rc =3D __ata_scsi_queuecmd(cmd, dev);
+		rc =3D __ata_scsi_queuecmd(cmd, dev, ap);
 	else {
 		cmd->result =3D (DID_BAD_TARGET << 16);
 		scsi_done(cmd);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index b5423b6e97de..3940dd33efb9 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -166,7 +166,8 @@ void ata_scsi_sdev_config(struct scsi_device *sdev);
 int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *l=
im,
 		struct ata_device *dev);
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
-					struct ata_device *dev);
+					struct ata_device *dev,
+					struct ata_port *ap);
 void ata_scsi_deferred_qc_work(struct work_struct *work);
 void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
=20
