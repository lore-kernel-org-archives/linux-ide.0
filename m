Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8153612C5
	for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561606; cv=none; b=ZWW4kl7TimY0KNNvbYNaekDTn5zJcUbD2dJ3+HmgXAcamjrF6osrPjeEdrahp+omT8HJgJCTzOBnLqqVR4+xrQ+eysPYiJAG+sVSEgagHCvKgdmxE35Uacn90NYNrEayN2uxx1ZW97QmBBpDn/TaAmIMsUZjKwWDvifhpklLLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561606; c=relaxed/simple;
	bh=874YjIc+TIqEHp80Tfj0LPpnChxebuv1n/hOnQHGoRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyjkr9ly0t4zKzKspaugxsHYfujRHLxMR/oz/+Y1lwactFmZad0ffD16c8GSB6cdz3kJfmTV0yiCJeIooZvcUjkIdKX/dUPqWFGeav+JBnim8iBOYHEucw52MxG+qT3rSSFaqSGrCUDrrueQD/GZQVhRBDEg3XRjJ6ZY6l+FxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLaNteUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLaNteUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F09C19423;
	Wed, 19 Nov 2025 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763561605;
	bh=874YjIc+TIqEHp80Tfj0LPpnChxebuv1n/hOnQHGoRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLaNteUFc43w7Xilc+oGRAeuIZn0cIm1ZZDoCh8q0Feyz9nuDj3UeBcL7Ybc37v1P
	 89lRLhHP8Tdu0KZsM7UKP4zzQhm7gqQuU66DEIoFJRcfq3t3+2o8w8WforRLHGjRSX
	 jzSWtcbkF1lkcoPtctQpRgEteQOXaQkPuZ6YTOEPpn4HqaVa+Lri+80uYDhLVz3+z2
	 hIn5Csc7HXFS7LL7vYCchXPmCevMkYu6xlUmJd8MJppD28Ph0dwB+nMbHPh+UvhTXc
	 GEo9c4VahVBO9qjnr0wMQDUAjusXtIJbQX1GUHeaTFn2qjIoOMNLOJm/4TkWgAsxPR
	 aK03uQ3S4avxg==
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Ilia Baryshnikov <qwelias@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ata: libata-core: Set capacity to zero for a security locked drive
Date: Wed, 19 Nov 2025 15:13:15 +0100
Message-ID: <20251119141313.2220084-4-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119141313.2220084-3-cassel@kernel.org>
References: <20251119141313.2220084-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=cassel@kernel.org; h=from:subject; bh=874YjIc+TIqEHp80Tfj0LPpnChxebuv1n/hOnQHGoRk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJlL1SZdew/my3DolMjf0hV8sD1c5eCQ93cWPL2HXvG7 x3vfS23o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPxiGX4K9prvXlubmBHjzGb cfXXFh1HGd7Huh4Nr6WmfzkTYmb8ieE32zYJ83VLmk6JTA4K+GjUzJfKb+OyZE/aPeutDsv1Gtb wAgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

For Security locked drives (drives that have Security enabled, and have
not been Security unlocked by boot firmware), the automatic partition
scanning will result in the user being spammed with errors such as:

  ata5.00: failed command: READ DMA
  ata5.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 7 dma 4096 in
           res 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
  ata5.00: status: { DRDY ERR }
  ata5.00: error: { ABRT }
  sd 4:0:0:0: [sda] tag#7 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
  sd 4:0:0:0: [sda] tag#7 Sense Key : Aborted Command [current]
  sd 4:0:0:0: [sda] tag#7 Add. Sense: No additional sense information

during boot, because most commands except for IDENTIFY will be aborted by
a Security locked drive.

For a Security locked drive, set capacity to zero, so that no automatic
partition scanning will happen.

If the user later unlocks the drive using e.g. hdparm, the close() by the
user space application should trigger a revalidation of the drive.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2a210719c4ce..f48fb63d7e85 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3006,6 +3006,16 @@ int ata_dev_configure(struct ata_device *dev)
 		}
 
 		dev->n_sectors = ata_id_n_sectors(id);
+		if (ata_id_is_locked(id)) {
+			/*
+			 * If Security locked, set capacity to zero to prevent
+			 * any I/O, e.g. partition scanning, as any I/O to a
+			 * locked drive will result in user visible errors.
+			 */
+			ata_dev_info(dev,
+				"Security locked, setting capacity to zero\n");
+			dev->n_sectors = 0;
+		}
 
 		/* get current R/W Multiple count setting */
 		if ((dev->id[47] >> 8) == 0x80 && (dev->id[59] & 0x100)) {
-- 
2.51.1

