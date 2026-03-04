Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767A376489
	for <linux-ide@vger.kernel.org>; Wed,  4 Mar 2026 23:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668420; cv=none; b=LAlTfYOdCcc20AchXG3ouGfIhGkijfWmIiWi+FKTgKoW/3LYtAk9/74D5g0PnHasXw2vZVmSGsk6mfc6i4eTeZ3Yqnn4XwUSjjGeijsmi0Q0ViziTZhIySLrEL/Wg/ENAUMZl7aI3FWOsVePPguQIz5ZK2VtKz8ivRJ/Lqta3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668420; c=relaxed/simple;
	bh=hM0fx+PufUG+eR0kIJ1dr4h1ANr/zb80CpZtG5LPG3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH6DjdPSSLf7v4BoX/3WDAwj6JOA0YI0WN50x1MXbhk3r5xajl2fmuFFuhiDPxEtN28MQfozOd1nSO5LoVzC1ZY1xvZ17dKlaSE+qgxKd55xKSfHs9FE2xXqCDr49gJHIB27g3RcBlxoJ+bEajSnoBcjZDZNrUZYNYLuDNYdzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHnTZhnF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BsK7qQ8l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHnTZhnF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BsK7qQ8l"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624M8WgS1203235
	for <linux-ide@vger.kernel.org>; Wed, 4 Mar 2026 23:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V50tlCURGOSWEpUNVC/f5JBG
	lAu9WVw1+uCs3+cXy8Q=; b=bHnTZhnFYn/tiIi8J4ULThpsgbab7UrmgW5OOJJi
	m7XwaAv8gzL5i/PPJCFmKWpARNfKhBWcj2eQ98Jty0ias+PktBjqdKCkXAPaELNj
	a0Gl+BUEEowrMPAKllx/ORmbxKvdbnv06gsWNMRC4vNwMWDRsN+/Umbybcd+e88B
	r/+5sfU/Jr5rGByjhLIWV29LUZnpLgy3RQf4wS6C8MkG2aHm4Hpng0Hc/lXMymq8
	+xAymHfPQW0I/zSIuwudwEu/Xyt9EGrksONWTgra0NIIeQgGca3xHZntcQ/B1uyx
	S9yybI9F7OtwJgszxO8ID4FgfjHXJVcqqpvfDRNL7lu1yA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpf9c36ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2026 23:53:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb37db8b79so5402297585a.3
        for <linux-ide@vger.kernel.org>; Wed, 04 Mar 2026 15:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772668417; x=1773273217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V50tlCURGOSWEpUNVC/f5JBGlAu9WVw1+uCs3+cXy8Q=;
        b=BsK7qQ8lpgf4MccOs8W7P4/DhshR1Te1sl3mDVTFek6FHBU+SP+YnG91rAsMrSiBqI
         9ZI/l49Go+6X2HLBzEJuQUMqPhS0X21IMF5frdw7o6p9+WiUwihLtOucPB4UwcVB7gR1
         /TDtEKV+6eRrKNTjJVjUEslUBQ5NnWU/e9vVl9ATl97WjFl5qiYxpUVMnoDmE3yXf8Fl
         yGu1qjp72SH1jaPwdnfGvB4t6p8C23m19vvnRxN28ms3opiktg9gf7H+SBz7N5rm2EmS
         oZFO6InnfnmC0OlubIJXakoZV9aFBjmrxoeKGbrYw3Fk8nbvhs8RM2xp5cTA7BfjB0Ug
         XpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668417; x=1773273217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V50tlCURGOSWEpUNVC/f5JBGlAu9WVw1+uCs3+cXy8Q=;
        b=b1mzA2rGV2Q1j1eWPQjsZu+ZajIUYuZ69ZQ8o+iDLg/j7+Pe37K4kXZdVkdTxF3fdB
         db3XCMonC6fhf1pdGn8BgXrAtrakVgVS4YpXwpCjcuRzvh1lEB+sO1v5136AerkWm0F5
         GqTPBXnAYG9EMvQ5IyExEmuhOjPir8UImH3aE12sVomgkx3+DbxUYUZvhlF4HfH19ug9
         4ujPUtu0Puf4Dr/1aRyQ3rVuHJgr4WK5uP47zh9foDC2LZmFGe9jgzhjovjtwbf/2h9e
         Qw4nSyhgro4qXyUl4qrRp/3YiI9AGnt08Hv7wrv0vyREQcI0PN1etTN7S5de448p0jDI
         vgOg==
