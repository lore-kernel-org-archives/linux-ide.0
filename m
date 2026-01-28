Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0142DC77E
	for <linux-ide@vger.kernel.org>; Wed, 28 Jan 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614669; cv=none; b=Qdr2PQcu16wz2Cuqu/+sxZlOm8tlxgy3YJp+qcst6VMlGP6KAO9E0zj9+CofcRMfoQnHtSckg9v0jRpdsEo66N4Ypkpxkx+lZrbYF3gUv2ade4hw54r35RORH1/9fd/PDmb8AfnxZgy3J3i8sUjcGd34LqSjAQ0khnd86h/UvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614669; c=relaxed/simple;
	bh=ayAnJWhqvxVqxUb3jotL1noUt0bxhrC/p43Y0YGiw+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSepNirVGN+eMQIu574cOoH09xJTuy4ZetOKGPPfIzyqcsfc/NETEUQq3CXHJYF0pnMJF3RPnH41QmF/9+XGvXkA5d88iGt9Yu8CwlhTmzz2VsS+cA2wvCP3kIEbWFdR9rmZ+4oHX3wtTp27T5VhGOtZ18d1ue6p8OKmIfPbplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm1I/HQV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Utuq9YgC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm1I/HQV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Utuq9YgC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92cEY041993
	for <linux-ide@vger.kernel.org>; Wed, 28 Jan 2026 15:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=; b=pm1I/HQViuD+1Wjj
	US583gRwrpmFHWWZUcIpkChN3JuLgy4e4rdaGCl8H1E9Di0n0On1bdWymUzrfpcs
	35N2dDqOY9HsaBDt+2TH1gjCc6PMTx+LDNeZpGIVbc07qzgv2bpvuuPsxk5olQyD
	9Eyv9AV2rsSlzjBax/Ffr+Twv2ing1ML/DG67qqaWrVU3ynLoVEkjnbwdQB/TqHS
	9eH5ELKPhi7mp36OcuOvZsBJKW3pOO4sztt3cJ6ZeRGrw2qA7hOUXPNghzdeMpfK
	BsJWMUpUnKrFF+s6yBJ3LhSsiPbCTU+Yd1vk3rS1/oyHubMJDnojdLTsmNJVEDI4
	pgptqg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355unxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jan 2026 15:37:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f29ae883bso48169755ad.3
        for <linux-ide@vger.kernel.org>; Wed, 28 Jan 2026 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769614667; x=1770219467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=;
        b=Utuq9YgCF879zM/zcNoTsRxDRmX9ioUO6qfLUvNVJkk/5q4GgK8QQGbpEhX9xz/e28
         Uj4vSRXsycpHzKUX2LFMTiOuQKNGxp1MZY1b4sb153hf3c7z3azr6HzEIVsdz4QJ58OA
         vY42bGPf9moC9qljUmvB6QGj0x3XjuZeGIwHn/d1U4tLzGd+JLK54c2JjOujxx8meSZs
         6KJyqgBNwAs+c0b6aofftOwoq+kQjMgRAPyQIcBMYmgDZl7QwDP74nHBYAwAgWAXkxoa
         rjgBc53fAqrzR3zsDK/5mEkGlJCr2HRA9+rHqNmqxjbrQWsURghXw5NjEdN6o4NfpI/t
         pgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614667; x=1770219467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=;
        b=WepM7+UzYAc2IQ+dkatVUjrAQqRKIVg3jST9PAQy3vS94SsNMzgQG7VtIyiTH6oSJn
         gJpsiHaYb9aaKUppkNNymzP9GdRS1W3y6lIrDnB0WOfdcoA6P0MU9KAN2o8qTbWPAWd4
         IWeitKiM0GEVX+zHiKdv2WxGKAroMnEjWn8oJv/BUez/E0JEkXI+Mgwzfe9IIOf7NF1u
         7+yl4U87NwPzmD1P34HmNiXI/YX3g2hU8clV8veA/pMhMqPKFilXdKXYLal+FnOU/Fw/
         9CC69T67CsPS0WHLl5qV7A85jR5SLR/qluXtpmIcaLM94Oj4WA71LTlD6N1TI/MgPh5T
         bTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGhRpSs/KR3fLHhj2h/qltNf9//B1Vhyrhup5X+5+s3IltJ8dkSdKPk7s6J24NWZ7L98qnmM5EB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhMTEoE8Sps1p1WkInLEwQk8gOgfq2B/f+Qn8a06NzhwRPjOA
	g4M9KM7Vb2XFqSXn3LqICE+DtgN7DX9OPN8HgOGefSPB7Kzwm9yIpnwG/avaErbUmbghkskGfiY
	hMOQVCJTypjvuADCdJQewXVArj+EHlZpTS3iQOTo7k1LpYichh0lMbmU6KvpO+S0=
