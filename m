Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620236;
	b=aRIsYZElgt+YC7KnCYAO2st4rSvVfDNm38D7QFNXmq0NhXFOCZOVgvS6mvZZFRLYGeFL
	 OKE2gbl4ArMftiwfFAakhOxrQqlbtm2MpkIMWRtbIMWteZwKYBfw37QfGcKbV+IonpULJ
	 9tANvwINXuGa1G8QeJjnYAC0QGjJ51DyDY6BLu+kMObZIpp7kabtL3+fcIOL+I5eMG9nr
	 3Xuk9uI/mS5Q8UqLPnflZt91Xo0DKmscBhXWUxb911afNP5Z+ltu35zkRrQPg61uTWbHR
	 ICCQDJjTDPljx/AjN4TKOEn3ng0ybzyWaLFwGZLCbGvN4VYSQshQWKuYJ8BiT5+l4GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6EawhG+KLo0QFi1RDOt/xFrv1BkUvSlbwXPxTKgA5RU=;
	b=z8WxQFWQ5fnm69HmQrQIGK0sW5BmA7uQWt+UCnz/EdzvqSNdDtj1Sax6+QihNI+qZYxr
	 v9aJE0Q8ZXXNfpYqRCW61I39GvaBsL7tj8tb148gTnbg4YjrBl2ADvXsqTf/2Vve0DzAW
	 aLRlt7p9uzigdd28eHjnnY2CDgFnJoXVB5LsLocYhGczfu0IFY4JDV+OE3p3lfmZ1ufsA
	 HOjGOc9YJeqhM/+OK3hjatvItCDAhmi1uKQOcGcBOwoPdIMUuosTmVYkdWwsbJ6wZQZIZ
	 lG8yHrKrkbulwGI7YGhqNQWJDLjt/Wpju9cKAwhMiY5YBlBPlt3/W1EhFduyBiJNgYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HV59Go/c";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A463606A6B6
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 15:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A463606A6B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HV59Go/c
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb5e3cbf45so5583175e9.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620234; x=1796225034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EawhG+KLo0QFi1RDOt/xFrv1BkUvSlbwXPxTKgA5RU=;
        b=HV59Go/cpYxcL5WAtD+1Xny/BMhy0t9/kE+xSUBeIAXT2ybiCQLIyTQ4h3HkOSA2iq
         gNyH9I8G/McXyIPTXuzl14x+pjVZ87BluZhtNOeTcSGH4nzsaFp3M6hxc1PnlWFzuXK3
         QNdVzw/Aejc2xEcOcciscKn5TAVulJgU5L99QIYaUJPpzsS92Cd0hVkaEzdBtnIwti4U
         pxmm7IGW1a67oLYNGiSKwli/TzIA8SRprYd/iw9Ry8YwYmozZZAGEDyTU/xj6VEZn/be
         2S4/cgN4xMsLbNse50VLvxG0hag43J4BvpXXIFgacs9GnWPvyHuoy1fRcnJxLdGbM6vr
         erGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620234; x=1796225034;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EawhG+KLo0QFi1RDOt/xFrv1BkUvSlbwXPxTKgA5RU=;
        b=JZKfpNz5rNh2MYv3wPaaSQc6VpRH3o/SD9m0m9cAfX17zOnjf0coOKAPdDH3Z8io4m
         9Buyf/pGk8B62fEQM9essVfg6ShA3bSHa1PLjymWVIrZbnSCyYKuAIABDgjMBnV5xeRR
         fl57TDLvNnUimC02gixJtPG7P15yfUS8TaU0L1QcvA20KjnPogvUBSy10+4b9pMW7pJg
         d8x/JvxtHzomoZ7iYtHEox5mqgQn2U0GRq7yLlaAoEP0eEEZ3LuGX4Fr8zgR5I+rxkpS
         pD9rCW6/IxqlAMs08Iyrupi0GGL+h1NzBWwz8dUF71b9i63lRFANllOsxgI6bJfvp09S
         xNkw==
X-Forwarded-Encrypted: i=1; AL+hErFKxwvs1HP8v0RmcQtknZC8pEm06htK8rWgaCfA/moEWxaoT9qiHw44spno4ssUc4OAvid5IT2R0so=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lDArErWHJaRv8K2GAW9uMhCfShm1amGNicf04W4gNDimb2d0M
	i8XvDNHf0pXWUarxcspRvs1QsvAvoyL9I4mVil95YY5owjtm62X4TgHm
X-Gm-Gg: AZFdTZcfPHfaY93rb06oiP2cPfAfN1o4nvza6WSUP13VRXRZcHpfwp9/UdqGg8QHxFW
	e/AqDD0iqfz+h559ByTrfdLovmKoUeOCJnAd4v730fEwmttKA51J+TdWwLkO+puD+w15ONxA6df
	+g6Q4XoYE2cssyyfurveDScNVqibo0g7zgJ7JA5GbJQJFxtxf6JZ4LCiiPBoqxYctjRPWvLy+Ki
	81++3a1OTqBpVqP+fdVkUbwtzTVjtGLsj0x4+EZU4qPhxdGJW1Z5nkr6hI+oUETSvQHFPzf99L8
	P3lKDHKEmVU2nh3+WjwKMS0qofR6FhkvcQZYzZkJX27Fw7n2OgANSC3FrITX1Lpu7XUIGdS3TA4
	XUh2mq+mpoI9R/PLKaIiFGBEmn03S4JElnW1OAMVQ8yBIVRmd0FZbZpgsQgYwvIFIfTEUmRIsr/
	A/nLwxmnZ1LLvjQDC0bdPuwD3ib+FFcXDSW+BZ3iRdKehNpLxQZpyNoikDk/v21UmreMASReCed
	B9pi+2IWQ6YZ5NbdK1W+q4C8exrGeepwXNBuHzEF9zT//gayq8fSF1gjOAQ+dWzWNNxB0eny7dx
	b2VBDaVvU1tJ8yB+lrtD
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr344398855e9.0.1795620233772;
        Wed, 25 Nov 2026 07:23:53 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:d3cc:6bc:a861:f9da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm316515815e9.2.2026.11.25.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:23:53 -0800 (PST)
Date: Wed, 25 Nov 2026 17:23:50 +0200
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
Subject: Re: [PATCH v5 7/8] PCI: cadence: Use phy bulk data api to simplifiy
 the logic
Message-ID: <awb9XRze_e8xt9tA@skbuf>
References: <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-1-inochiama@gmail.com>
 <20261125043639.249525-8-inochiama@gmail.com>
 <20261125043639.249525-8-inochiama@gmail.com>
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
In-Reply-To: <20261125043639.249525-8-inochiama@gmail.com>
 <20261125043639.249525-8-inochiama@gmail.com>

On Wed, Nov 25, 2026 at 12:36:38PM +0800, Inochi Amaoto wrote:
> According the document of cadence PCI controller, it use multiple
> phys for multi-lane setup, so replace the loop of phy operation
> with phy bulk apis.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Minor nitpick in commit title: s/simplifiy/simplify/

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
