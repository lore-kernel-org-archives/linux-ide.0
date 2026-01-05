Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E882F28E3
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623394; cv=none; b=DpsPHPWxfa4zGOyMyKRJ0k1VHnDXFWoxQyir2f3pq8XhvoySzE1/xStBuu7SypHTenYRA9b+JJ3Om/EKiAPSKjK7xpK/2yi+yn3b7MXGG9O243RodCAbvspVAoAvrlEGMSNRsz1Raoc2XmEqrIhQsEOd9Rfu+hFvEvPjVO0Xbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623394; c=relaxed/simple;
	bh=fAegm32bM9RyJz+Nl9EGlr82cAT+Hy4WuMkpCZJ7rro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBKQ66rXcXwPh4DDVEUh2u9TtS70Wn9VbmykSjvaMX9xVW6YqWm78XeOkOtKbggzPqSs/HVjVhzC53Spg6Z/i7G3HLmCE5hkV9wYosb13ptdVw60v7lHF5q1cObnCimplv2MYLYXLQF603BMnXXF1UEmjMmdsUThQPByAtNspvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NE43sUYG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ONs5uUqR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NE43sUYG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ONs5uUqR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058LrLv3738169
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2026 14:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uHEQAWSamf6mSgVcU48rQFJXFmJhwrjLABU
	raXAPotc=; b=NE43sUYGtyV+BvCZMBQIlJdT1wm1XiOf0OTrOVxUk6y94X1MIZ9
	ZKDSaZmmPrDjoKgy3AsWeKkhGI/uOMJGiViqpAccR4l8KvKTeGMQeldaRmiaB4w+
	2BJdykkqdO9+fR0CmXfpYsSf9fEF4XaA5cVJpknsKXoKIK8pjG9ODV45uqlEDKBP
	fQBBuyFaNu2TeJexcXxH9gQzKh/XZum8C6E7f1BQN4/5SVNh8l7tDHVgCP7rQKjH
	QHekhAyPev/dTFuNwA9z5D6pAhTVVAHRPDmQQkdMQ7cipVi2kQQaOrwSIUbkR0r6
	ZpV9fk+ZA/PERJSiIG6vDs6AVqL8jUEheCA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bet2qvxc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 14:29:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b22d590227so1611355585a.1
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 06:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767623391; x=1768228191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHEQAWSamf6mSgVcU48rQFJXFmJhwrjLABUraXAPotc=;
        b=ONs5uUqRfDpwtWom+7N9p1jZ5FR7ONiio5Xl38tqb9J7seihm3QRkxu7qfeylqAXPh
         FMZ5/UR2GsORpZSQiADBRf7wTuvd464tTMbK8V4bo1m8NbgfIw/FceKVQVvLJD/7o29o
         FAFeO2ojo/aF1++Q5Po+5MGjFawd6VSf3kSZK8hAEVKuvNnlsWmw+Kk9gQ5U+hvZ+HKp
         vT9R0wwR8JqphVxp16NmDLvJ2U59i9EikWc36HeQt5SWBmL4EbFdawM6RadRf38DS6iE
         +3YYK3jNGgsn5uAfaxJtjkP2tQIVo0TppkDf4CjFfKrr0nuGpcRW+4WQCDN78M9XfkQR
         akMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623391; x=1768228191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHEQAWSamf6mSgVcU48rQFJXFmJhwrjLABUraXAPotc=;
        b=YK2a7FHFXn15XdZmwZ9iWVJL3w0uoYBGEXEIEJtazQ94IujQNjFO1pxx8GouJK3j1F
         fkv9LwJAPvkmVRSx+LOfCC4l9SW0NPQWyWRVQoAQ/ONHf4IyMgStB3sWF1gGeX1pBiZ+
         hAGsXCyqaf07Sdxp6ynkmWBBIJ+j9IUOyRFlO6T5uLo62CnClOmliyCeIie4CMygAwSb
         OLoTqBdb623xEcXd1K85Wz7UE+uppaF6qHYLlE9KMFyMWyFcGt8/+RRSn5mGXoTp1Pvj
         j9mDLNOgVjsRlixqL+MQ0B6P10lLvXhCfFMxPsU17j+YW+V5JI9he5IxwTHOe6tVxmW3
         Ugrg==
