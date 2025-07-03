Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2E2E3380
	for <linux-ide@vger.kernel.org>; Thu,  3 Jul 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539514; cv=none; b=WjHsK3p2wkbOaipAcLgZuzTILHKklBZ3sMWPhO2HohMQUoBlxuAkn31FegkUGj8xVgsimJVQK7gCJCvZv35rRZ2ovaHJUf/3zfQZRQvmDltzwAboPrj6cQwXYXyhkYqB9b1PR1u3RKRSPJXjihzFgMAnP9uHL9DSVUkyjPzzKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539514; c=relaxed/simple;
	bh=to9T5ISxM3vXFMZFiTHu1GZCU9zl7yJjzIGwhjAnAIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um126bv/xtMO0O1AXKDAFDwwOGLdt3S78m7fDZ42nu2m9vJvuTYhZZ7BSHkxjqNcQJps2/YsmF2dAVvlyeAm+g+GOAQu0qG0iHb58n4odY5QocaOVg2kOb9h4CcgmJb7R17AhzKFgMPAvkj3857MdxuWw7k8C+kGjnG1ITJ7XWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiEtRy63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiEtRy63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979BBC4CEE3;
	Thu,  3 Jul 2025 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751539514;
	bh=to9T5ISxM3vXFMZFiTHu1GZCU9zl7yJjzIGwhjAnAIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiEtRy635QCKBS1heRtsLoTJTP1Zm7X8IwrFriV+OR8qHOxzEnnpwgMSeBdmwOMi8
	 SMRvb565Qu069ppIrI+9BvVeRNC6k/fwt1ZY+IWE/PdvFyUnpcWy6kh7tX+S8n3ZXV
	 mYoGpyKVgR5XdAVuORQH7r6QiFoAFJ/Jj5zkx/q+bSdJscxoZ2A/8zB9gsMkAZ8HD/
	 89mPwg/mKm7H0UVpfMpIPB67EZQ0J307yvz6qbSS3FtvjzghGgqGmz1HUFJ6VgXs6v
	 Sq/NwjsUsvK2sHcJex5zOZriO3CgGxeipTyubk1FvaKrC9kjy585gES4wMizT8uIGO
	 g9UcUzBB840VQ==
Date: Thu, 3 Jul 2025 12:45:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ata: libata-core: Cache the general purpose log
 directory
Message-ID: <aGZfNpJWTi8ULn6D@ryzen>
References: <20250703103622.291272-1-dlemoal@kernel.org>
 <20250703103622.291272-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703103622.291272-2-dlemoal@kernel.org>

On Thu, Jul 03, 2025 at 07:36:19PM +0900, Damien Le Moal wrote:
> The function ata_log_supported() tests if a log page is supported by a
> device using the General Purpose Log Directory log page, which lists the
> size of all surported log pages. However, this log page is read from the
> device using ata_read_log_page() every time ata_log_supported() is
> called. That is not necessary.
> 
> Avoid reading the General Purpose Log Directory log page by caching its
> content in the gp_log_dir buffer defined as part of struct ata_device.
> The functions ata_read_log_directory() and ata_clear_log_directory() are
> introduced to manage this buffer. ata_clear_log_directory() zero-fill
> the gp_log_dir buffer every time ata_dev_configure() is called, that is,
> when the device is first scanned and when it is being revalidated.
> The function ata_log_supported() is modified to call
> ata_read_log_directory() instead of ata_read_log_page().
> 
> The function ata_read_log_directory() calls ata_read_log_page() to read
> the General Purpose Log Directory log page from the device only if the
> first 16-bits word of the log is not equal to 0x0001, that is, it is not
> equal to the ACS mandated value for the log version.
> 
> With this, the log page is read from the device only once for every
> ata_dev_configure() call. For instance, with pr_debug enabled, a call
> to ata_dev_configure() before this patch generates the following log
> page accesses:
> 
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x13, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x12, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x8
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x3
> ata3.00: read log page - log 0x30, page 0x4
> ata3.00: read log page - log 0x18, page 0x0
> 
> That is, the general purpose log directory page is read 7 times.
> With this patch applied, the number of accesses to this log page is
> reduced to one:
> 
> ata3.00: read log page - log 0x0, page 0x0
> ata3.00: read log page - log 0x13, page 0x0
> ata3.00: read log page - log 0x12, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x8
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x0
> ata3.00: read log page - log 0x30, page 0x3
> ata3.00: read log page - log 0x30, page 0x4
> ata3.00: read log page - log 0x18, page 0x0
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
