Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271802;
	b=H8aQ5zhXa8wGMwAjvMZof96E2qtIpnHcqqPEyMudExOTGvFt4h0OxBp67BnFS1vc0bp5
	 l+mpCKIT1q3nDs1KRJuPKvUpG3x/KPZUSek5JbZ4bL0yZi0Av4vWPLAAhhifldzOhaMkH
	 tRN9Pc6c4kkUAEw/uy4y2aWE10j4R9SRD8wAvKvVKHkLfFQiTyLJfwh2ZQ5PGBiy3p/ul
	 dbLwo/5tO/X8FLMqB6LcwtezXhzm5fDQKg4/ivGd0Y+choyGvaB1VSidX7BVvVF4XjSO8
	 YvA9Z1vThNblHx6E+q+6ZQRo8/ZB0nT6hYLiSoQ44u8wT7n2CEwA3uR5DOVma/hh5Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271802;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=KfmDwcMrjK2ZAGraZ+4RY99djt++qfZZqI79X0qnDYI=;
	b=kU7bHzjgGGEv8+r3XJCsH3OS859tlMHL32xUw+p2wiPSKySYEJkaEtblToJ+W1IlW1X8
	 EMbh95e9GosCNvafFPLfCY9XTAtMZk8co5AlsL0OKzarRBuk6RVPIofy0TpVY4LbXjIJj
	 6MWFcpfpryP0LMZjHqvPSZdK/YPWGAU2zEa3JJwoz0IBgcLQDaObvV+rpzBUfXNH2qwz9
	 ItymQMueCAwbA8oTlBkJDc1A72zV/hWXdg5Tr384lqc6xw4nwpt6Ng1VrCfM/7ln0GdEO
	 kDe2Lcb+pgip8B4XhUQqVjdpo4DrwkW2a9f+JWKVHFVwh+HnksaxSlmOZBv0gv1okOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2470606A323;
	Thu, 29 Oct 2026 11:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2470606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFhD76rkpz8Xrrb;
	Thu, 29 Oct 2026 19:03:19 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 69TB3Cwl071868;
	Thu, 29 Oct 2026 19:03:12 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 29 Oct 2026 19:03:14 +0800 (CST)
X-Zmail-TransId: 2afa6ae327f2272-0a40c
X-Mailer: Zmail v1.0
Message-ID: <202610291903148135Df-fh-xl3zWuRJkq8AXn@zte.com.cn>
Date: Thu, 29 Oct 2026 19:03:14 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IGxpYmF0YS1zY3NpOiBzZXQgdGhlIGZpZWxkIHBvaW50ZXIgd2hlbiByZWplY3RpbmcgQ0RM?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69TB3Cwl071868
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 29 Oct 2026 19:03:19 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE327F7.000/4jFhD76rkpz8Xrrb

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ata_mselect_control_ata_feature() rejects enabling CDL while NCQ
priority is enabled, but unlike its other error branches it returns
without setting *fp.

ata_scsi_mode_select_xlat() initializes fp to 0xffff and, when the
handler fails, adds the mode select header and block descriptor lengths
to it.  The resulting sense data then reports a field pointer far
outside of the submitted parameter list instead of the byte that has to
be changed.

Set *fp to the beginning of the mode page data, as the other branches of
this function do.

Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5cde90fe594e..c07c1ff09757 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4494,6 +4494,7 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
+			*fp = 0;
 			return -EINVAL;
 		}
 		ata_dev_dbg(dev, "Enabling CDL\n");
