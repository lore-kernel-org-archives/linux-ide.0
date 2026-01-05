Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E33370F4
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623398; cv=none; b=KjelsZUfZLs+lH3LxJ5UlZ+cF7yBwqt9QLCaGEUgsrBvNBqMG0IwFZdbNcleTC3TOsqkxPOHabDsZor1X8JZjTF/47aTS5P3MsnIG1Fa9qHbBYXvGk/0SH687WOswnEL3UnNyGsQHfR3KuMZqYbAa1Ak13Y3T5xlfo4yRwGGHaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623398; c=relaxed/simple;
	bh=BWYdpph40V6+ahw3fGxd5TEaRDtyIoFvWrDnre9gYGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIeTR2D2TnrYZLfofjOQONNglIHveXqNHJH1ielOteg4VWyBQEs/EIOfatEfSXFIyCKVlrU/KoCv9+qL81ZcxHOs+jvQQO/UpMRuBr/KrAjR5VxsC7VYqLjabMFyrJBJRhr14hSumPkrGoUc9zwKR+QAH60I7/Tet7cJbLSqfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKrGuv+M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OW/jhg0P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKrGuv+M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OW/jhg0P"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058JLHS3803597
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2026 14:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+iNK/CviJGp
	soYfpGa3P7BzXOJu5rWNivgQO0pzVOhI=; b=GKrGuv+MDRzWfoH6u2MOaWA+jUS
	QMJW14mjgycgebMrgtwzzoIz1KFBvmTRklF6sUa4KahKDwl3Q4YwULmRTNGLgT8V
	C7zBejimhM++9gZO+sZQYp4ILpQ93ODbv+zI5iOwGwZfK+PPimmXNYA7Vn2LLfGQ
	uG93w5yRfvjPEQ6+p4nEe1OgI8pMBGISOm3HO+s3BVYYhGSI37a94vKxOpZcSGja
	B/tQnUYg0vPlxcriq0N3ZccNDltxupt+vOOpXW3PsgXaFMNUVs2s5HFGU7l9j2/E
	Tg4FAvhQCwJmAa8jOeVqwTnE8yPSXFUGjbk2xTLesjIK811F41xPHEi2BiQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beuvd4r3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 14:29:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so49919931cf.0
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 06:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767623394; x=1768228194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iNK/CviJGpsoYfpGa3P7BzXOJu5rWNivgQO0pzVOhI=;
        b=OW/jhg0PXCK83mW6oxKmb1tTsPuBzv5oiKNStG9Oy0vlvYiq+rqTy3GIrJG3SCfSDZ
         rMWYSfWh+mXGt7RA0vd/XTTHpW8cV3eLwAiQcliBTqbAOMmAZtt893nrSVRORJ7OcBF7
         3JAWpV/6XKwLfFuRUxsLeT5B+/FW4orJGL6Z9Ce5w4jjcsd1Bi1G5qu/QGye3ZibJ2OQ
         mlm3J/l40dpXys2HFseIqsGcyGkCxfzEGe5hOG5VkLQ2zRuIvybkxj09fRH8uoUN71J8
         hXm8hq28DfBr5y3ycVfXJChI4pqsvmRAMXh2XWygMU+omF5xvCikMo+SYjcqROl7oelo
         n/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623394; x=1768228194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+iNK/CviJGpsoYfpGa3P7BzXOJu5rWNivgQO0pzVOhI=;
        b=PEdyuULE8TBZEvDXTvugjhUNTHXzGUAxShUPAtBl9FCPFr+MThLuwfv7ucn3pW78RV
         Z94tQ+17xKPvlCLvPBLou4MNN76SQ34POkXUVTUjsqXmJWBXW5EWi4VThcZIwlOMztxq
         fXGUt6i6gkeTK30w3tHqE9vErzNj0G8MwavNjPRAd/+XwMVYwBxYbsHGnufF/GkyftPz
         //Didd3YUGxI2GFP2MQtHn9UBDugwxkS+24/BPoSZCut/ybxZYt0k/SMgRwCYmq7ctPI
         jyuY2S9e2OYLv7NjWwJuE3APxkz8N2gb1mzrbSC55PuVdFtgpaS3NrNZSFvTJTuEPDVq
         Gy6w==
X-Forwarded-Encrypted: i=1; AJvYcCX36r86DZm0yY20ZCt2mhXkfh0fzXs55Xhd9uqJzRzYdC3q99sNZkJZNtmOC0oO6QjX60pW5v/4bgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgkZpKycM0nQu+JE5zDcHLkqH50aVerxse+phiU6PACS3lc+i
	FGLQXdcPbSLLXV0oYcOP5zQoCoqQvSExbj5V/bvd8V1qlml8UR2sJp6RrMbm1OWwfhJSSwQys6X
	fOjv/4hXVgE8d2otvFEQSIPRpE4BHeJDC2TB4WKfrj2KhsUUcllnAERWM8Csp5LU=
