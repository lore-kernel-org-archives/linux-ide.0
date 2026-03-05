Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA63909B4
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715713; cv=none; b=ez6DXOZN9eZfPiXO/tN4blm2sHTLSmvivLUWtsvVOKDTk3NADYH+HmVgOvCe1AkfwQ414E9bs5IQDbuuLdN6ESozmkg8k9ki7FwEwcI3oq51/dWx3giID3dVY19QJi6xqN9gm9R7ZLhoLk2ClAhd8zFPLHw1ThCa5vyHbqMxm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715713; c=relaxed/simple;
	bh=mzxuHFEBJ8rIbeR5gmZexUBLMULkEpRVqRmwwCFyU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdXfxmNg5b3UesVlPAvwn18zFUYQ5l1HPFeEbB/eCEkZYWA92Hu7BemczR8n1KQ/AUGevbJuVRyeqLHoPG/Pxa8VPEy9J3JqIgNj7SI41QpXWn4eWryIGhp7MBxsdycUQv5jwI8gFBJv5yQahqShyxs1WCoyUC/+D3VENxCV8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae43042ea7so53424905ad.0
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 05:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715712; x=1773320512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IxpxVkGnClS/pzWnTPcTEx+bl+pPZR21vGpLksfVXc=;
        b=X9DdLUssTErxln2kmnDgarZI+8eQY/thdVq9IoJfcyp42ZmxovccE3W2yU8jKikN1M
         eD4FoxCwtUlVWbTfkaHuhAcY6uW+jhYzdajgeQxOlTXQ68oU/gaEsdI0jWTUKpd9oTq9
         5MAgSO0hioEgxWl8IhIp0ULtedTXaef8IhVxRJ1PPVaphmBuBYZXPRykJjAnO9POH68+
         P0K+y8TaoUVgFI2S54J9TDur7wrgEXBtjjwhGZKC6DejvYzPYeHUulNEVmB2e55nmVMD
         MEW5dFoNXkmZMeeRbJ9D5vTrtywg8c6FnT6zkZjvte6/FLogYzwHXn8aXyrheNoqWVpS
         59BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQjEaWJBZIbqVToWLQTfAOFrYw1S0SQfGdj6cO61HZVA9jVOUecvYAndYfsx5KTMbE0OJyMbdfX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAt7uUXHF3wJUuhkqOjWZPkJFcBMg4XsCkLu0SArU8zIvmvHad
	4HSpPSeaDADY6iKcY1iZCJ2prizPrDnJZIYZhp34ygKKAkoW1lgjWFDo
X-Gm-Gg: ATEYQzwXuOAkW6kGs/ZlJzDL2k39sz1C6I2q24LZWiuytsOU2mbj76NOaJ4UeSP9/Nx
	11Xt89LKJRaYPiq7EcietFqOk4uUptjoWY3p1/xs2BP0G6VysZspHYgqm5CUavVjgvt/HKz+Fn4
	jOxcNloM1Te9wFHh1H90dEjkqH02ElI2kceJY/bvGRR2lemo6ln+9ahDyuZmh/YrwLlBcwCFH58
	geAG8ZzfiI6VnPDKyU77YJyWfhwq7lTfzJZuvsc+ujlGbNyV9e6OpyQBWLWdDPMi7VQazGE/RhT
	u76VPiaeXjcNTYmcEmK8r9gJfpXJ5ytzO1J3kX1mMDXlCmNajba49dG3el5NfXXeO7RN2mePNb8
	5F+ViggBp1efu8MAqVXDwg67cPars/0cOJkMdOJaH6wxM9q2L4PM7jBYYzVNI8Rcueex7isuVIo
	M1ISRuQuRKZqmIT2wVRY2gArviirJ3nIaSIHfJS9KAFQoOLgHunNO4Gf88ZUAn/SYl6Fj8bk6vh
	Z3o6vN8y27zXA12B36lS0OW3FZJBFTHuf2IBlZjtAkkYiaoMctqdC6Lz3i4KA==
X-Received: by 2002:a17:902:ce03:b0:2ae:5b52:3818 with SMTP id d9443c01a7336-2ae6a9deb2amr60551085ad.8.1772715711782;
        Thu, 05 Mar 2026 05:01:51 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae54136b28sm115696425ad.73.2026.03.05.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:01:50 -0800 (PST)
Date: Thu, 5 Mar 2026 22:01:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305130149.GA1659133@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305122957.GA1652563@rocinante>
 <20260305123956.ojkt4k3ly64xz7fu@skbuf>
 <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>

Hello,

> > > For content match, it could also be:
> > > 
> > >   K:    phy
> > > 
> > > I believe this would match everything of interest?
> > 
> > Yeah, and way more. Think USB PHY, network PHY, etc. Don't want to drown
> > the linux-phy mailing list in unrelated patches, either.
> 
> Also phylink, any memory management / DMA stuff that happens to mention
> "physical", and probably numerous other examples.

Makes sense!  Sorry for the commotion here, then. :)

	Krzysztof
