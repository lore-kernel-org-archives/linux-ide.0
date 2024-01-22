Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AE495F1
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2024 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959241; cv=none; b=DPr0LdQgZQ/bQfKBTb//g4t0zBNqfGrLg2WVfmHGR/RTNgvbc0Cms0XeKaKH/3Z1ydzTdd/tMwvrX3C4sxuAB5KhpbIH7OQ4BhIUPzCbGoAuM4lhtMOnmKDaEahBw/GHGPyfIDC5fqLuCIX4gzqhEXBc40Tq1N0jOLCCFIMZvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959241; c=relaxed/simple;
	bh=epSrRaz8cbvoETGfHrVMjhXyAAn4OCSfj25OTFMbtE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl7Fqh9r7SeZvdGzLY/gAm6dltYhc3w2UMWU1YcSDqMfOah/a484VErSQYSbT3RF8a7vIpOdaOPiimdq5/O9xGkSENDKDwn+95kztYAnxSxgLA/ReVkX37nOsFUUAIH06jlAOZj/K8ma9w8xfR9/EaF+7QgjipCOlt5f4oeHFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv5LTybC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv5LTybC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0555AC43390;
	Mon, 22 Jan 2024 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705959241;
	bh=epSrRaz8cbvoETGfHrVMjhXyAAn4OCSfj25OTFMbtE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lv5LTybCNdVWS6u6i8jZ1H5Dt9Z5yITSHMGNC1hCy/v2cpHPtyZPrcoKjWb+Zm6Eq
	 fD77VNqHw1rAiz11AAbNncbn4g4M1nbaK6dNAZcsk6F5d0yrPKO1m4oOfhuF0xM4NV
	 A1b9HsCeqO7VKkibQkdIxwaG/5h9of1k9CIfnBG96lpFcDb7kJDXXrpiRdhzLbrwfd
	 YL9dSR5VjLMo4lepqyxFtBQMOIMyal2mTtL1e/8KJu/J2Yu48eCAtxxmSYJ2fQZB3I
	 typQ0JHzPWHUjIsaEWOtOSxSFW1Tb+GlZt6SzhPTxNvfpUofwW27dGmVZToAPQ/8uf
	 b1M9ATx0Nbqvg==
Date: Mon, 22 Jan 2024 22:33:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-sata: improve sysfs description for
 ATA_LPM_UNKNOWN
Message-ID: <Za7fQwOvbAjeSBD9@x1-carbon>
References: <20240111165745.3653361-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111165745.3653361-1-cassel@kernel.org>

On Thu, Jan 11, 2024 at 05:57:44PM +0100, Niklas Cassel wrote:
> Currently, both ATA_LPM_UNKNOWN (0) and ATA_LPM_MAX_POWER (1) displays
> as "max_performance" in sysfs.
> 
> This is quite misleading as they are not the same.
> 
> For ATA_LPM_UNKNOWN, ata_eh_set_lpm() will not be called at all,
> leaving the configuration in unknown state.
> For ATA_LPM_MAX_POWER, ata_eh_set_lpm() is called, and setting the
> policy to ATA_LPM_MAX_POWER.
> 
> This also matches the description of the SATA_MOBILE_LPM_POLICY Kconfig:
> 0 => Keep firmware settings
> 1 => Maximum performance
> 
> Thus, update the sysfs description for ATA_LPM_UNKNOWN to match reality.
> 
> While at it, update libata.h to mention that the ascii descriptions
> are in libata-sata.c and not in libata-scsi.c.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes
