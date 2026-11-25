Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620043;
	b=sx6YJ+RwGJ9pcxksRXi73183wldECbWsNZDZw93eT/69KvV2qyj5+IpBcvUw0bZaNqPu
	 dxHJ3bwlszF6vG059cw3spySA2oiwj8/9lJYSiQZFle+18Bdtvi+n3FxD/Q/hWKflSwNR
	 GLm8DNaK7i6gMGmq4pNTTe5cgohot9lQ3HUo+BnMhoJINSTfCHpxHoLt2BTG/aUon8Ynh
	 xDrGgeQ/mkMP7TbK6ut8GAeP0/IBOnjnqJ9hA8m2nYaxKlhGtD9plqLarpeg/jAcrcDod
	 v7fc9EiF5ZJMGWtDvdu30QVFhzta2ifKhJG3NARq8c4753Z4KzTfaSqgmDIfIZNpftw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U7BBvICMuzzfnr5B7tFxaU0ZRbyofyJaoqar4LTl4jM=;
	b=u57QXOZsPbU3Rn3Bb9XyFDu9eEY1pMLmIBVGmMhFQwUkHo1jlgB/eQDIG3S47xfYkK0n
	 7QFxuZWqfBehstPaQsIveoCeR/r6erva3r42NgJXgoGec2av3kZL6pd0cp8fA81cj9qCY
	 lKz3ix3Mz4xRLkjaqwzsQkQD50n01v/miFQ8tgJnZ5P0ZJoa9xO/Femr9F2nryrZ9ghxG
	 C1VWXZ2T3B5lflecl2TKr7T09WNpPuDeiNMWkSkN4XcjvXBRzyUSECbAHjxHTd9+dPW2K
	 fUVZNeDPPvh7vNSHyKCZDGkYs4g1vQdvEOCjmLvkjbzuVJSfvE0UgPavjHoqLGLOjJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPs7IeC2;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3856606A330
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 15:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3856606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPs7IeC2
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b896db8f9bso572588a12.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 07:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620041; x=1796224841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U7BBvICMuzzfnr5B7tFxaU0ZRbyofyJaoqar4LTl4jM=;
        b=jPs7IeC2SRkubIeMfVnhV/BhR49WqE7eahuEzR6lok9Tb6/91SnF6JgW3QvDRw9VIh
         I8NXvAazDYFAWvjL2/R5Brx3YKskZH5+t8TClG/n/H7N+mfcNGnDHTDUYE1iF4lz2sEr
         8MYzT/BBWPa8yU7bqPNSmvXOtyWTyA1wfph9fhRL7dRFWXFf+9LEenZH6NXyAJikaLMU
         w8Hx8OOb/rRljzVrIGU1RJDznnDds1VoXnAS5QjAQd45pF9bXy8nA/pg/XPK4KzKRJ4H
         uSKUl3EeuMxVaUeOXhKmwnIIrFIln8gdmrREcmWQiKyU3yrUkBvxnZ90UvLKy+OBlrFi
         +yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620041; x=1796224841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7BBvICMuzzfnr5B7tFxaU0ZRbyofyJaoqar4LTl4jM=;
        b=G28HWlQW29xqpNqTF/TM8mm6CVr9rRoH851B8PMc000feGQ/sVpyPvqGbpH0vnUjsc
         pzhp5rxGXmcvXZP//APJhFV9WbIxTz/uPHTQg1MTMFi4sdKSPK+keHWm2OnWDvtF6ywu
         OgVJaVGdGUtWdmqyLNxYwHonhbMf1oyihbXjidBsnHQMAHxZEGvddeCttkdZ3MIGmNOi
         sWW4GFmzXPV9YSq4DZK8lXyQS1VV040RAeqqeBRAK8Ehy4F8xPIy3EBVxwEoQQZOe4NN
         XZOSyhyJQXbKmOapzq6Mp9GtG3KFBVuye9ftRUA85XsXnjSeTbYcQw3bd8rxVP1lOztV
         K7YA==
