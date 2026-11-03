Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739310;
	b=znT0eETul1yrn17SR2u2oOyymQ8EeTLnzdCAKG8K0lrYmeY3rca2eqZO3or1vUo97jo2
	 XXamHbxVtJ+UVvNihv+1VveEWxIfW/4NktF4xrHBZNNdN9Rv2bFp5IDlziUqsRfuqRX09
	 KcyFViDmKW/6g+pBfkqQpecIxSoj8hFDg7Hwy0/VapSv9RSyt6K5wAmJoyr5ts6QO4BFM
	 cCHPeQheZGJFK0/aWb6nQrPlkuqv+fKdCIY6zGHT/5ne/ix2HR+83rjVL0ooMKViwl6sm
	 uNl6ZLbmCUsKJOXYK9aUuJswg/gILfuMMfaLtVDprezLz+4rXTEl2QOZtbajgTne6zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=dr/aJNJAwsO0oM+RX3sCYt+5XsnEKi4JOGpWZauqS3A=;
	b=vtufZTcqoimXiFuXqawA7z35EeaOoIYS06WxmJM46UBNx8cw83lJDOxjxZYJ7ZRJ2juc
	 e0nkKFAUF/ky8jH1h4iSjuXlkIoO0OH31qES9V9CEoA0emqFCIXThlxGo//39SPkcSREH
	 ZZrYyHK2G2KEcOorzTCnZggeqM1GoBnnxnT2CeUSBg9xd14o1MwQON/7TKhHJmj4sNBQO
	 PboRBQhfWvG5gGjcbw/nv5MBbAHmsrN2qFogMQWOs3Je1l/jG9J6fbdgcP7Cg/W849H4N
	 vDDf/zuX2n4ucdF9RZY/L+5O9O8Bk8ZikCUTQE31TIJHPPEYzCkNbRAfCYy296hK35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOgBPqu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAC606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOgBPqu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1401F00919;
	Tue,  3 Nov 2026 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739309;
	bh=dr/aJNJAwsO0oM+RX3sCYt+5XsnEKi4JOGpWZauqS3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOgBPqu6+6LJunm5/BCWbxKtMce84Lk02oyvvtW4nS1fAkrDNCIZh6eK35sVg6Yvo
	 qL3xQkPYlIP988TLuvCy1Hn5lgkO+gqVBfk9HGJQNDBLsZubc1rcVnU/d+xwH16Yh7
	 s6fWLbfy9QcEn04nHsYaJDwW7dgQpeseGLouR7FKNbsHjefYZspTFq0s86OallMIeW
	 9p3hthDzwXP9H6bS+bp8kZZvv6yqILjAjWhxQ93unXUzk5LKe7SAm/tsjOiZsv5QXf
	 2jEtXNFQYFcic0CavbQHkqPxznSiwPB2MGBFFekR1Nu28jjaLuuD05LB76wjFUcwU4
	 yKPfjLMXLooow==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6/8] ata: libata-scsi: pass the whole mode page to the MODE SELECT handlers
Date: Tue,  3 Nov 2026 21:54:55 +0100
Message-ID: <20261103205448.931471-16-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103205448.931471-10-cassel@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9820; i=cassel@kernel.org; h=from:subject; bh=MRFbPhm0c/ulrla+2oOdNXk+8zMrBNxsKziWm3SnVjY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeecnOmDhRVX6zH3ey4JGfN8sSr560rf/CKTRF29TL5 oq9lkVPRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZSvIiR4Z1H75ydT15+m55x 82+PEJ9WV07mzsO7T25/ojjL6tq0ruOMDO82lPw98JqzOviZet6hPVWSrUK1pQpPmO8vmc97Yoq ZBxMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_mode_select_xlat() strips the mode page header before calling
the mode page handlers, which report the position of an invalid field
as an offset relative to the mode page data. It then converts this
offset into an offset in the parameter list by adding the length of the
mode parameter header and of the block descriptors, but not the length
of the mode page header. As a result, the FIELD POINTER of the INVALID
FIELD IN PARAMETER LIST sense data points 2 bytes (page_0 format) or 4
bytes (sub_page format) before the byte that is actually invalid. For
example, changing byte 3 of the caching mode page in a MODE SELECT(10)
parameter list without block descriptors reports byte 9 instead of
byte 11.

Pass the whole mode page, starting with its mode page header, to the
handlers instead, like the ata_msense_*() functions, which generate the
whole mode page. Offsets in buf are then the byte numbers of the mode
page, as used in the mode page definitions of SPC, SBC and SAT, the
handlers can compare buf with the mode page generated by the matching
ata_msense_*() function without adjusting offsets, and the conversion
done by ata_scsi_mode_select_xlat() becomes correct. This also allows
reporting an invalid PAGE LENGTH at the PAGE LENGTH field, which was not
part of buf before. As ata_scsi_mode_select_xlat() rejects SUBPAGE CODE
FFh and mode pages with a wrong SPF bit, each handler only gets its mode
page in a single format, so the mode page header length is known.

