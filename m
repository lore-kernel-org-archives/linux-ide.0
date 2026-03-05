Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A31377EA2
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702116; cv=none; b=oexRmzmabdSISnd1CTgn+m4qz2UZ6NU1VQSC6I2bRUU0KF4o8TZz6lLLNv7ayl+wTyorl1fRUv5WBAaBAneu9Anf2vmTDM1tsduQhotn6pmpCYplWkKXAoK+4n2uwZtbztY4P8vkXIBeZmRyNFvZwygOF+YfuXWp/nqCTZEo4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702116; c=relaxed/simple;
	bh=XRZpedr+2qpOkN3fG8Q8Osa6UFaMF5goxsvzLuitC0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEnAklPpg8j3ecF9/pMD4m5g4+S1G6ntXQXq7cSQwQnQwkSm/c6QpcfzqDkvB7nczeT6NE4tmFz0L+zp5Ka+pp3cUKnLT5XaMd0Z9krYISc+TjlCIxHfFs9bajHR1jTgxGNCY3XHpOEzFpgK8fP6GRETWoQpXr/BshK8bUr9o5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQRkPmX+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elIVdE5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQRkPmX+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elIVdE5x"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6258sDIl3665129
	for <linux-ide@vger.kernel.org>; Thu, 5 Mar 2026 09:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lB2MyXzqwL2fKx+Ie3b2ww9IDsTWQhJEMy9qeDpkHuo=; b=fQRkPmX+D74BHrMb
	asyUwF1awRSU41+Alv6Wnw7Gs81vmURRSipvQe26gecP5AjxUQs2FjH2evlpCBle
	EvlJTGeq7/hZa7TgbL/eiwIfLm9VDQ84HkWp0PDa9k8zC3mFxWdX2oUrXIvDSeUO
	MJlRb3hfiqoNxb4lqLQBC5yk39pNljrdNKN9SvZotseq/6rNLYILsr5slIzaGT2r
	CXRqeu0rHZQRIblzagGnKAQ//HjjGknA7AXeqY14HW8GLv/JQd3X9Okrf7xmxJF5
	2NdQ/R4sUdq3+kMqXrOnJ6N/9Kl6X1z8XshPF4tixarfRUFzzIjQtTlkBNy1zXbb
	lHd6eg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u1d4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 09:15:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a012f8ab7so25540636d6.2
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772702112; x=1773306912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB2MyXzqwL2fKx+Ie3b2ww9IDsTWQhJEMy9qeDpkHuo=;
        b=elIVdE5xveLAfRBnCtdDhukPFFVPhEfx0OAdRQ+3+MO7xCuxXqfJWTMfdS8rhrElSB
         13662Oq8ZZ+mGNGAeBf79TlXnCqjKrxUQFmgbHcVs0Zeip04r7A8Yk1GvxcLKd3ltuST
         M/JefZb/htFzUIIT1RehJM3GGC8jTSHr8k0zAoa7kQ9plHRHLdLjj/iOTjMRnj0Lw8bh
         DAjTfpJLX5OxJsr8aeSjnX5iJgkEjJNnPQ7Kc+nkLONfrP+A0ra0gBTJZGDKVlvNBIMN
         fSZFBQoZg7UuhVsHa3O3BKxTI1ghb1zQDYKgW7zMjyHuMpTICO6470i00cL1VyacoETu
         5PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702112; x=1773306912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB2MyXzqwL2fKx+Ie3b2ww9IDsTWQhJEMy9qeDpkHuo=;
        b=VRDWSQejmmA3DosybHqiU92+f26gr740NfdCp9rIT2QyUfvk25xrrmr91n510FvsXB
         uJrsMvJjsyAUSPl5QG4K81Hi+kReVVeeznp9kZEJGCXQfiRmvhrzLJT9lD/jjpgvwJQp
         6N39oVGrBSslkwkKYmz/1E52A/biAPd0FkRuyjZbqD+DqWMWzXDLqzJ6f3gPHs2rKreV
         cZsQsSivW/JYx9/LCGAXJvE9utpvv3RH5RPRbn3LZHDu7vHzUHhXYcJSE2hbvabDpuFi
         23iSrfWvy/VyUXNOO4l2qgG8z97j4OZUiqxUPlm6vNB5UTEKDriZ+7mEzkHQK4oRRAWM
         tPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhBG1idwcxX+lYbE8/yaxe/Quqld8SQvxJzsPTdpDSWG0tV/StJ8KUJ8Tr2nWGnAhHMa7mIpDcjWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSka+watyazvAeKcYp7gMvzwjBcPkEljzoYncNuc2IW+RV9efB
	B4kn/Wb5jliEkXyhVzg7e2lO+d/uL+K1lbuGLhEQMTT0lZzj6ZU7HEqvzTNFSZSZpqDGcxt9aM2
	PInzWS+rlzZ3qRnZXjPhI3kRzW3vgJzXiT0M4Bjb1TxfQ7ezPD13OvPLR5YMt5HORrlMnfuw=
