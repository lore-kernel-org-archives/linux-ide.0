Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A237EFEF;
	Tue,  3 Mar 2026 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578397; cv=none; b=JhRS5xF3I53HP8PEWtmo57BGEdGoWegtLY3m0jHjpimyz0su3fLzp8KyiAELhtooS0jKrExC76KaIrPlemxca2mJsdZjNZQ+br+esAAHG2GlHjeOXZIYdnVelBMr5ogf2aswiojpFlxEAkm0GFCWP645LaD2e3wwkw96yDYj/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578397; c=relaxed/simple;
	bh=3p7A34l8bAj8LHKh231p15RoRohiKcEy6UUuiIyVVw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jt1Vrun15r5RhvjQt0xU0ImWFTqpjxd8L+K2ZpmXr/ceKeqemiW9QRgFfLc927+ivrwamGK2PWFxGdZYId6rXdDqA+t1pLTDAVESBLy56C1E8RXdWUJplEIxQ5L3CZDdsR1NzSXvLoiwauMn0YU6DtBcB4GPaPU5YaRFS6KjPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D54durp6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D54durp6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB79CC116C6;
	Tue,  3 Mar 2026 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772578397;
	bh=3p7A34l8bAj8LHKh231p15RoRohiKcEy6UUuiIyVVw0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=D54durp64JzwzCT3xgSPE4NjVPj6mPNxicfESb9tFlzm+UipYHWpYFWi86NxsN6rM
	 qPRwIycU/htGqqsyWVUyZrwxV9odhWZyIMj3jKRcEbw/5svVwx9aSlpBcQqEVq6LNj
	 NdWR4/AmqrufUeuErkXyXUfyi9+xsuvbvpo9Jlnzj7NtmUYTWiub7yphsnIp9BoalO
	 R6Pd4S4X6WjEKjPbAK8SbIDuThsCcPYVVJGlSen24I3a9EUQPi4Y/5zuObv7485xjM
	 CWLb42Wp//NH23DlzxX85ow9VIOaw3PwfSThIgfELA5J+ft4rLnZ8YMAgU71VNiSOl
	 8KpNh4f6gS76g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77CEEDEBF7;
	Tue,  3 Mar 2026 22:53:16 +0000 (UTC)
From: Maximilian Pezzullo via B4 Relay <devnull+maximilianpezzullo.gmail.com@kernel.org>
Date: Tue, 03 Mar 2026 23:52:18 +0100
Subject: [PATCH] ata: libata-core: Disable LPM on ST1000DM010-2EP102
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-v1-1-40d5db367f67@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQrCMBAFf6Xs2YWXREvxV8RD0qy6kCYlKSKU/
 rvR0zCXmZ2aVJVG12GnKm9tWnIXcxpofvn8FNbYnSzsCAfHfvOcNPwwlyoctfmQhNO6cMncNgM
 gLjBgK6uB5YAwXUZMAnem3l2rPPTzf97ux/EFVFUXiYMAAAA=
X-Change-ID: 20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-b0b85608e034
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>, 
 Copilot <223556219+Copilot@users.noreply.github.com>, 
 Maximilian Pezzullo <maximilianpezzullo@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772578395; l=1306;
 i=maximilianpezzullo@gmail.com; s=20260303; h=from:subject:message-id;
 bh=neTp5ojoaCXWgRDr8G6XNKyq5Sb8kE/WuOHE9oCy1T8=;
 b=YYfgDgi2pZ7QrUybv9YQHXOVhAvFLhRa6EXTya1w0RFX3IlSKLpngNlU2GdhbXNm9K5toZS/d
 tIhxfYTYBRIBba8sJP4Hk5TiV0JcDrfTloCZekqulwguuA38kK6a6HY
X-Developer-Key: i=maximilianpezzullo@gmail.com; a=ed25519;
 pk=TRTR4c2Vb1IfluQvv5OUDPg7EE+pIzdPBND85UU559w=
X-Endpoint-Received: by B4 Relay for maximilianpezzullo@gmail.com/20260303
 with auth_id=658
X-Original-From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reply-To: maximilianpezzullo@gmail.com

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

According to a user report, the ST1000DM010-2EP102 has problems with LPM,
causing random system freezes since kernel 6.15. The drive belongs to the
same BarraCuda family as the ST2000DM008-2FR102 which has the same issue.

Reported-by: Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221163
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ccbf320524da..76b012f544ea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4189,6 +4189,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_FIRMWARE_WARN },
 
 	/* Seagate disks with LPM issues */
+	{ "ST1000DM010-2EP102",	NULL,		ATA_QUIRK_NOLPM },
 	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
 
 	/* drives which fail FPDMA_AA activation (some may freeze afterwards)

---
base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
change-id: 20260303-ata-libata-core-disable-lpm-on-st1000dm010-2ep102-b0b85608e034

Best regards,
-- 
Maximilian Pezzullo <maximilianpezzullo@gmail.com>


