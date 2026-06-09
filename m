Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EF15C14F;
	Tue,  9 Jun 2026 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048336; cv=none; b=p4i07AX9fGM/bS8td+2gSysUd10/mL09oxldNMA4BQidO/ljypOeyezBKm4CDTX4YTomSaNg7U4y4bJYlx+GUz+FRSeuAB+ORZjfHcJVyJW+NYFXLBTicMQq1Iwxs2xTdA2QUE5x7+W2/PrZcRf/9RRZQ32wGsDbhyzUCWk7CxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048336; c=relaxed/simple;
	bh=8PtAsjN49R+LZx9suHGPiubUdsy6ewC8TnqOXbh/rOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUVWEDMy6MlGKFuwP0QPeZw9SMNgt0TOxfRuRvywMigz49y23SPeGF++YNZKwRte/EA8FhhbZTf9B7Yu1FV6X/5zFqWif+DI79ee4RkMH8Jy+qJIQhYcYdJDIyGdmoc3dbDwpWnVIV//S72UDHP9Rfdwy5VlBCOgvl8YfcvIu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEvpmECD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEvpmECD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958451F00893;
	Tue,  9 Jun 2026 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781048334;
	bh=jbh2rY00akJ+3fSsC9PI7cf/OSLqCrUZkMdmNq//o4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DEvpmECDmUKhaO2WzQCSiDWTJtTJ4AeUxbgpl2rBqKIcRhVcZ4WKF6RwsrJRQcgOV
	 F633th1va4uhRdpTp2wC8EPWM4B+v1Hc4ti/lX1XtYN+qX0nNXQ9DqnKGf28hrI+dT
	 WjILS/ANrYU2KK8kMFCFqO0BGO3vfbRAySeB1XYLaQ90hmfAPtYSxp77L7NOPSOuAL
	 OQ4ZhJOadjYVn68TfMWyi97F+XpSKzcXvBze95fnG5avY5lSxFZxJ67bAcjrR/i+KJ
	 apYyVNmb5xmPMYkvUaf4lUcBekLNjcu1YXm4PlriG4Ny7VqyVA/VHTrjmVVYnwXiGV
	 JAQBZHmlJgJJw==
Message-ID: <36a6f569-9876-4a34-8ed6-cc013aed1469@kernel.org>
Date: Wed, 10 Jun 2026 07:38:39 +0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ata: pata_isapnp: Drop unused assignments from
 pnp_device_id array
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <395c2f2ed11614410956337fd0e10b7adb47f8d1.1781023750.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <395c2f2ed11614410956337fd0e10b7adb47f8d1.1781023750.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/06/10 0:51, Uwe Kleine-König (The Capable Hub) wrote:
> Explicitly assigning .driver_data in drivers that don't use this member
> is silly and a bit irritating. Drop it. Also simplify the list
> terminator entry to be just empty to match what most other device_id
> tables do.
> 
> There is no changed semantic, not even a change in the compiled result.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