X-Forwarded-Encrypted: i=1; AJvYcCXUkEH2C4EvUnY3MtK2ayVzI63bD6ye97gtyV9EAN5xDA+S4df54Hw330HfRB7TQtv1aqmniUOY1PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnGZxN0vM/yVPqgTE1oyGzaH5j904oqSXpvKI74Yi2RbBN7MV
	cTlwv1zsz7GATmFbjZJs88QuD8PBJV1DY8ciE48zaS79DImfMHJNeDi95zGHdZjbHaclnzYtnV7
	XmX5HrcdHdZMcFgYkvyCZS1w26pvohuSn9cOB2uOl40d2BSJEE9NNIy8WKQ83ZYo=
X-Gm-Gg: AY/fxX5YVsvckPcScXthnVtghOw7fdaoLCKEraIJUxXYDknkvsTC+brxhbTeZbxztna
	Kp0RvFDBOABAAKLvEptMIcIEASmrWOqQiQ3HhYYwlYjZq34MOLSbkR16sOvO3ilTVXuS4Mu8L48
	WodyOpBEZvKpm9oaGQCLRQ64Q0wVgKnm8okdVyzaFp3ZWtGO2SaZRZL4vC4S2oSgXDfcpE+W9ww
	43xWGGlLlQQb/n7bNRMRrKlyT5iuAEw78Dg/rC5IhkTLx2Hxcam8uKDjFXs3LvKtsOEZa4rgxVG
	ODJ0R37B+/UyWlTP1YWpcGPnRF/vQ7PdlRPiH8u+WRnWJBBw5iiPq6sUk0pVu7sX1+R3vnd6/qX
	1Cch7wbgIXnhx44GRBKlq9Ag6yA==
X-Received: by 2002:a05:622a:230a:b0:4ee:1365:ba71 with SMTP id d75a77b69052e-4f4abca88f1mr652021501cf.9.1767623391197;
        Mon, 05 Jan 2026 06:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlvRg+aO8t+zE5vVQx9pWdSJVFNfjvds9sCsVNmPwgMaoM5zPq5KHvwNtUo5Xk2hR51+Kd6Q==
