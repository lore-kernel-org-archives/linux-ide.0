Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CF1C69C
	for <linux-ide@vger.kernel.org>; Fri, 26 Jul 2024 03:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964000; cv=none; b=seXpDCC9ua0B9HBwIRiB2hqhCYXE9zjT4R1sGSYThNSg71N0lu4muwoHCEBHrYZ38fquOZakJkjTafO66DxTtmzmb8TRXTTw4AdghL0DpzjcJPrw+LmOO2cmJbCK7c9b/XK+f6rkpDakX7R1yBKb1xKnr/iuGDKZkNWbExsVSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964000; c=relaxed/simple;
	bh=6p/xyuixj70M/zNQINxCfV8lJa6VZ1S8DEL/oDl0zyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6yx4XwN7xXuP1z6LFZ0l5aaUl+cr/LvITzNLRT1Gufhd8e7wTZtUl9g8Jet7XC74DzGG/AgvKt197t/ivXK0mDz3k3IJyT40u3c27Yu/BuMlpE3ZHY/VK9onqhOAeL8ouM2BHBnYMc3lABlivRu+2q1D9zFbdLmgkwoWFRbjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1ASwkPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1ASwkPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC256C4AF0B;
	Fri, 26 Jul 2024 03:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721964000;
	bh=6p/xyuixj70M/zNQINxCfV8lJa6VZ1S8DEL/oDl0zyo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l1ASwkPOoBtMo0bHkWbtfavpV705yI5Z4BWXIyZlX9JXkvo4CJLHfgs52XHF6/Xyk
	 foE866W6NpsZlY6sHHwqJ0SVkFuoarEKSQk+h3ZQlDJHbCGbR0SF8tbjdHpBIlNFZ2
	 LK/kBC/ptGmGOdWOzD3zf3nJGvCybjIWG/DLVXjnkvQSHT4myY6Tqd1eRH3Ra2cm/7
	 6blZMt4T9UcAfuzn19pIWc7qyJJZ3AxU6FvtBMUtAXairUFT9VIFHZPlVB+adtUGtz
	 zm0ZiKCzo2NHGoPg9RE84Em+04MZSoC86qMLuDK2L1alpMTxEkp54KoV50QmSGT7Y5
	 Q2eh+Zr1Oh4yg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 06/11] ata: ahci: Rephrase comment to not use the term blacklist
Date: Fri, 26 Jul 2024 12:19:49 +0900
Message-ID: <20240726031954.566882-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726031954.566882-1-dlemoal@kernel.org>
References: <20240726031954.566882-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rephrase the comment for the eMachines entry in the sysids array of
ahci_broken_suspend() to not use the term blacklist.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a05c17249448..45f63b09828a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1370,7 +1370,7 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 		 * V1.03 is known to be broken.  V3.04 is known to
 		 * work.  Between, there are V1.06, V2.06 and V3.03
 		 * that we don't have much idea about.  For now,
-		 * blacklist anything older than V3.04.
+		 * assume that anything older than V3.04 is broken.
 		 *
 		 * http://bugzilla.kernel.org/show_bug.cgi?id=15104
 		 */
-- 
2.45.2

