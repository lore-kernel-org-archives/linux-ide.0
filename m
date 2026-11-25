Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620517;
	b=wCDtOEu6P4oH/TZ9HP9UK2lWyCrYdvuH2HpBUiRm7G85VkWuvTf6ZPHTq9y8EWomCXmO
	 xK106DqkkepSf6hBb4MiIg4ZTJnnr7DPn+Ujej8X0LcbC4mFAjBDkJzmH8gAuAgfxLsGI
	 OKlEMRIOABzZp14yZeGY9cRDMZw4OAaB/SkBsOOmIQOXfpjcKNG4q4kiJmpGjQ+qIkE5B
	 xAhvQIjHV9h2fRUW2NJeosWrem2Y4o0UKioMKWRmJSezsMQVqHdTHHb81ba5zGA0F3S/6
	 aZuyd0cTBOM74dAwhwTCNhZBmojVNryWHf5kOmoGiiOEOgRX1hw5YB01EKHMS93fX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4tA4R3M1tGeqFN2000iz5S9/N8qTO7Ro+JjVYjnPFCI=;
	b=IUEZH/X9Wk6UMJm4MgeVmOU3xQRdX7Qv5x7NCHvHj5MvCp4+xOKaO1tUNNBnIrVFEidn
	 4dk5Tq4+iwSCzITup5WQR1oCY1g7nH/yHJExal7r6fPM8tGrRMH3bkEyrrSwMjwikaPte
	 NN6LUHOtft8Fg6tf2zA4dhh7kY6sPgIKYOsG/0QQPhznRoWjA6xBwoOg0T7EVVJpIZO1e
	 Qp+Xg/L/a3UJIJpy1pLGM0+lsiD1l9IbCg9vtT9t37z2bX4qewIT2tGi6wC1D7yn3Ose0
	 yKaccYKqvBP2br51BOGaFWER+/6iAuzuL4OXLLDr93Ehsvo3lWYh+dU6FZDlKItCwKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d7AJtqC3;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3C606A327
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 15:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D3C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d7AJtqC3
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49355a50d11so292463f8f.2
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 07:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620515; x=1796225315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4tA4R3M1tGeqFN2000iz5S9/N8qTO7Ro+JjVYjnPFCI=;
        b=d7AJtqC3ItPc1GagK909ghnkB75xgGBmrWvrF1nHM8yjGyUu+GypKXUncZze9Nq+em
         a69o4b4ituyrhiECVj1p7plkFrQgUIAHrIxis+RvnVbp9yYs+5mUkE5PLtYA4u33cC5c
         1KUIHM5bQsnKTMuT055SSpwdHcAmbHOMedkTsZiPv7QgQQWG1juRDlANZ4RRiyKQYlDJ
         T3rivTor3/LtHWpWutwaNWl6dHxC4QnzKzuCigvarCYXWfApjNBqvMtYua4AYUH/i31f
         IpTCuGm+6IP1nxHBi8ggylJQPkNIgdykWRDhfxz9Y3FNbbQW0EN5kMXsRIwEoZZcRjRQ
         +YOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620515; x=1796225315;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tA4R3M1tGeqFN2000iz5S9/N8qTO7Ro+JjVYjnPFCI=;
        b=iAn1qOd2y4EiiY0exutpcAiDNcu3uSl1QX0elkgGTPZqE8QmkQXnBYbb+clUwgTUE+
         8MxCvx1ZKSX0Z44rvaSYIoIFlodZKnAfMGu+tJQBVoGhH1U2K1Cr6C5i4z3MtkXPGCTs
         64MBike4QP5JV5BVwwGV0f0xp2TbgVYhbcN4tcyG7J01ZgcudQWUz75J6i9ylxs/HPUl
         njjEbfrqgv98YYMrKz4z+WdINUz/LZ59mQenL3kGdUr2kkBEbq3WceiRF5U2ebGbTvay
         pvMrFin1Epiut/m8Xd3KTvcxyZchW/NVzTVD64hixISjeyRwyIRNYoq21mY5E0bo4PaT
         7ojg==
X-Forwarded-Encrypted: i=1; AL+hErGOeFN/HDwZ4nJjEHLj/88SgFKgPQDKJDAP3SyuSV8+z2Y344z29BK+3AYoSZf0jWMnnAutpF4Dk7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9a9EG1ptY/VgpoqWKXKfprennh/0oMYD5kMI7bejoTMbQsXV6B
	ihc3D5MBFtubOMcxT7aSiJkT5hdSTuyxMIQTtDr4i9NCYICb3G8PpXpQ
X-Gm-Gg: AZFdTZcY1fC6tA1sUNv5uyHQL6hxc1n5dvCaqC6+cqBwdl+SwNYgaZ3P60JrO0mj3La
	KrIgKHVIEs0XZo/aibVhIz0Td/zeuBRAuUZOAXPW+4jMr7XOleeczYAv0GR2O/Dng6x1cCv8tsE
	yg109+gI/y2Fe00vo/trg/2pO/FphiDurfupURpH/vQ+exDRbJnpPZK5/mUU/uMDuB/pxb509Z1
	B6zVoS2I2SOwIvT5tFXXEBo1Ev29FYQ+9skQjHU1+CnBLDUivaUnCrIT3iixa/UVk32nkSlwbNx
	DGirE3VO5AFa68+8spNw5aJ6r2C3Jx6iePA3KwMY12j8XieGWnxn5wHaaORFuw2al7dd+7NxEzK
	RKojzyrouuiSnabCIJihoVeSmKObGSyO08oV55we+9DsnsoZYc4bRt4T1HNZVhT8A4EJseJ2AN0
	jMgwuSTd1ta0ZQLi+sB9u4//DUfyqb2W80pGK3jZUnL2rGJ8rUXPnK0Jn6ozeyRFg8u/zAjC3VR
	v9eNlapKmMlNdKUZHea23oN5mnk0u3+ConDOaNHgZ9Eh+Dl77D55GVwckR652Q7yrb44JME0moB
	RRz8J7TubjgnqcwT9m2W
