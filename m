Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E7299AAB
	for <linux-ide@vger.kernel.org>; Mon,  7 Jul 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885016; cv=none; b=J/+zFD9Kg0lAQRdxW3/XF3NRg/zZYKMEngsrYC0jdJSN+QfbUyVWeFBvqcrHFpu6MUeWcRHqcg3ersHEUPlkB0KM0Kg6kcwTuRIGcOvNAP7oZuEAvWbIlqvUg/YvOJusY6aiXHIyS2Dau7B8Fuz2W8+EmvTy2YovPRH3Kw9cyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885016; c=relaxed/simple;
	bh=Prhot+iCx4ZOFZmekX+9rTMJ5lG+fE0bh2ny9Z2hhQ0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ll+S5PNisZM9SYuPg/Dqj66gzdDnYxdESDOIxLE+gq+WSHdIP3NpzRpnpuCb/k4LDSyTgcBDQE2jJTbItDYi6eBA7F5MlWo2h4xl0WgzzrOISmvm1Y+8Sj22RNBX3Ag0+NXNcDGXzCPag9xrvtxwYc8JylTBo8mMsKI3rEcV+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBrs2EDG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBrs2EDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC0CC4CEF7;
	Mon,  7 Jul 2025 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751885015;
	bh=Prhot+iCx4ZOFZmekX+9rTMJ5lG+fE0bh2ny9Z2hhQ0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NBrs2EDGkhLkoVt1aRW0qxc//efshXt8d7MyaKHRssdvEU8aE3yRvXJbHvD6DWzZK
	 v1Ex/7I3yfStSZGR4D7Y1+YQ2q/yX4TJCtV9TArV1gmcKGij04EOawcTPWaGrvFrz0
	 QRjiEWhF61SJX6EcYQTuVV5lDEagmrEsI81ZkmjLo+TEMCR4+MeXWfMk/Z+zvf7oQe
	 1U+0IL3+MtyRBVCmceREwycEDElWl05vxjYwNsKAhiY0HAUem3I2PaFzcipUMSVIWL
	 9ubEzU8SHPo/tkKkbhVAxoAEreZYddJA5eskqqy9yPaAVcWa9tNWOk/vvRtXRsZmVc
	 z8xQNeYD9zRKg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250704104601.310643-1-dlemoal@kernel.org>
References: <20250704104601.310643-1-dlemoal@kernel.org>
Subject: Re: [PATCH] ata: libata: Introduce ata_port_eh_scheduled()
Message-Id: <175188501469.569970.8645820885012805419.b4-ty@kernel.org>
Date: Mon, 07 Jul 2025 12:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 04 Jul 2025 19:46:00 +0900, Damien Le Moal wrote:
> Introduce the inline helper function ata_port_eh_scheduled() to test if
> EH is pending (ATA_PFLAG_EH_PENDING port flag is set) or running
> (ATA_PFLAG_EH_IN_PROGRESS port flag is set) for a port. Use this helper
> in ata_port_wait_eh() and __ata_scsi_queuecmd() to replace the hardcoded
> port flag tests.
> 
> No functional changes.
> 
> [...]

Applied to libata/linux.git (for-6.17), thanks!

[1/1] ata: libata: Introduce ata_port_eh_scheduled()
      https://git.kernel.org/libata/linux/c/7aae547b

Kind regards,
Niklas

