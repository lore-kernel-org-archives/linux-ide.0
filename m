Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69619993F
	for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098793; cv=none; b=Bed05dssq6IlYM9ZhF9/8F34gJXWW/gJVmDQilBd22iqA1Q1URUS3sA5D4kqNpgxRoLbw9qdwLVHzcWkNe2+MVV6PidWS8j4KLEtWvPM5yUb3HI7dt1hTFL2v/KFVtm+OWXccdtXiW3Y5OWTbTP9A3qZtA/Z6vcvefFx0dPiAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098793; c=relaxed/simple;
	bh=5/PcrQht1j/rJfFd24+gjjNe0q3/Ba5jCby/KmIAACs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsoXE69WvNoys2rDABk+4hbyQZP3nd7eRoigTxUQllrGk3+CtMmUNL65k5NlfMRT4v+CZRIUdU1mxwDgREO77gG7c6Tb91gm2hbs7VsaJNviGORU2PgaNsW6vsCc4dkEUrppPv5LXy/EsFgy+aHfB3SiHK/T75U6BqN9rGGHslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5bm8D24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5bm8D24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47DFC4CECE;
	Mon, 23 Sep 2024 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727098793;
	bh=5/PcrQht1j/rJfFd24+gjjNe0q3/Ba5jCby/KmIAACs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s5bm8D24tlhTyiBlMdTs+2USSuQFFDTq1nAAAZFI8Rc8fTIfpcMPcQp7dRZ5C1MkQ
	 4g4BLj7JZtIlmCI4++1Fx8O9SKtrYy377d+4B8wv/Dpk28mCvFfcQ0KakT4r0zKoLC
	 KAOdVhIycUOpeI1RQOpkDsMwmE1+y/zMHvhF5ugFXusIMDhB+2AraQWoGHWHXFRhSK
	 8gQBXpgsCXmhB4/Ueay1v3O13KGSfYDdl2DEVECL58nt8193O5pWj2As7HnxF0++kK
	 KjROHeAP0MNp2CDEl8LXwkxFZBbhXxlnqEphQBgREVUHu0X6gCealRyINHizjgzaXU
	 4oENcMIA5B2Uw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] ata: libata-scsi: Fix ata_msense_control_spgt2()
Date: Mon, 23 Sep 2024 22:39:48 +0900
Message-ID: <20240923133949.286295-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923133949.286295-1-dlemoal@kernel.org>
References: <20240923133949.286295-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_msense_control_spgt2() can be called even for devices that do not
support CDL when the user requests the ALL_SUB_MPAGES mode sense page,
but for such device, this will cause a NULL pointer dereference as
dev->cdl is NULL. Similarly, we should not return any data if
ata_msense_control_spgt2() is called when the user requested the
CDL_T2A_SUB_MPAGE or CDL_T2B_SUB_MPAGE pages for a device that does not
support CDL.

Avoid this potential NULL pointer dereference by checking if the device
support CDL on entry to ata_msense_control_spgt2() and return 0 if it
does not support CDL.

Reported-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
Tested-by: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
Fixes: 602bcf212637 ("ata: libata: Improve CDL resource management")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 061fe63497bf..97c84b0ec472 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2245,10 +2245,15 @@ static inline u16 ata_xlat_cdl_limit(u8 *buf)
 static unsigned int ata_msense_control_spgt2(struct ata_device *dev, u8 *buf,
 					     u8 spg)
 {
-	u8 *b, *cdl = dev->cdl->desc_log_buf, *desc;
+	u8 *b, *cdl, *desc;
 	u32 policy;
 	int i;
 
+	if (!(dev->flags & ATA_DFLAG_CDL) || !dev->cdl)
+		return 0;
+
+	cdl = dev->cdl->desc_log_buf;
+
 	/*
 	 * Fill the subpage. The first four bytes of the T2A/T2B mode pages
 	 * are a header. The PAGE LENGTH field is the size of the page
-- 
2.46.0