X-Gm-Gg: AZuq6aJ1vaemYkrkNZm/6uqCdW3b4mNsVhA3fqvRfqpcuF+CqOmVBUEb2UYQ+MBWWQK
	eKD6R1TfJuUNQnZsS9ZyWQ5ukmKbFgABfOHDwBtz0Zx4wu7iKnoM77segRZ6nWYA1jSQ+wREtfr
	agJWo6edfC+GcVXgaJVhBDQioCskiyQ+o3I+yoz1lTakL3Y8yJ2ZinyCGZEzwgU7eG9rAirfjXP
	pAHvCFpLxdqmVM88Y8c0YZHvjeK3PvmSDQCmbBrW1Y1HEb4kD+6ZGdT8PW9lVZkuvONoMg0g6I3
	g3opLwdmIseB7msmB1YC7bVn2rjGVAlB993dEmR8PRSrVhBnhF43gmUdwcsX6QTfD3+L91pAVHd
	xeoNFxW8gcjnMrGj2YvFSpArIM/kEd5SV1XA4DQ==
X-Received: by 2002:a17:903:183:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a870e1521cmr59413405ad.57.1769614666364;
        Wed, 28 Jan 2026 07:37:46 -0800 (PST)
X-Received: by 2002:a17:903:183:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a870e1521cmr59412945ad.57.1769614665732;
        Wed, 28 Jan 2026 07:37:45 -0800 (PST)
Received: from [192.168.1.102] ([120.60.55.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3ee98fsm26371725ad.9.2026.01.28.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:37:45 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 21:07:16 +0530
Subject: [PATCH v7 2/2] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-pci-m2-v7-2-9b3a5fe3d244@oss.qualcomm.com>
References: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
In-Reply-To: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ayAnJWhqvxVqxUb3jotL1noUt0bxhrC/p43Y0YGiw+k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpei01CRkwyRyAd55pohnc7Yxy6JiGTO0PVOqkm
 WPeunI7yGSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaXotNQAKCRBVnxHm/pHO
 9WDuCACcvTLvfMeR/n6MQQCFzYUGzhc5g0cX7wrTE95npc4sFrWjI0wQKvBG0GHgVWJiXlx9dsj
 677q6U/bW9rLCeZulg+DGSW32sg1kLyB68QpFoDAfEjwGFtDHdsJ2TP+v4fLmcfI1GtOYPwQOLM
 96Sj5bs8fyDEWXabaFadqIE/N2sXOkfxVxQxkxiRXovHCJ9BnqEd0kWC5xbZnnR09Ft9Nv6vxKy
 UpUaWQ876MCJXP6+q0e2tyDGPxMT2j3aJU5iQKiFi692tk6jO9IC85Z1qjg3BmCbYqxBL5V4kPO
 DH88TCj5/aoM/cwvGRPqWTQO5/PBzH1leSk9oTvlkaKnlWpC
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=697a2d4b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=F3mjE3T3/ow0zpRzCzjSvA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=0pvPJS888BSDkZzuOKoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: M9rHxNJuomUC-pa7UlPgSa2r4g-uyold
X-Proofpoint-GUID: M9rHxNJuomUC-pa7UlPgSa2r4g-uyold
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyOCBTYWx0ZWRfXxD+qD8PVRKAN
 HeDBf2guiPppkkbCoOvZSqGoJ69iPI1wUsrvrRXOK6are61gbxzCDvXfgU7QK5AQrKI56goiOMJ
 sOeReU8KPfRJQ7VuJhC4mNCCXuz/f7yriRLKqZOADXyXwW/L1ClOvyxW0p3m2pftajZdu13CCYL
 LS+mP1VxAoXtTEo5s6NSPDbFFvs4juW/VhBLQi4XCO461dvC0CVkmzfI9ewENBrxhul3RE+uKWr
 ixXvMv2fewgSFockqtwPnh0CX7mjvim/NhfyEzNdHoae1FKSsBY8o8hRwZ383QuuJlRrrjJr7In
 U68kuNHNjwZOREZHfgTn2Ii2fKIkFhbclYKoP+AGqhcwZvyPJcpfHTsjSJKakM+HL79y3hJN/1F
 epVudrmQYyniaxNJGN4YtPlJw97/gLJmitWtlvn9v7rFmQ25Zs5r2YQjI6LtYMUBuhIU7DVoiKC
 +1ZpDtFpyWSQtIJxAOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280128

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 1b91375738a0..6f7dea6746e0 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
@@ -295,10 +296,10 @@ static int pci_pwrctrl_create_device(struct device_node *np,
 
 	/*
 	 * Check whether the pwrctrl device really needs to be created or not.
-	 * This is decided based on at least one of the power supplies being
-	 * defined in the devicetree node of the device.
+	 * This is decided based on at least one of the power supplies defined
+	 * in the devicetree node of the device or the graph property.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
 		return 0;
 	}

-- 
2.51.0

