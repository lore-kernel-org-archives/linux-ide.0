Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC947DD6C
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685250; cv=none; b=WpRRvVMWDTYtqwhrcjn2ZKTbgv1NvnURmD4y/914GaPJFYq4jS/fkiWGegG/oxuPb0clB5U9n1SUvPgzPUE3Pb+D+H1OQbODGn8Y1oWiXvK3q2Z1iBiezQjNcw1PYWa0yBlOuQAYpXMuGgZhCqahMW/KGbWKZXOfts2WF54VGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685250; c=relaxed/simple;
	bh=7XVAuWe9jwMAcS2atGTSKlwZh4NFZXOJ0YhwSzZ0zxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDU1LonXtTZFPP7/CpdCmbIlGcuijWLCSaz7OlZpDt49UiUmcfNDEWHva6Ps5xFiENX0RJaKxQTf1bMABwhcR80cebzVWtyoEq/mXuSL2GwBAb4Q6K1MVw9lfMCKB0HovY6oB+OH3bMmHN2VSkulhiEaoe4Sbo1TWLzk1GUM5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldmgscwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldmgscwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256DDC19425;
	Wed, 13 May 2026 15:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778685250;
	bh=7XVAuWe9jwMAcS2atGTSKlwZh4NFZXOJ0YhwSzZ0zxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ldmgscwthOdxdOSzASrAjOIKYsvyvocO9ydrtrFfXWRgCuNXLwgDR6EfGUWDxPSG2
	 W0W6Vj94dKTKssXXF3DNpIr6fnA+EktspMlwZfiBFbMXxQoIWsYj/IGE+M7JYRGLPE
	 +ez35GP6ppCrTH5UoRH6E6tvKYsU2G13IFV4Czy9Wq6Ktlf9deXB4ltyknb9BVR6Wu
	 k5TFWMnP6VXfeMZliYCtF7/aK+tOslv+HTezi6/vQJwfCG8esSQRoPraPwGX2vWiAf
	 UbxCEhghNWzmSBjcd9nv89nxK6id0YI3HbBpO5Ce4DY3ob5rH9vvB09tERo3j7Lxal
	 TIVXnyafycqVw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 1/4] ata: libata-scsi: improve readability of ata_scsi_qc_issue()
Date: Wed, 13 May 2026 17:14:00 +0200
Message-ID: <20260513151359.1075403-7-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513151359.1075403-6-cassel@kernel.org>
References: <20260513151359.1075403-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=cassel@kernel.org; h=from:subject; bh=7XVAuWe9jwMAcS2atGTSKlwZh4NFZXOJ0YhwSzZ0zxk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJYpppf7Ft/1q1wo/q/lzyMv60+nVnnkTwnUutw2rc1H yY+P/onuaOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQAT6VRg+J960ljxBcti7fMr UuOrOUt3SZW18ThbmV09ynFvxp+CJhuG/75zOFZNfv0qYIOln9XtGqmUOd4W3UnLOZj23bx7auK rTxwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Improve readability of ata_scsi_qc_issue().

No functional changes.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6733f2b14521..b9064dd4390c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1767,7 +1767,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 	int ret;
 
 	if (!ap->ops->qc_defer)
-		goto issue;
+		goto issue_qc;
 
 	/*
 	 * If we already have a deferred qc, then rely on the SCSI layer to
@@ -1786,38 +1786,37 @@ static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
 		break;
 	case ATA_DEFER_LINK:
 		ret = SCSI_MLQUEUE_DEVICE_BUSY;
-		break;
+		goto defer_qc;
 	case ATA_DEFER_PORT:
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
+		goto defer_qc;
 	default:
 		WARN_ON_ONCE(1);
 		ret = SCSI_MLQUEUE_HOST_BUSY;
-		break;
+		goto defer_qc;
 	}
 
-	if (ret) {
-		/*
-		 * We must defer this qc: if this is not an NCQ command, keep
-		 * this qc as a deferred one and report to the SCSI layer that
-		 * we issued it so that it is not requeued. The deferred qc will
-		 * be issued with the port deferred_qc_work once all on-going
-		 * commands complete.
-		 */
-		if (!ata_is_ncq(qc->tf.protocol)) {
-			ap->deferred_qc = qc;
-			return 0;
-		}
+issue_qc:
+	ata_qc_issue(qc);
+	return 0;
 
-		/* Force a requeue of the command to defer its execution. */
-		ata_qc_free(qc);
-		return ret;
+defer_qc:
+	/*
+	 * We must defer this qc: if this is not an NCQ command, keep
+	 * this qc as a deferred one and report to the SCSI layer that
+	 * we issued it so that it is not requeued. The deferred qc will
+	 * be issued with the port deferred_qc_work once all on-going
+	 * commands complete.
+	 */
+	if (!ata_is_ncq(qc->tf.protocol)) {
+		ap->deferred_qc = qc;
+		return 0;
 	}
 
-issue:
-	ata_qc_issue(qc);
+	/* Force a requeue of the command to defer its execution. */
+	ata_qc_free(qc);
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.54.0

