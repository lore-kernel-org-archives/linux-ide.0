Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F72F3C37
	for <linux-ide@vger.kernel.org>; Thu, 19 Feb 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482507; cv=none; b=n42oo/tmK5aEIMJ/TphbDu3FsKbMr2DcjW5wI+D3kXpo0sH5XyudqLXKBaJYfpmH/1fhXYSN1BKh7O+MyIRX9uotWOWHbr/Rw2x6GUknIgEla7N0RjWe1qIimXCjhy/x/Z2Jk8wRKdXv9grQzj6RrxZlLBghZHSemYaT/K0vH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482507; c=relaxed/simple;
	bh=f8wWBUccu3jEQHtV1Ysifyz36R8Ez5+wCy0Z8BRc+xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn0SWmD1MS8yuOcwxucbH/5owC2IQObTb+YyiL3FKSHPfgAPIpa6RTchAj5DPEgE91Bpwqhj1o0SxAI+5HWHESGZlT7Ojn/SGQ69msLrFxUUpNhiV7mJFxELyXhVjv29Jy+gVlItZEefDIBW7CpjOQ/fED9iW5z1PIIX3O7GqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAq27e2F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAq27e2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CF9C19421;
	Thu, 19 Feb 2026 06:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771482507;
	bh=f8wWBUccu3jEQHtV1Ysifyz36R8Ez5+wCy0Z8BRc+xs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oAq27e2FG0Mq7a9sa6rLJTBox9Pk1Z17uPJrhgkavsVp4PVTmxcm3vhSaqRtYxcNj
	 EVmvkAhhy5bERAzWe0RiEBPetcGR9A6oU1+jjDt2B5jPFggFfcae2C1P/v1yEVcV1X
	 BYjpOFQY2gTXtwGU07wFYxNhW5q+WOcZz9+EK3vQIvj9OAfw7f18Wq+r8Ps5JsMRIH
	 KbkYtLpziIc2D6X/xLR2+3MyvZJmXX6UVd3P9D1HKYCU41vHXzUGwW/T5cy9QA+ZaD
	 Z1I73YO2onz5wcFzuoy3rcx5J7v4jubnxx9N3NhM1oxplRXMG/EZfel39hmuovCwA4
	 /SBE6fNrjQXog==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/5] ata: libata-core: improve tag checks in ata_qc_issue()
Date: Thu, 19 Feb 2026 15:23:08 +0900
Message-ID: <20260219062312.1030867-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219062312.1030867-1-dlemoal@kernel.org>
References: <20260219062312.1030867-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to check that the tag of a queued command is valid when
ata_qc_issue() is called, and fail the QC if the tag is not valid, or if
there is an on-going non-NCQ command already on the link.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beb6984b379a..0c42fb74eaf1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5146,8 +5146,13 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	u8 prot = qc->tf.protocol;
 
-	/* Make sure only one non-NCQ command is outstanding. */
-	WARN_ON_ONCE(ata_tag_valid(link->active_tag));
+	/*
+	 * Make sure we have a valid tag and that only one non-NCQ command is
+	 * outstanding.
+	 */
+	if (WARN_ON_ONCE(!ata_tag_valid(qc->tag)) ||
+	    WARN_ON_ONCE(ata_tag_valid(link->active_tag)))
+		goto sys_err;
 
 	if (ata_is_ncq(prot)) {
 		WARN_ON_ONCE(link->sactive & (1 << qc->hw_tag));
-- 
2.53.0

