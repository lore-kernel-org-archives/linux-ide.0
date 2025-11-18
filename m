Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFE260580
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477771; cv=none; b=D1sAYTpfhTlkejhDuFwl0XScfFbUCA4yGoCq5DUuwC6ZtRYLe2uwptYbOUbCWc2iWqdLUUuNylx8MKT6sWwDOkcwGHCJq2UXJ0gqVY8TRAGkWTVKVrW/fFGRSzPHuMdmD4an6z12j5AkoCaOuCdFgT2mmgeUlnDOpgxboZIWI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477771; c=relaxed/simple;
	bh=lvDpahMggxMfETaMD6nkVg5J9bcOxtactzk75dGOHsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnDFTQzA2kBuvLZ5DeweHPPCb0nYa6xlXc8Qxw6iUa1nCg6Wyi70tLFdDvGzT1Si6xmDJRddvaep2hXl32PeGb2Vv4bZS2eozOlsh6LXbhesZevMZFXieFtXLLifLhVdgL+DHOsmGD7XS8ChktaERvLssxI/i1iqP948xfwVz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/zs6WDM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/zs6WDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9656C19425;
	Tue, 18 Nov 2025 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763477770;
	bh=lvDpahMggxMfETaMD6nkVg5J9bcOxtactzk75dGOHsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/zs6WDMnnvmw7SQMYWNpSizRwF4A3oxPkdtjr7i5TxiUeI/62kT5IZHkq/hMLFP/
	 viwlmoc32rl74E3GFYcKHJtiMf5VFg74mm35UOkULY07Dv+6zI/EqwPXQzTyx+lIRH
	 a5QtegMkDCRdVEoVbBcB64g0dY8ff6lcobJu8tzUHg7eECjJu8w97agMASriXjQXZ4
	 dDSEy+clRKyfSjXBMi/PMTtdz18UOWxsT/GYmEj12Xjf9epij9utpq1/FlWwcbqTS9
	 IEmM/15LCwB54vnVDBylZKgJ1tfC6OXY7jg5Iwtbz9fxuN2xBwzBjf60sor2kmM96h
	 4jLqho/jC71RA==
Date: Tue, 18 Nov 2025 15:56:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] fix PCMCIA Iomega Clik!
Message-ID: <aRyJB2j4MDNIARIM@ryzen>
References: <20251117.134321.1327313572065130952.rene@exactco.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117.134321.1327313572065130952.rene@exactco.de>

Hello René,

On Mon, Nov 17, 2025 at 01:43:21PM +0100, René Rebe wrote:

Please change the subject to include: "ata: pata_pcmcia: " prefix.

I.e. something like:

ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI Adapter

Looking at:
https://en.wikipedia.org/wiki/PocketZip

It seems like this device was renamed to PocketZip.

So perhaps:
ata: pata_pcmcia: Add Iomega PocketZip Drive


> Add PCMCIA Iomega Clik! ID to pata_pcmcia.

Perhaps:
Add Iomega PocketZip Drive ID to pata_pcmcia.


> 
> -- Signed-off-by: René Rebe <rene@exactco.de>

There should be no "-- " before the Signed-off-by, see:
https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1


> 
> --- a/drivers/ata/pata_pcmcia.c	2025-02-27 18:51:20.641993816 +0100
> +++ b/drivers/ata/pata_pcmcia.c	2025-02-27 18:56:22.022992807 +0100
> @@ -362,6 +362,7 @@
>  	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
>  	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
>  	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
> +	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888D7B73),

I think this should be something like:
PCMCIA_DEVICE_PROD_ID2("Iomega PocketZip Drive", 0x888D7B73),

Also, make sure that you add this entry at the correct place, i.e. in
alphabetical order (Iomega, before IBM), please also make the hex ID
string in lower case letters to match the existing entries.


Kind regards,
Niklas
