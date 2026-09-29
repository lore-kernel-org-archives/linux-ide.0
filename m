Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5452B1F4;
	Tue, 29 Sep 2026 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688626; cv=none; b=uGmd6Goc96R2CwNDYq6INnledxEeNwzVt3ocgy2wVs9bS93xhdhWiiNbzRSxH5SrvPcd0IteXI4OxBrA4iF8R8TryrVQduQ7ER3/0E3SF0g6TfmXYrRYxUTnwwlRWWdtC4GjDy5U++kqjuNQrJ4wDv/Cf1S6PIdm33Wn7K7jsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688626; c=relaxed/simple;
	bh=jDaZ9QN1PfNQN7ekeOwptKaWTdUXlHDdlPTWkH0ZRkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHeyJvSguEZxSGcSvu4It7RVMlPTnNdGvKXdaW3sLOZik14YUh6UYhW2XDhgM7dmdhJsfuO+P097UF6XCSS9xsE2RV2K3QX1rSpGJMX6w3oNunYOlI6LEyTpGJ1TjGEY62MgchEfDOOQXTSmW2uW/8UUHEqFF2xiXo8RmlCN6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIuUtXQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIuUtXQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FB61F00893;
	Tue, 29 Sep 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688624;
	bh=YddyNBlBeMGDVbqSqWAWeupeImPN1+vt/HIPaYWlt0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RIuUtXQ7pN1ntHH5E9SHtFiVxk4VlC3Lx05nbDdqWgnrCoGrr5Kaw9EB3EurZOqnd
	 ver7PIljjQDwRadvVv/c0J+hSkjXNlJWDffpZQLU4o93+0nCvAAl0Ux4SYrhGz087x
	 /Em+ZWodHWV8OvgVNkTQErGD8adcsGYl1RKaedB7Hpt6DTY+b0QeVKsaMmFWtR0wIy
	 1brTzz3b1fmLHV899/10+jQutIesNgOTsfOa5laHgSWmjnUC6CSWuXFwsRIMHGnLYv
	 HGMSS19MSaUoKNmt7xqQq6t+vM1Gswc7Xht5EjiEDmf4hpi5r6Q6EcIVHkhsOwMVNz
	 JNZ4Kdafpc/Lw==
Message-ID: <45963e29-f896-4e67-87ee-ac90131773e2@kernel.org>
Date: Tue, 29 Sep 2026 15:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: core: Use EOPNOTSUPP for disabled blob return value
To: Inochi Amaoto <inochiama@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260929084739.467082-1-inochiama@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260929084739.467082-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/29 10:47, Inochi Amaoto wrote:
> Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> it does not reflect the function state correctly. As kernel already

s/function state/hardware capability ?

s/As kernel/As the kernel

> has EOPNOTSUPP for disabled blob function, replace ENOSYS with

What is "blob function" ? Are you talking about all the phy_xxx() functions?

> EOPNOTSUPP for a clear return value. Also adapt the return value
> changed in the following affect file:

s/affect/affected

> - ata/libahci_platform.c
> - drm/bridge/analogix/analogix_dp_core.c
> - usb/dwc2/platform.c
> - usb/dwc3/core.c
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

The ata bits looks OK, but this still feels like a lot of churn for no
functional change since the error is an internal one that is not exposed to the
user, as far as I can tell. The code in many places also uses -ENODEV, so the
error returned does not seem to be consistent anyway.

-- 
Damien Le Moal
Western Digital Research
