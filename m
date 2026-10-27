Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132977;
	b=MQCZAjjR0mrF4LAxjwiFD/4bCG4teSIuznSKz1KXr2IZZTi4hTROzFR465UqUt3dg1CO
	 aoHl/SSFxODHvyp9dqEJHVEvgC9vwAB5YAlRru+cciGyAr1WCLVgkLBk/v4deB9E9wxG+
	 Bt//oOUHkY0F690Cis2AefEd8SM/hoLDRUsUyW0f7Z7qT4iuCmJ7oUcAqkpi/XDep66YL
	 3QnGmAWGAjqA2Yj6MoNFx8UlTSgi5o5n82opgqCihfNN0fgkv21APDjtVu38QweQN/uzE
	 7GS2oCeXjk1Fk/p/nqUgLyooUDnddxVUlQCM0ssiLrtS5Jq0oWYNEzwPjSFr1+O9Azw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132977;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VAlgaavD+P4vxDan8MQm7ez26uYacnSaQulF7ZR2j28=;
	b=WoFrtjTZZOG6HhJgkT5RvSY/eGlmCQSjtFB0swUldAP5THOeT/kOTkR3QfXaeFHGAb0y
	 xKG7ivq4cYndQQcLR6Gzf2V8Uu3JYBh3lUEwopII2GHqtNTlJWLM2vvsNdvFvMdgWm/Om
	 AX+YFnxjelX1avJO5Tun4uYv9Dgns+HvCp7xNgaGe38L1IqSdiHb4gEbqpJwPZwSZYhp2
	 LArhVNt8yl3KGxPsmlGDQv0V9AabqkNI4gY1RBnphg/SbqFtB2OyKGcxacCJOl+tSw86W
	 06iu+9Ig3PbGKmm4AOEf3EH99TdnxoSP1SuJHxXy5Xd9dCohZLSpgKCEUVnQHC2kh0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6i9ox92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04A606A31A;
	Tue, 27 Oct 2026 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6i9ox92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96651F031EA;
	Tue, 27 Oct 2026 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132976;
	bh=VAlgaavD+P4vxDan8MQm7ez26uYacnSaQulF7ZR2j28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l6i9ox92KJgI6S9hzMiBZsJ6TdT8SRTvjvQWG9P53XWWEtsd016cKb2whxxUK7wmd
	 6eEe/w0v+RbdkDgXvHVrpk3UAYeTqeT9+LjtHrcd8YUjAeJYE+RKWFmgkJW7rCHi1e
	 YGlMQti26NWdsVLvi5KUundKYdYpsd/ozrzgRD9EFPZ5QzW+4e3P1QKSA4L+8E8oL/
	 Sk5KJuQBqR/YusUi4Hm+9M1HB0sts28Z4QT4i2Uq2ygGDhPUi34UnxiM0IWl9o4fM2
	 WDfpFGvAzDRttrR3WDBM+cx/I7GkC5RfgcIE3IYhVK5uTbC43zni3zvaT09jgesB+A
	 pa/HDySg64kFA==
Date: Tue, 27 Oct 2026 21:29:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Giuseppe Piscitelli <ooonea@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Check device support before querying
 power state
Message-ID: <auEJrdh5CfpJoFdj@ryzen>
References: <20261026202513.669084-1-ooonea@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026202513.669084-1-ooonea@gmail.com>

On Mon, Oct 26, 2026 at 09:25:11PM +0100, Giuseppe Piscitelli wrote:
> The standby path queries the power state before checking whether the
> device accepts ATA power-management commands. This sends CHECK POWER MODE
> to ATAPI devices, including the QEMU DVD-ROM, which rejects it.
> 
> Run the existing taskfile initialization and device-class check first,
> as the active-power path already does.
> 
> Fixes: 9cec467d0502 ("ata: libata-core: Do not call ata_dev_power_set_standby() twice")
> Signed-off-by: Giuseppe Piscitelli <ooonea@gmail.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
