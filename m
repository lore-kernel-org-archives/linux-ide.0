Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC228A718
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296099; cv=none; b=Omr2Rxo80a3SCqiH+HT3YZPvWBmn42jfHBgq4s3rqrK/QTtUAAFFEsfKPirLk/ibISIrudvFDWwswKy/3lqdu4mFMNl0eGjbW62boql3X48ZBdn/GX5fhr6b3rCAaCJdn129HzI/zxJG1hBV5GUd2Vd116MUjwYJWC4qolH402A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296099; c=relaxed/simple;
	bh=skat0xYJWM//MPrv20z8SThv5fRtkgX5Qc33L/KXtVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlP7uqCOpkjidI+a0lREEq5QtBUBAH5G15UHcqm9S348QXI9izNsoGrqgwWb1wleZ9hX90U3FCGFSGQ2yk8noK1jGJsGo//M31CmSzbkheNh6LQl+ukqzklJjOrAfy8m6fpV524BgiocM1pVcw062D53lJ7Li4pRag8KtGPP6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COC0YHej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COC0YHej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB84BC4CEE3;
	Mon, 30 Jun 2025 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296099;
	bh=skat0xYJWM//MPrv20z8SThv5fRtkgX5Qc33L/KXtVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COC0YHejkDaIYohRenCpjIDUU/3JjQhTIyF3i2vdQzZhlG1n0+J820utzmb3Lc3sz
	 8uzC+QvlaulKk22q7AVfx8ajQOEkHRf0LfX/aNkwDef2JSx6iftZn7Rs3Mw2qGq4f3
	 uyaHBr3wTUvFStfNMChKk/tRxp7LYOKiFFOsW3TXfhodJNBYXeb7INR1QKDRCDZcwo
	 lShhCpxq820RfkZydYvafb/+mYNAbl8EBuOSIjhU6fGLWfoZ3muJg9lE6i6FhANYpA
	 59nAzVruXTxQycghKiuVtckFeqTS2uD1jUgXxH119du4kgVYH+luiO+UsZ2UCfJuKL
	 RGS0zpD4awt+Q==
Date: Mon, 30 Jun 2025 17:08:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 09/10] ata: libata-core: Reduce the number of messages
 signaling broken LPM
Message-ID: <aGKoYG4cI05iFkpx@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-10-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:36PM +0900, Damien Le Moal wrote:
> ata_dev_config_lpm() prints the message "LPM support broken, forcing
> max_power" for devices that have the ATA_QUIRK_NOLPM quirk flag set.
> This messages is repeated for every device revalidation, which is not
> necessary, but also erroneously printed for devices without a broken LPM
> support when connected to a port that does not support LPM (e.g. because
> the port is an external one with hotplug capability).
> 
> Since in all cases the device port target_lpm_policy is set to
> ATA_LPM_MAX_POWER, avoid the "LPM broken" message repetition and
> erroneous output by generating it only if the port target_lpm_policy is
> not already set to ATA_LPM_MAX_POWER.
> 
> This change will suppress the "LPM broken" message for genuine cases of
> a device having broken LPM if the initial LPM policy is set to
> ATA_LPM_MAX_POWER through CONFIG_SATA_MOBILE_LPM_POLICY. This is not a
> problem as the ATA_LPM_MAX_POWER policy implies that LPM is disabled and
> unused, which is safe for devices with broken LPM.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
