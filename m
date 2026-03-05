Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671CD39A07B
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712938; cv=none; b=qMw/KCGOGfKl8jcBemcrhesmK5C0/Nicgd9++M1RJkp3osmmBdeZa7mflUgNPPZAm6QJD78tPlEqaVfwlHKeuU61vmkvLEzYFeoeK4N7aa8C5HUXds0+Hm+MCqwqWyXZAuMO7z5ejqtlr+s6T7HSLVdvdK8wf61DgBgBP4CvLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712938; c=relaxed/simple;
	bh=1N9rpptCfEGuKF24I3MO+ctQKVCjB9J9sj4YNN7+SI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOKoCycoWmwu9YZq2ign1pcsRz/mCExFU+WDKI15aL/2N6NTwrmfMYktHuI6KoTGt9+RX6nieTGmzrkSKZmu/vwmas70yT95WKu0AOm9ro0Dyi5sJuNiYPHJdhgAwlW3S/Ajc2uWq6O0IRGxSpFd2nalAhwPjRj/SEzKzjDiFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35983877dc5so2192183a91.2
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 04:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772712934; x=1773317734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS764krKV6WfB8kOxjvP29bXooB1nm1bNBDNiujlO4g=;
        b=gE7Qc05WiB1DIZWyr7hNjq9YDOcuJ+ekEA9fNHQwp3qJgto7TAA1fGxzVfv9lKehcS
         rpIrNORGcV0o0cUeqBr3fk74FrnFC9NVNHgUmPFLEodpOUAmVsC7XwF2rfzKY/GVNTaR
         aKOcI+5UhNR3eFXKe1dk0w0YZiCJ1ZULAfFZMMHVxehud2m1SulqAXVyBdJmDr9fNFYN
         PbAV4+zSXwkBt+c23DbmTafPq6hTfADI9vRzpjPtndgMu2ErQbNFz4ATPfkN48soQ2Hm
         t6c0Mpvoth9IvI7Cgd5meI3kKOEmNP4WlQ1SGdV6dwmzeYx297Qe0IvphIDSmbHAzcud
         IgYw==
X-Forwarded-Encrypted: i=1; AJvYcCXWlRy9SRb1ERHBlWRKFfc/u0OuWRF+aslCw+BkMMQ30xCzoddG7eJswEhKSt1MbIoTAzN9EzYktCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+MdkMvQQ7ZylQ3rJ3YTQJ8YJMDgIOtjLskxs8pu7Pbun+nIz
	X7nDVsK4Kkq2svTMY0wpVn9tZMLGiC5YWSL5YiikiCyMg8XriJjmY0k6
X-Gm-Gg: ATEYQzzwqyQXuNBG/PH0OHF6J+gSqpBGgrAcnLSrFdqEbOKcclt1H9Em239N6jbNbPS
	Ck1QmNxr4hVBhZJDiy+yzc5beens/Y0wQunU+6xt2b/oKZrAngMvg/8iFAVdaKWGeSyXmf5KHdp
	UVkl9sqV+tJSL8wsIvVv79PkWQN07rxhz2IZJAboI+bneSHWpKPFI4zfpvBzaLeUiXrwKvXrmq3
	gCB9IcAv6x9dGRxoJAlgtvm0pQg47c9COaqeC8co/5aC3obSD1KetZPBG8cnAVzjjox6zedlAr7
	BtdOCJSs3x50vERmxeKAqa/LnW257W9BcExuX+MzMtP6lRiTqVOP0f9tfUZnXYvLPmvPk7xCYN+
	5Dn4kjvm5XggmZ0Fr+LcUrkcmfoWA9n1yhVqwPBnbysPB4q51I7fzYSusSsaufNb4p0lIEZxRJt
	qwuO0yZNWvL8tE4Xu5frDqcsOTYbqvzPbl2LN+AU7OJuWpdLVoBR/+NjZm9WQEByiYEo3OtASol
	Xz7nKVAQQmgpMJ1RajAaIF0+8kUFI1RimC5oxmfoGEMqhapkcVpMotIcRMQnQ==
X-Received: by 2002:a17:90a:d44b:b0:34e:630c:616c with SMTP id 98e67ed59e1d1-359a6a92750mr4210979a91.31.1772712934483;
        Thu, 05 Mar 2026 04:15:34 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2c1daa6sm2391359a91.0.2026.03.05.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:15:33 -0800 (PST)
Date: Thu, 5 Mar 2026 21:15:32 +0900
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
Message-ID: <20260305121532.GA1649635@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305114352.2f7btqixg4tu5bzl@skbuf>

Hello,

> K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> K:	\bphy_(?:create|remove)_lookup\b
> K:	\bphy_(?:get|set)?_drvdata\b
> K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> K:	\bphy_(?:init|exit|power_(?:on|off))\b
> K:	\bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> K:	\bphy_(?:reset|configure|validate|calibrate)\b
> K:	\bphy_notify_(?:connect|disconnect|state)\b
> K:	(?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> K:	(?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)

What about

  F:	drivers/*/*phy*

or something along these lines.

	Krzysztof
