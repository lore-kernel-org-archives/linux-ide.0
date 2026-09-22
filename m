Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1A4A64C5
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057456; cv=none; b=Fee7dbdcmBv4JYjdMvUPm0AOA7e2X6ZgucaoAEQGm7FKiyEhUaBO864Xqu0+ooYdixHib+vzHV/O3yGBRqt2WA+GSmWXdbMFOoTMz2orUVHpFikZAenjw6FSHH8F+eDbVu9qSkAeNSKC/2rHKa+cgFHDep9dn5f3SarRISHnhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057456; c=relaxed/simple;
	bh=RokqHc4jdSnvvIpwNsLlY1MRsxLWarU0I9dgjhB3t0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VijrzNFIK7aMpwxnHUAc/OW0PVb08Z0QH4r9Jdla64ORmZl4d1p74o7USCUj4BlWEt/8Ww8brUk2/yrCa2GGKcnjhinfohce/D8bCMz07Z7rF2MB/Wnjsu2sFMhj+D5ZpTPvlOT78hjwAzS949rl9PEidrqgZepyiNB9Dbk/lLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw4TqhG1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw4TqhG1"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so2966409a91.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 23:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790057455; x=1790662255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=918Ed3YoBXTCboO/8XC40Sz5nROxBXuKCN2wfNcGPBs=;
        b=Yw4TqhG1YshOHpQsEDiGCM458s4+hM6rWQmwwWTGJNiI2FqlFQH1Hl6BAhRB1uo9nh
         gqRyv4UqT6d2e1lVOMqpuXy2glL1vR8wXUIPLpDn7s5ZY/Kk8Ydp+OGq3j9XWGXk9gxB
         rdJ3sLqTVZFVZFZSuSSnezwyGGSOSxKtidrXAjBXSHioFahyWZlzDyPpxdrJnW6+C0Vp
         hSt2WmnvlfrREXYVTH2KgqOHbNy113zhaf/Xw9sGgLcMhKheFCBLilnsWX2DsvkVyO0/
         E4jEDE5jKEUOQUGRI7o871ap0SRysc5TkIpgNLx/qNozjWbJCyU9Ia6SIrWYyMC0Lwaz
         eplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057455; x=1790662255;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=918Ed3YoBXTCboO/8XC40Sz5nROxBXuKCN2wfNcGPBs=;
        b=cJtySzu4eLEKPEN3iJEqZu8cLEMmB0TAGbaGuHoEZGwY+W2VaYmm8Q7qHZXItBFUGA
         2X2XImUr1eC1n+8wGVkhmneAtGvEaE8Sb5fiGCSyLcGwocCx117Pg91NbsbE/nyq3Q/C
         Jg/OsEU48EODSJlI5S+ypis18bycdtp5My4ci6msK4ojSHOZdhRKS5cW1NAlCV39CCmq
         vKR7XPMDtQtLfTKAGK4J3WqFiOVBV0yc7rylXeFxq0rl0lrGfM0HReqrgMgr2ORIgZFD
         dMxljuCbiOzW/mRMpRrs7nTF/WjZWsH2Fmu/TF3+bcvr+He28b1DkiYCWnbzP0bKkvt7
         EGsg==
X-Forwarded-Encrypted: i=1; AKwUvBzQyF7F9nLYrHiJxTXeTdDu/Di/0qyq+Mci8q1quAuOqAH7ty5OlrxilLYajQeN5ODrpUL36sEMwMI=@vger.kernel.org
X-Gm-Message-State: AFuF++nZoosSOjpJ0ITIWhFHTZu40SLQtuWD+kficmOcV4Bfiae31YQB
	wufR1xTcvjfU3U1akj1qJ/10cXqK6ib5DqmUsKQtIPUAK5DmO1OlaGIZ
X-Gm-Gg: AYBFou3RiTujw5FU7ciiaXOTqbnyi4VMjvGPLotmjM3g/YZh2F7B0eDwBybIP6kUxyd
	6aDTqjtrEiEF/EHLtkywVSipDYatgfWSBOazm4xoPA/StFciwRG4fijNWzEG4ZcrGbMlsGzdgQq
	pImyxjyvkExDom6dnOTdFPgEqvVp0q4TXuzqN80mDLk9O219Ykd6vsJdjbzLDNtwYceQV7nnw+m
	ib+Bblzca0QPmQFoKPq1GhftN+tnfwFs+Ema5ah9A4XttogjiBuEm3I5g4W0/Vc/cesguVEhPpt
	bFzNcQByQ8px7UxaxTX9b/wo6uCcTblUcp+sJMcVilf82jYIppEnuh0JpXf+Iu1YmL7IW2LOuSr
	K6Iv4ZF6M43UXqqLKBR8T98zwVY+R7EhxRNIYqwU0LDOA49bxZU/lSXRBTtnSy+tXz538WlPmqT
	s21u2sLRB83DtgqQYXmtFhpA54uOQmPcoLyaEQJaO4sid6bXwqGkwN0h5HPixO9lLkyHHF7Ps=
X-Received: by 2002:a17:90b:5105:b0:39d:f731:e5f3 with SMTP id 98e67ed59e1d1-3a073116712mr140073a91.24.1790057454636;
        Mon, 21 Sep 2026 23:10:54 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5a5eb4sm1489775a91.14.2026.09.21.23.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:10:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:10:01 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Minas Harutyunyan <hminas@synopsys.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Damon Ding <damon.ding@rock-chips.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [RFC PATCH 1/5] phy: core: Use EOPNOTSUPP for disabled blob
 return value
Message-ID: <arIZX-0aMQiabxJd@inochi.infowork>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-2-inochiama@gmail.com>
 <2026092256-shading-gratify-835a@gregkh>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092256-shading-gratify-835a@gregkh>

On Tue, Sep 22, 2026 at 07:35:19AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 10:47:16AM +0800, Inochi Amaoto wrote:
> > Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> > it does not reflect the function state correctly. As kernel already
> > has EOPNOTSUPP for disabled blob function, replace ENOSYS with
> > EOPNOTSUPP for a clear return value.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
> >  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> Based on the other patches in this series, this patch now breaks the
> users, right?  Shouldn't this all happen at once?
> 
> thanks,
> 
> greg k-h

It will break, and the change should happen at one. But I think
the affect should be limited as it only affect a special edge
case: build kernel with CONFIG_GENERIC_PHY disabled. So the
break should be limited.

IIRC I was told to seperate the patch into small part so each
maintainer can take its own. Is it fine to squash these patches
into one in this a case?

Regards,
Inochi



