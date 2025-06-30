Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258528C2DB
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294848; cv=none; b=OVDShmETt7DAcYA013yEoLsmgx11kuSk/dQtGeMXIktrqcoUbhLz9a8NMxst10ZYfhoK4bRQn4UMT7RDorNlGUTWP2RMIcuvmT6VDUvKdTgksV8oiymbRO+uUNmGSiKTwvK0/SVBCL89aeMbzAjD7LnyPZpjiO+bvjgbUMuPfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294848; c=relaxed/simple;
	bh=qNaHvDSda1jkJLXbBxVkmtJUem8JaUqg5ZWpPBUoiB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1OxD6keF8Mfbt/v219FuDPkFYpW+oIeNPQUv1Tztt7BjWfox3CPw6npzwYMxnHIWYMg29EErzRi898u8k7Nl1cjde6xtEPQtpdMNGYUX5MCN1FdfIktT2lJ3zG1oRKzb+IPsFeINITjBG9R1n051nTGw2hmBW/6UV/9d3LRoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AndfYOdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AndfYOdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0628BC4CEE3;
	Mon, 30 Jun 2025 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751294847;
	bh=qNaHvDSda1jkJLXbBxVkmtJUem8JaUqg5ZWpPBUoiB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AndfYOdc//9q7083k19I1xr69056ZsHOjYd9Iv0BaRMumHTJAShnupfb18UPXXW/T
	 12HeH5A8nCMcHccS2TG8u+3/TmfyTKea8KgLltVpjkyhO1/AAMnEZ/dJUYxQmXirDC
	 pvk94GafTCf/+c5o9rEGen6rL5DS1sVdrKoklrayyumAyI/rMV71GjlHRJzoRB6sJP
	 v61mLM/YajpI2JfuhqoOK89XZLoQP3LLgMasrpFMPQ9Pir0dW05rYuYc9zdsDKj9sF
	 YGu1mSebDR1yKxEIda+qtpFv06EEK0DvHqYEuO98YasYKhz/uADiEb1uIWxOxMMG8r
	 axKh3FbqB/mDw==
Date: Mon, 30 Jun 2025 16:47:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 02/10] ata: libata-core: Move device LPM quirk settings
 to ata_dev_config_lpm()
Message-ID: <aGKjfLFnuuXZ0Mbx@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-3-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:29PM +0900, Damien Le Moal wrote:
> Move the various cases of setting the ATA_QUIRK_NOLPM quirk flag for a
> device in ata_dev_configure() to the function ata_dev_config_lpm().
> This allows having all LPM related settings in one place to facilitate
> maintenance.
> 
> No functional changes.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