X-Received: by 2002:a5d:5e01:0:b0:4a8:eed3:770 with SMTP id ffacd0b85a97d-4abb47b25eemr37771369f8f.4.1795620514919;
        Wed, 25 Nov 2026 07:28:34 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm34443459f8f.10.2026.11.25.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:28:34 -0800 (PST)
Date: Wed, 25 Nov 2026 17:28:30 +0200
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
Subject: Re: [PATCH v5 6/8] doc: phy: Document some bulk helper functions
Message-ID: <awb-MUCgZJn94Lbx@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-7-inochiama@gmail.com>
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
In-Reply-To: <20261125043639.249525-7-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:37PM +0800, Inochi Amaoto wrote:
> Document all newly added bulk helper function, it can be used to manage
> a set of PHYs automatically. This is useful when the driver want to
> simplify the management of multiple PHYs.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  Documentation/driver-api/phy/phy.rst | 40 ++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
> index 0865c2e94eec..cae3d4700814 100644
> --- a/Documentation/driver-api/phy/phy.rst
> +++ b/Documentation/driver-api/phy/phy.rst
> @@ -114,6 +114,12 @@ it. This framework provides the following APIs to get a reference to the PHY.
>  	struct phy *devm_of_phy_get_by_index(struct device *dev,
>  					     struct device_node *np,
>  					     int index);
> +	int devm_phy_bulk_get(struct device *dev, int num_phys,
> +			      struct phy_bulk_data *phys);
> +	int devm_phy_bulk_get_all(struct device *dev,
> +				  struct phy_bulk_data **phys);
> +	int devm_of_phy_bulk_get_all(struct device *dev, struct device_node *np,
> +				     struct phy_bulk_data **phys);
>  
>  phy_get, devm_phy_get and devm_phy_optional_get can be used to get the PHY.
>  In the case of dt boot, the string arguments
> @@ -129,6 +135,21 @@ Some generic drivers, such as ehci, may use multiple phys. In this case,
>  devm_of_phy_get or devm_of_phy_get_by_index can be used to get a phy
>  reference based on name or index.
>  
> +The bulk helpers are useful when a controller operates several PHYs together,
> +for example the lanes of a single PCIe port. To get a set of PHYs by name,
> +the driver supplies an array of ``struct phy_bulk_data`` with the ``id`` of
> +each entry set to the corresponding PHY name. devm_phy_bulk_get() returns
> +zero if it obtains all the requested PHYs or a negative error code on failure.
> +The driver owns the array and keeps it valid until driver detach, when the
> +PHY references are released.
> +
> +When a controller needs every PHY listed in a device node's ``phys`` property,
> +devm_phy_bulk_get_all() obtains them from the controller's device node.
> +devm_of_phy_bulk_get_all() does the same for an explicitly supplied device
> +node. These functions return the number of PHYs listed in the node, which may
> +be zero, or a negative error code on failure. They store the allocated array
> +in ``*phys`` only when the return value is positive.
> +
>  It should be noted that NULL is a valid phy reference. All phy
>  consumer calls on the NULL phy become NOPs. That is the release calls,
>  the phy_init() and phy_exit() calls, and phy_power_on() and
> @@ -149,6 +170,14 @@ The general order of calls should be::
>      phy_exit()
>      [[of_]phy_put()]
>  
> +After acquiring a set of PHYs with a bulk helper, the order is::
> +
> +    phy_bulk_init()
> +    phy_bulk_power_on()
> +    ...
> +    phy_bulk_power_off()
> +    phy_bulk_exit()
> +
>  Some PHY drivers may not implement :c:func:`phy_init` or :c:func:`phy_power_on`,
>  but controllers should always call these functions to be compatible with other
>  PHYs. Some PHYs may require :c:func:`phy_set_mode <phy_set_mode_ext>`, while
> @@ -172,6 +201,12 @@ PHY framework provides 2 APIs to release a reference to the PHY.
>  Both these APIs are used to release a reference to the PHY and devm_phy_put
>  destroys the devres associated with this PHY.
>  
> +For devm_phy_bulk_get_all() and devm_of_phy_bulk_get_all(), driver detach
> +releases both the PHY references and the allocated array. To release them
> +earlier, use::
> +
> +	void devm_phy_bulk_put_all(struct device *dev, struct phy_bulk_data *phy);
> +
>  Destroying the PHY
>  ==================
>  
> @@ -221,3 +256,8 @@ DeviceTree Binding
>  
>  The documentation for PHY dt binding can be found @
>  Documentation/devicetree/bindings/phy/phy-bindings.txt
> +
> +Missing Bulk Helpers
> +====================
> +Currently, only a few bulk helper functions are added as they have users.
> +Function not upstreamed can be found at https://lore.kernel.org/linux-phy/20260904083709.425893-1-inochiama@gmail.com/

s/Function/Functions/

Other than that:
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Thanks for updating the documentation, this is appreciated.
