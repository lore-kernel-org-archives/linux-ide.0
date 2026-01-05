Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491932D42B
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623396; cv=none; b=XG5uLYL1drbITEW10O7nXfGrGfc2nETMmlczBh1sYa9AOOg1d04u5EB6uZLgYcU6AWsjNQ5JXunswsjdOFQqUgXWSi5PzZHePU/g2VdgAn+LZ0Pi+62ch6cupoEJs6mbhwLJ5Pv96aiy4upEjpLRUoNDDGEw2jwY9KjCbuaIFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623396; c=relaxed/simple;
	bh=igGwUDv1bS4lVKcInMKEA1lV50w6SfWm+opQfVdJj6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+zMia+d80oKCC+1PvfCxjd6smzKeSq/Bk6Ei45sVyD69O7bpspAS+aL7m06qFgWEZ8t7Fn+M+osE45wH/jmcm4mljP+w6EH1nh2JCBf1oy/Vv554ZmoBg8xIxrbDUF/eKHC+xMEpj0C8KMd6+wzjbusZu3SW3bCRKZN8tWg1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8yY+Wpy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NhnHE/fT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8yY+Wpy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NhnHE/fT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058w4Zn593833
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2026 14:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B+99F91Qj0T
	X3qTYWzoTO67a6JxAHBWElgL+XwJORR4=; b=m8yY+WpycxOtEjAzLXeUicoLl+5
	sc2sKlS3xbw7WQvi3RM4b5pw5+cXtq6GqVLAZ/qI9ua38zFcjMt7778pQUiTUu6A
	rn7vd2/KwCFxk2pqQth8C081jbdRd/u8N8Koopr25HTWbliddxHPiVCX1AqDH9aw
	dSuE/1sImszUAXSmsZ8PuBcwcYl6CZVcgL9RFp29xQoA+1r5vL0mJOrMD+t8CCc6
	7jHTKreGIYW4+xn8LU02HDdby41E4UOEy1y3REvVxfROLNyfSz9nZRmPsFIChhYI
	VqFtNw0Nm/bemDIgYOjpS7+kic8HGce8GxDCq+sCzEZl3cpnSjq50cwskQQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bga8pgu7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 14:29:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee16731ceaso285713351cf.2
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767623393; x=1768228193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+99F91Qj0TX3qTYWzoTO67a6JxAHBWElgL+XwJORR4=;
        b=NhnHE/fTNAyRbJEOx74fzK84bqAp7Z8FIwE+OEhqXZWj5HJym5V2tc0/aAvM+vRNCi
         fv8PEpMM9x7dQBYcVQ5Ai4sJVmDd+0L7braVmNFAiltg5pnkiu+FcCmTaMLpKE0e/9Az
         mzAPjfIeIlODUoJJJ6yeym6am6hiaBzzdFB7qCwT3+BcZpKNSz+AokoRfUFND+tQmpRu
         QsI087Hof9ATZxk9WgaJz4rKLOlXBXjjINPSgIKL3ty3yrFfOT6m1Cv/axXfoPm6iMtl
         qafAyv2xYrdL885OL9vbmsXW0XHaSZRO0lvH7xV9SLtB7OZYaJ7NIRMo5G1b36hQbFkX
         N/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623393; x=1768228193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+99F91Qj0TX3qTYWzoTO67a6JxAHBWElgL+XwJORR4=;
        b=v1WgwB2JxyRQKHg5447ES9zzsyB0ldf7nakxQgxdHdNy8oZqhmEP38Hd7Z7P+y9mgr
         nqCe5lRCYhPrsl0v661BfvXoo9NF2uQ5bRp+8HFdudQ9wGBVx0B1+Ekc1IRpuOFh+kVZ
         iHsTH4gorWdJyoA4SIkvir0zvKt8n2Gr8AimAwMz0KNU5H2GngRtvmOaqRaEb7gaDsrW
         9n1l+0T+DBxEYH90x4Ddy/Bj3f9toWs8tAiSYFMIVrTkDY0b+raERqBleJ5jxlYox+gT
         gi5txRIiWcCYSZFFGaa1hSCBMCOGM2SmVTsxTmg087j7SmUUVxKv9+IH/SUuKtA0LHXG
         OUzw==
X-Forwarded-Encrypted: i=1; AJvYcCX3mwXZfhccve0jC28zkbpkTDGAZeR+RJ0R7+PjQXxt2OWc28tfMYVlzPDGxvlAeE6K41LenO/C4eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZXRWygPZ8Vc4+0GZD65BRJVv9SKmXRKfCTbRNJVwa/ERP1kj
	cSqjEJEPqb7HOKvypWlsEgq0Vq/3v0WaYaaehHIPCQ6Xkuv+6/2QJVbd+mjxiVHvXjD9gM+Cs6g
	ldhsbwq798bkMiWGAu4iJCYPjhRtP8FA6B0JKeUJ2vrZKnqIqaxLOQ41uZMMjgm0=
