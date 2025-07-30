Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21B1A26B
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835233; cv=none; b=nWiDOTfTYGI1oZR39mcJ450YLEyatH/nigex5lYo7dABq7ff8XWsX9yzL8c9JHyjIcGJ2fPRpLsD65XlDDxC0Zm7Q28XerjOPyn90yMKfSUhJ29MBN4i1WCrtHy/ZU+zZSDCVJZVnSDLsXBHM8HIfJNF16fJPWw2F8oszlzl/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835233; c=relaxed/simple;
	bh=KzhJZzWKKFSNWSPBq/1TSwGpHkiCjXBE43QnpohKbuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6ZnvXK+syGo2SfGM7DXUxPJd5Bfq8fcmfB/pQfAbNSYNZ8gdC3Is3rDKN2l9LRGyiJQNqa8lZEuElFcPrSD9AnwTlSW3LJk6oNVPCd7f2i0UeQyGL8jIttubl9MjMNp6Up3AXND/DB9NaOCuDMvt2JZEjKHVz4OHhQXYRrOMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su4k3Vgb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su4k3Vgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F49C4CEF5;
	Wed, 30 Jul 2025 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835233;
	bh=KzhJZzWKKFSNWSPBq/1TSwGpHkiCjXBE43QnpohKbuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=su4k3VgbvYgsIP39vElcnVusCrmwMfp/Dd4+C5GgT+0gfXXf19yST6YV3jQJ7PLe9
	 zEnmxcDf9SdF6oHCeikWOrfpwqWQ/XmrDBYdeTLklvmC3lS2Aq+XtLJRrFNh2PqnKv
	 +8b7s/1F9HxQsRQu7y7zwnacHjnB5Ww+4Htg6+nk/+zcRj8hI/monsR2MJZKrwvHVF
	 TF+h3XVaV8STRGyEui8GWQhdOJZK0W6giyYXvc24X4/29JrhYSpZ+cdMTzmLBCUGhc
	 F6VlirWSzrDsGOVj8SS2HL9BJ1iPR3HS/fz1cesYrFd5gEs0YzEsAS1AE+kmHugirl
	 I72C76yJacdSg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: [PATCH 1/2] ata: libata-scsi: Fix ata_to_sense_error() status handling
Date: Wed, 30 Jul 2025 09:24:40 +0900
Message-ID: <20250730002441.332816-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730002441.332816-1-dlemoal@kernel.org>
References: <20250730002441.332816-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
inadvertantly added the entry 0x40 (ATA_DRDY) to the stat_table array in
the function ata_to_sense_error(). This entry ties a failed qc which has
a status filed equal to ATA_DRDY to the sense key ILLEGAL REQUEST with
the additional sense code UNALIGNED WRITE COMMAND. This entry will be
used to generate a failed qc sense key and sense code when the qc is
missing sense data and there is no match for the qc error field in the
sense_table array of ata_to_sense_error().

As a result, for a failed qc for which we failed to get sense data (e.g.
read log 10h failed if qc is an NCQ command, or REQUEST SENSE EXT
command failed for the non-ncq case, the user very often end up seeing
the completely misleading "unaligned write command" error, even if qc
was not a write command. E.g.:

sd 0:0:0:0: [sda] tag#12 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
sd 0:0:0:0: [sda] tag#12 Sense Key : Illegal Request [current]
sd 0:0:0:0: [sda] tag#12 Add. Sense: Unaligned write command
sd 0:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0

Fix this by removing the ATA_DRDY entry from the stat_table array so
that we default to always returning ABORTED COMMAND without any
additional sense code, since we do not know any better. The entry 0x08
(ATA_DRQ) is also removed since signaling ABORTED COMMAND with a parity
error is also misleading (as a parity error would likely be signaled
through a bus error). So for this case, also default to returning
ABORTED COMMAND without any additional sense code. With this, the
previous example error case becomes:

sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
sd 0:0:0:0: [sda] tag#17 Sense Key : Aborted Command [current]
sd 0:0:0:0: [sda] tag#17 Add. Sense: No additional sense information
sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0

Together with these fixes, refactor stat_table to make it more readable
by putting the entries comments in front of the entries and using the
defined status bits macros instead of hardcoded values.

Reported-by: Lorenz Brun <lorenz@brun.one>
Reported-by: Brandon Schwartz <Brandon.Schwartz@wdc.com>
Fixes: 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 27b15176db56..9b16c0f553e0 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -859,18 +859,14 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static const unsigned char stat_table[][4] = {
-		/* Must be first because BUSY means no other bits valid */
-		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
-		// Busy, fake parity for now
-		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
-		// Device ready, unaligned write command
-		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
-		// Device fault, internal target failure
-		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
-		// Timed out in xfer, fake parity for now
-		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
-		// Recovered ECC error	  Medium error, recovered
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
+		/* Busy: must be first because BUSY means no other bits valid */
+		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
+		/* Device fault: INTERNAL TARGET FAILURE */
+		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
+		/* Corrected data error */
+		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
+
+		{ 0xFF, 0xFF, 0xFF, 0xFF }, /* END mark */
 	};
 
 	/*
-- 
2.50.1

