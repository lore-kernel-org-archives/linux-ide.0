Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6D136351
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893912; cv=none; b=ZZ6qJXAiRE0xY1fLyaxU1jkTMRFQt18EYOj3teJU1UQsF+iqDxAVxjwcvorikOhkIDD9Fw5Zo5WO3ZYmZNHbabypJz4MI52siHairR51OT0WiHe3APoQFXTxpv8zJGULCLCQFASn6uxRswAkuFgYdQfjd7SGNZVEeetPK+B1jqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893912; c=relaxed/simple;
	bh=VnnpFY8FQL6LthiOs2kUrRDIM2H4s1LzlcF7429vivE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=u679egWx0HvzlIe4dZXqwgrap44i/romP/dYgXoHOX9yObnWgAnCTggY5qqlqdxNSAO9IvZPvRlqNappMeTNq4PrE6tsS3zV9SOI06CgEaD30HlK5Sey2aWcENCfWVpyfxvhzhrnvtLjwEkz3ECzItpNUceZNc8RhHPmjA/CBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icOBXBi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icOBXBi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A639C116C6;
	Tue, 24 Feb 2026 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771893911;
	bh=VnnpFY8FQL6LthiOs2kUrRDIM2H4s1LzlcF7429vivE=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=icOBXBi9OhQjGleRAU9HGCeLDa+5DpoB+sJstFmBiU/uE++x+dyhYKb4GIR1pl3J7
	 U5gKEpQmZBeIiTmC14e3BKoEa/g91sdbLwPBDYNoX5Q1wBORuiW6ecR5q+LY5V9T/d
	 9/hI2lzwkAm13ZRWjucXY65C7Ce4DRSeAFM2YgyOByyUo7HwMhux9EK1escqzu59y4
	 3moSsbrbR2Qn78Vfw9pqDb+nC3+Up3cX+NfeezxurX5AF2QTIi3ndUvePpXsWuviXG
	 U95kuUmbP0icT7CuyGqe42xiQy7VUMFsTaa5OTd9NXSFg6Es7x2rtpIeiniK2jc3My
	 /UUKVJ87wloHQ==
Message-ID: <ef056893-2609-4daf-ac03-a7be773b3b43@kernel.org>
Date: Tue, 24 Feb 2026 09:39:54 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20260220221439.533771-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260220221439.533771-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/26 7:14 AM, Damien Le Moal wrote:
> The first patch addresses a use-after-free issue when a deferred qc
> times out. The second patch avoids a call to a potentially sleeping
> function while a port spinlock is held.
> 
> Changes from v1:
>  - Corrected typo in patch 1 message, improved comment in code and added
>    a WARN_ON_ONCE() call to verify that a timed out qc is not active.
>  - Fixed patch 2 to not call ata_scsi_requeue_deferred_qc() without the
>    port lock held. This call is in fact removed: it is not needed as
>    ata_scsi_requeue_deferred_qc() is called in EH, which is always run
>    when removing a port.
> 
> Damien Le Moal (2):
>   ata: libata-eh: correctly handle deferred qc timeouts
>   ata: libata-core: fix cancellation of a port deferred qc work
> 
>  drivers/ata/libata-core.c |  8 +++-----
>  drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
>  2 files changed, 22 insertions(+), 8 deletions(-)

Applied to for-7.0-fixes.


-- 
Damien Le Moal
Western Digital Research
