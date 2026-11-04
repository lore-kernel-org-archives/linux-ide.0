Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798093;
	b=kQ5jSl8iuHHK+hSINPRsrGK99acnDxoxNdjvY9Pw1l9FRJi9ape2jnHhB1URY0EhQw9c
	 KXLL60JlRsUpy06aFQ49BLKoblfzFOfwF5Qy69tKl1XGy4EUZr3JvsbOdG+7AgSoFav/1
	 74MJ4Jp1Za+1hp/wFp9FYvPuo/bN/4Zeaha9q9UuDX52e6FgeiaCQfVis+3VEgP7spjas
	 4O1wIlX693MKYBYHPQRD5/7yRebhIQrs89o9PqGgYCRqFWis9eAxilpJZdZPPbEMyS+yP
	 BM+NjkUMKXrcDvTeHwMf0zuwsQwHdhDmQ9AzP7AVOqwGMA42olRcTsieIH34LGYC9yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798093;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=uHecZIIQqP97hAU47h2EfArgPNJ7XX7U72jD992xnME=;
	b=t02DQQy63kv+X3C2Tzo2sA+JhCFgFxIYj7Gq7Y1d5HSrzxaMz5qs3wkIvsbJbo8u32Qz
	 lWernHai2G7uJMFsoYVyN8/bo3tkqBKt42NTkbV+e+pyZwOQPnpRU1o7S8VjyzfUw5FAD
	 SauiQtlPgjtogSgwHTV2Rokc4+RtslR+tHhLfzOm9dkGTpL9ZwVyy0Z9TQ2OmejwZgG0l
	 JEM3RbFX9jiiqqHoPTu1P4LqwrWBb3JaSolUWar/h7Bfy9H4ATy5NZiVSg7HuNk5SHkji
	 ZRMR6IUi5QUkBUfeI+b7m+wCVOIhT4IKF4q6+SiI8hKmm4V0o56VshJA5wi1N+cUcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF7606A32F;
	Wed,  4 Nov 2026 13:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBF7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKQrv5htBz57HS6;
	Wed, 04 Nov 2026 21:14:39 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A4DEbdV038305;
	Wed, 4 Nov 2026 21:14:37 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 21:14:39 +0800 (CST)
X-Zmail-TransId: 2afa6aeb2fbf463-f738a
X-Mailer: Zmail v1.0
Message-ID: <20261104211439250EftPg5v8hldkC4dnKtOxA@zte.com.cn>
In-Reply-To: <20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn>
References: 20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn
Date: Wed, 4 Nov 2026 21:14:39 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvM10gYXRhOiBsaWJhaGNpX3BsYXRmb3JtOiBkcm9wIHRoZSBkZWFkIGVycm9yIGNoZWNr?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A4DEbdV038305
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 21:14:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB2FBF.002/4jKQrv5htBz57HS6

From: Shao Mingyin <shao.mingyin@zte.com.cn>

IS_ERR(hpriv->ahci_regulator) is true here, so PTR_ERR() is negative
and "rc != 0" is always true.  Jump to the error path directly.

No functional change.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index ae342080556a..819fbf200dc0 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -557,8 +557,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
 	if (IS_ERR(hpriv->ahci_regulator)) {
 		rc = PTR_ERR(hpriv->ahci_regulator);
-		if (rc != 0)
-			goto err_out;
+		goto err_out;
 	}
 
 	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
