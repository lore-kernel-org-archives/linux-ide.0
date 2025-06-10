Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B2298CC0
	for <linux-ide@vger.kernel.org>; Tue, 10 Jun 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558819; cv=none; b=M2wjCMW+yEzON6WK7FHVosYFlWRBCBAM/eA0H8iyGZpI3xDR00yg+qwQPpMRFjrZvtNmpLJiJeof6YOamiSMnvFxRGPlWiy7z0Af/ohaS5ZXEeSYUHY/1aDTcij1JrVJsUGxnaXIXQNZ3dGsU0WVLHqIhotue5MDDQAznp/PZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558819; c=relaxed/simple;
	bh=T9p9xeAgTheeQF1IllfvuzFT139gWb/t0q8PYu9MUAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V+06sGGup2m0Z85hjJbgpNTqHYXcYnCP2su96EPIr2ANxiE5zPT5Y+U6XbnrQQAy1jcPfQFo5557zuuXJv5BmMhr4mUfRscXVwJWEGi5tOrvtZ9HQp/eqc6BvbwFWpYahtL+zCOJLWP7Rmm4WJrP1SnqCp+Yh3YemMGXMWja63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9cyoHCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9cyoHCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51282C4CEF1;
	Tue, 10 Jun 2025 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558819;
	bh=T9p9xeAgTheeQF1IllfvuzFT139gWb/t0q8PYu9MUAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d9cyoHCxHbU7qKoqYnvv4o8kv35VVtdjiMJG3J5t7IyAN2kh/BuuWudyo+00obaYL
	 nzEEdOC9J4FhX5qarHTuCdyZTRCTzUqaupGDrTS6VyAeY9kWVTxZhaE6frdEEcEHJ/
	 g/jCep61QJ3z2AY1r85VRDf9lz72/V55MvozUrmjesyiVt7sBPaA02b3PWNFzjnndj
	 4aJq7/5rQhE+QZGxegUvONXq3hwMFjl6lNTD7I+1O6ebb3RHtOTZN3mi7cV/ffBB/1
	 Y7PH9xzZDj/U/fdu/irtIloJ+He4y3IKhwBWFwAR3veVqJ4prOaXUY6hbGU41uAfmr
	 2w4XVT/LyA0qg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Tasos Sahanidis <tasos@tasossah.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250519085508.1398701-1-tasos@tasossah.com>
References: <20250519085508.1398701-1-tasos@tasossah.com>
Subject: Re: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on
 VT6415/VT6330
Message-Id: <174955881806.1439612.10734581495050489291.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 14:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 19 May 2025 11:49:45 +0300, Tasos Sahanidis wrote:
> The controller has a hardware bug that can hard hang the system when
> doing ATAPI DMAs without any trace of what happened. Depending on the
> device attached, it can also prevent the system from booting.
> 
> In this case, the system hangs when reading the ATIP from optical media
> with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
> Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
> running at UDMA/33.
> 
> [...]

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
      https://git.kernel.org/libata/linux/c/d29fc02c

Kind regards,
Niklas

