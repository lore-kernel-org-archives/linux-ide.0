Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862F27453
	for <linux-ide@vger.kernel.org>; Mon,  7 Jul 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886102; cv=none; b=JRMFIOfJwSBRGdm6ZU0m+fw4vM5uJAGjiojkW2zCe/725Scz6rMAFWL1AFPvZMfOV6lm4Hxnx4tfoqwN6EdW1uaqBBsgeLLOkpjeWikVnpz500XjVP0VbNsYfSrE0gBvuLQVMDU1LP0N3SYMdOqE1hfAW1AD6XLniN5Oo3WSN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886102; c=relaxed/simple;
	bh=TXl63IqT0lmlOiBhczZtvI/Jx/6HS+vx2wmfv/xxGf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8G8k4mfJGaUuITMiEOJzaS8Yk8pkV+iWy2TKqgwOCHAWTSJG0e4U/rzBoIrSW+PLU18MteodWacYk5UC5+80/IwBw3UhTQuhgF5+gHy3sXk63zBZaIqu57qrv7De+tw+dJPr25i3k/ZYl8s+TG/URGIiEUcPnY01GhdNznFiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbz4LYuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbz4LYuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A89DC4CEEF;
	Mon,  7 Jul 2025 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886102;
	bh=TXl63IqT0lmlOiBhczZtvI/Jx/6HS+vx2wmfv/xxGf0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Nbz4LYuYFoitfZjYAtFeonx/YGGrk3RUuAkF9DgnYN3PtwGlLXBeWnuUeGy6/Jri3
	 EAU2dKePkGamEMs16TohJYlMsCtWJd5ex4S2DBGc5X5vC6OC0b1PT7QBg78/BR217S
	 +T9iekCgw2XbxCO0PwPex8sSjBznFgMwrRmptR7gOO6XyT+MKKa/3TuPiRo5FHKDht
	 9VwNIWYnZnNVkM/cmQUoWceWrz/nLpHHXrGUSI+ei1Z8Pzw1MGsaVeJ3TXQUk7rsUV
	 ah05xcif1JplQsZtrhtLAcICWOPEWIHILndu/HWbHC5nwKWPS8ARkYZgL89D4FfKhX
	 kduUFlSRNG0Pw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/3] ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
Date: Mon,  7 Jul 2025 19:59:29 +0900
Message-ID: <20250707105931.548315-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707105931.548315-1-dlemoal@kernel.org>
References: <20250707105931.548315-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_eh_followup_srst_needed() returns an integer used as a boolean. So
change this function to return that type.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 42aafb1ddb5a..436536112043 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2781,15 +2781,15 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 	return reset(link, classes, deadline);
 }
 
-static int ata_eh_followup_srst_needed(struct ata_link *link, int rc)
+static bool ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 {
 	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
-		return 0;
+		return false;
 	if (rc == -EAGAIN)
-		return 1;
+		return true;
 	if (sata_pmp_supported(link->ap) && ata_is_host_link(link))
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 int ata_eh_reset(struct ata_link *link, int classify,
-- 
2.50.0

