Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8A4ABBC4
	for <linux-ide@vger.kernel.org>; Thu, 17 Sep 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668259; cv=none; b=YYZUVo5SLb1tgO/d9bbWi0Z2LxqJp4sWAh8oBvgF5O1YHa/lzZLiCUckBOEwa6+lE11WUmTn5PfUo2TSfbCC9vks+0a/ZXgswSOK5XAdT689YJLDTPn6hRj/TW/TvSCK6d2qCnf9C9uYflebchVfQfo/UbrC/kGgmfuLO6bx3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668259; c=relaxed/simple;
	bh=8WXNWTq+x/bPHH+/ADLPjJdk9uhlqy81TkVLbyOzciE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t4vkURj9olRLAI7/YlXv/ENJ4CahriRvcwfLCCAyTV77RzYELLZrHY5Y41fAQk6H+lEXTgNq1fXbgJUj4tPa0wT4VTLJlITXglNQ3EPcyUbX9OtYhm2RdqaE+/r7kLF6z8s8KiXETIokzI9/HQBAJTFk8QDBJlgoy1y0635HpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSrVIFKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSrVIFKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020011F00893;
	Thu, 17 Sep 2026 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668257;
	bh=2sYwEtgo9AM0UhmB4CNyLO9Nyn8N4IE9RU1Hzhi399E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CSrVIFKKuO9n00y2KvZmXl7ie67Jwk/27+qUK0ubJA/RrdFNrf38w7b4HOiLSl/Fd
	 QA5Bs7T2dxp42vQ5srGP/tzEeBuKTaMUQxN5GgrVOrEepmqhasmffQLEvhg7UyRl4A
	 LTLUsN2i3niw8jkGC/8ZOw3S2PLC0W0L2GgE3KGqQV+UN0fRTzt7Mws2oci61kwjim
	 FVC29Kg0W3bkS5k8xRcAPFNn4H5w5MsUuD5xBZJnIhH9F/6KD/N7itUj6G96Jjl1Y1
	 FDzN6JzOzQeh/Na029yLXrbV6u5rbiyB/SN5Ag9sjd6cUlzhmVsDB4jrRlaFZZvKcr
	 1oAWQhtKlqrZg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Nikolay Borisov <nik.borisov@suse.com>
Cc: dlemoal@kernel.org, rosenp@gmail.com
In-Reply-To: <20260917150707.1643330-1-nik.borisov@suse.com>
References: <20260917150707.1643330-1-nik.borisov@suse.com>
Subject: Re: [PATCH v4] ata: sata_dwc_460ex: Don't enable interrupt if
 libATA core registration fails
Message-Id: <178966825672.1473784.16622365868716742413.b4-ty@kernel.org>
Date: Thu, 17 Sep 2026 20:04:16 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 17 Sep 2026 18:07:07 +0300, Nikolay Borisov wrote:
> Recent 4bbc16a353a9 commit changed the timing when interrupts are
> enabled. However it didn't account for the libATA registration step. So
> it's possible that interrupts are enabled when the device is not
> registered with libATA core.
> 
> Resolve the issue by failing the entire registration process in case of
> failure to register with libATA.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: sata_dwc_460ex: Don't enable interrupt if libATA core registration fails
      https://git.kernel.org/libata/linux/c/e137035f

Kind regards,
Niklas

