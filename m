Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69913D76;
	Sat, 20 Jun 2026 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781924043; cv=none; b=BcjB4CfBqKJrHgzgr9GUwCYe9GkTu46IYF9+O/WI1t627h7lzX1ZCoPNl3qK3N6t3qPGfhIaMK2Mw7lFT6fRnv96NaEoCLwcOfBSxYJZ1Fq2rJ+o2KYe3+oHnjJACMCtMwZZxmyjg7QSu2JT9xWTzDL7LS4JjLwGvnih6eHt6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781924043; c=relaxed/simple;
	bh=2451CF90z1Hce72jO8OSYBN1DWeWgaRN76jWcamXYHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iRUScPlL2ENGmsmQbdRrZMhnZXL+CdEmwaDvVAxfiNbkLSD4JMqs1ghDICGt6ihfL39223q/40zurQvSFt9Yyu1s83WaHUtLh6l+TwYm/Oa3su5Tn3/oYFkITAb/oBrKvTaT8Qab+Mw/wLKxJ5sMUn81jLswjKf4b7bYWaRrN+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h41gqUXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h41gqUXz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61C4FC2BCB4;
	Sat, 20 Jun 2026 02:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781924043;
	bh=2451CF90z1Hce72jO8OSYBN1DWeWgaRN76jWcamXYHg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=h41gqUXzZIUMd8eiYAitKgfUlZqbkZyVxn9jOEGW0J97YDd6Uv1eCAvat1YT4ZK3d
	 mxjx2R1PfeSXxxqg+izEFxxWuuWBBn6t/ELvTsILmbvo7SDQYxQYBK35yo/+Xapm6/
	 ZEzciiFAhfzvve7EpcDIib4f5lWCJyjeeS8RtCbR5CbsB3y1C39LO8cmxElaZfDX43
	 g3D930CHIDvBbHNHG3bVZQ2/Ac0rU0gS7Y4CeqltAnp9jb4iASrC1PsKtiWb/lMjRA
	 SiabiUtxn0a8WHw/am5MDB/GH3rqBa7wxIZpK2XLUoYfpZhinbZfNVZvWwJ4X8G7na
	 hazXn7EDmK3kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A947CDB46B;
	Sat, 20 Jun 2026 02:54:03 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 19 Jun 2026 21:54:02 -0500
Subject: [PATCH] ata: libata-core: Add NOLPM quirk for PNY CS900 1TB SSD
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-disp-494070d2-v1-1-0c6d7be96237@proton.me>
X-B4-Tracking: v=1; b=H4sIAMkANmoC/x3MTQqAIBBA4avErBvwD8OuEi1Sp5qNhUIE4t2Tl
 t/ivQqFMlOBeaiQ6eHCV+qQ4wDh3NJByLEblFBWWOnQG4xcbjTOiElEhUFarbXTfnI79OzOtPP
 7L5e1tQ9WBapHYgAAAA==
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781924041; l=2401;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=o1g9RWfDLgEq+zCaJ+RXbfq0Fdywflc/XcToyx0FVEA=;
 b=O/QEYP1k1iBnVvN85QIAIDEqJ5yBp1INLpi6jrpT7DLnpTBIjw3nE50uGZ+h5DeS0L1lhp/UI
 SpOmufUipDqATVbLVk4ViPZwh6loAAOHbYPaCRZIys0dUyciaF7rZYh
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

The PNY CS900 1TB SSD (Phison PS3111-S11, DRAM-less) drops off the bus
after entering Device-Initiated Slumber during idle. With the default
med_power_with_dipm policy the link goes down (SStatus 1 SControl 300)
and does not recover, forcing the filesystem read-only. Forcing
max_performance keeps the link stable across prolonged idle.

Add a NOLPM quirk so link power management is disabled for this drive
specifically, leaving it intact for other devices on the host.

Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Tested on an Intel Alder Lake AHCI host. With the default
med_power_with_dipm the link drops after prolonged idle (SStatus 1
SControl 300); writes then fail and the filesystem is remounted
read-only, e.g.:

  sd 0:0:0:0: [sda] tag#22 CDB: Write(10) 2a 00 74 38 55 68 00 00 28 00
  EXT4-fs warning (device sda1): ext4_end_bio:368: I/O error 10 writing
    to inode 52429136 (starting block 243731117)
  ata1: EH complete
  ata1.00: detaching (SCSI 0:0:0:0)
  Buffer I/O error on device sda1, logical block 243730861
  sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result:
    hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

Forcing max_performance (which this quirk applies per-device) keeps the
link stable across overnight idle. Drive: model "PNY CS900 1TB SSD", firmware
CS900702. The Phison PS3111-S11 controller is shared across the CS900
line, so other capacities/firmwares may need the same; scoped here to
the unit tested.
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3d0027ec33c2..e1d05d4c13ba 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4280,6 +4280,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 	/* Apacer models with LPM issues */
 	{ "Apacer AS340*",		NULL,	ATA_QUIRK_NOLPM },
 
+	/* PNY CS900 (Phison PS3111-S11, DRAM-less) drops the link on DIPM */
+	{ "PNY CS900 1TB SSD",		NULL,	ATA_QUIRK_NOLPM },
+
 	/* Silicon Motion models with LPM issues */
 	{ "MD619HXCLDE3TC",		"TCVAID", ATA_QUIRK_NOLPM },
 	{ "MD619GXCLDE3TC",		"TCV35D", ATA_QUIRK_NOLPM },

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260619-b4-disp-494070d2-c1633393b79f

Best regards,
-- 
bryamzxz <hexlabsecurity@proton.me>


