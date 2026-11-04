Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798096;
	b=5quZcdMYQlzzqfildXcaxzvNPo4VH2Y2LBDPLH4PNRpdv+YULflQLLqe561jkhTuNDyT
	 GmAwIQFM5lCrraxQMokG1GxrBCVHmw25OaWZ8wc64fizsGF46QT0Qsk05LKcKW8p4UNAs
	 Sh9iM6+t/1uJu9YSku9fjvaKgOVL4NcR5g70akhNgIV5yq2GOpdK8PftUz/U3SZHiJrYz
	 ae+2K3r6sgPy3ZaD9Gg3eOnSQ/xcki3AwGMRyVqwjpsK1YPBuqgKVF664z1ovplse/uu6
	 Vw41fpbeG2H0DJu2N2/0E57heZ9H4AKhD7SZZPLAAf6CgXU0aCAP5JZN0V+E18Bg2+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798096;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=o2Z4FLmGoqgvma0ZXbEUdo+sXJMCcgvm9WqdLo49S00=;
	b=s7WqRdv/GfO+XmTF3IACCA2xtocjhft9ZKF3wRmCpThh8bmpkUOseWq5x5KL769U3zMD
	 FXdaDZOCfSPPlmc5/R18ss/QhZ0GcnVxcVneUJsOCoP9XJEqpjDg2xBfVVWmHXCtoG601
	 TFPcSq2wl2zYkm+jjh3x4R8lNJaFhiDdDmrxUNbSgTNSyYOrTXXMcnQ+U84EyxZria9JP
	 M5ZjnLAscts+wjvqjZIpNaKBCsH+N2lgFCwBjH1tjQ1HOKkNWU8sYIwFPLssXRzTgtMjm
	 dIiM0gJdpaUyW51k3k1GveCqA9jgtDhvotTL+dtCvtFFZFa3U8gdnYunbOmq5ZHcMWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D556606D814;
	Wed,  4 Nov 2026 13:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D556606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jKQs04ZGfz8Xrnt;
	Wed, 04 Nov 2026 21:14:44 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A4DEbK5088225;
	Wed, 4 Nov 2026 21:14:37 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 21:14:40 +0800 (CST)
X-Zmail-TransId: 2afc6aeb2fc08f4-eb827
X-Mailer: Zmail v1.0
Message-ID: <20261104211440455JCTCACMo5nXzgNNMAxIiJ@zte.com.cn>
In-Reply-To: <20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn>
References: 20261104211432688UOs4v84BESagMmLFH30Er@zte.com.cn
Date: Wed, 4 Nov 2026 21:14:40 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvM10gYXRhOiBsaWJhdGEtenBvZGQ6IHVzZSBhIHNpbmdsZSBleGl0IGluIHpwb2RkX2dldF9tZWNoX3R5cGUoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A4DEbK5088225
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 21:14:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB2FC4.001/4jKQs04ZGfz8Xrnt

From: Shao Mingyin <shao.mingyin@zte.com.cn>

zpodd_get_mech_type() repeats "kfree(buf); return ..." at five
points.  Use one cleanup label and return the result from there.

No functional change.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 414e7c63bd85..c03387d94006 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -53,6 +53,7 @@ static int eject_tray(struct ata_device *dev)
 static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 {
 	char *buf;
+	enum odd_mech_type type;
 	unsigned int ret;
 	struct rm_feature_desc *desc;
 	struct ata_taskfile tf;
@@ -78,26 +79,25 @@ static enum odd_mech_type zpodd_get_mech_type(struct ata_device *dev)
 	ret = ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
 				buf, 16, 0);
 	if (ret) {
-		kfree(buf);
-		return ODD_MECH_TYPE_UNSUPPORTED;
+		type = ODD_MECH_TYPE_UNSUPPORTED;
+		goto out;
 	}
 
 	if (be16_to_cpu(desc->feature_code) != 3) {
-		kfree(buf);
-		return ODD_MECH_TYPE_UNSUPPORTED;
+		type = ODD_MECH_TYPE_UNSUPPORTED;
+		goto out;
 	}
 
-	if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1) {
-		kfree(buf);
-		return ODD_MECH_TYPE_SLOT;
-	} else if (desc->mech_type == 1 && desc->load == 0 &&
-		   desc->eject == 1) {
-		kfree(buf);
-		return ODD_MECH_TYPE_DRAWER;
-	} else {
-		kfree(buf);
-		return ODD_MECH_TYPE_UNSUPPORTED;
-	}
+	if (desc->mech_type == 0 && desc->load == 0 && desc->eject == 1)
+		type = ODD_MECH_TYPE_SLOT;
+	else if (desc->mech_type == 1 && desc->load == 0 &&
+		 desc->eject == 1)
+		type = ODD_MECH_TYPE_DRAWER;
+	else
+		type = ODD_MECH_TYPE_UNSUPPORTED;
+out:
+	kfree(buf);
+	return type;
 }
 
 /* Test if ODD is zero power ready by sense code */
