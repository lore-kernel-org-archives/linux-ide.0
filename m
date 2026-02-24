Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829B23D2A1
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899115; cv=none; b=SRWrITkxQVjgFj5pzyUdFi5Uo9UX5KqMDWhP9coy7ijxYerNFIFGIQ2Y/OFdT2FQz6d7UBvEkqA/l4bsqHwfLDOn71eV34Uwz4DXB5PcD2v8AtRt6Se7H9wX55EtEOA9OgcY+taMX1aJFPHAmiKg/wZTWZVKGx/RAJUQw/vs50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899115; c=relaxed/simple;
	bh=OVTNAu5S84MrSRXKhvQEG8UHfuM5iam6NQ+kHGHtTrw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BS37EfKa+ZuBIBWc6Xxv0Zk1s+vGzmZaLQ3ptTBvOIzfR96wFH2xoQchOVljT1AVCcAo5170BlXtDXu+C3hVtSalUyuJG/jYhdJDoZBJRucXFbzeSaN89Gpdao9zB4TxoNpJ0FzhqVAC5fr530NOP79JR8tbhbED5iDaxMze47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ehb8KpS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ehb8KpS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFE6C116C6;
	Tue, 24 Feb 2026 02:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771899115;
	bh=OVTNAu5S84MrSRXKhvQEG8UHfuM5iam6NQ+kHGHtTrw=;
	h=From:To:Subject:Date:From;
	b=Ehb8KpS9/HoG4+SADmopYuRyIegXMhey6WQMc1EFBmkhi38uYvQSkUKLzW5rliGa3
	 +VzVADWPcdOOG6Z+bkU/Tk+WhSomU8DK56KKQUmn3JrFqV+CfxibXAKjxOwj0WROx/
	 QVLolDdB71RamygqNhucGTJGeYzEImCXWC8Hg+gXFMfj4mPXglws/HpMChegmmRNE6
	 zZ/aD+DIT0T041sVJWA8zfbUx36VoKo5m9m/ZVD+zIhgjwpjgBhlOn0A9UiBcfsgiS
	 rNsj1XYa6IAUmzB7wXyNRMVVCcPRX2nf7QTsu0MgWBwpCeSpYyAUWkNn4fappbTRJU
	 woKX+Q0JIkTnQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-eh: avoid unnecessary calls to ata_scsi_port_error_handler()
Date: Tue, 24 Feb 2026 11:06:38 +0900
Message-ID: <20260224020638.1194842-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling SCSI command timeouts, if we had no actual command
timeouts (either because the command was a deferred qc or the completion
path won the race with ata_scsi_cmd_error_handler()), we do not need to
go through a port error handling, as there was in fact no errors at all.

Modify ata_scsi_cmd_error_handler() to return the number of commands
that timed out and use this return value in ata_scsi_error() to call
ata_scsi_port_error_handler() only if we had command timeouts, or if
the port EH has already been scheduled due to failed commands.
Otherwise, simply call scsi_eh_flush_done_q() to finish the completed
commands without running the full port error handling.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 28 +++++++++++++++++++---------
 include/linux/libata.h  |  3 ++-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b373cceb95d2..c93423ce5258 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -560,21 +560,27 @@ void ata_scsi_error(struct Scsi_Host *host)
 {
 	struct ata_port *ap = ata_shost_to_port(host);
 	unsigned long flags;
+	int nr_timedout;
 	LIST_HEAD(eh_work_q);
 
 	spin_lock_irqsave(host->host_lock, flags);
 	list_splice_init(&host->eh_cmd_q, &eh_work_q);
 	spin_unlock_irqrestore(host->host_lock, flags);
 
-	ata_scsi_cmd_error_handler(host, ap, &eh_work_q);
-
-	/* If we timed raced normal completion and there is nothing to
-	   recover nr_timedout == 0 why exactly are we doing error recovery ? */
-	ata_scsi_port_error_handler(host, ap);
+	/*
+	 * First check what errors we got with ata_scsi_cmd_error_handler().
+	 * If we had no command timeouts and EH is not scheduled for this port,
+	 * meaning that we do not have any failed command, then there is no
+	 * need to go through the full port error handling. We only need to
+	 * flush the completed commands we have.
+	 */
+	nr_timedout = ata_scsi_cmd_error_handler(host, ap, &eh_work_q);
+	if (nr_timedout || ata_port_eh_scheduled(ap))
+		ata_scsi_port_error_handler(host, ap);
+	else
+		scsi_eh_flush_done_q(&ap->eh_done_q);
 
-	/* finish or retry handled scmd's and clean up */
 	WARN_ON(!list_empty(&eh_work_q));
-
 }
 
 /**
@@ -586,9 +592,11 @@ void ata_scsi_error(struct Scsi_Host *host)
  * process the given list of commands and return those finished to the
  * ap->eh_done_q.  This function is the first part of the libata error
  * handler which processes a given list of failed commands.
+ *
+ * Return the number of commands that timed out.
  */
-void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
-				struct list_head *eh_work_q)
+int ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
+			       struct list_head *eh_work_q)
 {
 	int i;
 	unsigned long flags;
@@ -694,6 +702,8 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	ap->eh_tries = ATA_EH_MAX_TRIES;
 
 	spin_unlock_irqrestore(ap->lock, flags);
+
+	return nr_timedout;
 }
 EXPORT_SYMBOL(ata_scsi_cmd_error_handler);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index db87c99e4189..c872d1f9f43b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1225,7 +1225,8 @@ extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 int ata_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
-extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
+extern int ata_scsi_cmd_error_handler(struct Scsi_Host *host,
+				struct ata_port *ap, struct list_head *eh_q);
 
 /*
  * SATA specific code - drivers/ata/libata-sata.c
-- 
2.53.0

