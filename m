Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798094;
	b=DFLzNMMm1UNuiRCsVbr3R4h5Uvoj6RQiTmmgSRPxUUMuuGj9C/S1wCzqc1tzBOo3WO+U
	 33kEPQRscrvRlhyJIqdnhIEOxIK/OFJ3DSIEwKjQMsLDLUf8GQlRaFBjgzXRWu3Xw5Hbk
	 to2AOZrcwjWtADirIzJM+fBPFF9pbuB5S9ODw1s4J2g/C5xx0esYB+TjdbCsArk0CL0Aw
	 Xv8YIbU7WXdU+tbvxebpd/svrA6q2vUSiQUdlMOKWRCB5Zk4cLlQ9ZAj1gdXJNZ7JllfU
	 DOMF3YWoov3y2C1kWFxjDkbsoOMYYiZ+rhwXkED47EjE79u0liivanX0TtAp/GMbk/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798094;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=VowS9xVzMEQrXVDmWDkONvYBWHoxc8NpMkl4qXPAec8=;
	b=COoVlC9umhmoB8cZ7bu4zardjaxSljmNK+OHheBii5LJN2zLZu1JKb9jhh8Se4nc3Ngr
	 JqxUbN3p4w/dCFJmjUI23AmMyC/i7esdv7rfCd6Ri/OPBL4IE1bR4i8YrWtQ7SVAzHwHk
	 eedRo3fBpKa7tJolyKYC27mNBOkChNjABD+z9RMauP0iT+n1cKH3dyAva13Ue9P/LkJGy
	 nRnulhwnCUFf9Ee42B9mkZ/MDROW1k/48INZsVGzsFqwXYOMfiubh6D4WEbLCTOlntJh6
	 Y4glXY9bXObRM95HtBc+SfoFLBRIUbApw0OzpCee+HG3W/VvY+Poje6HiJb8gNRtmhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB40606A32E;
	Wed,  4 Nov 2026 13:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB40606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKQrt6VbFz57HS0;
	Wed, 04 Nov 2026 21:14:38 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A4DEa9L038303;
	Wed, 4 Nov 2026 21:14:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 21:14:38 +0800 (CST)
X-Zmail-TransId: 2afc6aeb2fbe83a-eb76d
X-Mailer: Zmail v1.0
Message-ID: <20261104211438037bcIKTaLPaIlyGxIkLtstZ@zte.com.cn>
In-Reply-To: <20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn>
References: 20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn
Date: Wed, 4 Nov 2026 21:14:38 +0800 (CST)
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
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <hansg@kernel.org>,
        <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvM10gYXRhOiBsaWJhdGEtdHJhbnNwb3J0OiBkcm9wIHRoZSBkZWFkIEdTQ1IgbmV3bGluZSBjaGVjaw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A4DEa9L038303
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 21:14:38 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB2FBE.000/4jKQrt6VbFz57HS0

From: Shao Mingyin <shao.mingyin@zte.com.cn>

SATA_PMP_GSCR_DWORDS is 128, so "SATA_PMP_GSCR_DWORDS & 3" is always
zero and the branch is dead.  The loop already terminates every fourth
dword with a newline.

No functional change.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 95862dc34419..bebccda4d710 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -447,8 +447,6 @@ show_ata_dev_gscr(struct device *dev,
 				    ata_dev->gscr[i],
 				    ((i+1) & 3) ? ' ' : '\n');
 	}
-	if (SATA_PMP_GSCR_DWORDS & 3)
-		buf[written-1] = '\n';
 	return written;
 }
