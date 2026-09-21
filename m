Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D52F0C62
	for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961160; cv=none; b=XBgMvaLytpPXNLY93SLdSYvbSWSv2bv3msZunMVyhG23610rEWunpOMeHyeV2MAIaZyJGX9IfAWGGtd5YrPbLXkyGYMM2KIQZtvAqvvtZ/OGRiM8h8Oy5t6+rQe/pyjamg+bPeV3ZHLWmsf0BTmKzZnDvtU8YvZCbf7jrhzJ2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961160; c=relaxed/simple;
	bh=g+A9hiqbjdRm1wxc94/jFX4bCS9hLPFOLeL9XnppuiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=earnXROvEBg1XHAilOf6KRccUIY6HezwPMTiTuvVIBDDcxAGBPkD18tB13ME7L6gXQiwXkw6reqBq0EZ5T/WclTfBDx8UFyuKiMiSwnLYP1uZQ2wjbniX0XVT4H+nJ7SYmKsRoH8KCHNn/xTCNnZ/zNqwHUmxoeFedinESloV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6nx24SI; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6nx24SI"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1855011a91.0
        for <linux-ide@vger.kernel.org>; Sun, 20 Sep 2026 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961158; x=1790565958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahFIIwQaTlAjng+rA2gaDe9OuP97cH36xpLgGOlzKso=;
        b=U6nx24SIR7GarxQ2uXF/iDnqcW4ELWEfjlA0qUwrtqp91LHwJjMpxELtWhv+h8uvtx
         U7pMM3l36kDlJo4My18hwSdZ/+Wgku3or0ZRrSFtdRo9hWuybN+aaZC0n164Wo5yKE0n
         WF9TDtvGHNb37Lo3/hSLa4Pbw83FonqsExxZ0I3E8d98ANGS9+rJisLy/wWp42Tt6Kfa
         NvW2rUVd6MsThAHvba5d4Z8ZYJeAi+MS01CAFFuzIStLL33y91cMWb6hvYuBK71KJyVD
         ycQGs/sT/U+cxtAzHOBNFg9TElXx/dxSO1+ctNNiFEJKpilGjF5CMHA1FqMx8+3luyez
         dHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961158; x=1790565958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ahFIIwQaTlAjng+rA2gaDe9OuP97cH36xpLgGOlzKso=;
        b=V6nPQkz/C1LmNS2pMAAjPhuR2+0hBRW4gyc0xLnieBBp4UjWF2GRtR4CoMU9n0epfO
         rumg6IXxcDr9orVv4Vd5OpgYGrBYwyqVDYJMEPM+j1LtbFq5e5wp/o+4Gr4TiS8k3DJM
         AiascUYcni+6mvw5QixYNiXDsoTGD8SgAYXg255KNuhF+AmRC12/ZBTwaCKJrLmX1apT
         9yRpzRLTm7n3LsksYV0FlGsOkJXC5owrsAvFuVfWVhzOqQpsibQEkFHjRTeXCMk/bpbo
         ufmd7hIPyMXIVMbhEYWrE1lVbRNbraWCmFW1FS0lYvT+UJrmarEof+a5xbA5zbRYKFQM
         KWNg==
X-Gm-Message-State: AFuF++lijjvZo6ETqCFxObSJaABx0nyP2XprsydJq6d+ds4Snlxq59RX
	BmqEBNSZEZ/s9mVnZ1p0ltEq1F9tWG9Opc3vfSAk7zj4hlEfMsEiOuML
X-Gm-Gg: AYBFou2e4toVdr2vWbcxVF9jyshtNeZcZHHBXP+T64cvnZj8IYyuIbbWZLmVO7KQq4+
	MLjAiuQUgQFx33NSnEMu3Z3gnxgWZWIJx8B0Zdm/qwvjwgyNKrwrCzEOVXulecXM/r4hekWT+Yu
	WysevyFfOOzJYD0pTY2yz4o8JLYaxVBFsxOJmRByFwvn/Hf9ppbr05//chgW7l6bDoJVnJ5QG/y
	0x5pXY5CcwzZCtWIDyZCnLNZ/DH5ZWFfAFPR3eMtrWBWzvOV4OfJwhNwbZHMwzAGZ4caIDAWszu
	ASByotMfHW7lpqk6PBiktmeIovKckHahlSZXlnKgiMBEgSjuHpYzAYrGO5qkNnV7XoYQva90AdZ
	oXfDWpXfAL6sLP5dxsA5PZ36sBBH0AmnXKdY0ob8X6Q/H/mL3zUg8WB8M1Xt+bWO8OVPFVjRXV9
	qnCKzMcUfwy4PEMmD8zfsmS6x79pWSEVLWvJxuKUtWRXbIwWk06KeXcBQI+enBF3bHzPAumd1Pb
	PVT91SjcJud7jIhJdjeti9+kKcActzt4awuy7/Aysn6xohYxoic0oZnKCd774+xhEH/x7ASlH+8
	xrNtnRsezP8=