Document what buf, len and fp are, and the return values, in kernel-doc
comments for all the handlers.

Fixes: 7780081c1f04 ("libata-scsi: Set information sense field for invalid parameter")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 133 +++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 51 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4b8454335aef..3257bbbba5b6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4366,14 +4366,22 @@ static unsigned int ata_scsi_zbc_out_xlat(struct ata_queued_cmd *qc)
 /**
  *	ata_mselect_caching - Simulate MODE SELECT for caching info page
  *	@qc: Storage for translated ATA taskfile
- *	@buf: input buffer
- *	@len: number of valid bytes in the input buffer
- *	@fp: out parameter for the failed field on error
+ *	@buf: Mode page, starting with the mode page header
+ *	@len: Length of the mode page, including the mode page header
+ *	@fp: Out parameter, offset in @buf of the first invalid byte on error
  *
  *	Prepare a taskfile to modify caching information for the device.
  *
+ *	The caller has stripped the mode parameter header and the block
+ *	descriptors, so @buf points at the mode page header, like the buffer
+ *	filled by the ata_msense_*() functions, and offsets in @buf, including
+ *	the one returned in @fp, are the byte numbers of the mode page.
+ *
  *	LOCKING:
  *	None.
+ *
+ *	RETURNS:
+ *	0 if a taskfile was prepared, -EINVAL if the mode page is invalid.
  */
 static int ata_mselect_caching(struct ata_queued_cmd *qc,
 			       const u8 *buf, int len, u16 *fp)
