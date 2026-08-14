Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FC45A285;
	Fri, 14 Aug 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705522; cv=none; b=pWss5kQAjpYvE3kEcjpGNegKL8xlwY7rWYwhetP6mHAuh4f4QHKoRb5aCaYV8j/JOHaUeodUzNQWQ8TUr1uBb7YKgRJbuKkea8a3UOj8Xjuqff+cgVMflb66IUFRbUass+Kdx7SXj+rFkZ5DLxZyvJeYtJV0l8DIkRs/cmma7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705522; c=relaxed/simple;
	bh=4LEmA3I7+4h3LPRGS9Sl2QBTVDekp5o7uuqIhyY3ULk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVF97EKvp8duoUhJp6pMCQSK/d5l/WrSg+M90H0jvgxOVhfpw1KlPQMZXRfksFXt7Yh++WLLzjd2WJnx7ei4EcrZnyeIIQltBklVu2MlPT+94K5Ck06PK8W5dtR3TUR0/SyA9Hy1cEM55l5P0YPpoeAVghSb6lcewSBH+REaaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcHavI9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcHavI9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB21F000E9;
	Fri, 14 Aug 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786705515;
	bh=rw8ZM9EY7godKurMMgc8l637kojHmxLHeaQ6F2y8NVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JcHavI9JSlRAt9fhIE1gqFWyhzysxzYALMv/z9cCfrzhzKsvbCRqPAT8s7Rf2WNpn
	 jk6PwWEse0qvxsvTX1Y3AI3pOD/TjCxAqolYcqGJK52dEK8NWjX3EVuMh9QFldy6cB
	 AFUJGIjDcEpAdcJ7PRNvLE9jOEOLOGjS3zjBesidg3GC57WUEJQkm4SyKnSfYfafPP
	 C/BMCCmDQ5NsIAkcVV3iu6BCUx1a5XS5/JH58oe54hhM9rDKaaRXuaKmGmotIM2rJH
	 znjiBFPg4BsW+hysFmZT+l2FXhVrbXPQYMGskR/GNSXWrzT6O2pUIIwH3ylA6BxAbX
	 2Z41JGf3DZySg==
Date: Fri, 14 Aug 2026 13:05:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	liuyonglong@huawei.com, kangfenglong@huawei.com
Subject: Re: [PATCH v1] ata: libata-eh: Add timeout table entry for STANDBY
 IMMEDIATE
Message-ID: <an72ZpuHX6JhukdS@ryzen>
References: <20260814035846.2032778-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814035846.2032778-1-yangxingui@huawei.com>

On Fri, Aug 14, 2026 at 11:58:46AM +0800, Xingui Yang wrote:
> ATA_CMD_STANDBYNOW1 is not in the ata_eh_cmd_timeout_table and falls
> back to the 5s default (ATA_EH_CMD_DFL_TIMEOUT), which is too short
> for some drives to complete a STANDBY IMMEDIATE command issued from
> ata_dev_power_set_standby() via ata_exec_internal():
> 
>   ata1.00: qc timeout after 5000 msecs (cmd 0xe0)
>   ata1.00: STANDBY IMMEDIATE failed (err_mask=0x4)
> 
> Reuse the existing ata_eh_flush_timeouts for this command, as a drive
> entering standby may need to flush its internal cache, making the flush
> timeout a natural fit.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>  drivers/ata/libata-eh.c | 2 ++
>  include/linux/libata.h  | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 05df7ea6954a..8f9e12f460c3 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -149,6 +149,8 @@ ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] = {
>  	  .timeouts = ata_eh_flush_timeouts },
>  	{ .commands = CMDS(ATA_CMD_VERIFY),
>  	  .timeouts = ata_eh_reset_timeouts },
> +	{ .commands = CMDS(ATA_CMD_STANDBYNOW1),
> +	  .timeouts = ata_eh_flush_timeouts },
>  };
>  #undef CMDS
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 96e626d6a7ca..6c0d385b2cde 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -425,7 +425,7 @@ enum {
>  	/* This should match the actual table size of
>  	 * ata_eh_cmd_timeout_table in libata-eh.c.
>  	 */
> -	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 8,
> +	ATA_EH_CMD_TIMEOUT_TABLE_SIZE = 9,
>  
>  	/* User visible DMA mask for DMA control. DO NOT renumber. */
>  	ATA_DMA_MASK_ATA	= (1 << 0),	/* DMA on ATA Disk */
> -- 
> 2.43.0
> 

This patch does not seem to be on top of latest Linus tree.

If you look at latest Linus tree, it already has:
1e024d2b41ee ("ata: libata-eh: Increase STANDBY IMMEDIATE timeout")

Which looks to solve the same problem as this patch.


Kind regards,
Niklas
