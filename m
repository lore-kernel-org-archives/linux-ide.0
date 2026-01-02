Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3427321F39
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358251; cv=none; b=Bvy9PB1Ol7FaQc4L1BQW0+7OW4dTVsF1Dc3FfhPf2l0C315GvGD2ANvHdxKhVZjuCyW+YjCm4c4G5WaPUNGrVnND2ceGa9CwosjHnKF9H0Vyfg8KE8JTmtdA1VPvdydxJycQ+0Kd4l1tTuBgcQH1wTh312r0x2zvUSxKuYym0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358251; c=relaxed/simple;
	bh=bF6I3Il5StjpcdVfuPvLmyNYtVe2Yc4DUSHgz9j7Kc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDNxDmjV+iUM0AjthNH+gitynmnFZF85j+ASqysIML3YzClaYEFKGMkNPb1RZr3sHqQ1L/gYeYt8EcgUe9lKAL+BDv/BWslCE3y3Ls/xP7F54BI0iFz1l6pDFEPgDFan3NLKaX7nLyWIIluOx5LWehonuj9CroiLUiAp4dYvhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lPsT48SG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G0AlO95O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lPsT48SG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G0AlO95O"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WFN0824618
	for <linux-ide@vger.kernel.org>; Fri, 2 Jan 2026 12:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nUcD6pb0PVl
	Z39xOW5NFx+GBSd4bs/4hPrMvTVDDLMY=; b=lPsT48SGumWSYeYLa9JC9HNNgaW
	4tkT81SK3bG69TQVI9+jNnhST4lXfdbVwlFdHUb9ydRTqO1slc/lN0m4mUthbYiX
	X24ImfTWNqtIvSRjMirxBxWYpEZZinjkjfQgCXWKjSbQywkm7/cBUCumCUl/qlF7
	yGEo3xTFPJfJ4cp3pdeo/u2cdg0G7calDrldsVxVLxZOAqavtr0xOzKM90zf0WFq
	nRXjLErqpX99Qlu4Iz9Af0LYEMIIkDZ/LTkNrv3NJL8eLRWzsPRTHdqmTBL2TaJz
	wGZkcO+DTSiAPOyeqwOw3V/GjttYjl1gIHUh0N6kW71A/wEgysrotduNvNQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd8533c21-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2026 12:50:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f183e4cc7bso232930571cf.0
        for <linux-ide@vger.kernel.org>; Fri, 02 Jan 2026 04:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358248; x=1767963048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUcD6pb0PVlZ39xOW5NFx+GBSd4bs/4hPrMvTVDDLMY=;
        b=G0AlO95OGyTKcUZl9D4YilUOk8RwEbLt7gAKlUEhnMswcwfeYfRa0KxQ4xo12TUYJu
         GftLJ0fK32DbFW1DqCzpquu1cgFbhrqyWHBuk25Q2pL/3pikI4vpnQJ3/WYcrFLCjipZ
         7bee9KnxqdSqkitkt3ENFFzfJuLoDzs83vZ/aRLecIA3cDQwg2QSMPYhCeF9WHZxMWjq
         AUfb5PM8nhVaGfYfbf00EvK4ipd24YCicP//PXaOYRLVfImmo3FL1A6CeIeepz6IjwyW
         FoBFmifpt8ykbQQMVjpR1qxbhbBEZQKQjdjgzgeyAklkFLD0Xvau5vd/9In25tGOjTf5
         1CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358248; x=1767963048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUcD6pb0PVlZ39xOW5NFx+GBSd4bs/4hPrMvTVDDLMY=;
        b=lT5gu8vUUpFbLje+iJw1a+yvu8pT8XRjPZP4j5fQcEEyHw4F/SDw205BmWOfqXwJoI
         pUEWyWHpg6zGy9d2agYgBOTnIBqRb+6/kMJGIpxtEWFOL/Cvc9pKRRKeaoz2GkKF3o2B
         tZkgTznsBW9febu962fyYRlIY6aXFsFZCS1OfxlK/N7oPHAqZ98ViVkAYgQzATKZquUp
         EqCALMNFoQCHLhNZ5YwHhb16NESD2e1Rt1NwDGZgGE37WySsrwRNNVIWgEiBR7OygRYp
         TjnYFILmcOJVyWpBEY2nHYFMPc8QgviZSW/SkNePLJWrndwPYn12K1JalPLBGn5LO4GK
         tlIw==
X-Forwarded-Encrypted: i=1; AJvYcCURmEyBgYwILHDVrTr2zgBOjk2E0AMloZkNUPqu+RG11jOFlhaQnBWSMyudCSPMptJg3QqkwN8f4JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVJj4/NcAalhhIHZCdfIN5yzGkCziqrqIP7PLyTHy8/gJhLGJ
	nfvI/wifsS68ijkelsH/OjIMNVAf5wDRjR+Uj70C3Gshv0uSpFvalzxengweSA4lBrxr4lvinDY
	1ysn11E9y6DkAhtRGlhey8ROCIiYBe4LalvT3l+Bx3v41SnNCEopCTP1xdi7K/D4=
X-Gm-Gg: AY/fxX6fSKewjRAJ/IjWTLTw6gRZd8GhQ5ZM+FY1STvge5kpcwMMDhEmXnYiZzQkPPA
	TWeLTJpCTWHJT9/dcv6n4PVnLYOWUVLs0NJmGc/9LYl6yGzc0/xRRwiYItJ2A3+FT2oVtyJhyaF
	FwUx/1mz3CTUNAkDrzWtPGgPxJPIL6eIQH970vwpaTtbEC0xGrXutrKSr5p4xBobRXJ2IeSMQrN
	DhiDQzsl9oTJLAcyXrXjTN8EaxZ9cSh7e/zXw2MuA3yRH4VBvZ0aWwdFI2ZWW/+7C2LTL92xrkL
	/hmqJQzu6vtUTBXHDNJ1tFYQh+YnsJUcBrONT9HNZZ9GgDE4YNukF2N2aZewNV6xdPZx+1S3SJU
	cCaa2wLQlH9ssI8ZC67JwwXOKkQ==