@@ -4384,26 +4392,19 @@ static int ata_mselect_caching(struct ata_queued_cmd *qc,
 	u8 wce;
 	int i;
 
-	/*
-	 * The first two bytes of def_cache_mpage are a header, so offsets
-	 * in mpage are off by 2 compared to buf.  Same for len.
-	 */
-
-	if (len != CACHE_MPAGE_LEN - 2) {
-		*fp = min(len, CACHE_MPAGE_LEN - 2);
+	if (len != CACHE_MPAGE_LEN) {
+		*fp = 1;
 		return -EINVAL;
 	}
 
-	wce = buf[0] & (1 << 2);
+	wce = buf[2] & (1 << 2);
 
 	/*
 	 * Check that read-only bits are not modified.
 	 */
 	ata_msense_caching(dev->id, mpage, false);
-	for (i = 0; i < CACHE_MPAGE_LEN - 2; i++) {
-		if (i == 0)
-			continue;
-		if (mpage[i + 2] != buf[i]) {
+	for (i = 3; i < CACHE_MPAGE_LEN; i++) {
+		if (mpage[i] != buf[i]) {
 			*fp = i;
 			return -EINVAL;
 		}
@@ -4417,8 +4418,26 @@ static int ata_mselect_caching(struct ata_queued_cmd *qc,
 	return 0;
 }
 
-/*
- * Simulate MODE SELECT control mode page, sub-page 0.
+/**
+ *	ata_mselect_control_spg0 - Simulate MODE SELECT for control sub-page 0
+ *	@qc: Storage for translated ATA taskfile
+ *	@buf: Mode page, starting with the mode page header
+ *	@len: Length of the mode page, including the mode page header
+ *	@fp: Out parameter, offset in @buf of the first invalid byte on error
+ *
+ *	Simulate MODE SELECT control mode page, sub-page 0.
+ *
+ *	The caller has stripped the mode parameter header and the block
+ *	descriptors, so @buf points at the mode page header, like the buffer
+ *	filled by the ata_msense_*() functions, and offsets in @buf, including
+ *	the one returned in @fp, are the byte numbers of the mode page.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	0, as no ATA command needs to be sent, or -EINVAL if the mode page is
+ *	invalid.
  */
 static int ata_mselect_control_spg0(struct ata_queued_cmd *qc,
 				    const u8 *buf, int len, u16 *fp)
@@ -4428,26 +4447,19 @@ static int ata_mselect_control_spg0(struct ata_queued_cmd *qc,
 	u8 d_sense;
 	int i;
 
-	/*
-	 * The first two bytes of def_control_mpage are a header, so offsets
-	 * in mpage are off by 2 compared to buf.  Same for len.
-	 */
-
-	if (len != CONTROL_MPAGE_LEN - 2) {
-		*fp = min(len, CONTROL_MPAGE_LEN - 2);
+	if (len != CONTROL_MPAGE_LEN) {
+		*fp = 1;
 		return -EINVAL;
 	}
 
-	d_sense = buf[0] & (1 << 2);
+	d_sense = buf[2] & (1 << 2);
 
 	/*
 	 * Check that read-only bits are not modified.
 	 */
 	ata_msense_control_spg0(dev, mpage, false);
-	for (i = 0; i < CONTROL_MPAGE_LEN - 2; i++) {
-		if (i == 0)
-			continue;
-		if (mpage[2 + i] != buf[i]) {
+	for (i = 3; i < CONTROL_MPAGE_LEN; i++) {
+		if (mpage[i] != buf[i]) {
 			*fp = i;
 			return -EINVAL;
 		}
@@ -4459,9 +4471,27 @@ static int ata_mselect_control_spg0(struct ata_queued_cmd *qc,
 	return 0;
 }
 
-/*
- * Translate MODE SELECT control mode page, sub-page f2h (ATA feature mode
- * page) into a SET FEATURES command.
+/**
+ *	ata_mselect_control_ata_feature - Translate ATA Feature Control page
+ *	@qc: Storage for translated ATA taskfile
+ *	@buf: Mode page, starting with the mode page header
+ *	@len: Length of the mode page, including the mode page header
+ *	@fp: Out parameter, offset in @buf of the first invalid byte on error
+ *
+ *	Translate MODE SELECT control mode page, sub-page f2h (ATA feature mode
+ *	page) into a SET FEATURES command.
+ *
+ *	The caller has stripped the mode parameter header and the block
+ *	descriptors, so @buf points at the mode page header, like the buffer
+ *	filled by the ata_msense_*() functions, and offsets in @buf, including
+ *	the one returned in @fp, are the byte numbers of the mode page.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if a taskfile was prepared, -EINVAL if the mode page is invalid or if
+ *	CDL cannot be enabled.
  */
 static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 					   const u8 *buf, int len, u16 *fp)
@@ -4470,17 +4500,13 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 	struct ata_taskfile *tf = &qc->tf;
 	u8 cdl_action;
 
-	/*
-	 * The first four bytes of ATA Feature Control mode page are a header,
-	 * so offsets in mpage are off by 4 compared to buf.  Same for len.
-	 */
-	if (len != ATA_FEATURE_SUB_MPAGE_LEN - 4) {
-		*fp = min(len, ATA_FEATURE_SUB_MPAGE_LEN - 4);
+	if (len != ATA_FEATURE_SUB_MPAGE_LEN) {
+		*fp = 2;
 		return -EINVAL;
 	}
 
 	/* Check cdl_ctrl */
-	switch (buf[0] & 0x03) {
+	switch (buf[4] & 0x03) {
 	case 0:
 		/* Disable CDL */
 		ata_dev_dbg(dev, "Disabling CDL\n");
@@ -4502,7 +4528,7 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 		dev->flags |= ATA_DFLAG_CDL_ENABLED;
 		break;
 	default:
-		*fp = 0;
+		*fp = 4;
 		return -EINVAL;
 	}
 
@@ -4518,15 +4544,24 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 /**
  *	ata_mselect_control - Simulate MODE SELECT for control page
  *	@qc: Storage for translated ATA taskfile
- *	@spg: target sub-page of the control page
- *	@buf: input buffer
- *	@len: number of valid bytes in the input buffer
- *	@fp: out parameter for the failed field on error
+ *	@spg: Sub-page of the control page, 0 or ATA_FEATURE_SUB_MPAGE
+ *	@buf: Mode page, starting with the mode page header
+ *	@len: Length of the mode page, including the mode page header
+ *	@fp: Out parameter, offset in @buf of the first invalid byte on error
  *
- *	Prepare a taskfile to modify caching information for the device.
+ *	Call the handler of sub-page @spg of the control mode page.
+ *
+ *	The caller has stripped the mode parameter header and the block
+ *	descriptors, so @buf points at the mode page header, like the buffer
+ *	filled by the ata_msense_*() functions, and offsets in @buf, including
+ *	the one returned in @fp, are the byte numbers of the mode page.
  *
  *	LOCKING:
  *	None.
+ *
+ *	RETURNS:
+ *	0 if no ATA command needs to be sent, 1 if a taskfile was prepared,
+ *	-EINVAL if the mode page is invalid.
  */
 static int ata_mselect_control(struct ata_queued_cmd *qc, u8 spg,
 			       const u8 *buf, int len, u16 *fp)
@@ -4638,17 +4673,13 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 			goto invalid_param;
 		}
 
-		pg_len = get_unaligned_be16(&p[2]);
-		p += 4;
-		len -= 4;
+		pg_len = get_unaligned_be16(&p[2]) + 4;
 	} else {
 		if (len < 2)
 			goto invalid_param_len;
 
 		spg = 0;
-		pg_len = p[1];
-		p += 2;
-		len -= 2;
+		pg_len = p[1] + 2;
 	}
 
 	/*
-- 
2.56.0

