Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801406;
	b=Tw46G8AppSWxSxmIS3I8rGTykYaeLa9taC+ZZWB+0LB3uUzUN6xyDxTdLT8bxFNVbhwj
	 kaskZqyQpurX8dKuTumhTf+eWT7qTfZu/Vy2dC0LatY5zYApwvm8ogvn+t7rv1iOgWGV3
	 WnDxvlE8D0FGGwgLoBCI21rTSxr7Pzwai1m/0jITuNilg8VBlNrc0SydvM7pmTD+fCZuh
	 Hsbkk6iac0hk2JB6vhlH6b+rGViut0zHGc3KsmlQDqkSwf+QP7wYd0eTFP1Z8DJnAvnSL
	 7bISWVXHmJZ1fa0h4vQqq1a3ng8H3HZdVlpzbRakkLbXF++6sBoCDxkJAu+L/b1ng0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801406;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=b2CCWMjvgZNz5FP+7DNpzCei+hZeiZgmRKq9Ltb4IxM=;
	b=NHdgY/ZTwFFuIyIqpA77/psljCFg5FSPY8Ia7GNLATgurcKwDQnk8GA64ugIiPjpgzAs
	 5ZHst8KclHMULSOuBoFQV4lo3h32Bkre9+Igl5iZFcI0dWc2dpV7lhg3is5T9MF+l8Wrr
	 g3NBhoVac+Jc7AoJznRnP9HDHlBXFRsnyaVMrY7HTYR+nHeBCrvjGsSooBlOPiWYfYbuJ
	 TPMlfFc9iNcLgv4h5JSdruv8nIpKeUS9rLGaoNsoPDmEk/W64YDv1XFf5PldUhB9ixS+8
	 KgvnAyE50s6cC1lod2yYweIr/NpHutQnSS6Z8z61Mds7geuQYAaDKoueB1fcwrDMaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EE606A332;
	Wed,  4 Nov 2026 14:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1EE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKS4j6qJGz4yjjY;
	Wed, 04 Nov 2026 22:09:57 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A4E9aCA075538;
	Wed, 4 Nov 2026 22:09:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 22:09:39 +0800 (CST)
X-Zmail-TransId: 2afc6aeb3ca3b3f-2aa34
X-Mailer: Zmail v1.0
Message-ID: <20261104220939917jqg8_alGN5sACGWq5M9D-@zte.com.cn>
In-Reply-To: <20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn>
References: 20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn
Date: Wed, 4 Nov 2026 22:09:39 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvM10gYXRhOiBsaWJhdGEtc2NzaTogZml4IHRoZSBtdWx0aV9jb3VudCBjaGVjayBmb3IgMzItYnl0ZSBwYXNzdGhydQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A4E9aCA075538
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 22:09:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB3CB5.00B/4jKS4j6qJGz4yjjY

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_scsi_pass_thru() translates 12, 16 and 32-byte ATA pass-through CDBs.
For a 32-byte CDB (VARIABLE_LENGTH_CMD with the ATA_32 service action) the
ATA command descriptor starts at byte offset 9, so the function adds
cdb_offset when reading the protocol (cdb[1 + cdb_offset]) and T_LENGTH
(cdb[2 + cdb_offset]) fields.

The PIO multi-sector sanity check and the multi_count computation,
however, still read cdb[1] without adding cdb_offset:

	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf))
	...
	unsigned int multi_count = 1 << (cdb[1] >> 5);

For a 32-byte CDB, cdb[1] is the variable length CDB control byte and
its bits 7:5 do not carry MULTIPLE_COUNT.  As a result, the sanity check
that rejects a multi-sector count on a non-multi taskfile is silently
skipped, and multi_count is always computed as 1 << 0 = 1, so the
comparison against dev->multi_count either emits a spurious
"invalid multi_count 1 ignored" warning for devices configured with a
different multi-sector size or misses a real mismatch.

Read the count field from cdb[1 + cdb_offset], matching the rest of the
function, and report the field pointer relative to the same byte so that
a rejected multi-sector count points at the MULTIPLE_COUNT field instead
of byte 1.  For 12 and 16-byte CDBs cdb_offset is zero, so their
behavior is unchanged.

Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with an ATA disk
(ata_piix / QEMU IDE) at /dev/sda.  A 32-byte ATA PASS-THROUGH(32)
CDB for a non-multi command (READ SECTORS) with the multi-sector
count field set (cdb[10] bits 7:5) is sent via SG_IO; a control CDB
with the count field clear is accepted on both kernels.

  unpatched                            patched
  command accepted,                    rejected with
  read completes (status GOOD)         CHECK CONDITION,
                                       ILLEGAL_REQUEST,
                                       INVALID FIELD IN CDB (0x5/0x24)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb0331279..927e75b7498d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3574,13 +3574,13 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	}
 
 	/* sanity check for pio multi commands */
-	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
+	if ((cdb[1 + cdb_offset] & 0xe0) && !is_multi_taskfile(tf)) {
-		fp = 1;
+		fp = 1 + cdb_offset;
 		goto invalid_fld;
 	}
 
 	if (is_multi_taskfile(tf)) {
-		unsigned int multi_count = 1 << (cdb[1] >> 5);
+		unsigned int multi_count = 1 << (cdb[1 + cdb_offset] >> 5);
 
 		if (!dev->multi_count) {
 			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
