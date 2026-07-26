Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC957DA66;
	Sun, 26 Jul 2026 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785034163; cv=none; b=jMrVaR8lyxWUQmrzK/usB1vCTxHt4PmLYReJCyDS7s2AcTHFCkbqsK6/2bDA83VEE8lLfBTGPitJbZe0P3Goy6m+Urtpw1h2GI5V6lCh/0+YaBkLWHpYmPbLYnL9KuRMmEb09XTeeOeM6yBr+dE1DRkQ/iKhU4JWaKTbnVGCImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785034163; c=relaxed/simple;
	bh=W/XB5VgFHVQJ65pF8zPMr+s5TcDldcDBpFn1uOTH0S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpvrnIvA5krEGbnSyfc/c9GG2KRaJCWleQ/bZROLOI46+BLvDiblk4HBzKtGi2noXY4299+yrQv7XRdXg3fMykO1H4xZnk7brurMFNM5GRzPcweLAtdPW2O3/r06XezrZ/6jdSf/EfbSRzR3OfTKB7mFCRJQK2daqnppW3rJBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/mCVzFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/mCVzFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB21F000E9;
	Sun, 26 Jul 2026 02:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785034161;
	bh=fJrxuHciquTrsKNEPNzbpTuPw9GgZ0CiQukvxc3WI0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n/mCVzFwgglGrTWpTKpE8PiH40gpZJNlsXUKZyrSJTZlL2+C8sNfPQDHL9/Y13BEc
	 IJTvelwtkVmPndx2C9TnrpdaJF8a/3QMZV7lP127Yfb0cNDhvIdNIK+1dcLkEUPDly
	 /4yg2f08HdHR7Da5Z3I9bDI3+PMXW46dplOa6i5lI9idNdTUK6uZ18ge1tdB7cnsot
	 3yTIGwBrjHSLtlzAl8rX7DvIJfHAGvOT04b1w+aBrxTC6zn23OLFpKKM7zC7nMfRcU
	 X4SD9H02xvhdumb0gIvxQoSYf60soejSVeVTDDqHYsV6CtGrnzfkxJmAJL4I+JIAFP
	 1QScxuC68+AbA==
Message-ID: <343c7dd0-c16c-419b-97f6-379692266761@kernel.org>
Date: Sun, 26 Jul 2026 11:49:19 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: avoid kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
References: <20260725015209.1207666-1-rdunlap@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260725015209.1207666-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:52, Randy Dunlap wrote:
> Modify comments to prevent kernel-doc warnings:
> - use "/*" for a non-kernel-doc comment
> - add a Returns: section for ata_id_major_version()
> 
> Warning: include/linux/ata.h:770 Cannot find identifier on line:
>  *
> Warning: include/linux/ata.h:782 function parameter 'id' not described in 'ata_id_sct_data_tables'
> Warning: include/linux/ata.h:782 expecting prototype for Word(). Prototype was for ata_id_sct_data_tables() instead
> Warning: include/linux/ata.h:820 No description found for return value of 'ata_id_major_version'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: linux-ide@vger.kernel.org
> 
>  include/linux/ata.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- linux-next-20260722.orig/include/linux/ata.h
> +++ linux-next-20260722/include/linux/ata.h
> @@ -767,8 +767,7 @@ static inline bool ata_id_sense_reportin
>  	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
>  }
>  
> -/**
> - *
> +/*
>   * Word: 206 - SCT Command Transport
>   *    15:12 - Vendor Specific
>   *     11:6 - Reserved
> @@ -815,6 +814,8 @@ static inline bool ata_id_sct_supported(
>   *
>   *	The practical impact of this is that ata_id_major_version cannot
>   *	reliably report on drives below ATA3.
> + *
> + *	Returns: major version of ATA drive level or %0 if unknown

Is the "%0% here intentional ? If yes, why ? Or is it a typo? If it is the
latter, I can fix when applying.

>   */
>  
>  static inline unsigned int ata_id_major_version(const u16 *id)


-- 
Damien Le Moal
Western Digital Research
