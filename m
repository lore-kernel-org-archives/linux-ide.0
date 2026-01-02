Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AF322A00
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358252; cv=none; b=SCwRYh4ve3mVN8+BgRp/mUnBp+JSKYZPmdHofEj4f9ghYTRPTH0GEo+qxKJTtrNJpfUptwtSKVWjHmpg//PYDGsmtRJpFue829E31pX4Jhy9/To+MlVP4oPD7ivLGcTfYQblvI0HT8MFrm5MWCiKdf2P31cQsQ9NMPYS70wS2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358252; c=relaxed/simple;
	bh=aGmWnDdCsPxP/9AQk/c0mEIwm2GvlT+MuDcO0Ejg9Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuPj8wlwDTySbos30hJ4v9hoJ82AZPb5e7F9HabOA42Pz4p8i5LfD66k0BY/Rx9b2aOonc6mctomh220ei9pOmvWUPmWYbnu0Hu4vFh6dcnnI17K9wB6gyvzKXLD4vc1+NY+bV9BXhAgAdtIqHSn0ckd35TrSsbNWLY0B1qIrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3rRy6o9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RL7W/5gF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3rRy6o9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RL7W/5gF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WF1J427436
	for <linux-ide@vger.kernel.org>; Fri, 2 Jan 2026 12:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v+3Kw9OcKjm
	yi1BRmckH+Fe/+mzaD4IcuRMjS7jkrxA=; b=Z3rRy6o99Ek6SnSUPQ3d9ha1NQp
	MSh9lekW6Uu+XYNJ1baj8asA55OgLbj8AE64xcVryPn+z8DbRhtbJBwbA3Yj7EfX
	miPm0rxDm5pJzR89xVNN/ojUTYhG0cFOzj4rxWzl+ntyqWbegnoQG2SWoj4zlaEq
	kmmt8E4DzUJLm8cjNm65doFfGIcNpIOium2oV2/KQCL0s+iNh1IgIHyvBkjy85s/
	YUsgLkWVQrnB4PR78sqc1rZaOx5kuWu3jC83dzrjjtuIzj4zTDBKqR82tVD5k3he
	WoJCwADKO/XeRQwkdXIJjReXI/acrUCZXByXW5lJAPFQKt7DT25l8xyb4Ew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be6fjrxt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2026 12:50:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a3a4af701so338414416d6.1
        for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2026 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358250; x=1767963050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+3Kw9OcKjmyi1BRmckH+Fe/+mzaD4IcuRMjS7jkrxA=;
        b=RL7W/5gF7UM1Oef3o3SrrrVGG8UdYvGTyiieR74BESNUaB98/5rQp7wyI51oUBJ/Lm
         ltPgoC1iOWOPwkqwOv9Vvzyog4lUBxz3strfxcsOIttUrvflj8iq94s7mD7egnM3B1nq
         Ugqn1d01BpCQVLkFrq2nuvKWYId1Va0Y1qYAj2Or7sIYRTDsbMvjKZVrjKzmpNi9YgcL
         r4lqrtb2HGYo8SyGGttKnL3nrHir6Zu1dW4tczxSUOUexJZC0XWwMUL5q7wFUKTjt6tE
         O/bV6MEiIFojqz3czexmmmeZWA2w6LUVIGUTZgz1Xyakr2DUxccoe1BX6v3MUz8QZ0bo
         URhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358250; x=1767963050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+3Kw9OcKjmyi1BRmckH+Fe/+mzaD4IcuRMjS7jkrxA=;
        b=NIw7c+2zZslJfyP08Gl/WMVwxFlnshilhsawUOZhBz8k4OAhB/N6vJWV+fXwSF0I4r
         Iuh+1Ct2hh4Y1SigA9Sdwy6othS0SNSZ38hM7OhkKG7DUqmcVLKpK8hEl2OQ1cQqkHvs
         cVP9B1Z5tKx7bRwqKDcbzyLMr/cNscWJaOdRyJD7kXwpSaq+1oY/cYo36uePbYyqgCGF
         a5EtlqhJZ9pl62FDWiCjvxNDOV5AxBDxK/f1z3ld76vI678UqjrqhW8TDTJTbuiR64iZ
         uUfYPI9OItY7uiIODPQMiinFYwM7yuqHkvKr6EX4bP7BdTXSDwn2W8QsSgXAqJjnAG4S
         9CNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuVVIRog4OvwuHqmNVeKQLulTNi7pmqrXWamM6e26LKDBp05afEk3g9fI8edPuffXXc1TkefZrDTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMuHFJtnf3mAeBSRLE1oixra/VSSsAbGVN2Q32XLDWBQFeAzl0
	12ue/zLrq9plY0aheJeiwJ2culQW4QR2SlCumo2N+xJR/xeqjCv1es+dD9eht3yGH/fQH80gvaL
	sY7ALJVCys30HuFoEpoMGFCCT6N8NLzwcd+zkmRfCmxrE+aigd3SwRt59J8f2iLY=
X-Gm-Gg: AY/fxX5BQLWItlVFvIc20kUdZ00CgIWzp+nB5eewnU1FCexVi5jJaw2sWVzgAoZa5T0
	N3eahXIKQ5PWDxVHh606eP0Sfyii1bz5Y5R73qrXVWdMkMoqUAqoLrbGQ7YvwomhzRaVXfmmL3z
	VaEHIbljagjGUNswMsV8CAyXInwTR3eHCGFnl0MJIwkhCBIQZVnyz6BgT4wItn1mLCXagtOIobn
	lC9/N7kCW48udn78nG6N08hfNjwb1huqMmaYvPmDwixE5ZYCTYP2Bm1nmlrqIIK8J6alAxVmSxm
	EmYzYgi1QS5BUOfiDxYiidzJcmfLYs41fG1t7RlCdTka10VsB0MhsMIC1zvV5AFtjqmcOuTSi9C
	y94x8EeFXOQhoPk+RTlO5RGD38Q==
