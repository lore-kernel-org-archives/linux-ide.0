Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801334;
	b=KQguwf7fxXqMhw46lpRnQu7N/rx1BWonc5+14nqrO3EGhOsgnhgc/NmusQvykPNAUvF0
	 4HRI01Jkb7h9XcxuTToRkY0y7lOKjjJM6A+6BY/arzeEb7nT31Q9DjRZO4R4kXh4QPdC8
	 dxWE51cGToym/otvZudvsmpqh8sKfuUcdDCoo7ChKu+az7VcN8WUExwraoVTxhUvmj31g
	 0NSG5lbo8gmpn8Ay/nOTl1RCt7IbxdSlXc8iLgAsz1LUsD48OoUqpfX77pMWABLcUpMu9
	 nEvvaGGASUu5rPa6CToSM1b/ubmMyTmVChhuX/xlwzGKPAYerq4kqioL+KZKVf1QI3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801334;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=3mjuh8CzJvv3A5SO7dPmFQ8pnk8Ii5U4CXPIduE7Fj4=;
	b=rF7A4aRhpGjd0YILpJjRUs2qc6Qcbw5/yQTz9bzAERk/YZa5OLYZrgu19d/4FAyWQrwc
	 LIacgyWSeqPztgIbLooAmV+KbVNP6PC8xkKaosHIw+TBMVfhu3+T0Kvuot0FrSa1misAc
	 5NYTnAogr4wmIlYmNuWa63kbYN2ujgPQMTmRJOBYhMYsNtonei9XENOTlFfR/Ga7Vm93T
	 N7KxqkHQvdcRvtJeAA+/aQgq6tlBk10Xaz23zgvgMTN2SncV7SgtrH0GLR7LBhVynOi+Q
	 yVS2h6trhxEh/vOvNAgOH6Lrl5Pfd/NqbODW4IxONEPLcX1SAX6gHu6CWjkzoezLhOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A929606D80B;
	Wed,  4 Nov 2026 14:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A929606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKS3L3bjbz57HS1;
	Wed, 04 Nov 2026 22:08:46 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A4E8T4I019770;
	Wed, 4 Nov 2026 22:08:29 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 22:08:32 +0800 (CST)
X-Zmail-TransId: 2afa6aeb3c600bd-34fa7
X-Mailer: Zmail v1.0
Message-ID: <20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn>
Date: Wed, 4 Nov 2026 22:08:32 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDAvM10gYXRhOiBsaWJhdGEtc2NzaTogZml4IEFUQSBQQVNTLVRIUk9VR0goMzIpIGhhbmRsaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4E8T4I019770
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 22:08:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB3C6E.001/4jKS3L3bjbz57HS1

ATA PASS-THROUGH(32) uses the variable length CDB opcode 7Fh with
service action 1FF0h.  Commit b1ffbf854e08 added support for it, but
three paths still use the offsets of the 12- and 16-byte CDBs, or do
not recognize the 32-byte form at all.

Patch 1 fixes the PIO multi-sector sanity check and the multi_count
computation, which read cdb[1] instead of cdb[1 + cdb_offset], and
reports the field pointer for the same byte.

Patch 2 makes an unsupported service action fail with INVALID FIELD IN
CDB.  It currently returns 1 without setting sense data, so the command
completes with SAM_STAT_GOOD even though no ATA command was issued.

Patch 3 teaches the completion path to recognize ATA PASS-THROUGH(32)
and to read CK_COND from byte 11.  Without it, CK_COND is ignored and
the ATA Status Return sense descriptor is not built.

The three patches are independent and can be applied in any order.  All
were tested with a 32-byte CDB sent through SG_IO to a QEMU IDE disk;
the per-patch test descriptions are included after the --- line.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
