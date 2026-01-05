Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5858632B
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618337; cv=none; b=OXQBOF52V3L1iphOhcys8LNG5aMxZ+Ker16jOFFBTlXwcp7wDjktp+H4yRY4JupK+tE7k8X/DJUhMaGZzMkr+pMmHCWnk2o9zhUWqb54sUqJQi6nwjks4emmwb1rGyvYIQdQQ+igJlk1+owEEFjc+Y3KP91D4pDkJ0Q2BDpCDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618337; c=relaxed/simple;
	bh=OF0Z1w79CszBb+IjEfCZrCDLofdNtVZCjsmtoUszWeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKBPszh6a5K06NaVwohGTtHcO2lTZnxpDC1BfzRB/YhnCygP2TOy5fJdkkqZaT8tR2PAmVH2Lc/F4PhvwvLlAHuz3OCDIQRe1gCqlnpwHGBvLNwI+3VNZMgdRB2NOMoiCKwInVS8XrmbYE+ZHnWZXkmeHOhwutMBHjrMUx3oQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XVcSIxQ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eikMsCjR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XVcSIxQ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eikMsCjR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6059ckIm610322
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2026 13:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hi6xppA6IiF1VNFScxIPOX30v2qDntTfWCoxxMRGpNU=; b=XVcSIxQ630saEHyY
	0+qROzW3IL6wweWH0uTYosnIxlp9wfXX+ETURG4i2seE8sc8nShqbUzNWsjXLdYE
	sjC8/sbIzpYBYRdPJrnTP/mYF/0Lw47XS1hdXqdyreICqTaehkgmMOVeQhI2Dyfp
	qaWwLoBSWTUVzx/bLYuCgXQiijZk0h3J7ETcdkWjQJroqZaWbv6jqUSBHEGR8dRQ
	UYcWhwCrRrpwZBkMDUkJpKTDTQMSmK205q5BYmXzROsvUQX8qoKqKOEbUCovjAKw
	1pL9Vlezcr5FGJ3ooJ5Mjf265siq3YiD0sDGJaDQeB9Iux/UYUTWUz4JKubN6ixQ
	Z5tGWw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgaus0g2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 13:05:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so313907221cf.2
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2026 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767618334; x=1768223134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi6xppA6IiF1VNFScxIPOX30v2qDntTfWCoxxMRGpNU=;
        b=eikMsCjRW1CunIOonYnd+cffpn0/fV+dlNFLBme9PDMkxYB0er6Rmiq3KTK3KObsoP
         AKuNV7lMUCHP3JMyxm7LdBBlvtu5psThVZW1vD2DfJ7xfmq+OO8VWsiQJ0rfbamOmwsE
         H3Z6fklGAEPD6/M45VoaQTrj4Nd5HQ6OSmqXiYcuaPUifARYIlyfhKPmyZaE9mRBm4q6
         0KK5mwEenXdMOV3dkjMWLKdmiLu8cnmSrq7CPYbvl9M7Vc9GNny8LUbpbZEHvvRHl9N8
         FY7/M/pMShiif/uEHJmt+m2ja9VF9TUu+IQGB5XfzeH5+76VOYXl6nHxX5jXi2LeZ+3+
         wkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767618334; x=1768223134;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi6xppA6IiF1VNFScxIPOX30v2qDntTfWCoxxMRGpNU=;
        b=JlZptA743wXjP6sZhKh6qBXDQhvcYU0ROnPXzhcSl+Mhib7k6WULYAcz3941xBqGpn
         3VxvHrlLyl7N0//5NLoF3Tl1jN372epfFZqby84mqQRDFs56RXDo/Q5xlIy/lEXLadz3
         2qOdbQJ6RIwTnL+gqLkk59yMZhPkFqDqxqWFCQKQbHi2l9E2l2DXAaJ6ZIkJMGHfCXsQ
         maFndzw6HupabdqJvkMFp1q4GTMVR4csJRhgDkG931aEbtx9DoQdNT9KD9qEKml3GDn3
         E5S5GK6ZtcQ+BWDPXt1yf1VR+2tEtnMkbByCp882rpEqJpno7NVTMqgz78Zyo3AnQ7kx
         ozBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVyNkT5vntjaq0s64gDNqJAWrYI54+DTSHc8nJSRuiX6eUo5QERfjo/KqGr88UKzh9JlH8uXdtcBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCybbBaMQE+vsqMy5fPMvALpi9CnNAjwTmEqlLqx954J0J/yr
	MX0KDAAPIs88g7l1dBtqb4twO7ymzgtrLiKs9ySEPkQULM/iwoRtP7+DFAE0KKHXK2pactnGAco
	k0zm5L6hqiSwnCR0Xi6T17jQvI/OYqbZ69LP4JjSAvgB3QOUsVQrU7VKbyGDC7o4=
