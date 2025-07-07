Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40A27453
	for <linux-ide@vger.kernel.org>; Mon,  7 Jul 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886103; cv=none; b=IagC8JBTehBcqTn1QgDCBeA4WUkUurK+/Gspb6Q3AHeOSPUmbgZL5NRmKm3GD77NhuuIfXXeTdmAsCl58jdoz2iQHHSrZhK5zBmI01FJsNr1avURiHqMUxYVeDgyOkko1Wld0GG/j2FJPlmX7MxiK5ASKrxTttXcAO1paRrTU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886103; c=relaxed/simple;
	bh=44Be0L1O87HZfe0kQD01zuNqo9c6mYXVgYyBejPE828=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1swNeBzcC9fs+7IgvVxw34Q9MOq2KDc6w9zzKxZdpharp8Uzh2Oe+ZmqSLi6ZbPPCL6fRKdP1+wRHpMDIce1SK6L9tHta0FLaJQMO/IuSDOMyFtQs/HYNSITCo64p8gxILw5V2N/a8VjrNV5N4HoasiWbuOxEWk4AUo0UuFQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7eRntDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7eRntDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38D1C4CEF6;
	Mon,  7 Jul 2025 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886103;
	bh=44Be0L1O87HZfe0kQD01zuNqo9c6mYXVgYyBejPE828=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=d7eRntDWRYqWaNIh5ey2KW7jGKebqvwVnOZnqPWz9D/fF5ueFL0tuUUdoO6AUrv7h
	 v8SGrwrtcs7a1ivbkGFayc8tCiKWEhD7I751EGklVcuwtNW1cnF2jjgiXAYHTlOwM+
	 qeqT9bJ9DrCgTtK8X4Zb5B4HhPoHEjeHJotovJWOMp/CrSn713ecXpnES9ZpR2sO8Y
	 KHGjJ+EPwxsTrBkeTKET+cBvBGJPZipMgziwJcMAwk4kBfojXgY6Imukki2aEsNTI3
	 tV8MHfwA5rwej/3irsBlIyYbAHH1M/mN4vMHeWlVKg8EK2rvHE/UqQ5xzztQdAN2d7
	 bCAt8bqL28gcA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 2/3] ata: libata-eh: Remove ata_do_eh()
Date: Mon,  7 Jul 2025 19:59:30 +0900
Message-ID: <20250707105931.548315-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707105931.548315-1-dlemoal@kernel.org>
References: <20250707105931.548315-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only reason for ata_do_eh() to exist is that the two caller sites,
ata_std_error_handler() and ata_sff_error_handler() may pass to it a
NULL hardreset operation so that the built-in (generic) hardreset
operation for a driver is ignored if the adapter SCR access is not
available.

However, ata_std_error_handler() and ata_sff_error_handler()
modifications of the hardreset port operation can easily be combined as
they are mutually exclusive. That is, a driver using
sata_std_hardreset() as its hardreset operation cannot use
sata_sff_hardreset() and vice-versa.

With this observation, ata_do_eh() can be removed and its code moved to
ata_std_error_handler() with the hardreset operation change of
ata_sff_error_handler(). With this, ata_sff_error_handler() is
simplified and only need to call ata_std_error_handler().

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c  | 46 ++++++++++++----------------------------
 drivers/ata/libata-sff.c | 10 +--------
 include/linux/libata.h   |  3 ---
 3 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 436536112043..68581adc6f87 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4067,59 +4067,39 @@ void ata_eh_finish(struct ata_port *ap)
 }
 
 /**
- *	ata_do_eh - do standard error handling
+ *	ata_std_error_handler - standard error handler
  *	@ap: host port to handle error for
  *
- *	@prereset: prereset method (can be NULL)
- *	@softreset: softreset method (can be NULL)
- *	@hardreset: hardreset method (can be NULL)
- *	@postreset: postreset method (can be NULL)
- *
  *	Perform standard error handling sequence.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-	       ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-	       ata_postreset_fn_t postreset)
+void ata_std_error_handler(struct ata_port *ap)
 {
-	struct ata_device *dev;
+	struct ata_port_operations *ops = ap->ops;
+	ata_reset_fn_t hardreset = ops->hardreset;
 	int rc;
 
+	/* Ignore built-in hardresets if SCR access is not available */
+	if ((hardreset == sata_std_hardreset ||
+	     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
+		hardreset = NULL;
+
 	ata_eh_autopsy(ap);
 	ata_eh_report(ap);
 
-	rc = ata_eh_recover(ap, prereset, softreset, hardreset, postreset,
-			    NULL);
+	rc = ata_eh_recover(ap, ops->prereset, ops->softreset,
+			    hardreset, ops->postreset, NULL);
 	if (rc) {
+		struct ata_device *dev;
+
 		ata_for_each_dev(dev, &ap->link, ALL)
 			ata_dev_disable(dev);
 	}
 
 	ata_eh_finish(ap);
 }
-
-/**
- *	ata_std_error_handler - standard error handler
- *	@ap: host port to handle error for
- *
- *	Standard error handler
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- */
-void ata_std_error_handler(struct ata_port *ap)
-{
-	struct ata_port_operations *ops = ap->ops;
-	ata_reset_fn_t hardreset = ops->hardreset;
-
-	/* ignore built-in hardreset if SCR access is not available */
-	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
-		hardreset = NULL;
-
-	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
-}
 EXPORT_SYMBOL_GPL(ata_std_error_handler);
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 5a46c066abc3..e61f00779e40 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2054,8 +2054,6 @@ EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
  */
 void ata_sff_error_handler(struct ata_port *ap)
 {
-	ata_reset_fn_t softreset = ap->ops->softreset;
-	ata_reset_fn_t hardreset = ap->ops->hardreset;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
@@ -2077,13 +2075,7 @@ void ata_sff_error_handler(struct ata_port *ap)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	/* ignore built-in hardresets if SCR access is not available */
-	if ((hardreset == sata_std_hardreset ||
-	     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
-		hardreset = NULL;
-
-	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
-		  ap->ops->postreset);
+	ata_std_error_handler(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_error_handler);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d092747be588..4a7f308fa4e5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1412,9 +1412,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 
-extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
-		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-		      ata_postreset_fn_t postreset);
 extern void ata_std_error_handler(struct ata_port *ap);
 extern void ata_std_sched_eh(struct ata_port *ap);
 extern void ata_std_end_eh(struct ata_port *ap);
-- 
2.50.0

