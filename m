Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E247486B8F;
	Tue, 22 Sep 2026 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055276; cv=none; b=Z8KHu/oC/8BZ2pGpLRjhZwkKii1jnVwO2aKdUqbw2xgUk72M3qw4mepP2bGZBzS15jmMIuOzcpO0bQJDY9JsFqzGT5B/8WF6ipTK7Iwvd3FbsH1qj1LFpTsMKvlpiZT95mUocr/R4s18LH7Gz1R4Ew3/fyJ62FD+9oowajP9FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055276; c=relaxed/simple;
	bh=G5QWb085++C1NES4QHKSOkentZJJe/esSp7hNvxDtcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqw2RQr0OS2r/BySN6hA0X50vNZUaAm2huYq1Ky03N2ApBNp22GeIXV5rFa0Rwm9MF36KgEqScUqtIznGlaaoJM6yVklwcwCXbSOc4jA+P5pskm3WbOr9r1Gy7sgQFnw2N+Qzjsgv7C9ToRCfQ0LOBfFt9Wi/QP380VqJj5ah4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ozlkmqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ozlkmqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866421F0089E;
	Tue, 22 Sep 2026 05:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790055275;
	bh=yDg9zB+OcRSPGsH8sMFONNQJDzYQOBah6woULOymdfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1ozlkmqEZ5UoZqoZaKYxSNT7yfe/ybD/o1TG/HZHaD2MqlI6cQxlhIk0ozMIlLsBS
	 r8a8UP3pGxNFCAbY5cLCgQhr3gLBo0nEqZ2qbvlVePPFSXOn+OWDG3rFI8BLx76OTv
	 sB54JkYQk6I4b1ssxsK3Sc/J+VrgRTNfRIVT/oig=
Date: Tue, 22 Sep 2026 07:34:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [RFC PATCH 4/5] usb: dwc3: core: Adapt the return value changed
 for disabled blob
Message-ID: <2026092202-armband-avatar-0dd7@gregkh>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922024724.191412-5-inochiama@gmail.com>

On Tue, Sep 22, 2026 at 10:47:19AM +0800, Inochi Amaoto wrote:
> Check EOPNOTSUPP for disabled helper function as the change in phy core.

That says what, but not why.  And what "as the change" specifically?  Be
verbose please.

thanks,

greg k-h