X-Received: by 2002:a05:622a:230a:b0:4ee:1365:ba71 with SMTP id d75a77b69052e-4f4abca88f1mr652021031cf.9.1767623390710;
        Mon, 05 Jan 2026 06:29:50 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842673b560sm2074066b.33.2026.01.05.06.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:29:50 -0800 (PST)
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
Subject: [PATCH v2 1/3] ata: ahci-dwc: Simplify with scoped for each OF child loop
Date: Mon,  5 Jan 2026 15:29:45 +0100
Message-ID: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=fAegm32bM9RyJz+Nl9EGlr82cAT+Hy4WuMkpCZJ7rro=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW8rY87hRh0OzcNY6V/K6ooLENyRt+Cgnakquq
 iXDKU8drGGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVvK2AAKCRDBN2bmhouD
 12dTD/9Suk2plByjENwiUinWakQ+DPzMnIChhWLkeXgvvr1J3oRE1Ex4KAifn26iU5s0x7BtN68
 GNE+GefUqjIbOHPNiY3BIL0tfcgLjPne+kieuwmTzXonwITY6qodvNg7og57nnlqSV0P57Pi56G
 1PFQyuBOYzqCblfnmTcufc56svhZhH+R3RrCXS1h+xwtD2G3V6bfUUHakvyzAOfjiPhQuhRVKl9
 6EuGeCyEV9A/kvwxohhZsxD2PTZbJ2jk/NBZhxvuf3TLcQU/q2vdnxX9/w7H15XJrMXrMh2FlWQ
 NxLOvtnE9psQpCArJ8Cuvz2R1m+mUHX/MkPuqE6jDe4LjHdQhDPiMpiwVKRv//OrtbNPj1qMIPu
 Vk7BkgehA2WM6IjGm2/Q5lU1zSugg5St8RtFX5LBLcgY0qdC/BFna82n/a9hjV7YIB/V3kKOUOX
 mpTIDU1kw3VlmMvQvx9tk0e3KgAOkb5LxYHhHKtB3wfHxmdrGDLnzaMLilt+R7liU5LvAylVzF4
 26n7JbQVd4OPhs4Ac3Ze7mRUSZ91Cgi139zuyeQm8a+O1TjJLsQoatDVrRb1AKTGeES1pnKz8+H
 FydzfDgQdLIOiNlCdJPHoCrmQE7yCcM5ceup7eonMHEkdZ80viAMSNFdNO0gD0UKK6YKALuJDbL QmtPHJSK6N1c2dw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qzqI4gZPNgp4gW2_3HV4THHjStJinguZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEyNiBTYWx0ZWRfXwpZD03+hzb3o
 +JZ5ORd0zZd1FaSXpEWVCneGjKv2MYMq5yoaHGKSxV003az8apkVSMZ0W8uaTCGtI5zHeDe4w/q
 myzNhddSf+N4/xkwQqaw3DPpb+ASbh2rh54tognEpGJt5/FmOFOnFNjE6pXcZSSMNAKVIMN4kvR
 aXAlhePi7hirV368p1X1sFg8z4FrPeDGhBJt+AL+1u3Zh10caTfzS4xzAbS/p/bvPT7R2WQ7/RJ
 SWNeWeOrFcprSfVN71YUx1W2meImBYQ3opD4uzbA3IbLjRbOxyG4Zz6bDBV/e0Xc8FAM0SSQ3uK
 TVrw9omNRU0C6Z5L7Q9VTMrMzf9Pieq4JFEx11V4X3aoUMaf6fvGGHI8Hn9i+Jrg9z+a0F+jlYO
 L1gyXYd6WktZ3uhVWWRGxoEKmeuU+NDgQGmCT/2nOwgPdDm52QCF8wOOepu6Pv+bWuhxkEkgl4k
 uVJaO6QGgPso695+0ug==
X-Authority-Analysis: v=2.4 cv=RKK+3oi+ c=1 sm=1 tr=0 ts=695bcae0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6c6E2J2u3FmSKLr74-YA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: qzqI4gZPNgp4gW2_3HV4THHjStJinguZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050126

Use scoped for-each loop when iterating over device nodes and switch to
iterating already over available nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Use for_each_available_child_of_node_scoped (Jonathan)
---
 drivers/ata/ahci_dwc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index aec6d793f51a..64abf865bb67 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -260,7 +260,6 @@ static void ahci_dwc_init_timer(struct ahci_host_priv *hpriv)
 static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 {
 	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
-	struct device_node *child;
 	void __iomem *port_mmio;
 	u32 port, dmacr, ts;
 
@@ -271,14 +270,9 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 	 * the HBA global reset so we can freely initialize it once until the
 	 * next system reset.
 	 */
-	for_each_child_of_node(dpriv->pdev->dev.of_node, child) {
-		if (!of_device_is_available(child))
-			continue;
-
-		if (of_property_read_u32(child, "reg", &port)) {
-			of_node_put(child);
+	for_each_available_child_of_node_scoped(dpriv->pdev->dev.of_node, child) {
+		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
-		}
 
 		port_mmio = __ahci_port_base(hpriv, port);
 		dmacr = readl(port_mmio + AHCI_DWC_PORT_DMACR);
-- 
2.51.0