X-Forwarded-Encrypted: i=1; AJvYcCVGnqx1LCZh+CiXckBbv1RIL+QtU5zSAv01XPWOQaIBJ8KEQGp6VzFM2hgRvJbJlwVZcQo/MN4yty8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy16GHSlx5ZJQ35F5pgJmBsJJAENcM8X8G7w5Wt5CWznYi9OLh
	I6od7P1A0tQ0+qLEZS97vIWipaya5uiUowV6zyDzcSC0/qc9/+/UEV6bAjVnYK3EKb/zbskptiW
	TeKrJmNC8udNNqBgy1bfUQZQ3EA4+IPgU9Rq/MD9IJl0byI8JVbzoX+V0p9/z/f4=
X-Gm-Gg: ATEYQzzAy/jgBGBh2XGmvFCkChm+EOzXCgDtrP4oaX2ctIkOr/ZpK/ji0IhE07/b8Fx
	QQMuyyQPyDKQ1LCbNyBJerAMfPJ8U0HETm83frj+uiOStqtpssxWHdIETaVCM4EWqSQjdmmpeFI
	rekxX8UtRLy8wlRLhZf7tBH1nRPVGVcoFcm37KWolapOsDAws9TF9PjXX6BTqpRMjq05Djbbau2
	8t102h3MyWDq/xKQ+j3SamyQuBmnkPP4HaXNjd4r8VpHdqhvaftLwFyPULPjZNBtQTFi2MZamQE
	HxmxNDiOBn5qYy3f3hljPHAxTWDn/RaJ5OfgWvI4ywU+kBYqB4dCdWRv64Hr5ykB0arRYKv4FWD
	10cpgNlwkWVGmWK8NG84ERwy44QZvHKovULthCRnY1xQn/ULn4fqhZMXvLTCN6TxW1ogL7LO/ke
	Bc8nSSIbGBMa9gLaWCZwEwZMn+sd5ECLx6jaE=
X-Received: by 2002:a05:620a:3727:b0:8c7:c25:9e53 with SMTP id af79cd13be357-8cd5afa6707mr498610085a.59.1772668417080;
        Wed, 04 Mar 2026 15:53:37 -0800 (PST)
X-Received: by 2002:a05:620a:3727:b0:8c7:c25:9e53 with SMTP id af79cd13be357-8cd5afa6707mr498604985a.59.1772668416537;
        Wed, 04 Mar 2026 15:53:36 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1296993a0sm933837e87.31.2026.03.04.15.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:53:35 -0800 (PST)
Date: Thu, 5 Mar 2026 01:53:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH phy-next 11/22] drm/msm/dp: remove debugging prints with
 internal struct phy state
Message-ID: <esbforcln7bi4e5enmgwqj7d63usdyoobxyo3hwd4paou56aoc@kjlizz3ubksd>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-12-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304175735.2660419-12-vladimir.oltean@nxp.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE5NiBTYWx0ZWRfX9kVUxwRBqnsQ
 SpiWr5MJRE9q1ioG+e3JQ2JKQMZa1Drrkkfu1Xq1/arHjhjsBrafnT5WHO5/nvfHiTo2yo+s6xV
 G8vZeCkD4tqCX+DfdzfEd2+kifaoJ9hyycUmyA2TGSmjOTle26U1f6dCaiJVitly+YHjzx04kGV
 42GaBn9lBo8dK38u/LODYPba96VbY6mLojGGTAcNfhdLMSrpSmwFIft86TGb683e3S/NKUezyEu
 WVy0SIXMVNNNRAQTQN64gLTT9UnabRNM5wVp114/qf+69sW//xV/KLBjgEPEjru6OW+QIMqlUjO
 q2TAhGnMI8MdD13tH0TLn17gdpixSRvkp5KVA6SkLzHc1sPti0uNyJy4DTzLSki5enrURStek1i
 S4ECmkqBQC9cPwNXkQrH7NNsY1nc+FV/WrpEpR6yDOAv9Qg20zy+cqNucypawjM/L644GGMudVp
 y17aqbF2wE/QZJ1hPXg==
X-Proofpoint-GUID: eNzpqBP1vWHU4_98X4b1HRG48ccOITCk
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=69a8c602 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=8AirrxEcAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=3ogKHO_BN1K2bhpmqR8A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=ST-jHhOKWsTCqRlWije3:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-ORIG-GUID: eNzpqBP1vWHU4_98X4b1HRG48ccOITCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040196

On Wed, Mar 04, 2026 at 07:57:24PM +0200, Vladimir Oltean wrote:
> These do not provide much value, and will become hard to maintain once
> the Generic PHY framework starts hiding the contents of struct phy from
> consumers.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 18 ------------------
>  1 file changed, 18 deletions(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
