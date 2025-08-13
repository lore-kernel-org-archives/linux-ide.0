Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5962C17A8
	for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077390; cv=none; b=fBwe/VXKLqJ8Cie+MQssGP6p9tk2l4SPe6bDFK9xVMbJcUoPrkrst971VQAcRIdJKeJ4bXOOKi9DOCd/BN12a3qFJNGHPx0G4oOEMZBh/roKLch7Mzgf/I9jXNET1FDIs0lAahDjG8yFgJsmzkf0n8FRUVxRfNos4Jp2ljSeNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077390; c=relaxed/simple;
	bh=GQmMj/NUeeMyuZDx845+GTatXWRQU6PO/7BXbSzpiaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zbnu8Pn1u1MpjVX7qPbYYXBnSWOXacbwGjYQT4oJTmpUJ6CYGm92aSdp+llgCslRXg6NyAYG0m8JDKNx+FAfMb0aC2dCm5bY+n5wpFGHCDF2sYqOsvajm7B6d3wK5KKIs53sNxQd8aTij6pMmEy59yJsWkLS9GylhPwY6HqbKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+mv+o3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+mv+o3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D3EC4CEEB;
	Wed, 13 Aug 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755077389;
	bh=GQmMj/NUeeMyuZDx845+GTatXWRQU6PO/7BXbSzpiaU=;
	h=From:To:Cc:Subject:Date:From;
	b=L+mv+o3/gfstJp+ztTzmiG0zwh8dXSR8tw1m9l9Mc9bOxKs/trEMGe4TJltreDT+j
	 cRIBl1N1dJy4K4Or1jh5JJg8ITJejV9iZ/196sRF1IZJdSG6gf4a6WwRKwFdAZrh/5
	 h37XLALfjcevYmemXa+QVJvx6NLwvZdbM7726/XmJ24dwU5K8LtdVIjVPHECp4PJH4
	 nBzy/TSluPsapZW3SAfMWusPH0uShZNnPFQBo66wqgHY6aCleAtsZ6wm//GGEAWTg9
	 zpn4ie1vFoFWuvCKHE+cn83pjcZG/AZ+ShUpkKEyo3T0XgVAqTWetblc9tYPVQNkEA
	 mviVeIoNmZinw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] ata: libata-eh: Fix link state check for IDE/PATA ports
Date: Wed, 13 Aug 2025 18:27:07 +0900
Message-ID: <20250813092707.447479-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when
revalidating devices") replaced the call to ata_phys_link_offline() in
ata_eh_revalidate_and_attach() with the new function
ata_eh_link_established() which relaxes the checks on a device link
state to account for low power mode transitions. However, this changed
assumed that the device port has a valid scr_read method to obstain the
SSTATUS register for the port. This is not always the case, especially
with older IDE/PATA adapters (e.g. as emulated with qemu). For such
adapter, ata_eh_link_established() will always return false, causing
ata_eh_revalidate_and_attach() to go into its error path and ultimately
to the device being disabled.

Avoid this by restoring the previous behavior, which is to assume that
the link is online if reading the port SSTATUS register fails.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 4371fe1ba400 ("ata: libata-eh: Avoid unnecessary resets when revalidating devices")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2946ae6d4b2c..354d2c0abcf3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2089,8 +2089,13 @@ static bool ata_eh_link_established(struct ata_link *link)
 	u32 sstatus;
 	u8 det, ipm;
 
+	/*
+	 * For old IDE/PATA adapters that do not have a valid scr_read method,
+	 * or if reading the SSTATUS register fails, assume that the device is
+	 * present. Device probe will determine if that is really the case.
+	 */
 	if (sata_scr_read(link, SCR_STATUS, &sstatus))
-		return false;
+		return true;
 
 	det = sstatus & 0x0f;
 	ipm = (sstatus >> 8) & 0x0f;
-- 
2.50.1

