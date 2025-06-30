Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997A131E49
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296304; cv=none; b=CqRyLQ/OPjwZPzmP/yuORW/FR6o9qtsSeCXmsK8oZHCeUnHH5QRGOdaKAMhXenk9I669+voZqatIOcn9PuHhcBd3JF4Xjoc73aawEsH5aiH5ir3SMOXT94jZtHWacGVBJroSv2xWTDIVUsuhHE0JPHxpvjLY26hZKOTG+iu3yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296304; c=relaxed/simple;
	bh=TAo6VzqyV0QzSmkH3gTgNfZlq1uxcYij7MbSxjZqdwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II1T5kigPCMu1uho/Cl7sZhefHcUFtMqcAj+ZXnKHK7FRbKB5JP1Vk3TW1cu6FJxh/o/pn3le3203vZkjgOm7nlRPzHAwNcQZCjH6bMvoZPXbDLMK2dviU2cTLphPLFwJDIhvS8+RTQgwq1+cpOUojPoNSwVixXknCWDWkB9moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAnY0gu6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAnY0gu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFC7C4CEE3;
	Mon, 30 Jun 2025 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296303;
	bh=TAo6VzqyV0QzSmkH3gTgNfZlq1uxcYij7MbSxjZqdwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAnY0gu6ifCqSfojId1TAGscp35ooLQMPpqQQ7VmyZTHbuwn5gpeyL1tpfU5tcU7P
	 dYYlhuAMky64hb0sWT8ihHHNBxqYC+cW/L8qTzzNb9bhKRPmiDInLw9Ngai/wUj7tp
	 3iPQWr1O3ud/TET8O05HMygiBhnBLIEcNTmmGngJD9IOu7e6/pQ5MABzKtSQqQnn0f
	 4EzS5zD7yt5vRgdyHnI2TJNp2IZEcmljmo0RXrmNCx69TAD90Xi/NDvFbh5HZ+RIcm
	 GHAzF3BAwM/50JC3jMNQZYfYOYHaLqPqtjMnMCwS6fdRFghMyv53S8rEv0sMuVokRl
	 rHfaSMNLxVSyw==
Date: Mon, 30 Jun 2025 17:11:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 10/10] ata: libata_eh: Add debug messages to
 ata_eh_link_set_lpm()
Message-ID: <aGKpK4nidqbMbY9y@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-11-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-11-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:37PM +0900, Damien Le Moal wrote:
> To facilitate field debugging of link power management related issues,
> add a debug message to ata_eh_link_set_lpm() to easily track LPM policy
> changes done from EH context, that is, during device scan and
> revalidation, error handling, and when a policy change is issued through
> a host sysfs link_power_management_policy attribute.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-eh.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7f5d13f9ca73..7134a4ff6535 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2140,6 +2140,9 @@ static int ata_eh_link_set_lpm(struct ata_link *link,
>  	if (WARN_ON_ONCE(policy == ATA_LPM_UNKNOWN))
>  		return 0;
>  
> +	ata_link_dbg(link, "Set LPM policy: %d -> %d\n",
> +		     old_policy, policy);

Nit: This is smaller than 80 columns, so it can be one line.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
