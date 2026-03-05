Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A4366549
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701900; cv=none; b=Lfa/2oTGxSSdqfbsjKGtuuARANalRbeCdMK13dOhL8R7HWsXVtVS8NW/OJEb8n/OOBU6SRTJ5bD8QXJEBeNqV+zQypXn6O9GkWeN4U5eEof5ABH32+McMC9eF2/T0CA7450vaFmuk0iI7aNcDh7dYgF4Die2PEnizKe6+eI8Ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701900; c=relaxed/simple;
	bh=FD+sJlAHc/TYMCXoO9DaI4EA/KLKpeTcc4suUXKQBTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf+dvvwbylt37ZrnNoxJzmBACrpOdvF3UHV16K37M/MRfFccGTgV9zkNcqgrsJCMEJX+oVOn/pOaQXhjc5MdupO21RVjuYAAJSXUI08i07sx+SUZP7hNLkBlxU5opxa9JbYptmGBqagIFxZnbz9lq2BzYi6FDfMPdmPFd9UWPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0Hi5Pu+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xu+hSCZw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0Hi5Pu+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xu+hSCZw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6253AFO0865549
	for <linux-ide@vger.kernel.org>; Thu, 5 Mar 2026 09:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TypToE/9U/eP/4BcrjqQk96qrNbThgAgULngx0dU9VY=; b=W0Hi5Pu+/Kx9rub3
	1LuwoztTEiyin65jy0AFa9w9CeQosyQeKJh8uCqng/kW+AvyBzw620uEIw8ElxxS
	p7DgJXpyHxlQCgU7ZnXWh1fDC2kEZgsF+bNRtHfjWvvQQP20fzVlblnrbJN5YtJj
	cuXRnfwIw9A1WDVd75f5iR90V/hmIMXMAApDkJvz92wPoO8C6Cah4UDdFm28qxbm
	JkVKYxCSPSIeuDpcvHiSq5co1WnUKQ63+OjUFG3+cpPsRMO9kCFdRbA5AXYlIq+/
	D3NF4cr175vifDznzJXmfwFBgZlGYxgAmz/Vae9OYLQmqMJp28j53fTOD1MekVJb
	WfF0KQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq1pk139w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 09:11:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cb31bcdso579140385a.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772701897; x=1773306697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TypToE/9U/eP/4BcrjqQk96qrNbThgAgULngx0dU9VY=;
        b=Xu+hSCZwFjsWOYrN2/fJVUVV2JVinsq51AzuEJMbaRXQwTt+xPUsb938Ts2fQ3uU4K
         qQ17yWqnTAmVFVEoPgf4apBQSb257u64ZkhiIZ2/oUURYBex/De4jLKIVbC9CngaFiHR
         UIkEpF9QZyyWl7Vyeg6viBbHRNnECX4/zWgdK9kPtfXmqfHlJXMTb8RQumiUcyHSp+0m
         VuUg4mKpY9yFpWZ0Z7KadpHalk9ZjwKODOsPmHI0HmniU6ylTQMOlDGGDceCe+1LRbYB
         MoHt3X4lIHS556q0U6GcHI+UzFKMVsDVoEHUfiNjxXgMtGRiHZerrqgFeWB2w8pTKegg
         W9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772701897; x=1773306697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TypToE/9U/eP/4BcrjqQk96qrNbThgAgULngx0dU9VY=;
        b=FRpQGgInFZVarq1SZF7L3bKbLqFdcJohGl/F28i02jvV85oXOZNiIUhZXvEZwyNbfj
         TCv21ZMlZG3pzn4AQtef0Zp2MMIuy/UUoOG61iPOMBN53Yc31Eq7yne/NCBBfVnRAQy8
         KdhoyQhthuhKGolzwiwrH7KX68pS8gpfRiWc4SfX2K+Rb00F48IigaSDXvDgOash7ggv
         kjmx86xfqYkK3EIOcfVvts/h/uEKgh3zgrzEom8uhDRoDHQPZbUOXrz5E6PZFNZQhrpa
         6sBI1OOdaKiHQPIzuGVI0vF4zeNdG+DNRjYsDonhXYv9IG3n0HuDTl16Z8kCj8gua+fJ
         WKpw==
X-Forwarded-Encrypted: i=1; AJvYcCUFOoFIRaPjlY3wizDWu5Y1xuM3xOoHvFIsqowgkL1qMjwX4vqollPvbwjkNjUHXX2YEKsYqvc0xYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGqs9vaGiJxeAJ8K8ZGVUhK14X0h5qdYaT7hiPPo25gRxZkZ3
	zNVbMAX2+bW3hhQV9xrImjIMXtu6w7Swto+FSSxxfQp8M8XluHrQGFhL00AtOHNHdjmEExOKEKC
	yfEzSoHaustO6/k07UALtm+o9a83vRDPOzClxn0xhQiUW2pxnxCsoxK/NG8165ys=
