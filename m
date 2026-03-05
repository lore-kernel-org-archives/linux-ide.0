Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C983A0EB8
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715976; cv=none; b=R3OhMShT503eCsjJXibMgeCQGFvxACny3yTyVGejDS4EPWeWwDyi8zNsVkJY5qGtMOwiRimYdLnDBBEG6t+K1AoDnfKP8nRpJh89v/RjwDXq7m4l5UWrgLK6sLHPYDgXecoiipNJcPb/u4okYYAXzgH6cgDc8FwT2MHeJBQ5Fpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715976; c=relaxed/simple;
	bh=An6z6pGF00+43VUaOecTwb49LKqdBH2wGqINr17mp5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyvwrTHj2NyMnhu4zelE5Rw3QrdKSo3D0KxHnbmwyyupEXRx9oagO2m4graLX1qV5jKRM1QnxMnOLnWCtrdKd4N5k3ZQP/eTZOtG4/O72UjR9K9urlgfHtnlNvEzw1Mv9i4S6o/5ldu/dfIKQWB+AGCY66VGlXBLUxtd3sCu4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad4d639db3so36414075ad.0
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 05:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715972; x=1773320772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/3ao61LTSp6jCCF+e+2SF+gp23jwVu9a+x2K0Dcxpg=;
        b=vU1DikBBG4lJCtd9dkdEltZPanszmp0XEEiV9UoAciqK+T/4eRHJzLb1MfUpKJIzgk
         fNyKI7ryZT0QVAiXCuAoQBOAjxWZYFts0TlzUq8tHYyMPWgW5FD0aagco/YDPk9tS4P9
         TT2e4NRmGpW9PrOwZUJaK372G4KIC744je1crJl9xnIzZ5sa8rTz92QmGzhsJLCYPm+4
         QGmstO5Ea1lZsvCJFadeDY8Ra4O8c/asJeruKGiHGt8x5M7mJlrhJYXlCRAzLBCBlZkU
         1tiK2F5DUBv4z8ZfXj4GVLS9fqg/ScVxMb8S+shV+AOAoHTbS9JmgmFRho+RjDoVbUoZ
         2OeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk95n7RaHbsusY0F/CUjsdcJpVRhusxGagEK1pbraDyheU1FQqwHqXKBmRQzLa+dOgGJeGSJo4dnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlySBSwSdAoji2vuXjm1hifkO928Yt9ixlZjZxhiHxZ/xP1l76
	osgZaEbWQzNfVzUgtz6U5EJlNt56rx6LdL9zMAB7xy1RbIDbu+LMpRKs
X-Gm-Gg: ATEYQzwVqjifcM9Q9zk5EBGiUTX39j5hUJEBpXE5jF7fKtPrQa5SB02HeJ6quL/WB/I
	U68ZEg/ms/GKG0j30eoKtCqURL+EgADOKEn6njmlqTUOl9b+pBxzt4mF2L2kVTWzw9H1xViEnuf
	NcUa+ko0MbTW8VtIsOvQQsuiDBCj5np7HD6J32fCOStng7UEpVCI/cUMPILBQoOZbaur94Z1rYa
	Iy7rX7ub9Kz+6x6C/taYxjVO/tg1aKBkvfAxXvegRn4fIIT76EJsEhPFM1Qo0V5/iIdN6KugqXR
	SIKb/mSuFAxSkhJpe/Pf9HU5j4iEREUWRzBDwet5nwtpd0uowPOFQlze/aq2xp8m5jNMfGThha5
	T61UnrpbIcVHH2U3ZVVuIFkFSpr3vhPf8C3CEuHO0BxQSR8U4jO8wxCoVfmipk0CrFXmXOaaVJL
	jlGgyutQCLVWUOgtzcAgac9A85SwdJwiHR2anIdxbanD0p9GxMgUOL1+WRdcAP9HBUn4qNSnRum
	IkUOdafMMuZzF1E22cpvJNbFJmam/QYQchQM70ENiLkD/MRtLA=
X-Received: by 2002:a17:902:f68a:b0:295:560a:e499 with SMTP id d9443c01a7336-2ae6a9cd41cmr53596975ad.5.1772715971749;
        Thu, 05 Mar 2026 05:06:11 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d19559csm154128355ad.5.2026.03.05.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:06:10 -0800 (PST)
Date: Thu, 5 Mar 2026 22:06:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Joe Perches <joe@perches.com>,
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
Message-ID: <20260305130609.GB1659133@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305123843.i47asdrjychwlgdt@skbuf>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305123843.i47asdrjychwlgdt@skbuf>

Hello,

> > > K:    \b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> > > K:    \bphy_(?:create|remove)_lookup\b
> > > K:    \bphy_(?:get|set)?_drvdata\b
> > > K:    \b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> > > K:    \bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> > > K:    \bphy_(?:init|exit|power_(?:on|off))\b
> > > K:    \bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> > > K:    \bphy_(?:reset|configure|validate|calibrate)\b
> > > K:    \bphy_notify_(?:connect|disconnect|state)\b
> > > K:    (?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> > > K:    (?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)
> > 
> > What about
> > 
> >   F:    drivers/*/*phy*
> > 
> > or something along these lines.
> > 
> >         Krzysztof
> 
> I don't understand your suggestion. Is it meant as a replacement for the
> keyword regexes? Your file pattern matches on:

I was thinking more along the lines of using wildcards, the F: was just an
example.

[...]

> There are a lot of false positives, and a lot of false negatives.

Yeah, the "catch-all", for lack of better word, will not work here.

	Krzysztof
