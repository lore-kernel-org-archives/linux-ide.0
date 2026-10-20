Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483284;
	b=K2G9NrLjLZsclD1xT/sSfmcfUEc28K/uKyHxzzTaERJmZ/fsL1ZaZhjMgJ/gS6JuATRg
	 KxvUgYAqoeHI6AzHI0ZS1xq68uXB0PeIktwda2fFTCjMCOQo7MEyzlpBnpRAd+SjvVFP0
	 loPYd1PxyVLmN2SlU5KfTwWepsXeREP4mIYLT6zaHwKQbBnYNSvVEPNL2BzTWjprRvJYU
	 WxPG375A/zXAkKnWCMJ8SrJe4Id7SMZdjQaLG5QOhi46cISgq5+pA+gmvIE489gk9VLxM
	 XIVz6hGMBtqJX5MKxggWQ28WDIXeCA3Z0HUuN5u5nhcpyexgTbXg3hixlIhe+NzJsEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483284;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=bUSocYQGGTJOQwXBZPfUJOStDAn5cF3ScXlW/ksVeqo=;
	b=Jg4ZrdBdQ+HkzGj3+AG+VCn3m+X32YzcKmXW4LJd+X7YCs7qNuOhqLS8yaGqJ+kadLuD
	 xTVWxN84iCfl/7Sy0iPVnFAMVLYZkS4PXdPoZyqiyO1CBXQSTdf54wbba0Avl9zsIoeye
	 1pCPKciOXMrHagaD9IogpiiqIoRbe64p78GwG5T0QCMedkoqAeFmImrCsitxBN7IpdSLb
	 +scFPf8cZV03jioOvvO5F77/EkR0EUsH/Q5sRIYwwubJMaKor2Ib6c7cAbe+Sgb+vhf+b
	 VBugdMw9m2MImZbBy2buxS4MNW72c5fvd/NwWP6/b17mLT560K3ZBHUtVNK8AFTQaKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAB606A322;
	Tue, 20 Oct 2026 08:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDAB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j84cC0Hllz8Xs6w;
	Tue, 20 Oct 2026 16:01:15 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 69K80wU8091262;
	Tue, 20 Oct 2026 16:00:59 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 20 Oct 2026 16:01:01 +0800 (CST)
X-Zmail-TransId: 2af96ad71fbd29f-323d5
X-Mailer: Zmail v1.0
Message-ID: <20261020160101007xAtLUWDrReLsKCbDsa5eu@zte.com.cn>
Date: Tue, 20 Oct 2026 16:01:01 +0800 (CST)
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
To: <linux-ide@vger.kernel.org>, <dlemoal@kernel.org>, <cassel@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <yang.tao172@zte.com.cn>,
        <zhang.yue5@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IGxpYmF0YS1laDogZHJvcCByZWR1bmRhbnQgYXRhX3RhZ192YWxpZCgpIGNoZWNrIGluwqBhdGFfZWhfbWF5YmVfcmV0cnlfZmx1c2goKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69K80wU8091262
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 20 Oct 2026 16:01:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD71FCB.000/4j84cC0Hllz8Xs6w

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_eh_maybe_retry_flush() validates link->active_tag with ata_tag_valid()
before calling __ata_qc_from_tag(), which itself evaluates ata_tag_valid()
on the same tag and returns NULL when the tag is invalid.

Since the NULL return value of __ata_qc_from_tag() is the single source of
truth for tag validity, drop the redundant explicit ata_tag_valid() check
and simply return early when qc is NULL.  This mirrors the style already
used in ata_eh_get_non_ncq_success_sense().

No functional change.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: Yang Tao <yang.tao172@zte.com.cn>
---
 drivers/ata/libata-eh.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c93c24b22d9c..bf3313175a97 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3571,11 +3571,9 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
 	unsigned int err_mask;
 	int rc = 0;

-	/* did flush fail for this device? */
-	if (!ata_tag_valid(link->active_tag))
-		return 0;
-
 	qc = __ata_qc_from_tag(ap, link->active_tag);
+	if (!qc)
+		return 0;
 	if (qc->dev != dev || (qc->tf.command != ATA_CMD_FLUSH_EXT &&
 			       qc->tf.command != ATA_CMD_FLUSH))
 		return 0;
-- 
2.27.0
