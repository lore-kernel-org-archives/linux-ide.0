Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6026FD8E
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366495; cv=none; b=uuvPaQUl5asAumSESMIBb7Wxm0dkZ21flj8846j8Gqt7VjNtv9KCQDefonMbjA0gc5P5cA5LU6BOLUFKoD2u8WH/tlXpkKg18Ns+9/lpS0XAYS3AU1awszYth9A38J97qe84BEY1qmOpwlBt5i+3GPdaycZh2Ja7OQwpuIvj6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366495; c=relaxed/simple;
	bh=XsgYYOkJinzM01BHBlyEDiOzs5ZtvSEOWDzB66NIzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O94mvLwuz88RCL1ywfck0XI/6AqbwzdPERMWMOZmFMqV7mZHI0OSO52zUs+GsOkDoN8FxtJvpNeZpcC2UNAUjHdVOEnE+rSiq/bDTgU1ZOW65Gkq/NdnDDLyUP/qL8AG0mbcJe2JyQJvkUHzuIZ1mC/JfQ8/n+8Qcfh8Pnpgg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYjrEmpq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYjrEmpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468CDC4CEEB;
	Tue,  1 Jul 2025 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751366494;
	bh=XsgYYOkJinzM01BHBlyEDiOzs5ZtvSEOWDzB66NIzQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYjrEmpqUpi6JieI1VHcb5zaofiveo97lZHYGFxozu0c87BHpO174w4aEe7akyrbA
	 jp1r1FKuMtWMyi4lk2cs0LQtfd8Mdi6eb0B19VJ4v3GSXxJOqUtUhug2lpZtwjc1JF
	 pQPKojYUKSrCjLT4jGs8xe/X/bCOS9jT9tbiqTyVWDwEUnRzXbBjk0d+MGLV48c4bC
	 JyMTd/Iew7Y7L9e+zdKYTo/lGtho8xIyIvToxXzf0GBtkv98EaT9qXw+qkDpQ4JSHv
	 mTkedLlD7ITfJ4KZBgdJo3t8rRIq2Ow1B+jI0XK4lcN0RI25MzWVG/BZ4aeXDDlPTg
	 r7SAzkppB1Eiw==
Date: Tue, 1 Jul 2025 12:41:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 01/10] ata: libata-core: Introduce ata_dev_config_lpm()
Message-ID: <aGO7WxLsT6zCZRoq@ryzen>
References: <20250701001408.330364-1-dlemoal@kernel.org>
 <20250701001408.330364-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701001408.330364-2-dlemoal@kernel.org>

On Tue, Jul 01, 2025 at 09:13:59AM +0900, Damien Le Moal wrote:

(snip)

> Though DIPM is disabled on
> a drive by default thanks to the "Software Settings Preservation
> feature", DIPM may have been enabled by the system firmware when using
> the LPM policy "Keep FW settings" (ATA_LPM_UNKNOWN).

I see that you improved the commit message, but I actually meant that
maybe we should mention this in the comment above the disabling of DIPM
in ata_dev_config_lpm().

(Since someone just reading AHCI 1.3.1, "8.3.1.1 Device Initiated" will
probably read this sentence:
  By default, a device that supports initiating interface power management
  states has the capability disabled.

You basically need to read ACS-6 or SATA 3.5a to find out about
"Software Settings Preservation feature" and that DIPM can actually
stay enabled across a COMRESET.)


Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
