Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EF3909B3;
	Tue, 22 Sep 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790047443; cv=none; b=pWcA3S/saHeCMXVlD7Gviqt/69/Bo51FIPuQktaKTIBWxTgaFdkXwaZqUhSPNOAxBqI0XIGV9OdyGJeKeeaAwFfBxECjtInveL8QnVUHVwI2/hfe0jRI7N+k5Z8dNNhNd2PmtfBZm1c9Oa86AFnKjEspJ1n33t7lQwJRUF4RUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790047443; c=relaxed/simple;
	bh=XUqGq3E6wliJylX/FDBdHcmSuxDx6xPrEWs9647qYjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIcoz+1tiRCk/HSijGtmpckhcasTf0OuLWq6UOJjpjPaoJ1Cq7sJr2/1W87bTkZb+1hz8RfPp/i2SoNAofbNZrlLo9uCZRM7NCF8V1tqNEb/8uqzfkJUE+ZT6zOmVh3f/bLgbKR23gy7fLFSm+0jgkPfDP9vHy22PVU7gupY/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpMJC8Sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpMJC8Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2327F1F000FF;
	Tue, 22 Sep 2026 03:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790047440;
	bh=Ii3qyc0w1aYDJN77yU+YWW/365rbaC06cgQrcopc6Fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BpMJC8SyVUJOti0rK1Ie6MGWeuSoqdfPyKzTiQwdBRdYY4EI/SNW39IKeIQjIE3cC
	 VA4qzmdOIj+qc6zlDqH1lojF/6QtemOwrf7+HI1ZQg54dPX48Lg7HyWvEo+bGWWWbU
	 f+2oMo7f8ZRROQdvOJyhC316ig3XBt30r0S5qm726aq4SYYUOyl980MuUUHamYp7Lb
	 UAPG/mTuzYQlgL7v/fxhCT1fFstwC6c22j4CJhNHD+CrbVMibx5bphuSm6FK3kIiVp
	 RdzXvvrPKH4I6L5aexGN64U1ZUyNlI71UeUyUT/s2VFwc/X3aS6MPTty+IAOB2OqK2
	 T3JK08iR/TlSw==
Message-ID: <f0db06a2-08e4-4013-96cb-c6754f673126@kernel.org>
Date: Tue, 22 Sep 2026 12:23:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] ata: libahci_platform: Adapt the return value
 changed for disabled blob
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
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-3-inochiama@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260922024724.191412-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 11:47, Inochi Amaoto wrote:
> Check EOPNOTSUPP for disabled helper function as the change in phy core.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/ata/libahci_platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 6e072d681341..3e8ddbeb49b3 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -371,11 +371,11 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
>  
>  	rc = PTR_ERR(hpriv->phys[port]);
>  	switch (rc) {
> -	case -ENOSYS:
> +	case -EOPNOTSUPP:
>  		/* No PHY support. Check if PHY is required. */
>  		if (of_property_present(node, "phys")) {
>  			dev_err(dev,
> -				"couldn't get PHY in node %pOFn: ENOSYS\n",
> +				"couldn't get PHY in node %pOFn: EOPNOTSUPP\n",

I do not see the point in printing an error code name. Instead, let's make the
error message more sensible. Something like:

	dev_err(dev, "Node %pOFn: PHY not supported\n", node);

Or

	dev_err(dev, "PHY not supported on node %pOFn\n", node);

>  				node);
>  			break;
>  		}


-- 
Damien Le Moal
Western Digital Research
