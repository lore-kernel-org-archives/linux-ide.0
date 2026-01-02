Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34DC321F3E
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358251; cv=none; b=rPobgqRVk5Z0rksHlr9Quy9Q9rDv6IAcQ0Dd/pkzEOCk9Eiaxw2W3W9IxVKE8O7rBO1EQyHmCXG9JGlPtU4a+7QH7p0V7NIkBqAFHztqSy49ul9ZZiE+h2WDch1AAqmlesn4owetQApr9vTtGWt94Ynz1FG9/f9iPGjMksklNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358251; c=relaxed/simple;
	bh=VqwBxy8XYcU5QNpyDWii4kc8lsFQn+uB7jr4u0TFrb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2wGKVAa/SNtwZ/rUn7vAWrppoQvQ1MY+umElRCutwbkeP7aStwJ99VYsyvUNXV2fj2YdD3NX95BdYJH/EZT2vyvv8F6Ctnohak/ckKLv+icrymJSUl+AXoU0SISl7u9mMOTfQnpq1kPy9FhdLfjFpoymwajOoDK1jLwxlEEuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+FcXJaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WA4ig9SN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+FcXJaR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WA4ig9SN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029Wc2i824910
	for <linux-ide@vger.kernel.org>; Fri, 2 Jan 2026 12:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eNQ3dB0qjMdF3sPcFxLBfd7x75qLiik9Ihq
	QvOvA0YY=; b=i+FcXJaRoiSiRNNGV86Khuqm1BEf9vijAMGsTzZh9iW+xEzsWbO
	s9JCY4QxCOA4Vkowmt/cFMUkV+gVFJAxmpNFxFXJcO6852p9cfywX4cnvQUWY6mp
	NRW+0+DIuPXjTp93yAovMGEL96LAHL87q3y/V92SDIVxzbJMss3JHRJvHJ+Zzt7M
	GFUZIQqjsR9FrNhZOH3eCbjhB8KjmdH8lvgIZk3bkt0fUSurAdj32r2JVz5volno
	3TI8WFUQJRCfwkDzq3G12JTnVAx9o2UDhyNnx/6zguRhu0mJS87IkhWzgk5TC4SU
	44R4jzu4qEZ2ILc+/tC/D2bHTyqOG+uiw6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd8533c1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2026 12:50:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d60f037bso269347271cf.0
        for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2026 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358246; x=1767963046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNQ3dB0qjMdF3sPcFxLBfd7x75qLiik9IhqQvOvA0YY=;
        b=WA4ig9SN6EWsO/u8oVXj6OLwGZ+0SnwBdsTPBtJQDhUTUpuhD5Zo9j4k3fhXBwEREG
         0bJnGp6ViaPcvW3Dud/TQgLbsZOHoS2ouOoyrMGZDjph/OuRtpjY1gHk+KrWGJodlAD9
         Jdjl0Fm5+hj/TODOxa3ADlbJVhCqfrt/IFLYf37mqAXvnDBNrKeW+8dmaEuVZBYoicpY
         ePOHtJ0Ri6NnCnB0cHF1q9MJUKCEdyb+lU7S2c08JNIsQrW60Itmg7zsobVzQEuPTET7
         EGZx1zgM2/LLErwdkNLl2F3jppBg2C765z73NksH72N7X4VLdZoZb0isPSdFYQwMlPMY
         qj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358246; x=1767963046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNQ3dB0qjMdF3sPcFxLBfd7x75qLiik9IhqQvOvA0YY=;
        b=xBYoMfadE1dPDG7XFJi/R86ijgMNoStjOoYvcfFKdsacJbEnpb4fQwQ3PjRmQOGKhz
         Ej5SfkOO+aE96yOQNSHIyZl92RzOGT7S63D+OnMycWVaepuh3PSJwplPiZjQcSvkO8V0
         dn4Lo/bkyWip/1Pm8+eG26S/CXil8bsJnsMaL1U8OvF6WPMfRVuwEoI1OVDMREB4sA80
         4uDwpjWhoFofl9XhWxBmvQXqT5s4a61vpzJm3ATl5/3MSZT/ffwU68CqVYMfbwk/LqH8
         4iyxr/6iE5YQzQUdmvKzTlLNdarQclR1+FSiOXk/uPXlyJuNhysYOOuRs0B7uleONBZD
         zvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOeIQ9kGi7EIWUXUtXpSaycRjVfQ0SQJb8Ul/73p0JWTLqLqA02h+Ti4NKMIilH9yGnTGsuBxqm+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+LwQ6s1CG3u9oaBIEDloP/B4umjSrAVhtAfzK0JDa962Kg75
	sXdsa4sou4xbX1UOTdQckvMd6PLQq2PUCcgUWKIdCNr5r4n3N/1gBb7LrsGJMGAOk+Cn7Ne2wgl
	nlmUnYZLOmTb3cGvQImxQ58OhdF7uNYU4eQGDlWDE3mr7BEPXp07iLNt701whcww=
X-Gm-Gg: AY/fxX4GWepFAmqEumuemg6vbupQY+NtyaFyXWvO9knl+aixXi4j1MxjZZ8I8yvpz8E
	K6B9KvKpWyD+hJouDk6q8AJy0tIymUKoCRJhqrRXiNfpgUcGuYInWR1xnB9gZk7QesIHl9cecmX
	JpD135sFdjHY+uqitIgFYlf/A1C7maUnT11Mk8N8eR1MizPFtktI5UOMwMVYhkTTem4a232Q2rq
	g07JAWmhBvdw/N4Z0YJw06AqXHn2a416jYJsuJXuVF9qFB0cHqAZ7ulu4jueryRRinDZcn69ofQ
	BU4WnW0FhxnG+y+3YZNLgFtdbcnOB9o6Rev+C6soE2ouqjqQxaX/b9O0ZfbXnw2wu/e1jBW5Qod
	fd3hhpD5zpRHgwyD6K5PJkiJTBA==