X-Received: by 2002:a17:90b:3bcb:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39e54eab3e6mr21858131a91.12.1789961158476;
        Sun, 20 Sep 2026 20:25:58 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5547a04dsm6298293a91.3.2026.09.20.20.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:25:58 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0
Date: Mon, 21 Sep 2026 03:25:55 +0000
Message-ID: <20260921032556.1160734-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
References: <20260919222625.3797581-1-benquike@gmail.com> <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ATA_12, ATA_16, or ATA_32 pass-through command with a
multi-sector PIO command opcode (ATA_CMD_READ_MULTI,
ATA_CMD_WRITE_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_WRITE_MULTI_EXT, or
ATA_CMD_WRITE_MULTI_FUA_EXT) is submitted via SG_IO on a device where
multiple-sector mode is not configured (dev->multi_count == 0),
ata_scsi_pass_thru() currently logs a warning and still dispatches the
taskfile. When the DRQ interrupt fires, ata_pio_sectors() triggers
WARN_ON_ONCE(qc->dev->multi_count == 0) and computes
nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size, 0) = 0, failing
to transfer any sectors:

  ata1.00: invalid multi_count 1 ignored
  WARNING: drivers/ata/libata-sff.c:666 at ata_pio_sectors+0x27d/0x300
  Call Trace:
   <IRQ>
   ata_sff_hsm_move+0x211/0x22e0
   __ata_sff_port_intr+0x1c8/0x520
   ata_bmdma_port_intr+0xa1/0x5b0
   ata_bmdma_interrupt+0x1f5/0x550

Per ACS-3 section 7.12.7.21, if IDENTIFY DEVICE word 59 bit 8 is cleared
to zero (multi_count == 0) and a READ MULTIPLE or WRITE MULTIPLE command
is received without a preceding successful SET MULTIPLE MODE command, the
device returns command aborted (ABRT). Per the SAT specification, an ABRT
error translates to the ABORTED COMMAND sense key with NO ADDITIONAL SENSE
INFORMATION (0x00, 0x00).

Fail multi-sector taskfile commands in ata_scsi_pass_thru() with
ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0) when
dev->multi_count == 0.

Tested in QEMU against Linux 7.3.0-rc3 (-device ide-cf, where
dev->multi_count is 0) by issuing ATA_CMD_SET_MULTI (nsect=1) followed
by an SG_IO ATA_16 ATA_CMD_READ_MULTI command: on the unfixed kernel
this triggers WARNING: drivers/ata/libata-sff.c:666 in
ata_pio_sectors(), whereas on the fixed kernel it immediately completes
with sense key ABORTED_COMMAND (0x0b, 0x00, 0x00) and 0 warnings.

Fixes: 1dce589c38c3 ("libata passthru: support PIO multi commands")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Report sense key ABORTED_COMMAND (0x00, 0x00) via ata_scsi_set_sense()
  per ACS-3 and SAT specifications instead of ILLEGAL_REQUEST /
  invalid_fld, as pointed out by Damien Le Moal.
- Update the commit description to accurately describe the
  ata_pio_sectors() WARN_ON_ONCE(qc->dev->multi_count == 0) and 0-sector
  transfer path and fix the Fixes: tag to 1dce589c38c3.

 drivers/ata/libata-scsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b3666519b648..29fd6d8d97ce 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3507,6 +3507,11 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	if (is_multi_taskfile(tf)) {
 		unsigned int multi_count = 1 << (cdb[1] >> 5);
 
+		if (!dev->multi_count) {
+			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0);
+			return 1;
+		}
+
 		/* compare the passed through multi_count
 		 * with the cached multi_count of libata
 		 */
-- 
2.49.0
