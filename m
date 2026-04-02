Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84F224D6;
	Thu,  2 Apr 2026 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107563; cv=none; b=KkA1jh1WancmKjORYERbCYX9emcp4QTCKopgbVRusO448g+347IRp7BP+dOpc8ffGtTb1ikUzrZv7loI2dnPTNsIopVFFTHzQw1WdzIXO4fMi/ebdnyo9zjCMrlJUJF3MzFK5cZ3/R1ULWL/Fvsnos0pDoShmdPzgSTRgA5qRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107563; c=relaxed/simple;
	bh=qd/JxTv5xZAHXL1/Jy/xZr5yulaAMl+GLm/NxMf+s5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tG8vBJ5w30E35NOSK08V5A8Gz/PmJhdeMOSarUYUsNguM2+hrbnzuheZwwjAHqdeXfaMvdg+g9z7mr7rQARMhILmXn2XLWCSQXArorXJ+4AT2ZPso9KsQS0S2TPURSmUAMRyX7kHo6QLYpfPsxz4lz/IcIA50RKK5H2OCcvZsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4REQPY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4REQPY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D557C19423;
	Thu,  2 Apr 2026 05:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775107563;
	bh=qd/JxTv5xZAHXL1/Jy/xZr5yulaAMl+GLm/NxMf+s5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c4REQPY77pnL/1SRy/X/PvmknudVrULDyPSoTn/liQ8nBKFbpzJvgCuzOBe4O7czg
	 OTJpvjx02/03KFKTXMQC/DO62NrjLXfz3aGCCJT6r5II6RpXWU0v5qT7eszyfl9vZc
	 sVFP/26Qr5XFXZ42qPjPIBpOihwI2tCNi47IZgm+Yg5yHgVCLYuZSM4O++kBjXrJ63
	 vRfujsowpCSnjsD/OcQ7awXziX2bKwwmJ88H56HtGOxb+qNvdq0gwvAKTsWmMhyA+o
	 4Lff1ryob3dGlZL4JwKjhA+KBsLcU8jKnP+UFnd6ze+D07ybFRxwExlpSumaO5+XT9
	 apfiHkvIF8ROQ==
Message-ID: <0033e6ba-c1e6-4659-9ea0-aba33be6afb2@kernel.org>
Date: Thu, 2 Apr 2026 14:25:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-eh: Do not retry reset if the device is gone
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402011101.676267-1-ipylypiv@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260402011101.676267-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/04/02 10:11, Igor Pylypiv wrote:
> If a device is hot-unplugged or otherwise disappears during error handling,
> ata_eh_reset() may fail with -ENODEV. Currently, the error handler will
> continue to retry the reset operation up to max_tries times.
> 
> Prevent unnecessary reset retries by exiting the loop early when
> ata_eh_reset() returns -ENODEV.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
