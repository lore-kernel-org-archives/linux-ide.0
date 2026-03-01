Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3B13B58A;
	Sun,  1 Mar 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328976; cv=none; b=ezLoxdaRSxvMAxDNYWYyQwUBipth9plrMEkFON5v1/xctWYrbSwzc37c+qx0f38hKSc+mFWG6MoIBXlTuYMkvcdH+Ylj2C29wMhFsQo+hTVb9OCGs3/K1PoXngvsGwy8JRhq5qSubthnnuOO09LmZyJcaCTDjhVzwytiIBYWE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328976; c=relaxed/simple;
	bh=QtjNuD//9YELcVnrZEJeLGQvrXeQIUP9U0k2jUI711Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vs0oVY4xZS9jOokYYTZQMCIMZgAGmTtslqklccaKVQGwZf4UBwhibCS9An7EqcpJkfRdwQYxphKAMXta2b9ITGV6UhpW6jJkgGOjvNDYNbpi2ov/fnS/Pa9ll3ECVGvm6RkbEODaem6RY4JcAW2FWUf36K++oj8FeQ8QYLDgzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWyD63Z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWyD63Z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B7C19421;
	Sun,  1 Mar 2026 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328976;
	bh=QtjNuD//9YELcVnrZEJeLGQvrXeQIUP9U0k2jUI711Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WWyD63Z9rgt9ejx7u8kYA8fXQscVvwuSrn/5H2cFqYl4JrbljHPbYRrETu+hjYGfI
	 QIvXj/ZywMDlMR3dE+BnhNGDXXXpa6hqhad5L6bV9N/POzuMCLbECRSyuc1KeXhBGK
	 HkqtXsOtLRuHDGwWduFLnNZ1YxbMlgw9L+Sjj3mRg96u1Wg+9YUVqJlAcChYUCLZK0
	 A5CBgaYijiX1wkzr87WETFcYhvpu6FjIoMgsdKUQJUkV2SupB+mCCG9DujEFlLBHBi
	 mMMPMFJ4cceojUFU26aGh385ZfBJpaC255MvpEP1zR3Znsv0/klOZFYACae6ZjYPZt
	 QAay989b1bqDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linusw@kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: FAILED: Patch "ata: pata_ftide010: Fix some DMA timings" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:14 -0500
Message-ID: <20260301013614.1696150-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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




