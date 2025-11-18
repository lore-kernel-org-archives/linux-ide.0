Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167130BBA4
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499405; cv=none; b=bidltshH2iovuzrxIfvAXS3SBnopbX8GDohO93rxqirpacXoWPHbkKDI9eVVwbSEoST9sKw40VtzxQBQdP0HQ2Uu0dfVSkbNE2xcMNM506ZJEB+HQNeMLonRdJQ/+XtLtLQq45WCt1LdpapP7UHw3PbJl409JBkPooPruVIT4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499405; c=relaxed/simple;
	bh=J0xLiL/X5L7VHCz+h6HwLDTc8+lbmFzPhett4BfxyjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3cnJZ25C635WTcdX+dKqksu+PAB35NAU8KvIvn8ehsZoVvADif+6MTlS1LG/U9aq96zAz+/M36dBQ6gI72KWW5u3BLgzpMlw/usvJvKM0LpXYNQWATHQBZbxKjJ0qm25Zdv8emJ32ATE9WcwCOH2RN4D8YhJiwuuzqs4p2dh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odOhrI0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odOhrI0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B99DC19422;
	Tue, 18 Nov 2025 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763499404;
	bh=J0xLiL/X5L7VHCz+h6HwLDTc8+lbmFzPhett4BfxyjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odOhrI0/298jsgyDcPWCANuc646UoveHAQnSoiO2ShuknYeHbnoL/+N16FKmT0e+H
	 vghnvB+1xl+aBBKaqfN07FSeddmbDtUf86Ncd+xoVG24eXz1AgbMkLGO3qTtBp4Xr7
	 GsIJY1kAJt5KQ6MCWjgYVqSaaj2DgBfi0YA5QrEP/EeZWlOe54EInrCMOW9p29GkBY
	 KHU3kO6q9YrRg36V6VdcBVPH/yMWgRU3HksqqAmsumejTQKr2jB9v4r6UYvjDeZTxi
	 34x9HT3BKr3Yee41STxaFhfiJSEQX9CIZXUW9A9fmZFY7lDQcWlIU2gC84yR55PmWd
	 /JasFDn63Dubw==
Date: Tue, 18 Nov 2025 21:56:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH V2] ata: pata_pcmcia: Add Iomega Clik! PCMCIA ATA/ATAPI
 Adapter
Message-ID: <aRzdh6Q8xuu6OL7G@ryzen>
References: <20251118.174654.1384716262322584447.rene@exactco.de>
 <aRzSMYp-i4RDYl-l@ryzen>
 <87550962-6A64-4F07-AD72-001D85824B83@exactco.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87550962-6A64-4F07-AD72-001D85824B83@exactco.de>

On Tue, Nov 18, 2025 at 09:20:17PM +0100, René Rebe wrote:
> IOn 18. Nov 2025, at 21:08, Niklas Cassel <cassel@kernel.org> wrote:
> > 
> > On Tue, Nov 18, 2025 at 05:46:54PM +0100, René Rebe wrote:
> >> Add Iomega Clik! "PCMCIA ATA/ATAPI Adapter" ID to pata_pcmcia.
> >> 
> >> Signed-off-by: René Rebe <rene@exactco.de>
> >> ---
> >> v2: style and sorted
> >> ---
> >> drivers/ata/pata_pcmcia.c | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
> >> index cf3810933a27..caefcd8c4b3c 100644
> >> --- a/drivers/ata/pata_pcmcia.c
> >> +++ b/drivers/ata/pata_pcmcia.c
> >> @@ -344,6 +344,7 @@ static const struct pcmcia_device_id pcmcia_devices[] = {
> >> 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
> >> 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
> >> 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "PnPIDE", 0x281f1c5d, 0x0c694728),
> >> +	PCMCIA_DEVICE_PROD_ID2("PCMCIA ATA/ATAPI Adapter", 0x888d7b73),
> > 
> > Don't we want Iomega somewhere in the name here?
> 
> 
> IIRC this string came out of some pcmcia tool. I thought it came out of the device.
> Is it not used for matching or should match what comes out of the device IDENTIFY
> or so command?

Looking at drivers/pcmcia/ds.c, you are right,
the string is used for matching.

So we are stuck with this quite generic name :)


Kind regards,
Niklas
