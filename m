Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59939B48D
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989343; cv=none; b=J+ogUrpklKsu2cmx/PBj1ZzwiKpUcrZnNGt1HmF5YJBqRhnLm0Va67/03Ceh943LRwnsTPhH5RfOsvcxFF2SUHl6PLF9jCIHiTxld4NMAyQz0zy6xf5wnYygQOafyOjxNxqZxicFz0AVvLsPvJI373ZRSAaSoxk6sWz+mIt18SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989343; c=relaxed/simple;
	bh=3wa5qPxDuiKyQaHlluLKewdehZo7T25XYU4QSDMhbV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snO7Xkfia1g4VeB/yvG/AagyG8KXOtVddvMeQh5VF1OsT9m9+6NFf8OEsWQnQhU+E61OU7r9N3tOiqUw+1ZCvFoutBeQ6K+vwUcQfXpkd5E2LprN4ec0qRK2PwKbEAsD1ND/Q0DGjrq3UKu8ol7SgLI4SLEIPTKMEiitzk0QO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4JXBC7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4JXBC7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E9E1F00A3A;
	Thu, 28 May 2026 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779989342;
	bh=4z21hysIuE/IKnXztmRBaW+pyNx0zSsrlaqhcGOIVP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E4JXBC7fst0DZVZSWmU5/qT0SVswRwHj8Y5i7IVrJiLWjOFPCtgbjP5YwdWoCLGAJ
	 zfzpB9slHRkj3Qy1FBjvpp0q41hrwVADu55Icr01cZWhae9czuySLQzoyx8QKVdpFU
	 0itK3m2BFb8gm7AJoJRCB17OCUGq644RAflFkWMCKxFfsltm6kVdeP6uMSgh4h1+Sx
	 1avJVaRwTeFe4hZppcQAQ6mfEMHPqwgGVSKWngaq/dOBQbUK8MsFFmfzUkj5/8AKNX
	 QBUp53i1oOLOptrrdsa1xphXQ3xC2/JUSElu3JXisJzj76XPqK8DlKUHpVYSEWNhRo
	 EEV3BsrT2OMcQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in ata_scsi_translate()
Date: Thu, 28 May 2026 19:28:57 +0200
Message-ID: <20260528172855.703631-6-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528172855.703631-5-cassel@kernel.org>
References: <20260528172855.703631-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=cassel@kernel.org; h=from:subject; bh=3wa5qPxDuiKyQaHlluLKewdehZo7T25XYU4QSDMhbV8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIkqsMPaE50FH/fdpqZT6lfbX2n9IZGSQ+ZRfN+z1wzT e5RZTdvRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZyqZ7hF3Nnc+Cx2PSoT3FR Ryb+fK96NvzWjY+K9lsMfqxcu0x+vxMjw/Vv+9N8ZlWWN6vd/sZQ42gaEO+nsP7khpbgw8UHLy1 j5AAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

lockdep_assert_held() indirectly calls __assume_ctx_lock(), which will
suppress any real context analysis from being performed.

Remove the lockdep_assert_held(). This will be replaced with context
analysis in a follow-up commit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6733f2b14521..8bfd3ffd8b89 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1852,8 +1852,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 	struct ata_port *ap = dev->link->ap;
 	struct ata_queued_cmd *qc;
 
-	lockdep_assert_held(ap->lock);
-
 	/*
 	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
 	 * have nothing further to do when allocating a qc fails.
-- 
2.54.0

