Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE071367;
	Thu, 14 Aug 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165900; cv=none; b=XMPjCCqxkw1AXugvtxlEYGTQiXcLCvVTqw4xYo2ZaSRNT0OFD8LaErbLYx54L/0pFxdtWfnHUYSBskg3ZCpSz0nX+kqhjOtExjWmtq8V5IXKGZ7JyDFwCi1yt6jVWUUTqCje9qJj6qtHUEGrHv5X2ttYAFVVnX4wWuYjMCzUBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165900; c=relaxed/simple;
	bh=6eRZO0hVVKBcFC6WevqoMpTtS47SzqKF5hosBSUpqTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8iHuPaU+p3zgZfUkGXBQ4yYVkgIGmWVcIKbORxwkuyVhNuwMCY2b95FpQ1Gq/ygqV7IVShWSPbKKplAcXvXIeO7YbiyfL2ekDoOme7ifG/g7Bb6seA5zZaCHbFFqBoqPQMPxewouau1yfqfFUInvZE1lgTljRDUrE05jXfZ+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSoJ18vp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSoJ18vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F5C4CEED;
	Thu, 14 Aug 2025 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755165899;
	bh=6eRZO0hVVKBcFC6WevqoMpTtS47SzqKF5hosBSUpqTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QSoJ18vp0C6FZp+lzZ+OyZvhdBa1xT20JuHn6ccLkD4OBB4EEHC0MHrjmY2+9YIXN
	 tZhLw8OWZJtdpXRENLUQoInpQPkelUb2mPKdkbgNKeKLWsOuDJ5Bl1eWOtm0ie/BgN
	 0EC2eqeZHHDwaeHVKxSbpf9AgSJq9lYuaKG9OQTjmYaYhbctFF14472eNWp4+CNmlU
	 WUL0k7sZBafyv5XRN7dXo7S4eCDVYwIl+yReoHx5JQ9TsqcK63X3GBYSuGjHOun5sT
	 O0wpEyEMQjFpfyxsVYM4pRUe9eNc5FCOYjQBIxXm7eJKExf65m9EAPTdYWOpqJbqeP
	 hTk0x7Af+lU8g==
Message-ID: <790fe2ae-e750-4095-a716-f3dbb02e0570@kernel.org>
Date: Thu, 14 Aug 2025 19:02:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: Fix CDL control
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814022256.1663314-1-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250814022256.1663314-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 11:22 AM, Igor Pylypiv wrote:
> Delete extra checks for the ATA_DFLAG_CDL_ENABLED flag that prevent
> SET FEATURES command from being issued to a drive when NCQ commands
> are active.
> 
> ata_mselect_control_ata_feature() sets / clears the ATA_DFLAG_CDL_ENABLED
> flag during the translation of MODE SELECT to SET FEATURES. If SET FEATURES
> gets deferred due to outstanding NCQ commands, the original MODE SELECT
> command will be re-queued. When the re-queued MODE SELECT goes through
> the ata_mselect_control_ata_feature() translation again, SET FEATURES
> will not be issued because ATA_DFLAG_CDL_ENABLED has been already set or
> cleared by the initial translation of MODE SELECT.
> 
> The ATA_DFLAG_CDL_ENABLED checks in ata_mselect_control_ata_feature()
> are safe to remove because scsi_cdl_enable() implements a similar logic
> that avoids enabling CDL if it has been enabled already.
> 
> Fixes: 17e897a45675 ("ata: libata-scsi: Improve CDL control")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Applied to for-6.17-fixes. Thanks !
(Note: I added Cc: stable@vger.kernel.org)

-- 
Damien Le Moal
Western Digital Research