X-Gm-Gg: ATEYQzzuwrJFhmC6kZoddUFsZb05pvQMrI42WxLoFMjthu592jk2PNnJ1ix8M57+nPj
	nH+HlG2MoH4rosDQLNR23xMl2qsb7IIM6pm2SuFeiVPWZ53IsyZuEz32qbBxrs+0/nX4Mg5scHY
	99YIqdHGfz+TPizagz88r5uL1PmoiN+oy5b3LoHuowBWWVQMxWIQZGoHS7KmmO19UMLaFGoTa8k
	evRiTt4TPXL6m1BcmdScExh6nstt1Q68vDz8Ng0DeljrUv+aP4uLD957RtVJmLYnPWT224ElnTF
	BQm6XrKyrJMAcdIb44XDBcb3rmzRSgdLIENESS7FQjQlDKYwcTKZ43qDYLkMP/BZz6OAem44uru
	IlR8RaFXhL9Kvrm+nHP2IuBfdjMR1UPZoy5qdgS2DW3jy8xfN8qfypt12cmGfAjy1R5a1fvDE1F
	+d3lw=
X-Received: by 2002:a05:620a:4156:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cd5afb0224mr487943785a.7.1772701897052;
        Thu, 05 Mar 2026 01:11:37 -0800 (PST)
X-Received: by 2002:a05:620a:4156:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cd5afb0224mr487942685a.7.1772701896576;
        Thu, 05 Mar 2026 01:11:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-660bf4d8249sm2589351a12.17.2026.03.05.01.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:11:35 -0800 (PST)
Message-ID: <ebee2fcf-9069-4a9f-ae72-86f4471cd4f3@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 10:11:32 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260305085148.7cwo3yflp7vcfldf@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5f_-FWM_F2U5qIfuphz7Xg-Z_AnlESHv
X-Authority-Analysis: v=2.4 cv=Gu9PO01C c=1 sm=1 tr=0 ts=69a948c9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UIR2zDuwlqQ-mzEo0xkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 5f_-FWM_F2U5qIfuphz7Xg-Z_AnlESHv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3MyBTYWx0ZWRfXx/oNDEVztopX
 X+brz36sRTRzvU1Ya+UkGn8TqoovaGJS5mC6nGJ/WrHa2aFboY2TZPwJt9+p8rMDMQIQa7kVG6I
 zA7MAl/nNR+Glu3nXftUn0RUeY3rObt8rv3IcMpQpMptoiftioqxRc3gGc20Q3QoQKgekwGBDhW
 knP/v4tFskrBYnijR1WTOGQARz1qeHIQONUVkQVB7Pwik/64WoZR3i4eOysYnq04j981DxvsOSF
 VKDRB7DA0Y9uL4+wdtYmyKGtGUo5xdlbXxV+ojawqWCWnG+r799vW9rCyxpUWG9uIcRyvcEt1pd
 8/gwhEcf/fhplrqVKtSMhR5QBTaa59xluMR+m+KnXMv0uptNQv4oLUiByDpaz+aZEks2HJLMsU6
 StfX5JQj96TrJZx7k3XSiowPJaiudnO+WX0bF7hGZcMZ1g+OhYnic56ZZaATCLIhxWmJAKIT8mY
 ZsC0sd8iTR+tG946Q5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050073

On 3/5/26 9:51 AM, Vladimir Oltean wrote:
> Hello Konrad,
> 
> On Thu, Mar 05, 2026 at 09:39:35AM +0100, Konrad Dybcio wrote:
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 55af015174a5..bdfa47d9c774 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10713,6 +10713,7 @@ F:    Documentation/devicetree/bindings/phy/
>>>  F:   drivers/phy/
>>>  F:   include/dt-bindings/phy/
>>>  F:   include/linux/phy/
>>> +K:   \b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h
>>
>> Would looking for the devm/of_phy_ prefix followed by an open parentheses
>> not suffice for the 'has function call' case, instead of listing all
>> currently present exported functions?
> 
> This would maybe work when you run ./scripts/get_maintainer.pl on a file.
> But I would like it to have good coverage on individual patches too. And
> since the devm/of_phy prefix only matches when you "get" the PHY, not
> "use" it, my fear is we would still be missing out on the most important
> part of the patches.

But that's just '(devm_)?(of_)?phy_[a-z]+\(|includes.h'?

Konrad