X-Received: by 2002:a05:622a:2618:b0:4f1:caed:da6b with SMTP id d75a77b69052e-4f4abd2a295mr600889871cf.35.1767358249719;
        Fri, 02 Jan 2026 04:50:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7zF9JMBhGYnhDGu2/Y0ko9eaoSDqiHsiizO1xN0OYUtERy0LAazChQnttfMnUTtvdemOVkA==
X-Received: by 2002:a05:622a:2618:b0:4f1:caed:da6b with SMTP id d75a77b69052e-4f4abd2a295mr600889611cf.35.1767358249332;
        Fri, 02 Jan 2026 04:50:49 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm84491369f8f.7.2026.01.02.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:50:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 3/3] ata: ahci-xgene: Fix Wvoid-pointer-to-enum-cast warning
Date: Fri,  2 Jan 2026 13:50:43 +0100
Message-ID: <20260102125040.65256-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102125040.65256-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102125040.65256-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=aGmWnDdCsPxP/9AQk/c0mEIwm2GvlT+MuDcO0Ejg9Tc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV78itUdE9YSsc0MqT+n0aMAWzMrTX9ODAm1SQ
 t71zmsGjr2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe/IgAKCRDBN2bmhouD
 12NOD/9REcyL8OieJxiuRb/ZhNCPYYaSi2Nj36SpP3T0OuvEZp62VrrrKXsCNS1LIZ+oQS/VVOK
 PZsHlHBwr8EDxXGJBdu/rvbqDrjD+8sKcueg3vi9YPEOiaTGJEyZ187CPJ8zsBLGRIc+XtC4v6A
 D4ehi1+0q/avW54bXJbpn3DRpjVe/8CVBD1yPl+tiaY0nCcecPr2+9PnZePH2fbYJN9srUPSX0t
 o8PRzsXGtN9NEQ/S3nLw49p5tD0I5k869pZUPzNqoOQ2bCNT5Na6oIDuDip8gUYbTYd7C49gpFG
 Ejd8hPx151oAGReHnZKpMWjuyAGjusJznztI9bH4tEW9OX+lbjIgL2OIrRSo938ldgDDLtPTB4H
 KzicAZBG27TXC1Uh7C0nw8Xv4w2qH3Ptd+tZ1gZcuSmTS01pDZL5t8tJs32/UvUBfGuLVQ/Ph84
 8jnuWu6mlZ+Kf0uHrRMKfI1CjoLOuHDWvNk0XWE5qJZOs8RmaHFA5RmdctcO0jI9jDsCASc1Sf/
 gm28x4MP58D51Z2WWQbc5wG3wRMz9QUoHQswpx4i18ZFDsn1BiwJCYKq+bzAkr24zcl3OYvKsGE
 CBCE1EYzzb/w7nFsJTP+OMwhIwKhP08fCkf8yCWATzR3O/ZnrNrE5FuPMUb+mapOfLRxmn/KGJO 8egNX5LQ2weKIQQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Av7jHe9P c=1 sm=1 tr=0 ts=6957bf2a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=O-IaotXkb1TqCMFDYkEA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: qw9cz-mi7mQhD6zagIkj69K_XPTBHHFr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExNCBTYWx0ZWRfXzdvI5VHorF3P
 AunruhRiG95N3QnrU0iAHgK5/JwEnSSEMQ5REsAcfBnZJ0nhvsYdMgKUAWNe9VFT1jazQDrGJSV
 751vHugZDHj58YrYyhoVB0u+OdNiJ5dwDkbuc92HUeM74UF2nDARqAIP6d7fR3NBabVVD75XGCM
 P9FIPJwydKWHcBXUYUqyoa75M4To0yHAHNbc91fPO6uc1Kpoz8Dbm+npwgMa6SCioAN6Y6T4PJW
 tQvSJF6IySLKZyequHDuy5PcPHEnaGQDGKL8b5zIORSvOz8xjVniPGSwacwr2D6FPS5Ab+s0nCp
 ddLOV26gQ26ofrtNiNAwK6aBsP5uVY9N7DgjRr5S0TezXTFHGwY1oViRopH+UBCpH2rhPWhoARC
 Jq2x9jSGkUAQin2kTP8CPENaqkCCCBupw9CTiz9O24vec8U8kWLHD+y9UcdubmLyliIiPZn/+fa
 0pCwn5WECzlf4CjUoUg==
X-Proofpoint-GUID: qw9cz-mi7mQhD6zagIkj69K_XPTBHHFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020114

"version" is an enum, thus cast of pointer on 64-bit compile test with
clang W=1 causes:

  ahci_xgene.c:776:13: error: cast to smaller integer type 'enum xgene_ahci_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/ata/ahci_xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 6b8844646fcd..98c99b5a8242 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -773,7 +773,7 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 	}
 
 	if (dev->of_node) {
-		version = (enum xgene_ahci_version)of_device_get_match_data(dev);
+		version = (unsigned long)of_device_get_match_data(dev);
 	}
 #ifdef CONFIG_ACPI
 	else {
-- 
2.51.0

