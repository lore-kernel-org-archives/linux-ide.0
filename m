Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AB4BEE4E;
	Tue, 22 Sep 2026 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057781; cv=none; b=TD7+qnt5j6ahL47p94WvtD50eKvSISMhjwDwDXN/Boq5JbBI3PiDrVk6v3sAVUr04iXxEq3xx81WRZ/WIqPDDMV7XuH/Z+scdih7CU2Jc6LRUkcdV/6Dz2d3nWPLAUGuA6PlC7o8AV/OytBD6/3/uEofFbY/4t5MaLB3gLlZmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057781; c=relaxed/simple;
	bh=gPB5OXPiC8coFdupEsNjA1qIrNwA1g+9vVsHUY1kGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spoF3d6XKL/K/OWsy8FIdjlHeD5D6PqYoNktLaua1PITLyh4WgfMqM5p4pPkJC1PFUWDn6FbApyWVIeIExx1yyFKa6d0Z6PRFqFUzdHcpxBMdQJRqEzIq01T/+MAvJ6uRWvOtXy4eQuNyztFStg03Clbz8kJSdQaAuyzfbr1gbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqrIcQhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqrIcQhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC01F000FF;
	Tue, 22 Sep 2026 06:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790057779;
	bh=/vXLc3KmiHI0BdjyOF1vVkIbnWkhf1p3DV15kYagOYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VqrIcQhRzoFpQ4mdwFaOO4d2ucIiLTQfGR+B0kTVhDNUqpSJ27VbNBj2ECshiJrti
	 /WZtLKuX1Mr2jtnAeLuwPrFkWIgy5zGnGcUXFxgsuxYek8xiN5A5S0Luntdw1VvKga
	 UjcTyJz9HRL2pp93ewAu7I/ul0GE68KgWqKt1CA0=
Date: Tue, 22 Sep 2026 08:16:16 +0200
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
Message-ID: <2026092236-breeze-educator-0f6b@gregkh>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-2-inochiama@gmail.com>
 <2026092256-shading-gratify-835a@gregkh>
 <arIZX-0aMQiabxJd@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIZX-0aMQiabxJd@inochi.infowork>

On Tue, Sep 22, 2026 at 02:10:01PM +0800, Inochi Amaoto wrote:
> On Tue, Sep 22, 2026 at 07:35:19AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Sep 22, 2026 at 10:47:16AM +0800, Inochi Amaoto wrote:
> > > Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> > > it does not reflect the function state correctly. As kernel already
> > > has EOPNOTSUPP for disabled blob function, replace ENOSYS with
> > > EOPNOTSUPP for a clear return value.
> > > 
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
> > >  1 file changed, 26 insertions(+), 26 deletions(-)
> > 
> > Based on the other patches in this series, this patch now breaks the
> > users, right?  Shouldn't this all happen at once?
> > 
> > thanks,
> > 
> > greg k-h
> 
> It will break, and the change should happen at one. But I think
> the affect should be limited as it only affect a special edge
> case: build kernel with CONFIG_GENERIC_PHY disabled. So the
> break should be limited.
> 
> IIRC I was told to seperate the patch into small part so each
> maintainer can take its own. Is it fine to squash these patches
> into one in this a case?

You can't break bisection of the tree, so if it all has to happen in one
commit, that's required.

But really, why is this needed at all?  Who will benefit from this
change?

thanks,

greg k-h