X-Gm-Gg: ATEYQzyjMrb8tMn3mZS62p+1MxCU0bL+6hcy/Bv9TVuuKk7CXEd3kl/OKkZNlWQw/R3
	4pCc6kunQKjwzXkzLH+BEoUF0psvO9jjWIEhiwOmS5PLOcF9erXmHMhWyc+vYzq7VfG00rOoH8B
	sppIAYBG2KPXY3PYl/jz+EEEiRqjuuHGNLzZnEFgsJwbpHyXa0OQKbE9LF0tSmulSFPOPOs0rzB
	N/eBRgI8ZEwk8mR8AMr2noIk+p7dc5gfhmnOj3D7iLvJcWtiowuguoTXGtYcEer9mfgXr5pkM0n
	kVJj4MiKlRykVZ4u9EXorW4Bbhi3DtYsuUVSR/dHlFup1CHNUUOLUkoVNe1Y5Ss5xrf4QRoNOL0
	wMerfF5WpM7hif2dIebWV9ZGfckVcOgubyxFpA8v5yKyvgoX3CAVsAoO+1VH5xtjHrYuZp/Foxl
	128zA=
X-Received: by 2002:a05:6214:4842:b0:89a:1720:4c5f with SMTP id 6a1803df08f44-89a19aefda8mr48644596d6.3.1772702112232;
        Thu, 05 Mar 2026 01:15:12 -0800 (PST)
X-Received: by 2002:a05:6214:4842:b0:89a:1720:4c5f with SMTP id 6a1803df08f44-89a19aefda8mr48644286d6.3.1772702111839;
        Thu, 05 Mar 2026 01:15:11 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae666eesm878784966b.35.2026.03.05.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:15:10 -0800 (PST)
Message-ID: <19c70059-ee24-4b16-8df2-d5c9274ac6c4@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 10:15:07 +0100
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
 <ebee2fcf-9069-4a9f-ae72-86f4471cd4f3@oss.qualcomm.com>
 <20260305091336.ls3k24ieehntxf4f@skbuf>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260305091336.ls3k24ieehntxf4f@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: I_rT-LHZNH2E1VAAIJzUhTHCwaTDNQll
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a949a1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6df94im0sWgtjZpQi0gA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: I_rT-LHZNH2E1VAAIJzUhTHCwaTDNQll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3MyBTYWx0ZWRfX0l7dOZEiu7Ij
 i99gOBYVL2HPkM5XlDm8/W0+Bmg2797o/aa7ez66qS5zbJuGucs6DT3sozM63J05Pxge8FWJaP/
 dcPW4ssGsCoIySifkrtieSW842S9tjVuI2ZoMzr53U0rDNDSh/7blb9gop6s1dIKGoAqe1XZwMy
 jPVH7I3EnZ4EG5dyfEEpYd6wWU62gkefLHNwfgEAsYcxuqFMTvUvxrxRVxn/sRLKPL82j9VmjOt
 j6cKbqVNtmws1lTauFnt/iIZnM8OO1M1cYaMd4CXS6sgiSGbXuYEiGRyNIFp/1c5meLySb8Gn/U
 xkY6I7sySWoM8iCDR9mfLrqzYY2Zwbx+hXByP6dCe16dsJ8HaSNn55hmQCdIR5uSDFOwzaIr/f+
 xOiLrqL85GUVoGUo4tZxWFap8knenOtmc96wQuEOMRu24oE5JtasBdfxg6rm/P0RNgQS3A6Nmih
 klFSCWSEQlzNkMbuu5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050073

On 3/5/26 10:13 AM, Vladimir Oltean wrote:
> On Thu, Mar 05, 2026 at 10:11:32AM +0100, Konrad Dybcio wrote:
>> On 3/5/26 9:51 AM, Vladimir Oltean wrote:
>>> Hello Konrad,
>>>
>>> On Thu, Mar 05, 2026 at 09:39:35AM +0100, Konrad Dybcio wrote:
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 55af015174a5..bdfa47d9c774 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -10713,6 +10713,7 @@ F:    Documentation/devicetree/bindings/phy/
>>>>>  F:   drivers/phy/
>>>>>  F:   include/dt-bindings/phy/
>>>>>  F:   include/linux/phy/
>>>>> +K:   \b(devm_)?(of_)?phy_(create|destroy|init|exit|reset|power_(on|off)|configure|validate|calibrate|(get|set)_(mode|media|speed|bus_width|drvdata)|get_max_link_rate|pm_runtime_(get|put)|notify_(connect|disconnect|state)|get|put|optional_get|provider_(un)?register|simple_xlate|(create|remove)_lookup)\b|(struct\s+)?phy(_ops|_attrs|_lookup|_provider)?\b|linux/phy/phy\.h|phy-props\.h|phy-provider\.h
>>>>
>>>> Would looking for the devm/of_phy_ prefix followed by an open parentheses
>>>> not suffice for the 'has function call' case, instead of listing all
>>>> currently present exported functions?
>>>
>>> This would maybe work when you run ./scripts/get_maintainer.pl on a file.
>>> But I would like it to have good coverage on individual patches too. And
>>> since the devm/of_phy prefix only matches when you "get" the PHY, not
>>> "use" it, my fear is we would still be missing out on the most important
>>> part of the patches.
>>
>> But that's just '(devm_)?(of_)?phy_[a-z]+\(|includes.h'?
> 
> Yeah, but what about the networking PHY API, phy_start(), phy_connect(),
> phy_inband_caps() etc?

OK I wasn't aware of that poor namespacing..

Konrad
