Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695693019AA
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292175; cv=none; b=fTw5SgLpfSGckgJ1LRIFY6tf3011uCg5ygjaTyER+44UUm4z2wewxteMQgcyUWn6ABiDWrEHgiybcMM+YOxA/HvtOCeEIQZqrWKU05VgISApWOitxWZlfK8ovnGMFZuthR9YQI0bX1wCabcDbP18HAjFPLr98YTO3YWqY7UDnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292175; c=relaxed/simple;
	bh=DEBmBa1xEMKYbRRzjsceGpmGRtHw6BcWKO5TOWuaw5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xr1wYbcgnxquv9retZRxge/+wnmz4YmavwkRoEaf7wEaavOa+fPxAVeL0CdhO08KFO+B8eu4Lr06RKhrWZtjI/t8asNu9XReco72oux/iT+aYueONXlgJt1UbR6PkB9Vt9KInE+r3P/DpRsbu3KT37TZDRQf6QzZvd1PvLP0M/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USdumUOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USdumUOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A801F1F000E9;
	Wed, 24 Jun 2026 09:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782292174;
	bh=SVrUzzOKxujlvpf5JBLVu1DsqM5SReJqobfxx43Ji40=;
	h=From:To:Cc:Subject:Date;
	b=USdumUOFPWsVNj+P4hg9H8otSP8UKsiecVbaxEBDSikIP+NBjVYYgX1Y+OkICYSGN
	 pVtQ/8r000K1q78MaO9imL9ghTHG5v8QNUauQSj44rflgxAYOOOlyPuT3G87CVed4G
	 IqJhKjZ17q0UlKVyNEdkSO3mxSglYKxC2jq7eUjf/qKqZKhRq0MJQlm6sO2ZtcXk6V
	 Nyt34q/brB7eKgKI1qfviVILGjQ3GjPqoUrzFdoh1jiwf0ov0hW0q5QAMpHSIzBEJu
	 6vaJDSJZe0To43tUtAYXZ40LiSRegxOCtlntkUekLUdndlU0GiQ+AROrKHXVmY5yuR
	 iQW2fzGxt0iHA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat() buffer length conversion
Date: Wed, 24 Jun 2026 18:09:31 +0900
Message-ID: <20260624090931.1483644-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_scsi_security_inout_xlat() converts the SCSI command buffer length
into the ATA sector size based size by aligning upward the length to 512B.
That is incorrect as that can lead to specifying a buffer size that is
larger than the memory allocated for the command buffer, resulting in all
sorts of possible command failures and/or memory corruptions.

Ideally, we should bounce the buffer to a large enough size to fit
the entire SCSI command buffer, but we do not have anything in place to do
that cleanly. So for now, fix this by converting the command buffer length
downward with a simple division of the buffer length by ATA_SECT_SIZE.

Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-scsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d54ec1631e9a..e78801e7ea8c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4330,7 +4330,13 @@ static unsigned int ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
 		}
 
 		/* convert to the sector-based ATA addressing */
-		len = (len + 511) / 512;
+		if (len) {
+			len = len / ATA_SECT_SIZE;
+			if (!len) {
+				ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
+				return 1;
+			}
+		}
 	}
 
 	tf->protocol = dma ? ATA_PROT_DMA : ATA_PROT_PIO;
-- 
2.54.0

