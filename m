Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B072FE59C;
	Sun,  1 Mar 2026 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330596; cv=none; b=snaKn8USBCd7evgtkgbZF1X3dbUmvYMs4DZ481N8+22aJy0m0jaMWBWoxq4Obmk41jobtGGa8TsC9c8z1DF5a2iCP1JPwsJMTi53gJlQgY7qVaEvJ3XLtBsGymc5+V6bFzStNeDviUZh1GuGg5PSVCKOcTj/kZL9t+wsoOz2fhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330596; c=relaxed/simple;
	bh=xSWocl13mDkzbwYJz1ZYzkxtb2izMYc2XXRI67jfqmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ec62oVqiYhO1T2N5JzV5cMLhqE0O8Mj0I1UVxTZpMauhra6a4iP+vCvM4wMuO9euuubHEYqnoVE/c2+NDwMqJZ70Q3336NbP6FgWlKIBcJXV5Hc0+mlTiAt5jNXYEYO9XVH9nxEFvIRanc8PMTmbar5b0E9VfdUQttn/beRuPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+w7LVGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+w7LVGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2785C19421;
	Sun,  1 Mar 2026 02:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330596;
	bh=xSWocl13mDkzbwYJz1ZYzkxtb2izMYc2XXRI67jfqmE=;
	h=From:To:Cc:Subject:Date:From;
	b=q+w7LVGtsioqwNjy1LDxnODfmBxuUmX0Xy4WvIewWg9djGXKp1MXM1w76O6nfKUrW
	 iSWWSJx6wf+Tk5lG4qrpqMXSM5JzuPtX+q1gxn3RLmF6hm6JKoBlBbovv7ZcYJ6D+o
	 mE9PUA71sJgryLTwKnuswRZks1t/DccvquikRHREu8CsSvX5OWwxakloS9xJ2yNntA
	 RrsF7MUPhr6C3wfvO0b/Ka77ALoEXd8I8Uw/hxgrgOU2UNOlgS2FZ2mAxphTFAo2V1
	 eB1+Pwr+wWREyhAuUtyZ1DMUoXKQPX3A3hkZgV3Nf+K6oBoJhUZgRwm+0BoEdF2Yf5
	 9whYGHOicKoLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linusw@kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: FAILED: Patch "ata: pata_ftide010: Fix some DMA timings" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:14 -0500
Message-ID: <20260301020314.1731258-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ff4a46c278ac6a4b3f39be1492a4568b6dcc6105 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 11:23:01 +0100
Subject: [PATCH] ata: pata_ftide010: Fix some DMA timings

The FTIDE010 has been missing some timing settings since its
inception, since the upstream OpenWrt patch was missing these.

The community has since come up with the appropriate timings.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/pata_ftide010.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index c3a8384c3e04d..c41da296eb389 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -122,10 +122,10 @@ static const u8 mwdma_50_active_time[3] = {6, 2, 2};
 static const u8 mwdma_50_recovery_time[3] = {6, 2, 1};
 static const u8 mwdma_66_active_time[3] = {8, 3, 3};
 static const u8 mwdma_66_recovery_time[3] = {8, 2, 1};
-static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 1};
+static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 9};
 static const u8 udma_50_hold_time[6] = {3, 1, 1, 1, 1, 1};
-static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, };
-static const u8 udma_66_hold_time[7] = {};
+static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, 1, 9, 9};
+static const u8 udma_66_hold_time[7] = {4, 2, 1, 1, 1, 1, 1};
 
 /*
  * We set 66 MHz for all MWDMA modes
-- 
2.51.0




