Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59C367288
	for <linux-ide@vger.kernel.org>; Tue, 22 Sep 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057521; cv=none; b=XFi7maLRRWV2msysIafytjnBphKHZLap4ZFqwOfALx5L3iAOGglwNfu06wpiFNWRu21ZihzRNHHKQ6KGiowlQeiMpXOsmxDWWKMggcsT2HcpJQS0Dws/ltDQ6907+hN27KUoE22IREJITym/2tKi8bEkisUHsBLqRCfrel783Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057521; c=relaxed/simple;
	bh=E8YVM0lkb/F4gw1PQaH0+hECNdTEEr2VOF55Jy5TLIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9+3/5Dj2jNN2CwhRSL0ndHJKd2+jak1cZlKWrtWW6o4fdv0dzyhchDWXhAeGlc0UiHguwt9zXlz2TAGpvfcaIUV2oBb+4wstrGT0ycjyfSCY1g4IGRk25QuEQkqxvPb1+IFOIffWb4C+qvhGeD5GnMp0/TK1AGMrpuHNBEFs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwDCT5uh; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwDCT5uh"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8631d0023daso2774438b3a.2
        for <linux-ide@vger.kernel.org>; Mon, 21 Sep 2026 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790057519; x=1790662319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KARpXPYlM2wZhUyrKSogeHTLUD5EXLXuvN4rvW+uIK8=;
        b=XwDCT5uhRQ7K14nuhlXtK+CQ2AqUDac+8WMSbMqe+SkXu1wBNlvnAHjU88ECcE5PKO
         6Wd+5lYk61vWgybtcS8FBCg4AxLq0by7j86V99XCCmQw6ctrdtmr2nSrkdcluSZoVYT8
         Bzqv/RjNZ34vgCXJUKcAbSrTT7mU7tKsb+YFpjOPhH7m2f/qczDzNiFgG4DWIzjGrry6
         30NAntTrCbHMh4XXNGTyXyUUA3eyu6qbGNLJusFpFn1KxcLvWJ6W9VMy2KBihfmE4Dsb
         xHx0BNljnBeYWiIfvFWthcyaXArCAp0DSu5bWZkjrfUpJZV3mjNvBqtXnsZhOFsPSmRa
         f7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790057519; x=1790662319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KARpXPYlM2wZhUyrKSogeHTLUD5EXLXuvN4rvW+uIK8=;
        b=pXRyXiJNjitKo328Fiq14oa6DYdDIQZP8CKxqEmLHKc/oD1w/orfKZFGaGomF6sSvJ
         3Y/DZoWyIQrhE2G4knF74sUkSsAsa5FlNFCOEjF3rncdhA7phbV7E92MZD7oAZC7j2fv
         R69DiW9ToUuOK1asXU83sAWdVib3CLquZHHasGbxpaxAFepXFMLmCGtxcCN/nUsBFgBq
         d47PCfn62tl/r1L1wtdNLNjc6zcIH8sHNUQMx+Bwfg3F/gkTHgfHD9alDmOdBG+v5L6A
         wISoUtXbw04f+fpVmSJM3J0q5CgNluigmgjgPiO0XKZ9NsH8NLPRXsAEsc9zsFF3i/aP
         /aIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYOJ9K3yegtfvO5atDkPYNQXCvogQWvxJr+xx/B/Iq6klY6cFLdGFODdV/wVwTyEk2UYTZQQ8y0o4=@vger.kernel.org
X-Gm-Message-State: AFuF++kkzupiAkUfAEiL99YaRMWde9FdNgm4f/2UE355TwZtl5wn4QMe
	uRWlGivUKI+juJNGyv4ZyqtqiLhPshqmCXetwTJy4d9lUeN1f1dibVr/
X-Gm-Gg: AYBFou3Bul9zzup3b2iz8hDIEgDybszKDrVFLLaktBYj9HK2HhqQr/yZo0roV0gTgMg
	1aFEmI2/eTLyI12PGfLrniyfhD3uO3iis4+D6iIGECh1b7g7RnGMObcqPjVOxge/Xxk+Az4hMzQ
	+y45+sEt/97T7vx5CG9MlBP0EbU31jSoIZ6jU3Pyt5Y0/ovJxKLH23RHo9dN12OK2NnvvC7RC5z
	/JlxrogY6X7le5SRw+4oLgyhQpH4pdv7ro3uafdP5/FEU9LlBM+quv7XWkVOv61M1rB97T6/6fT
	5K8Sa5Jym0YqtsWHLrl+/Kp7/6pHF+l4Pqi8Vli77Xd64LTO8CHZ2HxEP8bBZXlpG13uYTIq7VY
	HjOFvgVNYwxTRd5KGUxMeIdjMx8yCQx3fB+QmjfumDyXxUjTCnwTHe8esO0+VphHE+IKWOxmBrU
	8RF0qUP/GHfGkYRr1V6AM7xAvJaBZYp4Mb3mruBgyMiudeUZKqLwPxT3F8edlTEj0eFU2R
X-Received: by 2002:a05:6a00:844:b0:879:1046:f4a2 with SMTP id d2e1a72fcca58-87c83c49a03mr112992b3a.33.1790057519137;
        Mon, 21 Sep 2026 23:11:59 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c31ee8a96sm317135b3a.20.2026.09.21.23.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:11:58 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:11:06 +0800
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
Subject: Re: [RFC PATCH 4/5] usb: dwc3: core: Adapt the return value changed
 for disabled blob
Message-ID: <arIb22v8tjUBpGEn@inochi.infowork>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-5-inochiama@gmail.com>
 <2026092202-armband-avatar-0dd7@gregkh>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092202-armband-avatar-0dd7@gregkh>

On Tue, Sep 22, 2026 at 07:34:31AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2026 at 10:47:19AM +0800, Inochi Amaoto wrote:
> > Check EOPNOTSUPP for disabled helper function as the change in phy core.
> 
> That says what, but not why.  And what "as the change" specifically?  Be
> verbose please.
> 
> thanks,
> 
> greg k-h

Thanks for this reminder, I will express this verbosely in the
next version.

Regards,
Inochi
