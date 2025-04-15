Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFD17A31F
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702497; cv=none; b=pwHX1bBU07WgFLVnEMSahRz/US6mGIq7zeoj3DRPz8ctVSC0MQizF4zNqWhYSvUjlVlyJcEZBqqjd3E9+3XnNcTIuXets45hHmUlH7l7sBWi3JyLrAgG+V45A6r+TYNYNZl/1/sxpyWiq70Buc/lYCHrBnw/WPkoGc+huCt16OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702497; c=relaxed/simple;
	bh=hfPZUxuSBqr0olrPNwm3BbF/lLqxzHwYFi/Ijy8pZSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfL8gG4Pq3gDRN2d9c1qXKuWl3Yrf8YLzOgFlKEjknZKXdCgv00xtijT9KtyXTvKRGVvTPXGsBW6c/DRGbvyCPEzagv6HsDTokUCGd9Mb6UZaPMkt0ave44FODyFTOrkairvyLG3xEj9ww4EK/8ZJv92ALJ5vMqYBdVGDS1ccmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQTskbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQTskbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABAFC4CEDD;
	Tue, 15 Apr 2025 07:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744702497;
	bh=hfPZUxuSBqr0olrPNwm3BbF/lLqxzHwYFi/Ijy8pZSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIQTskbxRz2AsXP5Pa9F7+g/TjILPF8J3ECdZcZEugr4K9t9e3iBsElNpWzMBFYTG
	 HjQhlRRw3zBCpIMq3KCVPnnIE7uuv45/hhpyY1Iu5ft8qvtP5T07EmUyzSjrbmtU5D
	 WpqiSP92E7oPF/heKcjTWZZQhGyXiB2xzbJvCCz928TlvbwM9SNHVAocz+ZFBV2X7t
	 MbXPcizkwRPMPMc0a1b/HflidBUyq8wlEIeKyhjYI4EPvps0/iMTORzZ4CgPfdV9CK
	 +5HnYufr+ZsW3OaghyzDzSNdhLas0NawGN6rIy8LE94dVWpJRffdkQd6+h+YD1FMHy
	 zQUeqari24zVA==
Date: Tue, 15 Apr 2025 09:34:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>
Subject: Re: [PATCH 2/2] ata: libata-sata: Simplify sense_valid fetching
Message-ID: <Z_4MHUVbKYAMRpo_@ryzen>
References: <20250411132522.126316-3-cassel@kernel.org>
 <20250411132522.126316-4-cassel@kernel.org>
 <24c4c3a3-01a3-4f69-9fdc-8154ceceb5c3@suse.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c4c3a3-01a3-4f69-9fdc-8154ceceb5c3@suse.de>

On Tue, Apr 15, 2025 at 08:51:46AM +0200, Hannes Reinecke wrote:
> On 4/11/25 15:25, Niklas Cassel wrote:
> > While the sense_valid field is 47 bits according to the specification,
> > we are currently only fetching 32 bits, because these are the only
> > bits that represent the tags (0-31), which is all we care about.
> > 
> > Thus, replace the existing logic with a simple get_unaligned_le32().
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >   drivers/ata/libata-sata.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > index 2e4463d3a356..5ba79a1053ea 100644
> > --- a/drivers/ata/libata-sata.c
> > +++ b/drivers/ata/libata-sata.c
> > @@ -1529,8 +1529,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
> >   		return -EIO;
> >   	}
> > -	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
> > -		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
> > +	sense_valid = get_unaligned_le32(&buf[8]);
> >   	extended_sense = get_unaligned_le16(&buf[14]);
> >   	aux_icc_valid = extended_sense & BIT(15);
> 
> Description is ever so misleading; we never fetched 47 bits to start
> with. All we do is simplify the logic.
> But whatever.

IMO, that is exactly what I wrote :)

Nevertheless, I clarified the commit message in V2.


Kind regards,
Niklas