X-Received: by 2002:a05:622a:2b43:b0:4ee:15af:b938 with SMTP id d75a77b69052e-4f4abdb9888mr636639591cf.70.1767358248086;
        Fri, 02 Jan 2026 04:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgMLeHLiaApDhr4y+t46crL0OCq2r5fx6YzaQIeAPiktL/EPDH+eFPWsNm9PgPDb379iiEJg==
X-Received: by 2002:a05:622a:2b43:b0:4ee:15af:b938 with SMTP id d75a77b69052e-4f4abdb9888mr636639121cf.70.1767358247588;
        Fri, 02 Jan 2026 04:50:47 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm84491369f8f.7.2026.01.02.04.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:50:47 -0800 (PST)
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
Subject: [PATCH 2/3] ata: ahci-imx: Fix Wvoid-pointer-to-enum-cast warning
Date: Fri,  2 Jan 2026 13:50:42 +0100
Message-ID: <20260102125040.65256-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102125040.65256-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102125040.65256-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=bF6I3Il5StjpcdVfuPvLmyNYtVe2Yc4DUSHgz9j7Kc0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV78htTPTsLhXFjjjfDr74HmSdB3AHf42Z5Y8+
 c1TGemZXLWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe/IQAKCRDBN2bmhouD
 16n1D/4pE1qzGL1s8HEKW7GRJAes9KGNCUeOwpOsXUDMiez4dAEYFZhEy46nbNa5OMSgone+q9h
 yrZ8uiKuxnkXHDAOXKLpMWFByOe6oLQveIr/8nhyuDQcSDJtiYGXQARD8rrHNhyajEYXHoo0xNy
 2HhL6FHPA9t5cHJZ6yRFqlax3bogb/yaWfk3WAmZF8rZE/2lrSt2Prs9uuO7C8rq0wlnuqXu6Zb
 2/M0eJSJkkt9nv8BgLYYVRXnSFxzfeCIHh3wqRFRDYERcnTfh56xYZ+6n0J2iTPufvt/JNsjzR4
 DCjmaN0hnlgsVXaae5MZGbTql8qCwp957eS6EpUu1WIQ+HBXnR2dESKNPm3+olmAMTODlNLxG1T
 o9pttb+XTBJ+wQb25WVA++EKFElhU6qE6v7fxRqe2Jf+gxFuLdpHiSZQnmDx1euYkm7SYF9AtK1
 /VpX4wqa+NSmv9QNCaSrjxzqnUTfzIusIOOQolhuDOl/N1lMu4ZxzQ1vt0GNtAoCggXyb3LG672
 EGfA2BlognhlEtOIyR2VPms7t9G6jM+br3Ek4U2GB7qYdjCOxsI/WfV2BqfPG8lpo3dt++PpxiF
 yQsOyAwt6i/AACbE4f5wsRpGpIAawtWaqnfER33Y3I9gh2Cjx0TrYY/8H8Gpl1urFlgt8Z4eHET 7k3nYo5wutjTiVg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nJ8t36LnpaKomErbqcLV_EWrU1gVqHSp
X-Authority-Analysis: v=2.4 cv=fL80HJae c=1 sm=1 tr=0 ts=6957bf29 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7zQf0MV6msiRB6oW4MAA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: nJ8t36LnpaKomErbqcLV_EWrU1gVqHSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExNCBTYWx0ZWRfXwJrAgC8tLiOr
 qt8iyBhRbaWt7qHvhYxR3RNl5Vdiq6dWNFVNGZ9Z6Wno7HH1E2iF4KU3H1dF07RYm6akutjB71d
 9Hmu71TqSvnYStojqzw5Jr+neKDCcP1tOSPdQeOYFB5GSPJmKj0DIJQrb4kEj9spsGVi+G6LQXs
 5Leat4VJiDnit+Qgy+FbNkNIphtNATcFIghXrPdbZChxu2JO/Tj3Lgsh55bQaDlu94l6auPC/4s
 FEOAcMU0RhlvNSMKIyecG5/B9MoSyzuh0eZ+c5eSILKPTMx1K9DhMLTpbi2J32VdUdHQMlZflk6
 9N36KL5W6p2+kYpUOKPWukQluum7QMOQGqnxh2MjYyUkxPK9Oi7iig7JW09hnmOUgSAjbuQvxVl
 C6qm29xSWiyYpXl5QZ4OotDgbbhc0cWBPf3Lp7DWAtIXDq91cgwAt7e3US1TEz1SeNoNloIO3aY
 R2BHtkTNamGuh9+WHmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020114

"imxpriv->type" is an enum, thus cast of pointer on 64-bit compile test
with clang W=1 causes:

  ahci_imx.c:872:18: error: cast to smaller integer type 'enum ahci_imx_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 86aedd5923ac..3d26595524d3 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -869,7 +869,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	imxpriv->ahci_pdev = pdev;
 	imxpriv->no_device = false;
 	imxpriv->first_time = true;
-	imxpriv->type = (enum ahci_imx_type)device_get_match_data(dev);
+	imxpriv->type = (unsigned long)device_get_match_data(dev);
 
 	imxpriv->sata_clk = devm_clk_get(dev, "sata");
 	if (IS_ERR(imxpriv->sata_clk)) {
-- 
2.51.0