X-Gm-Gg: AY/fxX5Xw6KkELBFJjABqMdTyY+qFcEuKtYOeDJKjRLveHqTfiSXv5vchbEOuz71bBH
	luRPzQDmRUQVsy26ColG8NmvFuMWHHaIbLR38VPzCgEsZ5kEQZss18jQSlycJBiUsLF5ZSgV7TD
	b7iVhJYvbJq/HAGb1dKCrLmRgKpZIy+K5KpSQIF+jW07sl/PyWyjroRRJ/0iwlbRrwzglyfxTH9
	pZSDiG2zKb9xZ+RPykiZCxBqZchpk5Ke4z8XKuqmwODnFDdKMDJc0ngX/m30CQsNjMOC5I2DD79
	UgfOrqdsTU6nvGgEeFxBKALA3IU9zzF82I48qp1ooEBDwd/ZhCq4SsgEXvqrh5PVHFHwkroWsmE
	PlILDG/n1H/0ncn3cpxKkPx3KXA==
X-Received: by 2002:a05:622a:1114:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4ff473d0731mr134520801cf.36.1767623394582;
        Mon, 05 Jan 2026 06:29:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE06SnXQd0QyMUw3KAomX8sIlRFZrYWQP05g/qKtByRhTo4HPd8NEFQcvSlC7YlkgOoEKitQA==
X-Received: by 2002:a05:622a:1114:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4ff473d0731mr134520491cf.36.1767623394170;
        Mon, 05 Jan 2026 06:29:54 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842673b560sm2074066b.33.2026.01.05.06.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:29:53 -0800 (PST)
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
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 3/3] ata: ahci-xgene: Fix Wvoid-pointer-to-enum-cast warning
Date: Mon,  5 Jan 2026 15:29:47 +0100
Message-ID: <20260105142944.372959-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=BWYdpph40V6+ahw3fGxd5TEaRDtyIoFvWrDnre9gYGI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW8raBLsX3Vc5LQN/Lm/KA2HXWJ3ElsyFcYpKw
 oci58LT6wKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVvK2gAKCRDBN2bmhouD
 18W/D/9BzNbkGi3fl7+u/MRsmiQ4kbuD38XsWOnVNS+RGOdpux08sN4iFjzr3Qvr756CrBgHF3h
 stnwcqEDDpEEK/gmVbPiOVxnL2akfXubjpbd5m2yuaHW/1pUULHCLLL7/n4nDmihY6i7G4m8PLa
 R61etURmds9vifnE3hkCKsZfc1ZxmeEvP0XuKTTV+YSKcNuMAAABCQS2IqcphURKrif+wDd5olw
 Ofe542fLtcTf7aT3p4ntPfwzfHDrE9dAjkEO/Ymz9gmwD8/EbjqX+nChs1LkxT7Z4E+PBOjdvdA
 ZBQM2DhKPVsp4xW2bFpNEx9hsCZe1JPSQCkhZ7kCyiBKsrwIa9qV3gDDYaHP8vvfivW+0cxCZp/
 udr0JU1stNjyXAgysiXaXUcnHDFrCs+aRWmQRGku5UANHi5OSqe2yxMxKCEU4x/p2cQpSuePdNk
 RzLiw9L8xvbledztQcqx8Z48tTFoBbem3qjyplQdQ+Gvv5UQjZxeDbPBf4M7+BuSgZIaiSQGFd+
 BaPLMa//bPBu1TjLNWSnFf52tywgSbijSfC7oM1Xw/aV2kHhzLmzBnRaA15rbAFvF5XlNoO1uMY
 +SRaNcbfYi3Nc7+ReyYxQJW4/fiLDSsnsuXul2FeRPkQYje5Pveh7YYWUAp13qoPmXmcoGqAjGq Sr/2aiwJPTacv+A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ga_Oiiy7qFdFwcbP_WexLn2II9vHF6MV
X-Proofpoint-GUID: ga_Oiiy7qFdFwcbP_WexLn2II9vHF6MV
X-Authority-Analysis: v=2.4 cv=OuhCCi/t c=1 sm=1 tr=0 ts=695bcae3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=O-IaotXkb1TqCMFDYkEA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEyNiBTYWx0ZWRfX5q1zc0VDcnwb
 RfnsrhOHDt1/W3SlHMbbvoPvopDPXjKIiunw13T3lfsP3j0dAVlKkaXvXzln544G5iQZn7swgZH
 WhVawsYafzm2kqs9fskkl5edgLGhzFWMuha+Y1AWwWIClUz5SQZcFGJsrwPAuBPa24jwqFk4Co8
 ydARrwa1Qbj3niSC//rbHcQqcvITPjegbkBzyNlLH8SLTNdR53xSkyNldSy72lC0ED/BmIHmyYX
 rIvvHY/P0Wopy+qFt5F8DFiDOQyUcrOxIJ2nbxpdQvwE3B5tbJB6kHZBoy1uWbtwrWyX8ypLmQN
 ebBSJYqFuqJoNgQM3rk2raTt5XYvLa+KqYcYmruOncyZ/ocBA+jyQ10Zcl2tukO6Hz4xr1Y5YGJ
 1G7BN312io+i7KXTFFw9EuiYr1tjTXRSNAoQKJ3Xsox4N2Kv6eU6MDRn1awPZQ/9Km5Fb757lDp
 p4v7XoiROo1DlujxKDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050126

"version" is an enum, thus cast of pointer on 64-bit compile test with
clang W=1 causes:

  ahci_xgene.c:776:13: error: cast to smaller integer type 'enum xgene_ahci_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. None
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

