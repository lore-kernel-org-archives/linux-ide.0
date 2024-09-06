Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90581BDE6
	for <linux-ide@vger.kernel.org>; Fri,  6 Sep 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587933; cv=none; b=p5FhGtauNzOndCR70312PbvGdOe7kvHMySvPCRWtXFe+mk5nJyU8zJfdaB4D3UQq9vDjq2zzl58bNeIHEds+9oIZGeP2xaGmUSlJaLO1I1o7Bba+vejn5RbIv4sN26aF4o9zCgbg4ePFgzQZwzWh49U8dDV3r+DlRT0hEw4uX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587933; c=relaxed/simple;
	bh=q1XO1oc84pps6eHI21sCyhddLdesocmZu5FYwe0+RME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrNzv2Lw94wLH036wy7fedf9469zTQC/VE5Sn+xFhGqCQNLZtpePVLgi62Eunvj847TKz26mSRm8Knx+7LaZPcGruXhqHZOtZh83EyrisFHxXHPHWfZBHCQ4VqpDdwWvV5M5tNkYBVcdQNZ3J9ccVNhn/V5SYdf6E1f5MpdZtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4jDCRWl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4jDCRWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D59BC4CEC3;
	Fri,  6 Sep 2024 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725587933;
	bh=q1XO1oc84pps6eHI21sCyhddLdesocmZu5FYwe0+RME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s4jDCRWlBiSPI+nDPtNMGjewLuQOqqI9kNCVee+GZAiw1TSZX9qboykTIQ9zH8qb9
	 5goKeb+nZwwnIlJYyXh+3VblOSQemZlRSmplw56EbbJqEnHJU/qYO4NqJAcDc4+zfu
	 z8Q9yiuLKmhX3LFBsV3oHTlYI5tmvDN81doSZdt8APSYzwc9xlQlqhap8GTjv4HP1X
	 Ja1MVrarvflNTqN7oX6xca3bU3FLuLjh68dYcArA4576o0cauGSibWufaZCyDbK62A
	 cDGdiHRjtgQN+/i7OymGwaejhLx0SuAgznST44mfNlXQRBoNUfh/Yg169Vhu/SRQCZ
	 Ro47C1XhokCzA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 6/9] ata: libata: Rename ata_eh_read_sense_success_ncq_log()
Date: Fri,  6 Sep 2024 10:58:44 +0900
Message-ID: <20240906015847.229539-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906015847.229539-1-dlemoal@kernel.org>
References: <20240906015847.229539-1-dlemoal@kernel.org>
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

