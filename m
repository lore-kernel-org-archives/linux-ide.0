Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739301;
	b=VbrDpxWGrTqYYAwxJP5zpUp+g+mByrLnKs0RdObpFK1WE75wx5sfC2zTJBgeconHJJRc
	 0ZIRo6w3CqHiQE/O7vtCCLbW/8mj2ETC+PKCNZrFslBAD5oJSv2MYxEjKoDoFyNKRijOG
	 6DKa8abl9B0SJRw8my8VYKynJfQIkTmrlBeVUIVgvkGUfZLxtLWJOx7dwd+cG+C61lkl9
	 DgonJLlDx5jwPJTBlEzByVK1leuF96cfR6WpZzCtG1LARY9bzR4QXnr2lP7g6dGl4Uoyi
	 unr4tuSJJxCFpCKOyL1U/D/B3KGB/oUlfUeLf2T23nXa0pF8zTFFrh0uqTO9AwKdk8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739301;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=GfOkWzfGmTRya3OiV8nldPiNTaZivTUEnEaaSprXjlM=;
	b=uxGomaZbega8Z4pjcqNDRDgU7KxC3FU2cWDLbF52SWJcMnbmxYLahsc+Q/I+pDGh1IXN
	 xXJgWs5iWbNInoMX8PR1oHq+FjOVfg0nPml/r+lOVwxPao2pgYtnPPRmGIqs5c9QZTSUT
	 wCu6I0mFAImxp0f4I+wccIIsdlssYEKKx6RcTPI2zeFa+VFBt5T7rkyfxYGN3BrsYFyP6
	 3nYB4tmfh2ZuRB6v+Tdn8xx4QEr7I4Mlh/w50e+dA4zyoMEu71y4JQxtENpusCIzhGu3D
	 67dIanhe1/kw6Ot8fuxt7uWBjngMKs0rZUHh2nzWBJ1Vo/MVecYN74mbq4eNLQmRnJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvN001FN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FE606A324
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JvN001FN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C7A1F0093A;
	Tue,  3 Nov 2026 20:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739301;
	bh=GfOkWzfGmTRya3OiV8nldPiNTaZivTUEnEaaSprXjlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JvN001FN5jjGcSbEje+b1djy+L+cFVn1VcWCrK1/gwytLpI5hMR9f8W+d+OnTziWz
	 vlqhNYi6Kn03U/GKX1lELx6l2y0uQY0bwX4QfgbyZrf6cdgs6NTEWWfV7vo6vzDrst
	 XTvWPESDYWbwrDRB7A+B0u0lQugTeiA5wRk2wxdWZblXX0Jr7fTkq00YIA876mp6+2
	 4BcBHwCDZDFdkwJqLgSzoRB8tViRXnetbPIuDsJ9W3nwB07iizBu2tEzIVLHH4BDyh
	 3yUwExfE64eqFkzUv1DAlB1CmRhlAyX884M536yBRmfnG14rfpFhYtgXRSHV3kNXeu
	 KRIpEcaVRkv3A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Shao Mingyin <shao.mingyin@zte.com.cn>,
	Hannes Reinecke <hare@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/8] ata: libata-scsi: fix MODE SELECT handling of data after the mode page
Date: Tue,  3 Nov 2026 21:54:50 +0100
Message-ID: <20261103205448.931471-11-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=cassel@kernel.org; h=from:subject; bh=ORVo8jnOgLxn5nXb+nGfll2eubwPzoxOWoh4cDYCdAM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJeeckozXx9zOFg9vUdVh+icuM+q4R2vufIVTlZtd6Ha zpPWOupjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkoQ/Db1Z144LU89n6bPJ/ j6eEHqi98rCw/nbFPAXTaIMtWwMWnWdkWHzaeMX/DzMOO0evD0u5bLC37vxMg52FG1d+4oo4d62 FjQMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_scsi_mode_select_xlat() only supports one mode page per MODE SELECT
command, and rejects a parameter list with data after the mode page with
INVALID FIELD IN PARAMETER LIST. However:

- It does not set the field pointer, so the sense data reports 0xffff as
  the FIELD POINTER.

- It only checks for data after the mode page after the mode page
  handler has been called. ata_mselect_control_ata_feature() has then
  already updated the CDL enabled flag of the device, even though the
  command is rejected and the CDL setting of the device is not changed.

- For the control mode page, ata_mselect_control_spg0() does not need an
  ATA command, so the check is skipped, and the data after the mode page
  is silently ignored.

Check for data after the mode page before calling the mode page
handlers, and set the FIELD POINTER to the first byte after the mode
page, i.e. to the first byte of the next mode page.

The reason why only one mode page per command is supported is that a
MODE SELECT command is translated into at most one ATA command, so
update the comment accordingly.

Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb0331279..7081caa8eb93 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4670,6 +4670,17 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 	if (pg_len > len)
 		goto invalid_param_len;
 
+	/*
+	 * A MODE SELECT command is translated into at most one ATA command, so
+	 * only one mode page per command is supported. Reject any data after
+	 * the mode page before calling the mode page handlers, which may
+	 * already update the device flags.
+	 */
+	if (len > pg_len) {
+		fp = p - buffer + pg_len;
+		goto invalid_param;
+	}
+
 	switch (pg) {
 	case CACHE_MPAGE:
 		if (ata_mselect_caching(qc, p, pg_len, &fp) < 0) {
@@ -4692,13 +4703,6 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 		goto invalid_param;
 	}
 
-	/*
-	 * Only one page has changeable data, so we only support setting one
-	 * page at a time.
-	 */
-	if (len > pg_len)
-		goto invalid_param;
-
 	return 0;
 
  invalid_fld:
-- 
2.56.0

