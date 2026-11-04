Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801522;
	b=2DwXZQfp1KkZ/nedBtUbS3WBb0f+OEf4IjKCCmgqAZyRASnJP092oqF4wTOqRCh7UinH
	 OMFZUhnxdBdzJ0cjk0DIBvQijsL2xC/s0orF+mlxxFROZ7DrL8Ifhe0CdIvZltavi1XL3
	 39Xu5xB5GwGoEmeAKfVEAnJBQ0u2xto6D4EpEoZ5ab7mbGl/ZL4jWQks/1KAh+5gWbNph
	 WwMOUvdCqbCHM44bABWEJgYgts+UY/8pFUALSezDanrkms3tRbyQzATbm9A84Anrh0VCc
	 67zeb3fz2eR4Vb07iPcECu9XVXx9OvtDqlbexfXWTjl8SaYSQEAta9UVe+sdf0b3pJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801522;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=74b4nHIZAeQuqtuQ72Ye91l6Q/AeJy4o4XPQ9n+gcBg=;
	b=gMxNvD4oBLoUWS+LylzADJKyFzyHDh7u9kbYcn9+DgbBo6GB+2pPiOKcUs4pGXsjRBpT
	 A4byhh7dcznt1gYViUROKJnpX/wmuxmH2v7vVoGDV3fNFeh+PRB1dxMj3/JFNT6ET0nD0
	 eZHa1Nfdv7XCVqRHy7yzgZHGuDltk/vyoJfS/mRRxYK3BDQOtpRNCOc7UK8YS0iR/Q0VL
	 wnMz6SZoNgiqTDaEOILTW8PiC+e03ExeQJyd+US1vZUpyRXHoQmfUqosUiIKI58Qa+z69
	 CTiJd6W9ALY36xKr1MK0Lxwh+O2uBNKWHH2VNi+tH27aLs/Rts4YXbxLFF03GSG62aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BDA606A32D;
	Wed,  4 Nov 2026 14:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00BDA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKS741mRbz4yjjB;
	Wed, 04 Nov 2026 22:12:00 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A4EBpAp033807;
	Wed, 4 Nov 2026 22:11:51 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 22:11:54 +0800 (CST)
X-Zmail-TransId: 2afc6aeb3d2a41b-2d30d
X-Mailer: Zmail v1.0
Message-ID: <202611042211545962bhKeo8yjWPGFgya4g6LG@zte.com.cn>
In-Reply-To: <20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn>
References: 20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn
Date: Wed, 4 Nov 2026 22:11:54 +0800 (CST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gYXRhOiBsaWJhdGEtc2NzaTogZ2VuZXJhdGUgU0FUIHNlbnNlIGRhdGEgZm9yIEFUQSBQQVNTLVRIUk9VR0goMzIp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4EBpAp033807
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 22:12:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB3D30.000/4jKS741mRbz4yjjB

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_scsi_qc_complete() detects ATA pass-through commands by the ATA_12
and ATA_16 opcodes only.  ATA PASS-THROUGH (32) uses the variable
length CDB opcode 7Fh with service action ATA_32, so for those commands
the function takes the ordinary completion path: the CK_COND bit is
never honored and the ATA Status Return sense descriptor is never
built.  A successful command with CK_COND set is reported as GOOD
instead of CHECK CONDITION, and a failed command gets the generic ATA
sense data without the ATA register values.

The byte that carries T_LENGTH and CK_COND is byte 2 for 12- and
16-byte CDBs, but byte 11 for a 32-byte CDB, whose byte 2 is part of the
variable length CDB header.  Detect ATA PASS-THROUGH (32) through its
service action and read CK_COND from the correct byte.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with an ATA disk
(ata_piix, /dev/sda); no special hardware is needed.

A 32-byte ATA PASS-THROUGH(32) READ SECTORS CDB with CK_COND set in
cdb[11] and a 512-byte data-in buffer is sent with SG_IO.  The same
CDB with CK_COND clear is the control and completes GOOD on both.

  unpatched                            patched
  status 0x00, no sense data           status 0x02 (CHECK CONDITION)
                                       sk 0x01, asc/ascq 0x00/0x1d
                                       ATA descriptor 0x09 present
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb0331279..97adeecc7736 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1888,9 +1888,12 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
+	u16 cdb_offset = cdb[0] == VARIABLE_LENGTH_CMD ? 9 : 0;
 	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
-	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
-	bool is_ck_cond_request = cdb[2] & 0x20;
+	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12 ||
+		(cdb[0] == VARIABLE_LENGTH_CMD &&
+		 get_unaligned_be16(&cdb[8]) == ATA_32);
+	bool is_ck_cond_request = cdb[2 + cdb_offset] & 0x20;
 	bool is_error = qc->err_mask != 0;
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
@@ -3389,6 +3392,6 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	tf->protocol = ata_scsi_map_proto(cdb[1 + cdb_offset]);
 	if (tf->protocol == ATA_PROT_UNKNOWN) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
