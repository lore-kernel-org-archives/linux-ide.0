Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F03F075E
	for <linux-ide@vger.kernel.org>; Tue, 20 Jan 2026 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905165; cv=none; b=Si/AOK9e+/nR4egZyoYUZJDi2gpA9E4sxbbOYu5qkRR0R8KQlSO4Nu37EYX7FNOJYX0Qg6yhjBwIpFJuLy1EZuFxSuM8dd7R/TsfXI+rGRY0vAUyqOi/gJ+u9NNvnH2muiXneB5dnZKwgUeAXwnBBOpjuecmEbikg14deyi7u3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905165; c=relaxed/simple;
	bh=6Ju0ZRxks4gPqJSbpas6/LFrmoPcwPF+qbmRwKo3Hcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pL5j3+1HzpXd/jQyYUdXkruLNKhf7mYqnfn6XYsd6jNjVixt3+MH7RNze6IOrhR3hjVZTEo57CT9D5jfP1Ly3JDqlRTn6p8mPbD4sFozHQ6Ly/5sQt8djlqq9Uj7FI8F/82WV6rqKV3/cd9tZLEX6OQdwFz9jF9cBFez79vHnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPddjSnd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPddjSnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF38C16AAE;
	Tue, 20 Jan 2026 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905164;
	bh=6Ju0ZRxks4gPqJSbpas6/LFrmoPcwPF+qbmRwKo3Hcc=;
	h=From:To:Cc:Subject:Date:From;
	b=sPddjSndv/uPktWt0nhIJhuYdSqz1so/PWXuYS6MJrerNW6maClcN3WmmY5G9KOqJ
	 /jJg2uId7FhcM7BcQE5tdAZqiyqIAO+IQ9X5U4tw1d/iTrI2apdSS87rMKdudzTEAj
	 LaDf/y6v5ZolUC8m0Cgb6y3smggPu8eEhumRzUiyyOcV0oZDrpDUqXy2JtGb7LGQkn
	 WwqkiG/aApyrFK7uxMWLzjUljLQXEXtY9ZWKrQQPu+ydYTxYit2RHkDjrhtcfEwUPy
	 0xmt11AnqpKbnd/Z8CfuRdON5bZ1rAK8dWa7hwCG9TEMn9wYaqUs/C4N0ryIzfpf/p
	 Jk7wSZGIxRJXQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Wolf <snow.wolf.29@proton.me>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-core: Quirk INTEL SSDSC2KG480G8 max_sectors
Date: Tue, 20 Jan 2026 11:32:38 +0100
Message-ID: <20260120103237.3922391-2-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=cassel@kernel.org; h=from:subject; bh=6Ju0ZRxks4gPqJSbpas6/LFrmoPcwPF+qbmRwKo3Hcc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLzI48yVRtpvzMSOjtZ5ObfDYL/r52a22TgfPSbi1+RD 7uA8rK8jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzklhTDX3HOg+ekDjhkvliv bXDKeU3M/7csSt5+S1c/vqr2qnHmza+MDAecd1wsMpjdvvDxwmZf+718OeWrzG0mdtmkf2prfpj wnh8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
the default max_sectors_kb from 1280 KiB to 4096 KiB.

INTEL SSDSC2KG480G8 with FW rev XCV10120 times out when sending I/Os of
size 4096 KiB.

Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
since any I/O with more sectors than that lead to I/O timeouts.

With this, the INTEL SSDSC2KG480G8 is usable again.

Link: https://lore.kernel.org/linux-ide/176839089913.2398366.61500945766820256@eldamar.lan/
Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Hello Wolf,

please test this patch and see if it works.

The patch is based on the for-next branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git

 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e888f2445692..8e41e8a33096 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4082,6 +4082,7 @@ static const struct ata_dev_quirk_value __ata_dev_max_sec_quirks[] = {
 	{ "LITEON CX1-JB*-HP",		NULL,		1024 },
 	{ "LITEON EP1-*",		NULL,		1024 },
 	{ "DELLBOSS VD",		"MV.R00-0",	8191 },
+	{ "INTEL SSDSC2KG480G8",	"XCV10120",	8191 },
 	{ },
 };
 
@@ -4336,6 +4337,8 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 
 	{ "Micron*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "Crucial*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
+	{ "INTEL SSDSC2KG480G8", "XCV10120",	ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_MAX_SEC },
 	{ "INTEL*SSD*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "SSD*INTEL*",			NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "Samsung*SSD*",		NULL,	ATA_QUIRK_ZERO_AFTER_TRIM },
-- 
2.52.0

