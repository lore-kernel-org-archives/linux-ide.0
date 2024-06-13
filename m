Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258E1304BF
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300039; cv=none; b=legypMlSJVODZZiEReoiFuzAPkJ76owGIbH/qD25ed5qhgONnl73oh623vaHBBmSVhIyEwDPlqbaH+8CR9ocaKQaHvKnhkhbqS0o9uS1AThLldE5K/6I09xIsIkrX3gNE/f9Sm2J+N/7yyhLOeoxFDnM5YpL5jkv7Hqsi8MuVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300039; c=relaxed/simple;
	bh=1sbzEv1w4Ws1MHKFPvlsXSJmB6057Jy63pNpPYo5j5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P8SiisiQG0hs1FTu2tVol9K7Gbxcn9vZmzNigiYVgAGhPKo2Eb7f3OZhRUV2EJCa9QH+28MFD3wSg4K8KiaB0/0YIH+dlZjZvT2gP8Zr47jZBTyRCZ87I5qGyPjr63pjUsT/VZCV8tlg0ZNPnhJS2N9yw4OFFouD1TJGbH/Lktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFhjl87S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFhjl87S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94351C2BBFC;
	Thu, 13 Jun 2024 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300039;
	bh=1sbzEv1w4Ws1MHKFPvlsXSJmB6057Jy63pNpPYo5j5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ZFhjl87S76GYiEQhRtB3BAAjnHE3VCWIMKWoT1A01TDQm3xFTwEq0VLg01rDy/6Fj
	 wE8NSYmb1lCa4dktMD+OofTAjdFLvmfhZAc9wppAbMWONaNRjlik2NSHKr5SVUQPCr
	 Zejf/QhVz77Au1/zriic91ne9uHzoUgsAlIr4VCJoZ8zgVabRYKnbHxHPisggfMqaH
	 LiZAX2yzZg5xQkaxGl6wv9OoFdhEqF9J5rYBKunjWN5+3NArTRNSXsOJl7MN5uCVeE
	 9+OUyJaxo4vKk0LkN4c+7UthzA+DF5Sg7o28OfmJDuVJOnOwNA1nHu2aVtSR9G5TSX
	 sM27D/dE/pMog==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-scsi: Set the RMB bit only for removable media devices
Date: Thu, 13 Jun 2024 19:33:53 +0200
Message-ID: <20240613173352.1557847-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3787; i=cassel@kernel.org; h=from:subject; bh=QZfozG2xTrcn4COiSgyTDMrxN6nb/g8CuBwNot3xFYc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNKydRvKYjyc77Jzb2DuK+0J5z8oUf1Ddv7CQ9tTSh1S7 T22VDzsKGVhEONikBVTZPH94bK/uNt9ynHFOzYwc1iZQIYwcHEKwES2hjAyLK9m/OnB2DEhsL16 6TsZt9leqw+3qW6ud33ccGtDA8+7VYwMLQX8pydFSV9otQsuuJYrP+PL/8uHNnPeE6pabhE42f4 sBwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

The SCSI Removable Media Bit (RMB) should only be set for removable media,
where the device stays and the media changes, e.g. CD-ROM or floppy.

The ATA removable media device bit is currently only defined in the CFA
(CFast) specification, to indicate that the device can have its media
removed (while the device stays).

Commit 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as
removable") introduced a change to set the RMB bit if the port has either
the eSATA bit or the hot-plug capable bit set. The reasoning was that the
author wanted his eSATA ports to get treated like a USB stick.

This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
Expectations" which has since been integrated to SPC, which states that:

"""
Reports have been received that some USB Memory Stick device servers set
the removable medium (RMB) bit to one. The rub comes when the medium is
actually removed, because... The device server is removed concurrently
with the medium removal. If there is no device server, then there is no
device server that is waiting to have removable medium inserted.

Sufficient numbers of SCSI analysts see such a device:
- not as a device that supports removable medium;
but
- as a removable, hot pluggable device.
"""

The definition of the RMB bit in the SPC specification has since been
clarified to match this.

Thus, a USB stick should not have the RMB bit set (and neither shall an
eSATA nor a hot-plug capable port).

Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
external/removable") then changed so that the RMB bit is only set for the
eSATA bit (and not for the hot-plug capable bit), because of a lot of bug
reports of SATA devices were being automounted by udisks. However,
treating eSATA and hot-plug capable ports differently is not correct.

From the AHCI 1.3.1 spec:
Hot Plug Capable Port (HPCP): When set to '1', indicates that this port's
signal and power connectors are externally accessible via a joint signal
and power connector for blindmate device hot plug.

So a hot-plug capable port is an external port, just like commit
45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
claims.

In order to not violate the SPC specification, modify the SCSI INQUIRY
data to only set the RMB bit if the ATA device can have its media removed.

This fixes a reported problem where GNOME/udisks was automounting devices
connected to hot-plug capable ports.

Fixes: 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
Tested-by: Thomas Weißschuh <linux@weissschuh.net>
Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Closes: https://lore.kernel.org/linux-ide/c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de/
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
[cassel: wrote commit message]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cdf29b178ddc..e231ad22f88a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		2
 	};
 
-	/* set scsi removable (RMB) bit per ata bit, or if the
-	 * AHCI port says it's external (Hotplug-capable, eSATA).
+	/*
+	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
+	 * device bit (which is only defined in the CFA specification) is set.
 	 */
-	if (ata_id_removable(args->id) ||
-	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
+	if (ata_id_removable(args->id))
 		hdr[1] |= (1 << 7);
 
 	if (args->dev->class == ATA_DEV_ZAC) {
-- 
2.45.2

