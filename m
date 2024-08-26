Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F813211C
	for <linux-ide@vger.kernel.org>; Mon, 26 Aug 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657469; cv=none; b=NWu5QgjQm5HzDtEt0eJu+sKEGP2O2Pv+Fi4tHgZXWGHSH0FyEBALjSlYpsbzQQVs/d6clIgufnobKoLbsVVDw6kTWkwhnad1RrfaaHZNGscci2isH42oPMc190lQ4kwkH1xN/jdkYGAFFubBqt0lzyx3CQ3D4P7divWgzkBaii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657469; c=relaxed/simple;
	bh=bknYmcwS216yV1xpvFAiecowwNzrfnRh2GOy7kO256s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Id9b/8qm2THqJdrVyNwOj0TeJWS2wusXrRepVxZdwPPI9gHObKK92XapxuqvyRkUE8jbDBrb8LeLOHqAFP/FEtBMH8g5hL0PXh8Wa5XQmXGgmqEXz6w7q4AIPGUJn69fyfDQAPv9wJCAlbrkvmAr3PKzgmnLf4zpGHg5tG7VsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfoPGmMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfoPGmMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E12C8CDC4;
	Mon, 26 Aug 2024 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724657468;
	bh=bknYmcwS216yV1xpvFAiecowwNzrfnRh2GOy7kO256s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NfoPGmMDVJaJ1GJJmw5VyR2XJszBJPeOGQSTx5yz19UTeqBg6FnNDB+bRcn77zI/8
	 szhhOq/pvoHiWqW3yGIcjqjHO14YKcnJoUYTNXICfIsini1fce7PQ/we0TnZEAW8KB
	 VcjtGeuzAMjI0YN0gaMQF6spNfyTIjrb2ZrnTExUXUGG05R05sv0NCuD8FQpn+Ca3Z
	 LxIfa+qWpEwE464st835UkcwXd7dgsqcfPqwGMaZXQXwr3TgrmWy1bCPvrc+5fmr1X
	 XCBBnPRV4PQ7bVNa2wVRB2k+vCzo441yLlsc+DKrX9kpjt8o+CkMMGVRfyDLbhaA8Y
	 IA5KGkaMu2bzA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/7] ata: libata: Fix ata_tdev_free() kdoc comment
Date: Mon, 26 Aug 2024 16:31:00 +0900
Message-ID: <20240826073106.56918-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826073106.56918-1-dlemoal@kernel.org>
References: <20240826073106.56918-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the kdoc comment of ata_tdev_free() to correctly describe that this
function operates on a ATA device and not on a link or PHY.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-transport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 48800cd0e75d..474816a9efa1 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -660,14 +660,14 @@ static int ata_tdev_match(struct attribute_container *cont,
 }
 
 /**
- * ata_tdev_free  --  free a ATA LINK
- * @dev:	ATA PHY to free
+ * ata_tdev_free  --  free a ATA device
+ * @dev:	ATA device to free
  *
- * Frees the specified ATA PHY.
+ * Free the specified ATA device.
  *
  * Note:
- *   This function must only be called on a PHY that has not
- *   successfully been added using ata_tdev_add().
+ *   This function must only be called on a device that has not successfully
+ *   been added using ata_tdev_add().
  */
 static void ata_tdev_free(struct ata_device *dev)
 {
-- 
2.46.0

