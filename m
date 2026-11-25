Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621185;
	b=enhex6giUu3O5J3wwzQIlwwN25VWwxNZC48XaCNDl9NVv+BHy61xOZIBQ3KS0MCiPEW5
	 C+r3lwrTHcnXDy+0DxxUOHuvc3242z0c+3Omeeiu5ZAaa4Mxs/CFetKvfwQzxf79MVucx
	 vUTm3Rcyl3gavkeoNwbSN90ig8ToPsHtOLOfABe3cJMV0BgrsXj/P+euYSPdzD/lsRYTK
	 gKZck3lE82dE3fe1RA9Az/7UZwPtR6GIMSfN+H53OzuQtCkQgOIyOB9AAfbwItqX5SXpK
	 NyqE+ftH5pCg8bBOYQTfdRFVgtXUfjZV96gre4xjvCmCKqV+4CHodgcFuZFuFEqBrLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=03OK5Wux5qBQjFwf+S+X4PZ6SO+iKxNmDWiFlrnb6so=;
	b=4JfuZSJmwxm4LwG/HeLNfflfKClNGbnc7H5UN3lw0LtCXbrjFB6OgMOame544gExGPOs
	 YXZoF7JD4/1iH4GGCXMf290Chaeoag/VftcpBC26TsQhk1S0F0UaJQOHQPjYvOzrVgYWC
	 cwcG5lE35ecMk6QcHlGe4MnVNwTnlNixh0LBT6DJbRzvlx2RTM16A2oWorQiYEKg11bPB
	 QwSoafB77vo7CBBPQsVgsa1Wfal8qsG7WsEFRc2FsO9rDDDpJncm02qQ8OW0XKB6APhtB
	 UEXLx0cFK0v5vWahXlvHMUQoDXk2dRdIcKScHZ7q+zv4ZZDg8a4KZLGTlILjbzVKUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZQkKpXf;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF388606A323
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 15:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF388606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZQkKpXf
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb72b6e1b2so4292335e9.2
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795621183; x=1796225983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03OK5Wux5qBQjFwf+S+X4PZ6SO+iKxNmDWiFlrnb6so=;
        b=hZQkKpXfoPCNOyIPGt3na6gHRDhBZ+SSP/SQA3rJHJZdqSm7Rqn+twjMd52AxubyQy
         vFD0Pnc3F4zWRaYn9vD46oH+u3j/NCE+HNKmR1h2U/ppARV1FO/vO2BXMGPp/imJBe7u
         CvqNLaHed8HmgawaaW54JlJPeoQuqrxdGP/0oHfFzObIHwATnPXumKuRH8eMi2ZyEhZ6
         qP0qxR9hxQZg2cwbh3S5OEBOng0kR2oEwMCPDOam3vgu64CMxGn4YxodQgsb4zQSAWWB
         wr6OLfgnXVJ2zeJLop02n0YA29iRtXdPDVrr2CDA9IG/r8zn0oKNfI/MqSZEr7K/Errl
         bQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795621183; x=1796225983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03OK5Wux5qBQjFwf+S+X4PZ6SO+iKxNmDWiFlrnb6so=;
        b=pTuO4S6WvMdWeaOjF5lyFk3azxLkx5Y26neDITFAsrSBaFhdpzDqm5wIc4JsV5hjAh
         GxJ6d9sjKU2MPKrisghq1wAA+gL9SXknqxFmv5sjcuFghc23DkgRd03/q1byD+HeYdTk
         vOHwJJpJC9aGfD6bc1ecgCCnMZAZ+bb2kFwNupnWPwIcQ2Ov2WhTyMu/xqyunku4rPhU
         Tu3gaSYi7QzW0xDpKJHufXp6wo5gXXoWbvMjORQE0dXdnX+XK/DSoZ0DDspyVWPYfaVR
         XaeehGb2cfXqtpHuoAqfz+eVVFyehcEV9373vOKEMGX51QC0XTR/xIZKkzKe+EsTjPUT
         fQNg==
X-Forwarded-Encrypted: i=1; AL+hErF8gGICn+PgDqKsTKqh8iaWbsF0agXm8Kr6lgYzrtcT4cEHYDNkLPXZ7Y/wpp3IsPpPtZu2Uyn9DNo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wsjEZOnDbHDeLyyQYNjfhIb3p8WrnXIFtlVonlvUZZxG+71t9
	QhtWM7Ndt5cBjS1SvZEv8ThSCOoKqSsHEEYQh3uDSH9UQN6kDsnCshke
X-Gm-Gg: AZFdTZeHkJ6hR28FzWZWk9Dg6Woj5fOU8tO7jp/2aSkqMWos55Hfv0vnHMTBykM4ues
	VlflJqMZbDwJ/AxEq4KNKJdu9XjsmNxTI5Z85OlefJC4cH0bgvKazLH9BRK4IyRGWNfqVc3nBg8
	K0j9Dh382wkjvBqR+SDBksAdsGBO602lZ2YHi5+JbC81a0ZJZI5/xpvJPEOpyPanddEwjN93rCq
	xIJ366LhiJ4GCb7hZ+8CyroeXYVZ94paBQSgsDH9UDGFsRuS7vU/E64bYszs6P3nKrRbQOHxV/r
	r70q/BVnAA0lf9nlwK2wXjlhjXc6f3M/rm+w1ZFZUrubewrCsvwR5FIL8Xj9YGYaoW3SUBvdazp
	EgtB6kyp3Z42Lp/Xu2EdaL+/Enmtn3CyV1STCaG4dlbVUqG1e2TrlWcZvGnrOCWh/Cimt+7R2Gx
	9XYzwoLsde8Z5ntGbhuE3mlpeVpNEFDB/oAQRFfc0/gBrs22hKxdZhJqc5s9JfELzcLylNpx8Pv
	2gnjcARA9XzxHGCYFxzmUyxTqBsRlIdi11+bMZcagLGEp4j1WSLOv8NMaiauljisysk1v+vaHjJ
	eMKWSDqbdE9fLTbbUIdeYyVgFq4=
X-Received: by 2002:a05:600c:828e:b0:4bb:7ad9:2f22 with SMTP id 5b1f17b1804b1-4bb887853e1mr340731425e9.0.1795621183256;
        Wed, 25 Nov 2026 07:39:43 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm474497565e9.9.2026.11.25.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:39:41 -0800 (PST)
Date: Wed, 25 Nov 2026 17:39:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aksh Garg <a-garg7@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rhys Tumelty <rhys@tumelty.co.uk>, 
	Manikandan K Pillai <mpillai@cadence.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Hans Zhang <18255117159@163.com>, Yao Zi <me@ziyao.cc>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 8/8] ata: ahci_imx: Use bulk PHY APIs for calibration
 PHYs
Message-ID: <awcBID5pfFm2FadY@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125043639.249525-9-inochiama@gmail.com>
 <20261125043639.249525-9-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:39PM +0800, Inochi Amaoto wrote:
> The i.MX8QM SATA PHY relies on the first two HSIO lanes for shared
> impedance calibration. Store these calibration PHYs in a bulk array
> and acquire them by name with devm_phy_bulk_get().
> 
> Initialize both calibration PHYs before powering them on in lane order,
> then keep the SATA PHY initialization, mode selection and power-on
> separate. Use the bulk helpers to release the calibration PHYs after
> SATA startup and to unwind failures without repeating power-off after
> a failed bulk power-on.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