X-Gm-Gg: AY/fxX7bP20pgJnyUQFljfPXWV4K9SmJPFiSR0AGS93/IrgzPSVJtkA6z/y8i/jNT8d
	BRSdfs8MQDzBfk0i+Ut81oYvIeMOVwLLRUlP3qDk+lYaPF1t6U4yAmuVvlfk5R4lefVrRoGoxaD
	6unT66pjgiAhSzNdDBcZVkMz8vTRKTYea7TlNIowbSknUbXD2gaH5c1WOxJiG4jl8TCMkzP7bfk
	Nuw1AEYLAH8nUnzZWxcz9M0bH9jUtrjAuj9aVMsRhd30SX05lPBkqbdF1Uz5ejZhHOgzfoGj+Pj
	bYFxLHOcJVrtMrwlhw2jIv9/Fu08JIF+parzUK0hvNdROHlghCWoXqXMPMz7D5EW5eUHsReF964
	ymJ7VZbSPpewJAzgHJtIMf4r94Q==
X-Received: by 2002:a05:622a:244a:b0:4f1:dfc8:50b with SMTP id d75a77b69052e-4f4abdb50afmr667718891cf.76.1767623393001;
        Mon, 05 Jan 2026 06:29:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEORDjsF0OtFq4UzheK0/5nT/1wsbM+CjFxawrMfjytQ6gQ76FQSUL3wyIGAbS4VwKg1VqJjg==
X-Received: by 2002:a05:622a:244a:b0:4f1:dfc8:50b with SMTP id d75a77b69052e-4f4abdb50afmr667718361cf.76.1767623392402;
        Mon, 05 Jan 2026 06:29:52 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842673b560sm2074066b.33.2026.01.05.06.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:29:51 -0800 (PST)
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
Subject: [PATCH v2 2/3] ata: ahci-imx: Fix Wvoid-pointer-to-enum-cast warning
Date: Mon,  5 Jan 2026 15:29:46 +0100
Message-ID: <20260105142944.372959-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260105142944.372959-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=igGwUDv1bS4lVKcInMKEA1lV50w6SfWm+opQfVdJj6Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW8rZVXDPJgsYrTfHciVsBIMXX2UdTXHPtsLNN
 MmkwkCUArqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVvK2QAKCRDBN2bmhouD
 1wD8D/9NmxkL4Xop/DcQWS+5stEAs8WFB656Cro4p04q4X8LYO9O8nlEWN3Q9Snf8b58CCb2yUG
 Iz+rH3+cAduDNZM41e/E2POIy+JRQcX2O53Sdj8iKEUkoH7t1ARwpA07J/nn2bmJI/01BifNJ4j
 inwbtVzap2lLz0NQ5uf6QNOKbqv3m+bQZzG/TX0VVU8SSydwn2740zNfIBjPS05mVQ1v6x6l5wy
 4xhjqGC06/S+JAmKyEjNenqOqqrSVwhEkhhJ7XgAQkEkvdE7C/o73ebFMDYkGbzMM7olZCeMuKA
 klVgoTgOzWOFlPkKvNoaBWIGVcTGBq1ThK2yd0mABs5nu8z0JQ7hj6b5BJRelq+c4+mT1Mu7Yjn
 zkhsVpxh0fBvtUdbBmmV+xbtflXn++B2GOJXov4fWxloYIwLWVOCOwaekrOLPBrwf50F3092L7J
 iD9Am90/5NbN7/ls2wUj6SbxLpXqoJkNcSO77bET2gH/fI6MevyoFZQmz/NrpdwFYjGy/mEqqGD
 /qkpdr1pkAG9G38copu1IIcX5cnPLpyxB14sI4XMNWica01BRrw02W4slTu5deabnZwej9Yoiti
 Iz7x1QZyJTlJRvSrk3jXdwAzI6MqG8f/voVfvLDLLzsUPwNB6gMhoLp2Uucz1uyMVu88bR4178G mDohUcKyY0GpBBw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEyNiBTYWx0ZWRfX/pveuxUx1aXj
 O3T9LZGYQI3zEvA2JXUtq1oKLAreKHeJHAe5Y1a7+TVrQmPgEs/76waN31lW9OEtHHLe5EBxDfJ
 KzuelZDk1KDhablayg5xrbL0sUm5hpoU/3j0yuVaU3FiSGm+RQYMK810aAMm8laGoVWwoL1lH6g
 fdRejFVJVA1XMVInTA4YIiQOaKIgjabtWEZ/d9YsGkAg3XzUcc7R/3FsEU4OLEk48bJt0q6iv+I
 wnKiYeDMVKd/Q10T/R96j0iiO1MVJhBccPoIpOkpe3n5DVMGOnuv3B8hYn0be+xrqBeJMzikFuO
 s7VMZ1asZdMSdksqgbTN4iOeWb1UXslIxVmgznxK30lrd4bo4MXmOgKHESafrEcHAzBp0p/uGvM
 sMLIcxtUXjDp/GfAdfspjr6u8UzisiuDp9xrKcSG6SygDe4lf5QDn5bd3AiXiYjcvuhDBrOdgzE
 GdfYwbkQR7PXwbEvj4g==
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=695bcae1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7zQf0MV6msiRB6oW4MAA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 5ls7AAXYZ9D82Lypzg9uOpRlZgZgUUpw
X-Proofpoint-GUID: 5ls7AAXYZ9D82Lypzg9uOpRlZgZgUUpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050126

"imxpriv->type" is an enum, thus cast of pointer on 64-bit compile test
with clang W=1 causes:

  ahci_imx.c:872:18: error: cast to smaller integer type 'enum ahci_imx_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. None
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

