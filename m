Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83148A8A4;
	Tue, 22 Sep 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055323; cv=none; b=N59BAyIQBO0MoIAkZqxCsb7snGDXJorRyHt3kTGGA5Xnb2tDuQaJoUgyO3a2HhXLOWGVTLzx3vwgBijBhxRgrW/o64dSnhklgbVCmJNBLZK1WG4pOU7PafcvcQr781g3218LmQUbCC3SowYS8goBnBJtYValDivzju3eP8+dXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055323; c=relaxed/simple;
	bh=JCWUuYoQjIHRjjVTq6RbNujuYoCCRtA3YDTPd40cmVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a28OkclRhBStNjN9QWoMaLUvs/W01WJx1ns+TZm9tg0ZwX9w7d8aXvKJHkXFjnl1aoWRG8DCREFPr7ul3NOjZhQYaKT9lAkALC1J4yn1PK1HfO3T23rTKQMEfAYOvaE6RVl61gPkyVtmwHWwUeFeyxGhlM6NdlpMd6mr8huqgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIsvkYIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIsvkYIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE741F00893;
	Tue, 22 Sep 2026 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790055322;
	bh=ZYB+hYGCWQEfwSVJqO8SUr9ROMxy5Ef20Zm5SUiNP9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wIsvkYIvlUY9UsSJ/aW+SnrQSjbGvHJ1ZN8sNav7y7N2VK528nQsLqMr+h10YEZrs
	 NH36ZRYG/n9KpCvh4jXBG9N5lSf0tOC0JKcowQwkyDRU1L7+CzXCttCA5xeFDKPXAK
	 VgF7FOX7Fi3Q7q37GHcSFqB1wMaHW3X1wlYUYZyg=
Date: Tue, 22 Sep 2026 07:35:19 +0200
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
Subject: Re: [RFC PATCH 1/5] phy: core: Use EOPNOTSUPP for disabled blob
 return value
Message-ID: <2026092256-shading-gratify-835a@gregkh>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922024724.191412-2-inochiama@gmail.com>

On Tue, Sep 22, 2026 at 10:47:16AM +0800, Inochi Amaoto wrote:
> Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> it does not reflect the function state correctly. As kernel already
> has EOPNOTSUPP for disabled blob function, replace ENOSYS with
> EOPNOTSUPP for a clear return value.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Based on the other patches in this series, this patch now breaks the
users, right?  Shouldn't this all happen at once?

thanks,

greg k-h
