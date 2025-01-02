Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B67E782;
	Thu,  2 Jan 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844286; cv=none; b=Z4kBTDp0nKPu3KmbWhVW5LFyQgCMu2fLbmbEnAoqfi8jTgUMqO1lROI6QFzATSacKpqBTkr1JGox4Tip/IZPhfQTRifQq0iABH6mixg3fgjcmDiSHwmoO9ZOWW+e4enVJ1efeceq3kWMkomTlNTEckxrhR9Ur0/Hp+BKFi6uB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844286; c=relaxed/simple;
	bh=ifr+rM2wbqLz1g6wpl7uHrjJhiMHA2Tg5ejsBvR2lkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxoPuNZPlDFdA3vvUCdOU9kjBro7PS53/xC4Gd3RfX+ZNgHc/sYeP3JW0Utco+iHua+d4l3e5thx8BFpWHpjMYK/JAaNMZtGtyMKcfGzJDHxow3xO021FEvThEfBdGuOSTsso40QuvIGwhburnclvN7n9YIhnzMKAdCaofR5At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvA5S9/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvA5S9/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68B1C4CED0;
	Thu,  2 Jan 2025 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844285;
	bh=ifr+rM2wbqLz1g6wpl7uHrjJhiMHA2Tg5ejsBvR2lkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvA5S9/2o4/RLnIQusHHRpuW1nkjDUTMAgZvElfXkh72p88VS6QbODz75WxXd+p9z
	 fMiqbTg/hMZp+8ZvEToU7lI4/IPfayP8SgAMiX6qDraEVvZhZuxT24gHrAD4TzypDw
	 2FqcJLeDL7bXYBNlkVePMdbFbpiNIxfrt3wfXrDoUChBUJks56NTcf/OtK9EezzGqT
	 U4PrjrHgkJ+MuxDmNdJ1Gxjo0m8qULMKl9zUZHjR8qkXzk+RgzuiZN92CvRlUYKApj
	 wSHUJas7Rq3TrG3vKWQSkQ+3PC+IIq6wXoNBLZwULki4HwKkwSnhtny8e0dpxpiiD1
	 zA/cD0VOThXXg==
Date: Thu, 2 Jan 2025 19:57:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: robh@kernel.org, linux@fw-web.de, dlemoal@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk, hdegoede@redhat.com, axboe@kernel.dk,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Aw: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf
 conditional failed
Message-ID: <Z3bht59DzN8yXjvX@ryzen>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <20241111203611.GB1887580-robh@kernel.org>
 <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005>
 <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9>

On Thu, Jan 02, 2025 at 06:44:32PM +0000, Frank Wunderlich wrote:
> is there any new state here? got no answer for my last 2 Messages
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20241109094623.37518-2-linux@fw-web.de/
> 
> sorry for the html-entities...they came from my gmx webmailer, it is reported multiple times, but i cannot do more here :(
> 

Since this is a marvell change, I expect it to go via marvell / mvebu tree.


Kind regards,
Niklas
