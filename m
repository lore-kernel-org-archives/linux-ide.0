Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAC185923
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461737; cv=none; b=Q4N+3althD8JR6JZBaXkE0JSJPS+g1yhACDSDeeg4eXlumqLNWx+6UY71K/xPNPsbWFrnQJfoUznQ5FAPiCYG3qdQVYdnWc4WmCobDS0u2f2vIpc+nz26jIjZQIP0zXXZUbhfkXGN/tXe1clRPnszrONm+bgr5c2AwS9sBUsl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461737; c=relaxed/simple;
	bh=E2RPDLmnOBTuLyS21VQEOnGS5iuo6pwvNrvkQN1uSm8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Sm9k8F/baTWNJdHa4yOXgg3Blo23nDydYmWWFObSWYbbaom7l6oDwE3JDh8FOlYPHp+qKSOX2Y3S71+JcrE1n+6XAlXGcP/HnMkLIqnaw6OxS9r62FtF2d32Z0Qr2OzC19utDyh8C4kxZdRFGBW4aGYUJdetqCTN2/hffjng4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC6aR/1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC6aR/1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E306C4CEC5;
	Wed,  9 Oct 2024 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728461736;
	bh=E2RPDLmnOBTuLyS21VQEOnGS5iuo6pwvNrvkQN1uSm8=;
	h=From:To:Subject:Date:From;
	b=oC6aR/1LAsuhwv2NH4ghxsNqQos0aoKDudBpQbja5KsWTyADSuByKjYO2fvgNZ8tH
	 NwJgG1ELN+VDZ0KM+vb+/9duoFQhDCLcbBwEAtqT9fR4fNY6OHnrH474H6bEWAKyrn
	 z94ELRhFGRSF4403weyNwZ7Nj4xmdk1FlksS4/viDp+v1Q/drqcsQNKebZ3ApITsVu
	 ye77eqClaja6TIl+kST8ADd9PBrBLt/KyAWWzjO8eqbszP1dHoJezOMARpu2D406/R
	 2zgBSGwJq/Ki08/gZ8UKILyQEaScOcZJ/8tZq9WBq4haCjtrltnXq9spqkzOTF5Gcm
	 SxyCr69cOoRQQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata: Remove unused macro definitions
Date: Wed,  9 Oct 2024 17:15:35 +0900
Message-ID: <20241009081535.376994-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ATA_TMOUT_BOOT and ATA_TMOUT_BOOT_QUICK are not used anywhere. Delete
these definitions.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/libata.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b4a6ff03235..c1a85d46eba6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -270,9 +270,7 @@ enum {
 
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 
-	/* various lengths of time */
-	ATA_TMOUT_BOOT		= 30000,	/* heuristic */
-	ATA_TMOUT_BOOT_QUICK	=  7000,	/* heuristic */
+	/* Various lengths of time */
 	ATA_TMOUT_INTERNAL_QUICK = 5000,
 	ATA_TMOUT_MAX_PARK	= 30000,
 
-- 
2.46.2

