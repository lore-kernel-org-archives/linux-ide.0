Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801472;
	b=O5MtesnbfkGTZgsSqS2AvC1ldUh8hm6Zgc9ZIrHOYB8lNry6S8/sEGix1Uri+qsLsjgE
	 wZ6sKWAybettoruuNYyF4D/P0kF0n7eEE0aXTiivTCdVIY5PpFCTQjS21aDfY/O9yODpa
	 BU0C7acRf8o1Vf4MWiaBr4YTkkWBK8bAOOZLyCa9L0R7pSwdzQ3yIClsjBjF9n7IP1Lux
	 fQfEB+xL3EWcDgO0dbG6GTiXWOSIwSund5u0PUAABtU4KsPw/MS0twS+oTSpqU1qbO9Y1
	 khaoVm9RYpXw5pkrBlFfDGHkCgEWrUoJXJzSFvDvaNva5DY9HxDgj8yGONdv295I/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801472;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=5v/IeceO5lEoHHhAzzAauPQ1V+NlTtQgDK8PwjgXsvo=;
	b=QyLn1SAB7u5GoToyChgADlW2eMck8bkB7GBCPTx53gx9HXe4dm2MK2y4NOBXwF2X74dk
	 Oalq5PfhB8R6zu2hxuLHsBfgsLgmYNartj5FOdRQakdx+Fp8NlZV1IJdH9zKRGQBmkT3F
	 2shN+/kumvSffEYYkj63rnJqKEt9Z3yfRHEtxVwOtCNIGPaJ+zY4FK8fwk7zLKE6rAlFW
	 gEKeJzG+TlZ/4aoIoKt5OzPe1/XaOeLSvOQRC7gTJTIcBsmszOpFmuH2mwNlgkqFZq2/9
	 5XhjIO200v4+SKAS4OLmk5UYSPxKEfPnFXSYjm4g5puLdxENIRhLC8NXgzuQ3loKO3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEE606A31B;
	Wed,  4 Nov 2026 14:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BEE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKS650Q6Qz8Xrrd;
	Wed, 04 Nov 2026 22:11:09 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A4EAx4n033482;
	Wed, 4 Nov 2026 22:10:59 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 22:11:02 +0800 (CST)
X-Zmail-TransId: 2afa6aeb3cf6ea8-37d90
X-Mailer: Zmail v1.0
Message-ID: <20261104221102824qAKUWNkiSgZ1yRnQM8hI9@zte.com.cn>
In-Reply-To: <20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn>
References: 20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn
Date: Wed, 4 Nov 2026 22:11:02 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvM10gYXRhOiBsaWJhdGEtc2NzaTogcmVqZWN0IHVuc3VwcG9ydGVkIEFUQS0zMiBzZXJ2aWNlIGFjdGlvbnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4EAx4n033482
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 22:11:09 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB3CFD.000/4jKS650Q6Qz8Xrrd

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_scsi_var_len_cdb_xlat() handles a variable length CDB only when its
service action is ATA_32 (ATA PASS-THROUGH (32)).  For any other service
action it returns 1, which tells ata_scsi_translate() that the command
has been handled and that scmd->result and the sense buffer were set by
the translation function.

No sense data is set in that path, so ata_scsi_translate() frees the qc
and calls scsi_done() with scmd->result still zero.  The command thus
completes with SAM_STAT_GOOD even though no ATA command was issued and
no data was transferred.  Before ATA PASS-THROUGH (32) support was added,
such CDBs were not claimed by ata_get_xlat_func() and were rejected by
ata_scsi_simulate() with ILLEGAL REQUEST/INVALID COMMAND OPERATION CODE.

Fail unsupported service actions with ILLEGAL REQUEST/INVALID FIELD IN
CDB and point the field pointer at the SERVICE ACTION field.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with an ATA disk
(ata_piix, /dev/sda); no special hardware is needed.

A 32-byte VARIABLE_LENGTH_CMD CDB with service action 0x1234 (not
ATA_32) and a 512-byte data-in buffer is sent with SG_IO.  A valid
ATA PASS-THROUGH(32) READ SECTORS CDB is the control and is accepted
on both kernels.

  unpatched                            patched
  status 0x00 (SAM_STAT_GOOD)          status 0x02 (CHECK CONDITION)
                                       sk 0x05, asc 0x24
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb0331279..d29b54688b53 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -5027,7 +5027,13 @@ static unsigned int ata_scsi_var_len_cdb_xlat(struct ata_queued_cmd *qc)
 	if (sa == ATA_32)
 		return ata_scsi_pass_thru(qc);
 
-	/* unsupported service action */
+	/*
+	 * Unsupported service action.  Set the sense data explicitly, as
+	 * returning 1 without it makes ata_scsi_translate() complete the
+	 * command with the SCSI result still zero, that is, with
+	 * SAM_STAT_GOOD.
+	 */
+	ata_scsi_set_invalid_field(qc->dev, scmd, 8, 0xff);
 	return 1;
 }
