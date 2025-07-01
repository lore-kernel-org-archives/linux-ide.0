Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38226E6E5
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363103; cv=none; b=RskHESrZdM1OJGYhMcguxR1T9xYDZ1htRrum6B0xXQ4+8Tb1GuaVzdBt5xepaqz7txVZHnHw8ypujP46qvzqZBiSmGh6pIwlAjXvSW/X89lH65uSstbMYFUfqk8hD/g3PCEGxZ39Z5uoYtxHab9jFzZUuoOQwDkryPd12zR6tHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363103; c=relaxed/simple;
	bh=/EpTtZqs/0NQHCyo3IwEF11uyO287i6laKYVgvU17Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPZOa6wqF97PdcRRHh4Xm/ku/P9fDBjkPO4MIuxqapxPWzH1wmZ822ELDygAZWmGmfGupLhrumZWLAey4RMsEPdg0eiB5Q1sNJY+FHZWu5ptUJQIpZbS2n+qRsD66Er/GInJCz1ouasi79Ft681ztj+viGo/REqmw6zwT2CXmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmXsIqCl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmXsIqCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB7EC4CEEB;
	Tue,  1 Jul 2025 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751363102;
	bh=/EpTtZqs/0NQHCyo3IwEF11uyO287i6laKYVgvU17Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmXsIqClEBpqcbD/KkUIv/k/cumAbsSVt3PYYaFK3ta6x2TFR3RDxRTyiqdyzS6KG
	 ar5OfiVBx4HnCdkRv/zCtP+XFp9fi+dtihlKG0Lzzt7ppLNZH81a00stzLCalC+qTe
	 tP91//B287/6/bZEC8g7+WW9VXWW/fcZqtMei/Gsf1YT1kQmA9XPDtamwTA/KWq4Ca
	 RHHEzpkr9ypBPpSrXa7xUfx16M1rSOEKXISG8DjF0yCZpTLxO21fuF2IUbgZKkYZua
	 dHVGQv3zEAUpYMqpYO7sGM09Bo2YxNNpssbqNBJjtUNtJyrPFgPCJqViKL6fQ5D7P7
	 qseT3IEyuF87Q==
Date: Tue, 1 Jul 2025 11:44:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 08/10] ata: ahci: Disallow LPM policy control if not
 supported
Message-ID: <aGOuGsDyrNQRU21a@x1-carbon>
References: <20250701001408.330364-1-dlemoal@kernel.org>
 <20250701001408.330364-9-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701001408.330364-9-dlemoal@kernel.org>

On Tue, Jul 01, 2025 at 09:14:06AM +0900, Damien Le Moal wrote:
> Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
> supported by the HBA") introduced an early return in
> ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
> of ports belonging to a host that does not support the Partial, Slumber
> and DevSleep power states is unchanged and remains set to
> ATA_LPM_UNKNOWN and thus prevents the execution of
> ata_eh_link_set_lpm().
> 
> However, a user or a system daemon (e.g. systemd-udevd) may still
> attempt changing the LPM policy through the sysfs
> link_power_management_policy of the host.
> 
> Improve this to prevent sysfs LPM policy changes by setting the flag
> ATA_FLAG_NO_LPM for the port of such host, and initialize the port
> target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
> low power state is being used on the port and its link.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