X-Gm-Gg: AY/fxX4Acxhuoy0e4gInbZR08r2ru11swkvaQwzk6tc8C4Um6Bj5IYl83ShJq6ixYwp
	/jYDsqFomMf+KsTs1t1vZKp4Op6xArfmdPZimujkyoakfSV+35VVToR77Md6utZ0SGDMdJXW9x3
	rOKEOl3Izbi8a2+KIxJx7GaGIl96GEdWslaf1wmx6u+AlGWIXyuSatUxOb6+vmBTi3XrtSCX7/r
	JIcD4h/XZKNjx+KbG8+zJ6xu/Nf1DhvWzSMPE82rTJj5jb9BulcQG+3TpA6aN7wiXhYKYumb8kH
	L4WJZdTthwL6peit5aXodGyucV4AGFcYuvc9TOwkWfnWCwh+tYliwEIhZhQwSdZ2vuvEEP5CkEe
	FvSR4h2E1ggRkE6FnFEgbwZWH1O5Qd2s5T8QX8w==
X-Received: by 2002:a05:622a:1248:b0:4ec:ef62:8c81 with SMTP id d75a77b69052e-4f4abd8c6bdmr618704121cf.47.1767618333726;
        Mon, 05 Jan 2026 05:05:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfJ35pQicqQxvlPnXhffYEueekmedaX9gRCfm9VbqtSrduD7dk8BlkO3qiI9eX3HsabS60XA==
X-Received: by 2002:a05:622a:1248:b0:4ec:ef62:8c81 with SMTP id d75a77b69052e-4f4abd8c6bdmr618703671cf.47.1767618333337;
        Mon, 05 Jan 2026 05:05:33 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be7773dsm58741995e9.8.2026.01.05.05.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 05:05:32 -0800 (PST)
Message-ID: <3ca74ed7-fe54-4ddd-b0ab-5f9eb56e6a09@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 14:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: ahci-dwc: Simplify with scoped for each OF child
 loop
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
References: <20260102125040.65256-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260105105252.00003b5a@huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260105105252.00003b5a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YSsQ8x_RKfIjNEoocaD9CXMtnoEDcPeU
X-Authority-Analysis: v=2.4 cv=DP6CIiNb c=1 sm=1 tr=0 ts=695bb71e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NwBXXhG94a3s30lnhPQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: YSsQ8x_RKfIjNEoocaD9CXMtnoEDcPeU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExNSBTYWx0ZWRfX+gpp7ztu1aL2
 gcUqRXv8spZSo0ilvoniZ+U5r3IwxFf+3vMiVgvFuKg6UqB3YNeTQcdmDp4dC8bIk41DAy8qb74
 LCqWPdIVILhM6PK375iYQJBzTC7nWser4okWFHn2yawgR+PTN2xP8ps/n7T1zT4u8+KSca9xRL8
 hL4wXlR06TFLFzYMsX0yysVuolFPcg4t6Kaoale6oWwF3ZqEzamkPgofrc3JIMdwhzamWTNIRb5
 iWjluNG1WA7o0H49Kmxx5//2ZaSACloeA8jMwHHUiulweM55ZSyMUUor9CR/dX/aImgiq8X5OAL
 5MI4BrrJhJaayeV9e4EvWphgL2TQj7rspeERW5zgChhlVEON/1XBPoQ+iJyiUShC3thNkRAdXov
 v3WW77jQtBJ2+bGWIH3h91yQzFJTmx0sGxsCVA4p+EMOsfrHtdpxRf79N0T/r73tJuuBh856kYV
 mM9E/hMMgU0xaGmNVEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050115

On 05/01/2026 11:52, Jonathan Cameron wrote:
> On Fri,  2 Jan 2026 13:50:41 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
>> Use scoped for-each loop when iterating over device nodes to make code a
>> bit simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> A whilst you are here suggestion inline to make it a bit simpler.
> 
>> ---
>>  drivers/ata/ahci_dwc.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
>> index aec6d793f51a..bfd24772ee67 100644
>> --- a/drivers/ata/ahci_dwc.c
>> +++ b/drivers/ata/ahci_dwc.c
>> @@ -260,7 +260,6 @@ static void ahci_dwc_init_timer(struct ahci_host_priv *hpriv)
>>  static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
>>  {
>>  	struct ahci_dwc_host_priv *dpriv = hpriv->plat_data;
>> -	struct device_node *child;
>>  	void __iomem *port_mmio;
>>  	u32 port, dmacr, ts;
>>  
>> @@ -271,14 +270,12 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
>>  	 * the HBA global reset so we can freely initialize it once until the
>>  	 * next system reset.
>>  	 */
>> -	for_each_child_of_node(dpriv->pdev->dev.of_node, child) {
>> +	for_each_child_of_node_scoped(dpriv->pdev->dev.of_node, child) {
>>  		if (!of_device_is_available(child))
> 
> for_each_available_child_of_node_scoped()?

Huh, indeed I did not notice it. Thanks!



Best regards,
Krzysztof