X-Received: by 2002:a05:622a:312:b0:4e8:aee7:c55a with SMTP id d75a77b69052e-4f4abd02696mr589485651cf.26.1767358246468;
        Fri, 02 Jan 2026 04:50:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/YCPL0+UNOHn9nZVMaYS8i6WyQ4Wfeniq2uQe1ZvEyhVOJTJwFUgj3aklQn1hgwDpKla7Bg==
X-Received: by 2002:a05:622a:312:b0:4e8:aee7:c55a with SMTP id d75a77b69052e-4f4abd02696mr589485441cf.26.1767358246063;
        Fri, 02 Jan 2026 04:50:46 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm84491369f8f.7.2026.01.02.04.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:50:45 -0800 (PST)
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
Subject: [PATCH 1/3] ata: ahci-dwc: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:50:41 +0100
Message-ID: <20260102125040.65256-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=VqwBxy8XYcU5QNpyDWii4kc8lsFQn+uB7jr4u0TFrb0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV78gkLRi/ij6HD+pORAra8irvuUDfnaiYR8he
 QSPIHHh1yOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe/IAAKCRDBN2bmhouD
 1zh1D/4jn2PFeyojebR9apQNrt0zOd38aGoQnQmhw+d60/iPQ7SsnfwDvpdHHYesOAvjS6nKSTF
 bwee5ROqrJxWj6OGKTA4bXX287VEFogf9JyAtejUrefW4NcpiRx47yhAMAGrABcdvoZ3Pu+RoNs
 nJVd59fqABzCpnJ62EOgzL+oX53+ejsxt/bzKBKcH9LUapbh21+ZNuFMc/MUSxU6npQCNyQHYD6
 vRAQjck2ol0e0ZZkEqHd07mFJmoHDp32+MMiIl0zdLx2N4+/NRLrsobUSDFa6NE9fv9pGL3qG2S
 0Stn30U3Lnv+Pe0fSSRw8C2qv1s8rbQXhdjycztw24EYv/ZGGcBbeDzqIqG80IIOEZbGSQ5RWJk
 RkArRTFQ5Qy2+TW452GwDnpx7vKofpmxYZPYGdlFXS3fWIPmz1xfQojd+bS54iQneC6Hnj+ANuR
 6/yB68IB0jiMd+WQayC2VxySQeMUtUxdDDgiJnp4PlGmp6MXNs23ZnxaaU6rfwv856zPT62rNyl
 oZNh8fWpanng2WdHj4r9FJ4t9+smikxfVxLWEGdhXZhvNZCEQaNlfAMhrh5i3PNbm+r55hn1mBJ
 btjRk75NXo/7g3HWMir8wllZsipsg02MFIertSaDH3TCC27v4zYOQ4ZqAKO1vgsKuyGvc1xYOdS 7VILipyVJ3AFWtg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iTtKB3mcmBsHa3jw6Tufd9lb0N9eaT4y
X-Authority-Analysis: v=2.4 cv=fL80HJae c=1 sm=1 tr=0 ts=6957bf27 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sw2bo_H_5zbN9pJnse8A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: iTtKB3mcmBsHa3jw6Tufd9lb0N9eaT4y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExNCBTYWx0ZWRfX7aSzHWRXE2XH
 Q2Vq3ol5zv7UnJ2h7j/XG7xFrrhbaAzdPm4FGyqkyG7OigpF+5rmr2A6KVkS40bSUnU8j/cdtNc
 2i06d1GQU1fLjaUrX9ZEPcVLywxwWMhsixOEDbO8TbJB/IBHfXop0ALkoSzkAFHUjo04le6RQLb
 Xob/uE+01Btb5hB2GBvfSb2IXQ2JMe/4pszClyHuViwdPcWop+dsckBnHEsWvQSair0LbtIshRj
 j9W0mgAynGWL8xKVv8OhMTQ0Y4SuvIgaCjnzZn3sjNtcVbPXJztCNyJmqvIl9AQ299KYnkyRFoF
 BvIRFs1CC5U9CJVheidSeyxQDAMiNAF7iD7rsKfbq1ZeluX0Gp9kL6B0sRcv7iOZb79ult15VMb
 3BtkhvvjCA1x8P7Zu/WkUlZ7OtV+tRvRK+24OoKTfivAAoz4AiKw8j/EqDy8Q6BX8iLEYGOatuw
 M1S/pBIU2a5UrjOJopg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020114

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/ata/ahci_dwc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index aec6d793f51a..bfd24772ee67 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -260,7 +260,6 @@ static void ahci_dwc_init_timer(struct ahci_host_priv *hpriv)
 static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 {
 	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
-	struct device_node *child;
 	void __iomem *port_mmio;
 	u32 port, dmacr, ts;
 
@@ -271,14 +270,12 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 	 * the HBA global reset so we can freely initialize it once until the
 	 * next system reset.
 	 */
-	for_each_child_of_node(dpriv->pdev->dev.of_node, child) {
+	for_each_child_of_node_scoped(dpriv->pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
 			continue;
 
-		if (of_property_read_u32(child, "reg", &port)) {
-			of_node_put(child);
+		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
-		}
 
 		port_mmio = __ahci_port_base(hpriv, port);
 		dmacr = readl(port_mmio + AHCI_DWC_PORT_DMACR);
-- 
2.51.0

