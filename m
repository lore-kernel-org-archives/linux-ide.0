Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141B1428E8
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318441; cv=none; b=dkX5/Xvz/whXyTXU4Sw/nItKVi8nOW+zpJcc41QrGScTyKxF3UJwJrNOK67XqGzzegr1Dvg7DV+UuUSRfF8SV5jZ2w7I23L0nLksKI7TXSKhWbtepLLAtvkwzsCq4tqwl7MhKfTZ3HCwHnnbnziDS6lSAkmu7Zy/+Kwl3ZRDGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318441; c=relaxed/simple;
	bh=q1XO1oc84pps6eHI21sCyhddLdesocmZu5FYwe0+RME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugrYKHepWVxcaHy3tpvYAowvhzJ9amGI1JVyELZKHKUEHVGdA937NUgsB/+qnrdu7kTdxrGo0jSd4B65yYA1uen1/7qfSuW0rwvHAFhNjI1kOhaB4UnHBf3cSQI85BkXgrjx7nIbrsvW1kOsvjZdxpQ/ozbVr9g7lLREtjS2PaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfdqp043; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfdqp043"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CDC4CEC6;
	Mon,  2 Sep 2024 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725318440;
	bh=q1XO1oc84pps6eHI21sCyhddLdesocmZu5FYwe0+RME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qfdqp043E555sUhaMCW90vijVDix3dh4BhFBffRFB5QKYf/ntPGA7wKHQ6tz9lSVp
	 mRdmarteNJUgLQqJrlcCnAv04e9jU63yomaU5K6oCItnPt9oRnDk2NKP/sG2EQ1Z33
	 QfkoLOYqUUWAEnx0cDQNBkMFwrOyxK/VlvHbZTgalN0jb4y9SUZPtbvdu/TXWM/a9E
	 JlxlTx8X2smJKkKHGN2nJ5LIGnzmo5gVTpU7eS0EC1v/JhyDWUAQE6beicHo2ScS4O
	 cgBJh1Xp2s4ScYff6Ma5GCWUyTH3wSvkJJqPCr7EEkMif/kRuUGMMGCpTwU/A/C8fy
	 8eZ6xo79cFF3w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 5/7] ata: libata: Rename ata_eh_read_sense_success_ncq_log()
Date: Tue,  3 Sep 2024 08:07:13 +0900
Message-ID: <20240902230715.176522-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902230715.176522-1-dlemoal@kernel.org>
References: <20240902230715.176522-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ata_eh_read_sense_success_ncq_log() does more that just
reading the sense data for successful NCQ commands log page as it also
sets the sense data for all commands listed in the log page.

Rename this function to ata_eh_get_ncq_success_sense() to better
describe what the function does. Furthermore, since this function is
only called from ata_eh_get_success_sense() in libata-eh.c, there is no
need to export it and its declaration can be moved to
drivers/ata/libata.h.

To be consistent with this change, the function
ata_eh_read_sense_success_non_ncq() is also renamed to
ata_eh_get_non_ncq_success_sense().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c   | 6 +++---
 drivers/ata/libata-sata.c | 7 +++----
 drivers/ata/libata.h      | 5 +++++
 include/linux/libata.h    | 5 -----
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7de97ee8e78b..d2747a0d684c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1962,7 +1962,7 @@ static inline bool ata_eh_quiet(struct ata_queued_cmd *qc)
 	return qc->flags & ATA_QCFLAG_QUIET;
 }
 
-static int ata_eh_read_sense_success_non_ncq(struct ata_link *link)
+static int ata_eh_get_non_ncq_success_sense(struct ata_link *link)
 {
 	struct ata_port *ap = link->ap;
 	struct ata_queued_cmd *qc;
@@ -2013,9 +2013,9 @@ static void ata_eh_get_success_sense(struct ata_link *link)
 	 * request sense ext command to retrieve the sense data.
 	 */
 	if (link->sactive)
-		ret = ata_eh_read_sense_success_ncq_log(link);
+		ret = ata_eh_get_ncq_success_sense(link);
 	else
-		ret = ata_eh_read_sense_success_non_ncq(link);
+		ret = ata_eh_get_non_ncq_success_sense(link);
 	if (ret)
 		goto out;
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 40f70de94fbd..4e063cb42018 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1487,8 +1487,8 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 }
 
 /**
- *	ata_eh_read_sense_success_ncq_log - Read the sense data for successful
- *					    NCQ commands log
+ *	ata_eh_get_ncq_success_sense - Read and process the sense data for
+ *				       successful NCQ commands log page
  *	@link: ATA link to get sense data for
  *
  *	Read the sense data for successful NCQ commands log page to obtain
@@ -1501,7 +1501,7 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
+int ata_eh_get_ncq_success_sense(struct ata_link *link)
 {
 	struct ata_device *dev = link->device;
 	struct ata_port *ap = dev->link->ap;
@@ -1571,7 +1571,6 @@ int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ata_eh_read_sense_success_ncq_log);
 
 /**
  *	ata_eh_analyze_ncq_error - analyze NCQ error
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 3df17da08c7f..2a9d1bbf2482 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -95,11 +95,16 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 /* libata-sata.c */
 #ifdef CONFIG_SATA_HOST
 int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
+int ata_eh_get_ncq_success_sense(struct ata_link *link);
 #else
 static inline int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 {
 	return -EOPNOTSUPP;
 }
+static inline int ata_eh_get_ncq_success_sense(struct ata_link *link)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /* libata-acpi.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d52ae7723c05..55a6b57742bc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1234,7 +1234,6 @@ extern int sata_link_hardreset(struct ata_link *link,
 			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned int *params,
 			    unsigned long deadline);
-extern int ata_eh_read_sense_success_ncq_log(struct ata_link *link);
 extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
 static inline const unsigned int *
@@ -1277,10 +1276,6 @@ static inline int sata_link_resume(struct ata_link *link,
 {
 	return -EOPNOTSUPP;
 }
-static inline int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
-{
-	return -EOPNOTSUPP;
-}
 static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 extern int sata_link_debounce(struct ata_link *link,
-- 
2.46.0