X-Forwarded-Encrypted: i=1; AL+hErFBKlA2oxNJpIjRkhadXUuPzt0ETHhV9oLJViyNUbemiQzjEVvCKVHU3q7kw7c/TYWzrrKjC8C9bHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z97j+I/RBAhQiQ7mA0FGIdCrYzDSUvhrhHrXWQcQ/Mh/8fOMo2x
	dQW/IRAeVEVk78f6+Ed9qQbbzp3iBG03gR2NP2KDJQw0d1LCn2W+chy9
X-Gm-Gg: AZFdTZfuYeh2U/fOKO7kXS4CwPWo7xjEPq29Ks0+kv2Z5/LAz+Cssc4MgZxhZoPfb/m
	crG08dDvidGu46DGCfywRaOEoetSXVSIION4636uhArMMxciayV5F/XRujF01RRjw2QZnQ5ACdi
	CnNm4ou87obHmWo/lU1YmbFpB/gk7aR5O7EXbmZEl4HJ622ePJ0n5GLMk9Obbe0TxKVlUE7cSWY
	PlBtF8Bcgt0023rOvWNSoFB3gtsjg8DEGjGWdQ+rQcCVcYafc7GQ+7MpjyISHP1WY87vE7wtfcz
	dgwLQi03pCKd2qPMQD+0K+X2C5oyzBpT3r8CFJuWdbibo+b1u1jLXVdUJrjiaKPO/PXroN3S01Q
	tPH/P8GBc6tOQ1q6rb7RuFMeQoLtFfaCd/LlS2hkPrsPdYShOD7yN3UA8XuxuqNvbBNt/u21Z6A
	Y2E5M4LLhltIjamny8gz26m+jKpTGek6mE1LLlD0QuIvYjRWP6z+cL8zCuXJpVyVAlStfx9DQWW
	//1TdmKUfRfFZT4RH3lfizRWMlq0x5a8FYPYnemWBe1Ug24nKp6iwvQxVhun7wGx4vR1gdsD24m
	lp6QF6HsszD67N8EW5MD
X-Received: by 2002:a05:6402:90d:b0:6b7:dace:635d with SMTP id 4fb4d7f45d1cf-6ba37ac9214mr15694051a12.0.1795620041130;
        Wed, 25 Nov 2026 07:20:41 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e78a7sm8131962a12.16.2026.11.25.07.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:20:39 -0800 (PST)
Date: Wed, 25 Nov 2026 17:20:36 +0200
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
Subject: Re: [PATCH v5 4/8] phy: core: Add phy bulk data helper functions
Message-ID: <awb8ZycWk2PJzTUD@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-5-inochiama@gmail.com>
 <20261125043639.249525-5-inochiama@gmail.com>
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
In-Reply-To: <20261125043639.249525-5-inochiama@gmail.com>
 <20261125043639.249525-5-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:35PM +0800, Inochi Amaoto wrote:
> Add several helper functions that allow drivers to get several phy
> consumers in one operation. If any of the phy cannot be acquired then
> any phys that were got will be put before returning to the caller.
> 
> This can relieve the driver owners' life who needs to handle many phys,
> as well as each phy error reporting.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Transient build warning due to improper patch splitting, please fix.

Documentation/.renames.txt: warning: ignored by one of the .gitignore files
../drivers/phy/phy-core.c:1202:12: warning: unused function 'phy_bulk_get' [-Wunused-function]
 1202 | static int phy_bulk_get(struct device *dev, int num_phys,
      |            ^~~~~~~~~~~~
../drivers/phy/phy-core.c:1242:12: warning: unused function 'of_phy_bulk_get_all' [-Wunused-function]
 1242 | static int of_phy_bulk_get_all(struct device_node *np,
      |            ^~~~~~~~~~~~~~~~~~~
../drivers/phy/phy-core.c:1274:13: warning: unused function 'phy_bulk_put_all' [-Wunused-function]
 1274 | static void phy_bulk_put_all(struct device *dev, int num_phys,
      |             ^~~~~~~~~~~~~~~~
3 warnings generated.
