Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F442A84
	for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2024 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEEd1/I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EBEC433F1;
	Fri, 12 Jan 2024 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705044012;
	bh=3ut80d9UXEbBMpJpdj3X4JUuj2FolW/4JLVaf9h/jQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iEEd1/I+MOhhNEipfIMY349VExcN1+Kk9jXnsnsi0cGJMCodOnTp8AEVrg1TnOQ0d
	 ranroqDHcVISWIcX/X7t4HrZKcGOi5F38XgSk86qUQ9eVXeRkApBUvzbS1AiHiXaky
	 FBE4WeGrXr6u9Ztx5dEin5c5bW4PqcpLCYAGI1o6GZ6ZJO3fCRfY0gK19+qF1UYTPH
	 8/5CCbMMdYTQRoR2gf6Dsds9bMq7sV2DUW2r9ULnbGmGM9jfGOJVqwb5QGPb5TVLDa
	 hihikVLE4erImzddxnRoqC/Dc0cpoEoqcoAOXuwtb9PK1JE4Gr586qyl0t4+gpuC2e
	 MjZf71tf19nug==
Message-ID: <61b8e66f-cc93-42a8-b677-d14641267386@kernel.org>
Date: Fri, 12 Jan 2024 16:20:10 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sata: improve sysfs description for
 ATA_LPM_UNKNOWN
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240111165745.3653361-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240111165745.3653361-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 01:57, Niklas Cassel wrote:
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

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

